import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/authentication/widgets/auth_button.dart';
import 'package:tiktok/generated/l10n.dart';
import 'package:tiktok/utils.dart';

class SignUpScreen extends StatelessWidget {
  static const routeURL = '/';
  static const routeName = "signUp";
  const SignUpScreen({super.key});

  // 네비게이션을 다루는 로직과 메서드를 UI에서 분리하기 위해 따로 사용
  void _onLoginTap(BuildContext context) {
    //  Navigator.of(
    //   context,
    // ).push(MaterialPageRoute(builder: (context) => LoginScreen()));
    // Navigator.of(context).pushNamed(LoginScreen.routeName);
    context.pushNamed(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    // Navigator.of(
    //   context,
    // ).push(MaterialPageRoute(builder: (context) => UsernameScreen()));

    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionDuration: Duration(seconds: 3),
    //     reverseTransitionDuration: Duration(seconds: 3),
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         UsernameScreen(),

    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       final offsetAnimation = Tween<Offset>(
    //         begin: Offset(0, 1),
    //         end: Offset.zero,
    //       ).animate(animation);

    //       final opacityAnimation = Tween<double>(
    //         begin: 0.5,
    //         end: 1.0,
    //       ).animate(animation);
    //       return SlideTransition(
    //         position: offsetAnimation,
    //         child: FadeTransition(opacity: opacityAnimation, child: child),
    //       );
    //     },
    //   ),
    // );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsernameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        // if (orientation == Orientation.landscape) {
        //   return Scaffold(
        //     body: Center(child: Text('Please use the app in portrait mode.')),
        //   );
        // }
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    S.of(context).signUpTitle('Tiktok', DateTime.now()),
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).signUpSubtitle(0),
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      icon: FaIcon(FontAwesomeIcons.user),
                      text: S.of(context).emailPasswordButton,
                      onTap: () => _onEmailTap(context),
                    ),
                    Gaps.v16,
                    AuthButton(
                      onTap: () {},
                      icon: FaIcon(FontAwesomeIcons.apple),
                      text: S.of(context).appleButton,
                    ),
                  ],

                  if (orientation == Orientation.landscape) ...[
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            icon: FaIcon(FontAwesomeIcons.user),
                            text: S.of(context).emailPasswordButton,
                            onTap: () => _onEmailTap(context),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            onTap: () {},
                            icon: FaIcon(FontAwesomeIcons.apple),
                            text: S.of(context).appleButton,
                          ),
                        ),
                      ],
                    ),
                  ],
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
                  Text(S.of(context).alreadyHaveAnAccount),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      S.of(context).logIn('male'),
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
      },
    );
  }
}
