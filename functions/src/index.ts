import * as admin from 'firebase-admin';
import {
  onDocumentCreated,
  onDocumentDeleted,
} from 'firebase-functions/v2/firestore';
import { tmpdir } from 'os';
import { join } from 'path';
import { promises as fs } from 'fs';
import { spawn } from 'child-process-promise';
import ffmpegPath from 'ffmpeg-static';
import axios from 'axios';

admin.initializeApp();

// 비디오 썸네일 생성 로직 functions톨더에서 npm i child-process-promise 후 사용
export const onVideoCreated = onDocumentCreated(
  {
    document: 'videos/{videoId}',
    region: 'asia-northeast3',
    cpu: 1,
    memory: '1GiB',
    timeoutSeconds: 180,
  },
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const data = snap.data() as { fileUrl: string };
    const video = snap.data();
    const id = snap.id;

    const inputPath = join(tmpdir(), `${id}.mp4`);
    const outputPath = join(tmpdir(), `${id}.jpg`);

    // 1) 원본 다운로드
    if (data.fileUrl.startsWith('gs://')) {
      // gs://을 저장했다면 GCS SDK로 다운로드
      const [, , bucketName, ...rest] = data.fileUrl.split('/');
      await admin
        .storage()
        .bucket(bucketName)
        .file(rest.join('/'))
        .download({ destination: inputPath });
    } else {
      // https URL → axios로 /tmp 저장 (토큰 포함 URL이면 OK)
      const res = await axios.get(data.fileUrl, {
        responseType: 'arraybuffer',
        timeout: 60_000,
      });
      await fs.writeFile(inputPath, Buffer.from(res.data));
    }

    try {
      // 2) ffmpeg 실행 (로컬 파일 입력)
      //  - '-v error'로 에러만 출력 (필요 시 'info')
      await spawn(ffmpegPath as string, [
        '-y',
        '-v',
        'error',
        '-ss',
        '00:00:01.000', // 입력 앞 시킹(더 빠르고 안정적)
        '-i',
        inputPath,
        '-vframes',
        '1',
        '-vf',
        'scale=150:-1',
        outputPath,
      ]);
    } catch (e: any) {
      console.error('ffmpeg failed', e?.stderr || e?.message);
      throw e;
    }

    // 3) 업로드
    const [file, _] = await admin
      .storage()
      .bucket()
      .upload(outputPath, {
        destination: `thumbnails/${id}.jpg`,
        metadata: {
          contentType: 'image/jpeg',
          cacheControl: 'public,max-age=3600',
        },
      });

    await file.makePublic();
    await snap.ref.update({ thumbnailUrl: file.publicUrl() });

    const db = admin.firestore();

    await db
      .collection('users')
      .doc(video.creatorUid)
      .collection('videos')
      .doc(id)
      .set({
        thumbnailUrl: file.publicUrl(),
        videoId: id,
      });

    // 4) 정리
    try {
      await fs.unlink(outputPath);
    } catch {}
    try {
      await fs.unlink(inputPath);
    } catch {}
  }
);

export const onLikeCreated = onDocumentCreated(
  {
    document: 'likes/{likeId}',
    region: 'asia-northeast3',
  },
  async (event) => {
    const snap = event.data;
    if (!snap) return;
    const db = admin.firestore();
    const id = snap.id;
    const [videoId, userId] = id.split('000');

    await db
      .collection('videos')
      .doc(videoId)
      .update({
        likes: admin.firestore.FieldValue.increment(1),
      });

    await db
      .collection('users')
      .doc(userId)
      .collection('likes')
      .doc(videoId)
      .set({
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        videoId: videoId,
      });
  }
);

export const onLikeRemoved = onDocumentDeleted(
  {
    document: 'likes/{likeId}',
    region: 'asia-northeast3',
  },
  async (event) => {
    const snap = event.data;
    if (!snap) return;
    const db = admin.firestore();
    const id = snap.id;
    const [videoId, userId] = id.split('000');

    await db
      .collection('videos')
      .doc(videoId)
      .update({
        likes: admin.firestore.FieldValue.increment(-1),
      });

    await db
      .collection('users')
      .doc(userId)
      .collection('likes')
      .doc(videoId)
      .delete();
  }
);
