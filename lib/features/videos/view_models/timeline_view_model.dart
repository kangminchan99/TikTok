import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/repos/video_repo.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideoRepository _repository;
  List<VideoModel> _list = [];

  // void uploadVideo() async {
  //   state = AsyncValue.loading();
  //   await Future.delayed(Duration(seconds: 2));
  //   // final newVideo = VideoModel(title: '${DateTime.now}');
  //   _list = [..._list, newVideo];
  //   state = AsyncValue.data(_list);
  // }

  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videoRepo);
    final result = await _repository.fetchVideos();
    final newList = result.docs
        .map((doc) => VideoModel.fromJson(doc.data()))
        .toList();
    _list = newList;
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
      () => TimelineViewModel(),
    );
