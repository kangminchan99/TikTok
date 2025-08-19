import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/repos/autentication_repo.dart';
import 'package:tiktok/utils.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    state = AsyncValue.loading();
    // 에러가 없으면 보낸 future의 결과 값을 넣어주고 에러가 있으면 에러를 넣어준다
    state = await AsyncValue.guard(
      () async => _repository.signIn(email, password),
    );
    if (state.hasError) {
      showFirebaseErrorSnackBar(context, state.error);
    } else {
      context.go('/home');
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
