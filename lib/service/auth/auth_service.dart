import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  /// instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// instance of firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  /// sign user in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      /// sign in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      /// add new a document for the user in users collection if it doesn't already exists
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    }

    /// catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  /// create a new user
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      /// create a new doc for the user in the users collections
      _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  /// sign user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
