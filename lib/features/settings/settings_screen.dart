import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/common/widgets/video_configuration/video_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool value = false;

  void _onSwitchChanged(bool? newValue) {
    if (newValue == null) return;

    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Localizations.override 위젯을 사용하여 앱의 로케일을 강제로 설정할 수 있다
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          // SwitchListTile.adaptive(
          //   value: VideoConfigData.of(context).autoMute,
          //   onChanged: (value) {
          //     VideoConfigData.of(context).toggleMuted();
          //   },
          //   title: Text('Auto Mute'),
          //   subtitle: Text('Videos will be muted by default.'),
          // ),
          SwitchListTile.adaptive(
            value: value,
            onChanged: _onSwitchChanged,
            title: Text('Enable Notifications'),
            subtitle: Text('They will be cute.'),
          ),

          CheckboxListTile.adaptive(
            value: value,
            onChanged: _onSwitchChanged,
            title: Text('Marketing emails'),
            subtitle: Text('we wont spam you'),
          ),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                initialDate: DateTime.now(),
                lastDate: DateTime(2030),
              );
              if (kDebugMode) {
                print(date);
              }

              if (context.mounted) {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (kDebugMode) {
                  print(time);
                }
              }

              if (context.mounted) {
                final booking = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                );

                if (kDebugMode) {
                  print(booking);
                }
              }
            },
            title: Text('what is your birthday?'),
          ),
          ListTile(
            title: Text('Logout (IOS)'),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('pls dont go'),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.pop(context),
                      child: Text('No'),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () => Navigator.pop(context),
                      child: Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: Text('Logout (Android)'),
            textColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: FaIcon(FontAwesomeIcons.skull),
                  title: Text('Are you sure?'),
                  content: Text('pls dont go'),
                  actions: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: FaIcon(FontAwesomeIcons.car),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: Text('Logout (IOS / Bottom)'),
            textColor: Colors.red,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: Text('Are you sure?'),
                  message: Text('pls dont go'),
                  actions: [
                    CupertinoActionSheetAction(
                      isDefaultAction: true,
                      onPressed: () => Navigator.pop(context),

                      child: Text('Not logout'),
                    ),
                    CupertinoActionSheetAction(
                      isDestructiveAction: true,
                      onPressed: () => Navigator.pop(context),
                      child: Text('yes logout'),
                    ),
                  ],
                ),
              );
            },
          ),
          AboutListTile(
            applicationName: 'TikTok',
            applicationVersion: '2.3',
            applicationLegalese: 'Dont copy me',
          ),
        ],
      ),
    );
  }
}
