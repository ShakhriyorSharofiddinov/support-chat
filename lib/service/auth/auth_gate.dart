import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../pages/home.dart';
import '../../pages/login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          /// user is logged in
          if(snapshot.hasData){
            return const  HomePage();
          }
          /// user is Not logged in
          else{
            return const LoginPage();
          }
        },
      ),
    );
  }
}
