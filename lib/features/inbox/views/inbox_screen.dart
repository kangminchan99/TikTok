import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/inbox/views/activity_screen.dart';
import 'package:tiktok/features/inbox/views/chats_screen.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  void _onDmPressed(BuildContext context) {
    context.pushNamed(ChatsScreen.routeName);
  }

  void _onActivityTap(BuildContext context) {
    context.pushNamed(ActivityScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('Inbox'),
        actions: [
          IconButton(
            onPressed: () => _onDmPressed(context),
            icon: FaIcon(FontAwesomeIcons.paperPlane),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // 밑줄 높이
          child: Container(
            color: Colors.grey.shade300, // 밑줄 색상
            height: 1.0, // 밑줄 두께
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => _onActivityTap(context),
            title: Text(
              'Activity',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
          Container(height: Sizes.size1, color: Colors.grey.shade200),
          ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Center(
                child: FaIcon(FontAwesomeIcons.users, color: Colors.white),
              ),
            ),
            title: Text(
              'New Followers',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            subtitle: Text(
              'Messages from followers will appear here',
              style: TextStyle(fontSize: Sizes.size14),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
