import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok/features/videos/models/video_model.dart';

void main() {
  group("VideoModel Test", () {
    test("Constructor", () {
      final video = VideoModel(
        id: "id",
        title: "title",
        fileUrl: "fileUrl",
        thumbnailUrl: "thumbnailUrl",
        likes: 1,
        comments: 1,
        creator: "creator",
        description: "description",
        creatorUid: "creatorUid",
        createdAt: 1,
      );
      expect(video.id, "id");
    });

    test(".fromJson Constructor", () {
      final video = VideoModel.fromJson(
        json: {
          'title': "title",
          'fileUrl': "fileUrl",
          'thumbnailUrl': "thumbnailUrl",
          'likes': 1,
          'comments': 1,
          'creator': "creator",
          'description': "description",
          'creatorUid': "creatorUid",
          'createdAt': 1,
        },
        videoId: "videoId",
      );
      expect(video.title, "title");
      expect(video.comments, isInstanceOf<int>());
    });

    test("toJson Method", () {
      final video = VideoModel(
        id: "id",
        title: "title",
        fileUrl: "fileUrl",
        thumbnailUrl: "thumbnailUrl",
        likes: 1,
        comments: 1,
        creator: "creator",
        description: "description",
        creatorUid: "creatorUid",
        createdAt: 1,
      );
      final json = video.toJson();
      expect(json["id"], "id");
    });
  });
}
