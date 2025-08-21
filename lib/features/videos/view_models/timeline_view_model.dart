import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/repos/video_repo.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideoRepository _repository;
  List<VideoModel> _list = [];

  Future<List<VideoModel>> _fetchVideos({int? lastItemCreatedAt}) async {
    final result = await _repository.fetchVideos(
      lastItemCreatedAt: lastItemCreatedAt,
    );
    final videos = result.docs.map(
      (doc) => VideoModel.fromJson(json: doc.data(), videoId: doc.id),
    );

    return videos.toList();
  }

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
    _list = await _fetchVideos(lastItemCreatedAt: null);
    return _list;
  }

  Future<void> fetchNextPage() async {
    final nexPage = await _fetchVideos(lastItemCreatedAt: _list.last.createdAt);
    state = AsyncValue.data([..._list, ...nexPage]);
  }

  Future<void> refresh() async {
    final videos = await _fetchVideos(lastItemCreatedAt: null);
    _list = videos;
    state = AsyncValue.data(videos);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
      () => TimelineViewModel(),
    );
