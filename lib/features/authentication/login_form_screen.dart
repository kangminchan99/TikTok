import 'package:flutter/material.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';
import 'package:tiktok/features/onboarding/interests_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formDate = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        // 폼이 유효한 경우 텍스트 폼 필드의 onSaved에 저장
        _formKey.currentState!.save();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => InterestsScreen()),
          (route) => false, // 모든 이전 라우트를 제거
        );
      }
    }
  }

  void _onScaffoldTap() {
    // 키보드 내리기
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(title: Text('Log in')),
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: Sizes.size36),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please wrtie your email';
                    }
                    return null;
                  },

                  decoration: InputDecoration(hintText: 'Email'),
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formDate['email'] = newValue;
                    }
                  },
                ),
                Gaps.v16,
                TextFormField(
                  validator: (value) {
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Password'),
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formDate['password'] = newValue;
                    }
                  },
                ),
                Gaps.v28,
                FormButton(disabled: false, onTap: () => _onSubmitTap()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
