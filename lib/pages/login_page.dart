import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/components/my_textfield.dart';
import 'package:login_auth/components/squaretile.dart';
import 'package:login_auth/services/google_auth_service.dart';

import '../components/my_button.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text field controller
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

// sign in ontap
  void signUserIn() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (builder) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

// error message
    errorMessage(String message) {
      showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              title: Text(message),
            );
          });
    }

    // try signin
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);

      //show error message
      errorMessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 45,
              ),
              //logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(
                height: 30,
              ),

              // Welcome back, you've been missed
              Text(
                "Welcome back, you've been missed!",
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              const SizedBox(
                height: 25,
              ),
              // emailtextfield
              MyTextField(
                controller1: _emailController,
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(
                height: 15,
              ),
              //password textfiels
              MyTextField(
                controller1: _passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(
                height: 10,
              ),
              //forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              //Signin button

              MyButton(
                onTap: signUserIn,
                btnName: "Sign In",
              ),

              const SizedBox(
                height: 15,
              ),

              //or continue with

              const Row(
                children: [
                  Expanded(child: Divider(height: 0.5)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("or continue with"),
                  ),
                  Expanded(child: Divider(height: 0.5)),
                ],
              ),
              const SizedBox(
                height: 50,
              ),

              //google + apple signin buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // goole button
                  GestureDetector(
                      onTap: () {
                        AuthService().signInWithGoogle();
                      },
                      child:
                          const SquareTile(imagePath: "lib/images/google.png")),

                  const SizedBox(
                    width: 10,
                  ),

                  //apple button
                  const SquareTile(imagePath: "lib/images/apple.png")
                ],
              ),
              const SizedBox(
                height: 25,
              ),

              //not a member? Register Now

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Not a member?"),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
