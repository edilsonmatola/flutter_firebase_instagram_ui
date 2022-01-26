import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // * Adding the profile picture (image) to firebase storage
  Future<String> uploadImageToStorage({
    required String childName,
    required Uint8List file,
    required bool isPost,
  }) async {
    // * .ref ->  Pointer to the file in our storage (firebase), it can refer to a file that exists or does not exist.
    // * first child -> child is a folder, that can exist or not
    // * second child -> will be the user Id, so we need to get the user ID.
    var pathReference =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      // * Generate a unique ID for the post
      final uniqueIdPost = const Uuid().v1();
      // * The name of the post will be unique Id
      pathReference = pathReference.child(uniqueIdPost);
    }

    // * Putting the file in the firebase, in this case Data because we are using
    // Uint8List
    final uploadTask = pathReference.putData(file);

    // Waiting for the upload
    final snapshot = await uploadTask;

    // Fetching the download link
    final downloadUrl = await snapshot.ref.getDownloadURL();

    // Returning the download link
    return downloadUrl;
  }
}
