import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/auth/auth_service.dart';
import '../widgets/text_field.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final  _email = TextEditingController();
  final  _password = TextEditingController();
  final  _confirmPassword = TextEditingController();


  /// sign in user
  void signUp() async {
    if(_password.text != _confirmPassword.text){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password do not match!")));
      return;
    }

    /// get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailPassword(_email.text, _password.text);
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
                const SizedBox(height: 90,),
                /// logo
                const Icon(
                  Icons.message,
                  size: 110,
                ),
                const SizedBox(height: 50,),

                /// welcome back message
                const Center(child: Text("Let's create an account for you!",style: TextStyle(fontSize: 16),)),
                const SizedBox(height: 30,),

                /// email text-field
                MyTextField(_email,"Email",false),
                const SizedBox(height: 10,),

                /// password text-field
                MyTextField(_password,"Password", false),
                const SizedBox(height: 10,),

                /// confirm password
                MyTextField(_confirmPassword,"Confirm password",false),
                const SizedBox(height: 60,),


                /// sign in button
                MaterialButton(
                  onPressed: () {
                    signUp();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.black,
                  height: 56,
                  minWidth: double.infinity,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30,),

                /// not a number? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a member? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("Login now", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),),
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
