import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/login_form_screen.dart';
import 'package:tiktok/features/authentication/view_models/socical_auth_view_model.dart';
import 'package:tiktok/features/authentication/widgets/auth_button.dart';
import 'package:tiktok/utils.dart';

class LoginScreen extends ConsumerWidget {
  static String routeName = 'login';
  static String routeURL = '/login';
  const LoginScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    // Navigator.of(context).pop();
    context.pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginFormScreen()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                'Log in to Tiktok',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Opacity(
                opacity: 0.7,
                child: Text(
                  'Manage your account, check notifications, comment on videos, and more.',
                  style: TextStyle(fontSize: Sizes.size16),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v40,
              AuthButton(
                onTap: () => _onEmailLoginTap(context),
                icon: FaIcon(FontAwesomeIcons.user),
                text: 'Use email & password',
              ),
              Gaps.v16,
              AuthButton(
                onTap: () =>
                    ref.read(socialAuthProvider.notifier).githubSignIn(context),
                icon: FaIcon(FontAwesomeIcons.github),
                text: 'Continue with GitHub',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: isDarkMode(context) ? null : Colors.grey.shade50,
        child: Padding(
          padding: EdgeInsets.only(top: Sizes.size32, bottom: Sizes.size64),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don\'t have an account?'),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
