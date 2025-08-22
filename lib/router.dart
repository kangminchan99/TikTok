import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok/features/authentication/email_screen.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/repos/autentication_repo.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/inbox/views/activity_screen.dart';
import 'package:tiktok/features/inbox/views/chat_detail_screen.dart';
import 'package:tiktok/features/inbox/views/chats_screen.dart';
import 'package:tiktok/features/onboarding/interests_screen.dart';
import 'package:tiktok/features/users/views/user_profile_screen.dart';
import 'package:tiktok/features/videos/views/video_recording_screen.dart';

final routerProvider = Provider((ref) {
  // ref.watch(authState);
  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.matchedLocation != SignUpScreen.routeURL &&
            state.matchedLocation != LoginScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        name: InterestsScreen.routeName,
        path: InterestsScreen.routeURL,
        builder: (context, state) => InterestsScreen(),
      ),
      GoRoute(
        path: '/:tab(home|discover|inbox|profile)',
        name: MainNavigationScreen.routeName,
        builder: (context, state) {
          final tab = state.pathParameters['tab']!;
          return MainNavigationScreen(tab: tab);
        },
      ),
      GoRoute(
        name: ActivityScreen.routeName,
        path: ActivityScreen.routeURL,
        builder: (context, state) => ActivityScreen(),
      ),
      GoRoute(
        name: ChatsScreen.routeName,
        path: ChatsScreen.routeURL,
        builder: (context, state) => ChatsScreen(),
        routes: [
          GoRoute(
            name: ChatDetailScreen.routeName,
            path: ChatDetailScreen.routeURL,
            builder: (context, state) {
              final chatId = state.pathParameters['chatId']!;
              return ChatDetailScreen(chatId: chatId);
            },
          ),
        ],
      ),
      GoRoute(
        name: VideoRecordingScreen.routeName,
        path: VideoRecordingScreen.routeURL,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: Duration(milliseconds: 200),
          child: VideoRecordingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final position = Tween<Offset>(
              begin: Offset(0, 1),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(position: position, child: child);
          },
        ),
      ),

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
});
