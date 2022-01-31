import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import '../models/posts_model.dart';
import 'storage_methods.dart';

class FirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // * Upload post
  Future<String> uploadPostImage({
    required String username,
    required String profileImage,
    required String description,
    required Uint8List file,
    required String uid,
  }) async {
    var result = 'Some error occurred';
    try {
      final photoUrl = await StorageMethods().uploadImageToStorage(
        childName: 'posts',
        file: file,
        isPost: true,
      );
      final postId = const Uuid().v1();
      final post = PostsModel(
        uid: uid,
        username: username,
        description: description,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profileImage: profileImage,
        likes: [],
      );

      await _firestore.collection('posts').doc(postId).set(post.toJson());

      result = 'Uploaded successfully';
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  // Update likes
  Future<void> likePost(
      {required String postId,
      required String uid,
      required List likes}) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (error) {
      debugPrint('$error');
    }
  }
}
