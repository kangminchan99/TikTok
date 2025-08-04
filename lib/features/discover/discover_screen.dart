import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/breakpoints.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

final tabs = ['Top', 'Users', 'Videos', 'Sounds', 'LIVE', 'Shopping', 'Brands'];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController(
    text: 'init text',
  );

  void _onSearchChanged(String value) {
    // Handle search text change
    print('Search text changed: $value');
  }

  void _onSearchSubmitted(String value) {
    // Handle search submission
    print('Search submitted: $value');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Breakpoints.lg),
            child: CupertinoSearchTextField(
              controller: _textEditingController,
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
            ),
          ),
          bottom: TabBar(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            labelColor: Colors.black,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,

            tabAlignment: kIsWeb ? TabAlignment.center : TabAlignment.start,
            tabs: [for (var tab in tabs) Tab(text: tab)],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              // 스크롤 시 키보드 내려가게
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size6,
                vertical: Sizes.size6,
              ),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 22,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Container(
                      // 이미지가 컨테이너를 overflow하기 때문에 Clip.hardEdge 사용해서
                      // BorderRadius.circular 적용되게한다.
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size4),
                      ),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/images/ping9.png",
                          image:
                              'https://avatars.githubusercontent.com/u/114412280?v=4',
                        ),
                      ),
                    ),
                    Gaps.v10,
                    Text(
                      '${constraints.maxWidth}This is a very long caption for my tiktok that im upload jusy now currently',
                      style: TextStyle(
                        fontSize: Sizes.size16 + Sizes.size2,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.v8,
                    if (constraints.maxHeight < 200 ||
                        constraints.maxWidth > 250)
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: Sizes.size12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://avatars.githubusercontent.com/u/114412280?v=4',
                              ),
                              radius: 12,
                            ),
                            Gaps.h4,
                            Expanded(
                              child: Text(
                                'My Avatar is going to be very long',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size16,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.h2,
                            Text('2.9M'),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(tab, style: TextStyle(fontSize: Sizes.size28)),
              ),
          ],
        ),
      ),
    );
  }
}
