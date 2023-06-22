import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shakhriyor_sharofiddinov/pages/register.dart';

import '../service/auth/auth_service.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// text controllers
  final _email = TextEditingController();
  final _password = TextEditingController();

  /// sign in user
  void signIn() async {
    /// get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailPassword(_email.text, _password.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Center(
            child: ListView(
              children: [
                const SizedBox(
                  height: 90,
                ),

                /// logo
                const Icon(
                  Icons.message,
                  size: 110,
                ),
                const SizedBox(
                  height: 50,
                ),

                /// welcome back message
                const Center(
                    child: Text(
                  "Welcome back you've been missed!",
                  style: TextStyle(fontSize: 16),
                )),
                const SizedBox(
                  height: 30,
                ),

                /// email text-field
                MyTextField(_email, "Email", false),
                const SizedBox(
                  height: 10,
                ),

                /// password text-field
                MyTextField(_password, "Password", true),
                const SizedBox(
                  height: 60,
                ),

                /// sign in button
                MaterialButton(
                  onPressed: () {
                    signIn();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.black,
                  height: 56,
                  minWidth: double.infinity,
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                /// not a number? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const RegisterPage()));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      child: const Text(
                        "Register now",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
