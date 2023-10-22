import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/components/my_textfield.dart';
import 'package:login_auth/components/squaretile.dart';
import 'package:login_auth/services/google_auth_service.dart';

import '../components/my_button.dart';

class SignUpPage extends StatefulWidget {
  final Function()? onTap;
  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  // text field controller
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

// sign up ontap
  void signUserUp() async {
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
      print("-------------------01$message");
      showDialog(
          context: context,
          builder: (builder) {
            print("-------------------02");
            return AlertDialog(
              title: Text(message),
            );
          });
    }

    // try creating the user
    try {
      print("-------------------2");
      // check password and confirm password
      if (_passwordController.text == _confirmPasswordController.text) {
        print("-------------------1");
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        // pop the loading circle
        Navigator.pop(context);
      } else {
        print("-------------------3");
        //show error message
        errorMessage("Password donot match");

        print("-------------------4");
      }
    } on FirebaseAuthException catch (e) {
      print("-------------------5");
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
                height: 25,
              ),
              //logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(
                height: 25,
              ),

              // Lets create an account for you
              Text(
                "Let's create an account for you!",
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
              // confirm password

              MyTextField(
                controller1: _confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: true,
              ),

              const SizedBox(
                height: 10,
              ),

              //Signup button

              MyButton(onTap: signUserUp, btnName: "Sign Up"),

              const SizedBox(
                height: 5,
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
                height: 25,
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

              //already a member? Login Now

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Allready have an Account?"),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login Now",
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
