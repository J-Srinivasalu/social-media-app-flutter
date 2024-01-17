import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> getFromGallery() async {
  File? image;
  XFile? pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    image = File(pickedFile.path);
  }
  return image;
}

Future<File?> getFromCamera() async {
  File? image;
  XFile? pickedFile = await ImagePicker().pickImage(
    source: ImageSource.camera,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    image = File(pickedFile.path);
  }
  return image;
}

Future<Uint8List> convertAssetImageToUint8List(String assetPath) async {
  ByteData data = await rootBundle.load(assetPath);
  List<int> bytes = data.buffer.asUint8List();
  return Uint8List.fromList(bytes);
}
