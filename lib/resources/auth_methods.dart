import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up user in the firebase
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List profilePicture,
  }) async {
    var result = 'Some error occurred!';
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
        debugPrint(credential.user!.uid);

        final photoUrl = await StorageMethods().uploadImageToStorage(
          'profilePictures',
          profilePicture,
          false,
        );

        // Add user to Firestore Database
        await _firestore.collection('users').doc(credential.user!.uid).set(
          {
            'username': username,
            'uid': credential.user!.uid,
            'password': password,
            'bio': bio,
            'followers': [],
            'following': [],
            'photoUrl': photoUrl,
          },
        );
        result = 'Registered successfully.';
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        result = 'The email is badly formatted.';
      } else if (error.code == 'weak-password') {
        result = 'Your password should be at least 6 characters.';
      }
    } catch (error) {
      result = error.toString();
    }
    // await _firestore.collection('users').add(data)
    return result;
  }
}
