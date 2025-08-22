import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/repos/autentication_repo.dart';
import 'package:tiktok/features/inbox/views/chats_screen.dart';
import 'package:tiktok/features/videos/views/video_recording_screen.dart';
import 'package:tiktok/notifications/repos/notifications_repository.dart';

class NotificationsProvider extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late final NotificationsRepository _repository;
  @override
  FutureOr build(BuildContext context) async {
    final user = ref.read(authRepo).user;
    _repository = ref.read(notificationsRepo);
    final token = await _messaging.getToken();

    if (user == null || token == null) return;
    _repository.updateToken(token, user.uid);
    await initListener(context);
    _messaging.onTokenRefresh.listen((newToken) {
      _repository.updateToken(newToken, user.uid);
    });
  }

  Future<void> initListener(BuildContext context) async {
    final permission = await _messaging.requestPermission();

    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }

    // 어플이 켜져 있는 동안 알림을 받을 때만 작동함
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // Background
    FirebaseMessaging.onMessageOpenedApp.listen((notification) {
      context.pushNamed(ChatsScreen.routeName);
    });

    // Terminated
    final notification = await _messaging.getInitialMessage();
    if (notification != null) {
      context.pushNamed(VideoRecordingScreen.routeName);
    }
  }
}

final notificationsProvider = AsyncNotifierProvider.family(
  () => NotificationsProvider(),
);
