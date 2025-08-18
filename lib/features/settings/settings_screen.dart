import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok/common/widgets/video_configuration/video_config.dart';
import 'package:tiktok/features/videos/models/playback_config_model.dart';
import 'package:tiktok/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok/utils.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Localizations.override 위젯을 사용하여 앱의 로케일을 강제로 설정할 수 있다
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ValueListenableBuilder(
            valueListenable: darkModeConfig,
            builder: (context, value, child) => SwitchListTile.adaptive(
              value: darkModeConfig.value,
              onChanged: (value) {
                darkModeConfig.value = !darkModeConfig.value;
              },
              title: Text('Dark Mode'),
              subtitle: Text('setting dark mode?'),
            ),
          ),
          // InheritedWidget
          // SwitchListTile.adaptive(
          //   value: VideoConfigData.of(context).autoMute,
          //   onChanged: (value) {
          //     VideoConfigData.of(context).toggleMuted();
          //   },
          //   title: Text('Auto Mute'),
          //   subtitle: Text('Videos will be muted by default.'),
          // ),
          // ChangeNotifier
          // AnimatedBuilder(
          //   animation: videoConfig,
          //   builder: (context, child) => SwitchListTile.adaptive(
          //     value: videoConfig.autoMuted,
          //     onChanged: (value) {
          //       videoConfig.toggleAutoMute();
          //     },
          //     title: Text('Auto Mute'),
          //     subtitle: Text('Videos will be muted by default.'),
          //   ),
          // ),
          // AnimatedBuilder(
          //   animation: videoConfig,
          //   builder: (context, child) => SwitchListTile.adaptive(
          //     value: videoConfig.value,
          //     onChanged: (value) {
          //       videoConfig.value = !videoConfig.value;
          //     },
          //     title: Text('Auto Mute'),
          //     subtitle: Text('Videos will be muted by default.'),
          //   ),
          // ),
          // SwitchListTile.adaptive(
          //   value: context.watch<VideoConfig>().isMuted,
          //   onChanged: (value) => context.read<VideoConfig>().toggleMute(),
          //   title: Text('Auto Mute'),
          //   subtitle: Text('videos muted by default'),
          // ),
          SwitchListTile.adaptive(
            // value: context.watch<PlaybackConfigViewModel>().muted,
            value: ref.watch(playbackConfigProvider).muted,
            onChanged: (value) => {
              ref.read(playbackConfigProvider.notifier).setMuted(value),
            },
            //     context.read<PlaybackConfigViewModel>().setMuted(value),
            title: Text('Mute video'),
            subtitle: Text('video will be muted.'),
          ),
          SwitchListTile.adaptive(
            // value: context.watch<PlaybackConfigViewModel>().autoPlay,
            value: ref.watch(playbackConfigProvider).autoPlay,
            onChanged: (value) => {
              ref.read(playbackConfigProvider.notifier).setAutoPlay(value),
            },
            // context.read<PlaybackConfigViewModel>().setAutoPlay(value),
            title: Text('AutoPlay'),
            subtitle: Text('video will start playing automatically'),
          ),
          SwitchListTile.adaptive(
            value: false,
            onChanged: (value) {},
            title: Text('Enable Notifications'),
            subtitle: Text('They will be cute.'),
          ),
          CheckboxListTile.adaptive(
            value: false,
            onChanged: (value) {},
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
