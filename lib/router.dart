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
import 'package:tiktok/notifications/notifications_provider.dart';

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
      // ShellRoute - 알림 provider가 초기화된 후에 각 route를 rendering하고 있는데
      // context를 통해서 각 route에 접근할 수 있도록 해줌
      ShellRoute(
        builder: (context, state, child) {
          ref.read(notificationsProvider(context));
          return child;
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
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    final position = Tween<Offset>(
                      begin: Offset(0, 1),
                      end: Offset.zero,
                    ).animate(animation);
                    return SlideTransition(position: position, child: child);
                  },
            ),
          ),
        ],
      ),
    ],
  );
});
