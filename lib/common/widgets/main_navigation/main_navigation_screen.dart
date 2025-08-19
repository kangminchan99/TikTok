import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/common/widgets/video_configuration/video_config.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/features/discover/discover_screen.dart';
import 'package:tiktok/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok/features/users/views/user_profile_screen.dart';
import 'package:tiktok/features/inbox/inbox_screen.dart';
import 'package:tiktok/features/videos/views/video_recording_screen.dart';
import 'package:tiktok/features/videos/views/video_timeline_screen.dart';
import 'package:tiktok/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = 'mainNavigation';
  final String tab;
  const MainNavigationScreen({required this.tab, super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = ['home', 'discover', "xxxx", 'inbox', 'profile'];
  late int _selectedIndex = _tabs.indexOf(widget.tab);

  // final screens = [
  //   StfScreen(key: GlobalKey()),
  //   StfScreen(key: GlobalKey()),
  //   Container(),
  //   StfScreen(key: GlobalKey()),
  //   StfScreen(key: GlobalKey()),
  //   // Center(child: Text('Home')),
  //   // Center(child: Text('Discover')),
  //   // Container(),
  //   // Center(child: Text('Inbox')),
  //   // Center(child: Text('Profile')),
  // ];

  // web에서 url 변경 시 바로 반영
  @override
  void didUpdateWidget(covariant MainNavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tab != widget.tab) {
      final next = _tabs.indexOf(widget.tab);
      setState(() {
        _selectedIndex = next < 0 ? 0 : next; // 안전 가드
      });
    }
  }

  void _onTap(int index) {
    context.go('/${_tabs[index]}');
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: darkModeConfig,
      builder: (context, isDark, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: _selectedIndex == 0 || isDark
            ? Colors.black
            : Colors.white,
        // body: screens.elementAt(_selectedIndex),
        body: Stack(
          children: [
            Offstage(
              offstage: _selectedIndex != 0,
              child: VideoTimelineScreen(),
            ),
            Offstage(offstage: _selectedIndex != 1, child: DiscoverScreen()),
            Offstage(offstage: _selectedIndex != 3, child: InboxScreen()),
            Offstage(
              offstage: _selectedIndex != 4,
              child: UserProfileScreen(username: 'minchan', tab: ""),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
                isDark: isDark,
              ),
              NavTab(
                text: "Discover",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
                isDark: isDark,
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onPostVideoButtonTap,
                child: PostVideoButton(
                  inverted: _selectedIndex != 0,
                  isDark: isDark,
                ),
              ),
              Gaps.h24,
              NavTab(
                text: "Inbox",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
                isDark: isDark,
              ),
              NavTab(
                text: "Profile",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
