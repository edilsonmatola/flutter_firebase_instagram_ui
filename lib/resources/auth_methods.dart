import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../models/user_model.dart';
import 'storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetail() async {
    final currentUser = _auth.currentUser!;
    final snapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return UserModel.fromSnapshot(snapshot);
  }

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
          childName: 'profilePictures',
          file: profilePicture,
          isPost: false,
        );

        final user = UserModel(
          uid: credential.user!.uid,
          username: username,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );

        // Add user to Firestore Database
        await _firestore.collection('users').doc(credential.user!.uid).set(
              user.toJson(),
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

  //* Loggin the user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    var result = 'Some error occurred';

    //* Error Handling
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // * waits for sign in
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = 'Successfully logged in!';
      } else {
        result = 'Please fill in all fields';
      }
    } on FirebaseAuthException catch (error) {
      // In case the user does not exist or not found
      if (error.code == 'user-not-found') {
        result = 'The user was not found';
        // Wrong password inserted
      } else if (error.code == 'wrong-password') {
        result = 'Please insert a valid password';
      }
    } catch (error) {
      result = error.toString();
    }
    return result;
  }
}
