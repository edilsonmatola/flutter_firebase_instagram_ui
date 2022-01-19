import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage(ImageSource imageSource) async {
  final _imagePicker = ImagePicker();

// XFile? for the web version too
  final _file = await _imagePicker.pickImage(
    source: imageSource,
  );

  if (_file != null) {
    return _file.readAsBytes();
  }
  debugPrint('No image selected');
}

// Function to show snackbar message
dynamic showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    ),
  );
}
