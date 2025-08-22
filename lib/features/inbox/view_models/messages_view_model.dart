import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repos/autentication_repo.dart';
import 'package:tiktok/features/inbox/models/message_model.dart';
import 'package:tiktok/features/inbox/repos/messages_repo.dart';

class MessagesViewModel extends AsyncNotifier<void> {
  late final MessagesRepo _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(messagesRepo);
  }

  Future<void> sendMessage(String text) async {
    final user = ref.read(authRepo).user;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final message = MessageModel(
        text: text,
        userId: user!.uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _repository.sendMessage(message);
    });
  }
}

final messagesProvider = AsyncNotifierProvider<MessagesViewModel, void>(
  () => MessagesViewModel(),
);
// autoDispose를 해주지 않으면 StreamProvider는 계속 살아있음 why riverpod은 위젯트리에 있지 않기 때문에
final chatProvider = StreamProvider.autoDispose<List<MessageModel>>((ref) {
  final db = FirebaseFirestore.instance;

  return db
      .collection('chat_rooms')
      .doc('rqqNUWDQz61u3glNgPqM')
      .collection('texts')
      .orderBy('createdAt')
      .snapshots()
      .map(
        (event) => event.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList()
            .reversed
            .toList(),
      );
});
