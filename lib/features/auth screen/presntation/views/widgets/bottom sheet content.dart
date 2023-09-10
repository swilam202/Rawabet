import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/auth controller.dart';

class ImageBottomSheet extends StatelessWidget {
  ImageBottomSheet({
    super.key,
    required this.cameraFunction,
    required this.galleryFunction,
  });

  Function() cameraFunction;
  Function() galleryFunction;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          title: const Text('Camera'),
          leading: const Icon(Icons.camera),
          onTap: cameraFunction,
        ),
        ListTile(
          title: const Text('Gallery'),
          leading: const Icon(Icons.image),
          onTap: galleryFunction,
        ),
      ],
    );
  }
}
