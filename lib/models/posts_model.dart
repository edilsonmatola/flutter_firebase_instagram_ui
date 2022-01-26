import 'package:cloud_firestore/cloud_firestore.dart';

class PostsModel {
  PostsModel({
    required this.uid,
    required this.username,
    required this.description,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
  });

  final String uid;
  final String username;
  final String description;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'description': description,
        'postId': postId,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'profileImage': profileImage,
        'likes': likes,
      };

  static PostsModel fromSnapshot(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;
    return PostsModel(
      uid: snapshot['uid'].toString(),
      username: snapshot['username'].toString(),
      description: snapshot['description'].toString(),
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      postId: snapshot['postId'].toString(),
      postUrl: snapshot['postUrl'].toString(),
      profileImage: snapshot['profileImage'].toString(),
    );
  }
}
