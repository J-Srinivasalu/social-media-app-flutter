import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class UploadImageFrom extends StatelessWidget {
  final String title;
  final Function(File file) actionWithImage;
  const UploadImageFrom({
    super.key,
    required this.title,
    required this.actionWithImage,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UploadImageFromModel>.reactive(
        builder: (context, model, child) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.start,
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 37, bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      uploadFromOption(
                        Icons.camera_alt_rounded,
                        "Camera",
                        model.getFromCamera,
                        context,
                        actionWithImage,
                      ),
                      uploadFromOption(
                        Icons.image_rounded,
                        "Gallery",
                        model.getFromGallery,
                        context,
                        actionWithImage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        viewModelBuilder: () => UploadImageFromModel());
  }
}

Widget uploadFromOption(IconData icon, String title, Function action,
    BuildContext context, Function actionWithImage) {
  return InkWell(
    onTap: () async {
      File? image = await action();
      if (image != null) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        actionWithImage(image);
      }
    },
    child: Column(
      children: [
        Icon(icon),
        Text(title),
      ],
    ),
  );
}

class UploadImageFromModel extends BaseViewModel {
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
}
