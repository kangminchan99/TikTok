import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok/features/users/widgets/user_account.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // 앱바 사라지게 하려면 CustomScrollView + SliverAppBar 사용
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text('Minchan'),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.gear, size: Sizes.size20),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      foregroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/114412280?v=4',
                      ),
                      child: Text('민찬'),
                    ),
                    Gaps.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '@민찬',
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
                          UserAccount(account: '97', title: 'Following'),
                          VerticalDivider(
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade400,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),
                          UserAccount(account: '10M', title: 'Followers'),
                          VerticalDivider(
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade400,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),
                          UserAccount(account: '194.3M', title: 'Likes'),
                        ],
                      ),
                    ),
                    Gaps.v14,
                    FractionallySizedBox(
                      widthFactor: 0.33,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Sizes.size12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(Sizes.size4),
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
                    ),
                    Gaps.v14,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
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
                        FaIcon(FontAwesomeIcons.link, size: Sizes.size12),
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

              // SliverAppBar(
              //   // 앱바가 중간에 나올 수 있게 함
              //   // floating: true,
              //   // 앱바의 배경 색깔과 flexible space bar의 title을 보여줌
              //   pinned: true,
              //   stretch: true,
              //   collapsedHeight: 80,
              //   expandedHeight: 200,
              //   backgroundColor: Colors.teal,
              //   flexibleSpace: FlexibleSpaceBar(
              //     stretchModes: [
              //       // StretchMode.blurBackground,
              //       StretchMode.zoomBackground,
              //     ],
              //     background: Image.asset(
              //       'assets/images/ping9.png',
              //       fit: BoxFit.cover,
              //     ),
              //     title: Text('hello'),
              //   ),
              // ),
              // SliverToBoxAdapter(
              //   child: Column(
              //     children: [CircleAvatar(backgroundColor: Colors.red, radius: 20)],
              //   ),
              // ),
              // SliverFixedExtentList(
              //   delegate: SliverChildBuilderDelegate(
              //     childCount: 50,
              //     (context, index) => Container(
              //       alignment: Alignment.center,
              //       color: Colors.teal[100 * (index % 9)],
              //       child: Text('Item $index'),
              //     ),
              //   ),
              //   itemExtent: 100,
              // ),
              // SliverPersistentHeader(delegate: CustomDelegate(), pinned: true),
              // SliverGrid(
              //   delegate: SliverChildBuilderDelegate(
              //     childCount: 50,
              //     (context, index) => Container(
              //       alignment: Alignment.center,
              //       color: Colors.amber[100 * (index % 9)],
              //       child: Text('Item $index'),
              //     ),
              //   ),
              //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //     maxCrossAxisExtent: 100,
              //     mainAxisSpacing: Sizes.size20,
              //     crossAxisSpacing: Sizes.size20,
              //     childAspectRatio: 1,
              //   ),
              // ),
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
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: "assets/images/ping9.png",
                        image:
                            'https://avatars.githubusercontent.com/u/114412280?v=4',
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
    );
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
