import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/repos/autentication_repo.dart';
import 'package:tiktok/features/users/view_models/user_view_model.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/repos/video_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideoRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videoRepo);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(userProvider).value;
    if (userProfile != null) {
      state = AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final task = await _repository.uploadVideoFile(video, user!.uid);
        if (task.metadata != null) {
          await _repository.saveVideo(
            VideoModel(
              id: "",
              title: "From Flutter",
              fileUrl: await task.ref.getDownloadURL(),
              thumbnailUrl: "",
              likes: 0,
              comments: 0,
              creator: userProfile.name,
              description: "Hell Yeah!!",
              creatorUid: user.uid,
              createdAt: DateTime.now().millisecondsSinceEpoch,
            ),
          );
          context.pop();
          context.pop();
        }
      });
    }
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
