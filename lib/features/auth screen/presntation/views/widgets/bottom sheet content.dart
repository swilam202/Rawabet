import 'package:flutter/material.dart';

class ImageBottomSheet extends StatelessWidget {
  const ImageBottomSheet({
    super.key,
    required this.cameraFunction,
    required this.galleryFunction,
  });

  final Function() cameraFunction;
  final Function() galleryFunction;

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
