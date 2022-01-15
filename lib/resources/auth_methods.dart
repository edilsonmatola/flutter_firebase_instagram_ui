import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List profilePicture}) async {
    var result = 'Some error occured.';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // Register User in the Firebase (Authentication)
        final credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Add user to Firestore Database
        await _firestore.collection('users').doc(credential.user!.uid).set(
          {
            'uid': credential.user!.uid,
            'username': username,
            'password': password,
            'bio': bio,
            'followers': [],
            'following': [],
          },
        );
      }
    } catch (err) {
      result = err.toString();
    }
    // await _firestore.collection('users').add(data)
    return result;
  }
}
