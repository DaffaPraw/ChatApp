import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'phone': '',
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailandPassword(
      String email, password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': '',
        'phone': '',
        'pfpurl':
            'https://firebasestorage.googleapis.com/v0/b/chatapp-dfdd5.appspot.com/o/images%2Favatar.jpg?alt=media&token=988476bd-3aa7-4226-83a2-46b564c5972f',
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
