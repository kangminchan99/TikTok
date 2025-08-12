import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/email_screen.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/users/user_profile_screen.dart';
import 'package:tiktok/features/videos/video_recording_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => VideoRecordingScreen()),
    // GoRoute(
    //   name: SignUpScreen.routeName,
    //   path: SignUpScreen.routeURL,
    //   builder: (context, state) => SignUpScreen(),
    //   routes: [
    //     GoRoute(
    //       name: UsernameScreen.routeName,
    //       path: UsernameScreen.routeURL,
    //       builder: (context, state) => UsernameScreen(),
    //       routes: [
    //         GoRoute(
    //           name: EmailScreen.routeName,
    //           path: EmailScreen.routeURL,
    //           builder: (context, state) {
    //             final args = state.extra as EmailScreenArgs;
    //             return EmailScreen(username: args.username);
    //           },
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
    // // GoRoute(
    // //   path: LoginScreen.routeName,
    // //   builder: (context, state) => LoginScreen(),
    // // ),

    // // GoRoute(
    // //   // context.pushNamed('username_screen')으로 사용
    // //   name: 'username_screen',
    // //   path: UsernameScreen.routeName,
    // //   pageBuilder: (context, state) {
    // //     return CustomTransitionPage(
    // //       child: UsernameScreen(),
    // //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    // //         return FadeTransition(
    // //           opacity: animation,
    // //           child: ScaleTransition(scale: animation, child: child),
    // //         );
    // //       },
    // //     );
    // //   },
    // // ),
    // GoRoute(
    //   path: "/users/:username",
    //   builder: (context, state) {
    //     final username = state.pathParameters['username'];
    //     final tab = state.uri.queryParameters['show'];
    //     return UserProfileScreen(username: username!, tab: tab!);
    //   },
    // ),
  ],
);
