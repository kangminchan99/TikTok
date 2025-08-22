import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateToken(String token, String userId) async {
    await _db.collection('users').doc(userId).update({'token': token});
  }
}

final notificationsRepo = Provider((ref) => NotificationsRepository());
