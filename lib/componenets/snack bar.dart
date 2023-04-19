import 'package:get/get.dart';
import 'package:flutter/material.dart';

showSnack(String title,String message){
  return Get.snackbar(title, message,icon: const Icon(Icons.warning,color: Colors.red),snackPosition: SnackPosition.BOTTOM,colorText: Colors.red,);
}