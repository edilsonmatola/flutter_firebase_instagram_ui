import 'dart:ffi';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // * Adding the profile picture (image) to firebase storage
  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    bool isPost,
  ) async {
    // * .ref ->  Pointer to the file in our storage (firebase), it can refer to a file that exists or does not exist.
    // * first child -> child is a folder, that can exist or not
    // * second child -> will be the user Id, so we need to get the user ID.
    final pathReference =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

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
