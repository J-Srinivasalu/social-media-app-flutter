import 'dart:io';

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
