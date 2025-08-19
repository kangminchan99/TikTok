import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/settings/settings_screen.dart';
import 'package:tiktok/features/users/view_models/user_view_model.dart';
import 'package:tiktok/features/users/views/widgets/avartar.dart';
import 'package:tiktok/features/users/views/widgets/persistent_tab_bar.dart';
import 'package:tiktok/features/users/views/widgets/user_account.dart';
import 'package:tiktok/features/users/views/widgets/user_icon_button.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(userProvider)
        .when(
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => Center(child: CircularProgressIndicator.adaptive()),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == 'likes' ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: _onGearPressed,
                            icon: Icon(
                              FontAwesomeIcons.gear,
                              size: Sizes.size20,
                            ),
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Gaps.v20,
                            Avatar(
                              name: data.name,
                              hasAvatar: data.hasAvatar,
                              uid: data.uid,
                            ),
                            Gaps.v20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '@${data.name}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Sizes.size18,
                                  ),
                                ),
                                Gaps.h5,
                                FaIcon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  size: Sizes.size16,
                                  color: Colors.blue.shade500,
                                ),
                              ],
                            ),
                            Gaps.v24,
                            SizedBox(
                              height: Sizes.size52,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  UserAccount(
                                    account: '97',
                                    title: 'Following',
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade400,
                                    indent: Sizes.size14,
                                    endIndent: Sizes.size14,
                                  ),
                                  UserAccount(
                                    account: '10M',
                                    title: 'Followers',
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade400,
                                    indent: Sizes.size14,
                                    endIndent: Sizes.size14,
                                  ),
                                  UserAccount(
                                    account: '194.3M',
                                    title: 'Likes',
                                  ),
                                ],
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Sizes.size12 + Sizes.size1,
                                    horizontal:
                                        MediaQuery.of(context).size.width / 6.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(
                                      Sizes.size4,
                                    ),
                                  ),
                                  child: Text(
                                    'Follow',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Gaps.h5,
                                UserIconButton(
                                  onTap: () {},
                                  icon: FontAwesomeIcons.youtube,
                                ),
                                Gaps.h5,
                                UserIconButton(
                                  onTap: () {},
                                  icon: FontAwesomeIcons.chevronDown,
                                ),
                              ],
                            ),
                            Gaps.v14,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizes.size32,
                              ),
                              child: Text(
                                'All highlights and where to watch live matches, plus the latest news and features.',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: Sizes.size16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.link,
                                  size: Sizes.size12,
                                ),
                                Gaps.h4,
                                Text(
                                  'https://tiktok.com/@minchan',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Gaps.v20,
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: PersistentTabBar(),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        // 스크롤 시 키보드 내려가게
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,

                        itemCount: 20,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size2,
                          childAspectRatio: 9 / 14,
                        ),
                        itemBuilder: (context, index) => Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 9 / 14,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholder: "assets/images/ping9.png",
                                    image:
                                        'https://avatars.githubusercontent.com/u/114412280?v=4',
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 5,
                                    child: Row(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.play,
                                          color: Colors.white,
                                          size: Sizes.size16,
                                        ),
                                        Gaps.h4,
                                        Text(
                                          '4.1M',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(child: Text('Page two')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
    // 앱바 사라지게 하려면 CustomScrollView + SliverAppBar 사용
  }
}

// class CustomDelegate extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return Container(
//       color: Colors.indigo,
//       child: FractionallySizedBox(
//         heightFactor: 1,
//         child: Center(
//           child: Text('title!!!', style: TextStyle(color: Colors.white)),
//         ),
//       ),
//     );
//   }

//   @override
//   double get maxExtent => 100;

//   @override
//   double get minExtent => 100;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
