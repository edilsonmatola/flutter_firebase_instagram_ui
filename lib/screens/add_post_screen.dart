import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors_util.dart';
import '../utils/util.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  Future<void> postImage({
    required String uid,
    required String username,
    required String profileImage,
  }) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await FirestoreMethod().uploadPostImage(
        username: username,
        profileImage: profileImage,
        description: _descriptionController.text,
        file: _file!,
        uid: uid,
      );

      if (result == 'Uploaded successfully') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(content: 'Posted', context: context);
        popFromPostScreen();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(content: result, context: context);
      }
    } catch (error) {
      showSnackBar(content: error.toString(), context: context);
    }
  }

  Future<Future> _selectImageToPost(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            'Create a Post',
          ),
          children: [
            // * Upload from Camera (Take a photo)
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop(); //* Removing the dialog box
                final file = await pickImage(
                  ImageSource.camera,
                );
                setState(() {
                  _file = file;
                });
              },
              padding: EdgeInsets.all(20),
              child: const Text(
                'Take a photo',
              ),
            ),
            // * Upload from Gallery
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop(); //* Removing the dialog box
                final file = await pickImage(
                  ImageSource.gallery,
                );
                setState(() {
                  _file = file;
                });
              },
              padding: EdgeInsets.all(20),
              child: const Text(
                'Choose from gallery',
              ),
            ),
            // TODO: Make a better cancel option
            // * Cancel option
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(); //* Removing the dialog box
              },
              padding: EdgeInsets.all(20),
              child: const Text(
                'Cancel',
              ),
            ),
          ],
        );
      },
    );
  }

  void popFromPostScreen() {
    setState(() {
      _file = null;
    });
  }

  // TODO: Create similar post ui and functionality of Instagram

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Center(
            child: IconButton(
              onPressed: () => _selectImageToPost(context),
              icon: Icon(
                Icons.upload,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: const Text(
                'Post to',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: IconButton(
                onPressed: popFromPostScreen,
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => postImage(
                    uid: user.uid,
                    username: user.username,
                    profileImage: user.photoUrl,
                  ),
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                if (_isLoading)
                  const LinearProgressIndicator(
                    color: Colors.white,
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(),
                  ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.photoUrl,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .3,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Write a caption...',
                          border: InputBorder.none,
                        ),
                        maxLength: 8,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              alignment: FractionalOffset.topCenter,
                              fit: BoxFit.fill,
                              image: MemoryImage(
                                _file!,
                              ), //* MemoryImage for the Uint8List
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }
}
