import 'package:flutter/material.dart';
import 'package:login_auth/pages/login_page.dart';
import 'package:login_auth/pages/signup_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially show login page
  bool showLoginpage = true;
  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginpage) {
      return LoginPage(onTap: togglePages);
    } else {
      return SignUpPage(
        onTap: togglePages,
      );
    }
  }
}
