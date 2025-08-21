import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _itemCount = 0;

  final PageController _pageController = PageController();

  final Duration _scrollDuration = Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    // 애니메이션 종류랑 길이를 모든 화면에 적용시키기 위해 사용 (페이지 전환 시 마지막에 좀 느려지는데 이 코드로 그거 없앴음)
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCount - 1) {
      ref.watch(timelineProvider.notifier).fetchNextPage();
    }
    setState(() {});
  }

  void _onVideoFinished() {
    return;
    _pageController.nextPage(duration: _scrollDuration, curve: _scrollCurve);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    return ref.watch(timelineProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(timelineProvider)
        .when(
          error: (error, stackTrace) => Center(
            child: Text('Error: $error', style: TextStyle(color: Colors.white)),
          ),
          loading: () => Center(child: CircularProgressIndicator()),
          data: (videos) {
            _itemCount = videos.length;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              // refresh Icon 돌아가는 위치
              displacement: 50,
              // refreshIndicator가 화면에 나타날 때 시작점
              edgeOffset: 20,
              backgroundColor: Colors.black,
              color: Theme.of(context).primaryColor,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                // onPageChanged - 현재 페이지 인덱스 위치를 알 수 있다.
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                    onVideoFinished: _onVideoFinished,
                    index: index,
                    videoData: videoData,
                  );
                },
              ),
            );
          },
        );
  }
}
