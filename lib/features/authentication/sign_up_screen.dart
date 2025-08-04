import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/email_screen.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  // 네비게이션을 다루는 로직과 메서드를 UI에서 분리하기 위해 따로 사용
  void _onLoginTap(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => UsernameScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return Scaffold(
            body: Center(child: Text('Please use the app in portrait mode.')),
          );
        }
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    'Sign up for Tiktok',
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Text(
                    'Create a profile, follow other accounts, make your own videos, and more.',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      icon: FaIcon(FontAwesomeIcons.user),
                      text: 'Use email & password',
                      onTap: () => _onEmailTap(context),
                    ),
                    Gaps.v16,
                    AuthButton(
                      onTap: () {},
                      icon: FaIcon(FontAwesomeIcons.apple),
                      text: 'Continue with Apple',
                    ),
                  ],

                  if (orientation == Orientation.landscape) ...[
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            icon: FaIcon(FontAwesomeIcons.user),
                            text: 'Use email & password',
                            onTap: () => _onEmailTap(context),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            onTap: () {},
                            icon: FaIcon(FontAwesomeIcons.apple),
                            text: 'Continue with Apple',
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.grey.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
