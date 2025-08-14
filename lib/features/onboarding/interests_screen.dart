import 'package:flutter/material.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/onboarding/tutorial_screen.dart';
import 'package:tiktok/features/onboarding/widgets/interest_button.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});
  static const String routeName = 'interests';
  static const String routeURL = '/tutorial';

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _showTitle = false;

  void _onScroll() {
    if (_scrollController.offset > 100) {
      if (_showTitle) return; // 이미 타이틀이 보이는 경우 중복 실행 방지
      setState(() {
        _showTitle = true;
      });
    } else {
      setState(() {
        _showTitle = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onNextTap() {
    // 다음 화면으로 이동하는 로직을 여기에 추가
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TutorialScreen()),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: Text('Choose your interests'),
        ),
      ),
      // 오른쪽에 스크롤바를 표시해줌
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              left: Sizes.size24,
              right: Sizes.size24,
              bottom: Sizes.size16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                Text(
                  'Choose your interests',
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                Text(
                  'Get better video recommendations',
                  style: TextStyle(fontSize: Sizes.size20),
                ),
                Gaps.v64,
                Wrap(
                  runSpacing: Sizes.size16,
                  spacing: Sizes.size16,
                  children: [
                    for (var interest in interests)
                      InterestButton(interest: interest),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        child: GestureDetector(
          onTap: _onNextTap,
          child: Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Center(
              child: Text(
                'Next',
                style: TextStyle(color: Colors.white, fontSize: Sizes.size16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
