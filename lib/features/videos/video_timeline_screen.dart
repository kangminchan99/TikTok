import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  final PageController _pageController = PageController();

  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink,
  ];

  void _onPageChanged(int page) {
    // 애니메이션 종류랑 길이를 모든 화면에 적용시키기 위해 사용 (페이지 전환 시 마지막에 좀 느려지는데 이 코드로 그거 없앴음)
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 150),
      curve: Curves.linear,
    );
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      _colors.addAll([Colors.red, Colors.green, Colors.blue, Colors.pink]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      // onPageChanged - 현재 페이지 인덱스 위치를 알 수 있다.
      onPageChanged: _onPageChanged,
      itemBuilder: (context, index) => Container(
        color: _colors[index],
        child: Center(
          child: Text(
            'Screen $index',
            style: TextStyle(fontSize: 68, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
