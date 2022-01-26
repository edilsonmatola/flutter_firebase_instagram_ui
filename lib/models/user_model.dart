import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });

  final String uid;
  final String username;
  final String email;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'email': email,
        'bio': bio,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following,
      };

  static UserModel fromSnapshot(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'].toString(),
      username: snapshot['username'].toString(),
      email: snapshot['email'].toString(),
      bio: snapshot['bio'].toString(),
      photoUrl: snapshot['photoUrl'].toString(),
      followers: snapshot['followers'] as List<dynamic>,
      following: snapshot['following'] as List<dynamic>,
    );
  }
}
