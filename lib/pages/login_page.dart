import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
        emailController.text,
        passController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF041C32),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 0),
              Icon(
                Icons.message,
                size: 80,
                color: Color(0xFFECB365),
              ),
              Text("Chat chat chat",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFECB365),
                    fontWeight: FontWeight.bold,
                  )),

              const SizedBox(height: 30),

              // Email Input
              MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false),

              // const SizedBox(height: 30),

              // Password Input
              MyTextField(
                  controller: passController,
                  hintText: 'Password',
                  obscureText: true),

              const SizedBox(height: 20),

              MyButton(
                  onTap: () {
                    signIn();
                  },
                  text: "Sign In"),

              const SizedBox(height: 5),

              Row(
                children: [
                  Text("Don't have an account?",
                      style: TextStyle(
                        color: Color(0xFFECB365),
                      )),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Create an Account",
                        style: TextStyle(
                          color: Color(0xFFECB365),
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
