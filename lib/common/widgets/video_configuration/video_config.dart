import 'package:flutter/material.dart';

// ChangeNotifier

// class VideoConfig extends ChangeNotifier {
//   bool autoMuted = true;

//   void toggleAutoMute() {
//     autoMuted = !autoMuted;
//     notifyListeners();
//   }
// }

// final videoConfig = VideoConfig();

final videoConfig = ValueNotifier<bool>(false);

final darkModeConfig = ValueNotifier<bool>(false);

// // InheritedWidget

// import 'package:flutter/widgets.dart';

// class VideoConfigData extends InheritedWidget {
//   final bool autoMute;
//   final void Function() toggleMuted;
//   const VideoConfigData({
//     super.key,
//     required super.child,
//     required this.autoMute,
//     required this.toggleMuted,
//   });

//   static VideoConfigData of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
//   }

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return true;
//   }
// }

// class VideoConfig extends StatefulWidget {
//   final Widget child;
//   const VideoConfig({super.key, required this.child});

//   @override
//   State<VideoConfig> createState() => _VideoConfigState();
// }

// class _VideoConfigState extends State<VideoConfig> {
//   bool autoMute = false;

//   void toggleMuted() {
//     setState(() {
//       autoMute = !autoMute;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VideoConfigData(
//       toggleMuted: toggleMuted,
//       autoMute: autoMute,
//       child: widget.child,
//     );
//   }
// }
