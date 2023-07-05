import 'package:chatapp/componenets/snack%20bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/contacts.dart';

class HomePageController extends GetxController {
  HomePageController({this.args});

  String? args;
  RxString userName = 'held'.obs;
  RxString userImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCgOdPs_lDLRw3h6HgRHYJDvoX3VlEMz2Rm6jalq3fGA&s'
          .obs;
  RxList<Contacts> contacts = <Contacts>[].obs;
  RxList contactsList = [].obs;
  var users = FirebaseFirestore.instance.collection('users');
  Rx<TextEditingController> contactController = TextEditingController().obs;

  addContacts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await users.where('id', isEqualTo: args).get();
    QuerySnapshot<Map<String, dynamic>> userSnapshot =
        await users.where('id', isEqualTo: contactController.value.text).get();
    List queryContacts = querySnapshot.docs[0]['contacts'];

    if (queryContacts.contains(contactController.value.text)) {
      showSnack('Warning',
          'The user you are trying to add already exists on your contacts');
    }
    if (userSnapshot.size > 0) {
      querySnapshot.docs.forEach((doc) async {
        await doc.reference.update(
          {
            'contacts': FieldValue.arrayUnion([contactController.value.text]),
          },
        );
      });
    } else {
      showSnack('Error', 'Sorry no user found for this email');
    }
  }
}
