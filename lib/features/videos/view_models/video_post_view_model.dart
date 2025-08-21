import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repos/autentication_repo.dart';
import 'package:tiktok/features/videos/repos/video_repo.dart';

// FamilyAsyncNotifier - Notifier에게 추가 인자를 보낼 수 있게 해준다
class VideoPostViewModel extends FamilyAsyncNotifier<bool, String> {
  late final VideoRepository _repository;
  late final _videoId;

  @override
  FutureOr<bool> build(String videoId) async {
    _videoId = videoId;
    _repository = ref.read(videoRepo);
    final user = ref.read(authRepo).user;
    final myLike = await _repository.isLiked(videoId, user!.uid);

    return myLike;
  }

  Future<void> toggleLikeVideo() async {
    final uid = ref.read(authRepo).user!.uid;

    // DB 업데이트 & 결과 값 받기
    final newValue = await _repository.togglelikeVideo(_videoId, uid);

    // UI에 반영
    state = AsyncValue.data(newValue);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, bool, String>(
      () => VideoPostViewModel(),
    );
