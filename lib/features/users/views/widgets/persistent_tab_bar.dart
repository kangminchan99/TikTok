import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/utils.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isDark = isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        labelColor: Theme.of(context).tabBarTheme.indicatorColor,
        labelPadding: EdgeInsets.symmetric(vertical: Sizes.size10),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Icon(Icons.grid_4x4_rounded),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: FaIcon(FontAwesomeIcons.heart),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
