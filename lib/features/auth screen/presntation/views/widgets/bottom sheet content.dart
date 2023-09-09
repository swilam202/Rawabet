import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/auth controller.dart';

class BottomSheetContent extends StatelessWidget {
    BottomSheetContent({super.key,});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    return Wrap(
      children: [
        ListTile(
          title: const Text('Camera'),
          leading: const Icon(Icons.camera),
          onTap: () =>
              controller.takeImage(ImageSource.camera, context),
        ),
        ListTile(
          title: const Text('Gallery'),
          leading: const Icon(Icons.image),
          onTap: () =>
              controller.takeImage(ImageSource.gallery, context),
        ),
      ],
    );
  }
}
