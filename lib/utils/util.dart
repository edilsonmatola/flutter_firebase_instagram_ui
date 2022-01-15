import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage(ImageSource imageSource) async {
  final _imagePicker = ImagePicker();

  final _file = await _imagePicker.pickImage(
    source: imageSource,
  );

  if (_file != null) {
    return _file.readAsBytes();
  }
  debugPrint('No image selected');
}
