import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/password_screen.dart';
import 'package:tiktok/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';

class EmailScreenArgs {
  final String username;
  EmailScreenArgs({required this.username});
}

class EmailScreen extends ConsumerStatefulWidget {
  final String username;
  const EmailScreen({super.key, required this.username});

  @override
  EmailScreenState createState() => EmailScreenState();
}

class EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  String _email = '';

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    // 이메일 정규 표현식
    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (!regExp.hasMatch(_email)) {
      return "Email is not valid";
    }
    return null;
  }

  void _onScaffoldTap() {
    // 키보드 내리기
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, 'email': _email};

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(title: Text('Sign up')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              Text(
                'What is your email? ${widget.username}',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _emailController,
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: TextInputType.emailAddress,
                // onSubmit하고 같으나 값을 알 때 사용
                onEditingComplete: _onSubmit,
                // 자동 수정 기능 없애기
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Email',
                  errorText: _isEmailValid(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
              ),
              Gaps.v16,
              FormButton(
                onTap: () => _onSubmit(),
                disabled: _email.isEmpty || _isEmailValid() != null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
