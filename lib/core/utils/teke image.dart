
import 'package:path/path.dart';
import 'dart:io';

import 'package:chatapp/core/utils/user%20data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> takeImage(ImageSource source,) async {
  File file;
  ImagePicker imagePicker = ImagePicker();
  var image = await imagePicker.pickImage(source: source);
  if (image != null) {
    file = File(image.path);
    String name = basename(image.path);
    var reference = FirebaseStorage.instance.ref('Rawabet/images/$name');
    await reference.putFile(file);
    String? url = await reference.getDownloadURL();
    return url;
  }
}



