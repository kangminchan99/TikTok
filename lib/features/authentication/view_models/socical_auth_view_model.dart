import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/repos/autentication_repo.dart';
import 'package:tiktok/utils.dart';

class SocicalAuthViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> githubSignIn(BuildContext context) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.githubSignIn(),
    );
    if (state.hasError) {
      showFirebaseErrorSnackBar(context, state.error);
    } else {
      context.go('/home');
    }
  }
}

final socialAuthProvider = AsyncNotifierProvider<SocicalAuthViewModel, void>(
  () => SocicalAuthViewModel(),
);
