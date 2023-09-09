import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../componenets/snack bar.dart';
import '../../../../core/widgets/custom text field.dart';
import '../../../../models/contacts.dart';


class HomePageController extends GetxController {
  HomePageController({this.id});

  String? id;
  RxString userName = ''.obs;
  RxString userImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCgOdPs_lDLRw3h6HgRHYJDvoX3VlEMz2Rm6jalq3fGA&s'
          .obs;
  RxList<Contacts> contacts = <Contacts>[].obs;
  RxList contactsList = [].obs;
  CollectionReference<Map<String, dynamic>> users = FirebaseFirestore.instance.collection('users');
  Rx<TextEditingController> contactController = TextEditingController().obs;

  Future<void> addContacts(BuildContext context) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await users.where('id', isEqualTo: id).get();
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
      Navigator.of(context).pop();
    } else {
      showSnack('Error', 'Sorry no user found for this email');
    }
  }

  void loadContacts(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
    contacts.value = [];
    contactsList.value = [];
    for (int i = 0; i < snapshot.data!.docs.length; i++) {
      if (snapshot.data!.docs[i]['id'] == id) {
        contactsList.value =
        snapshot.data!.docs[i]['contacts'];
        userName.value =
        snapshot.data!.docs[i]['name'];
        userImage.value =
        snapshot.data!.docs[i]['image'];
        break;
      }
    }

    for (int i = 0; i < contactsList.length; i++) {
      for (int j = 0; j < snapshot.data!.docs.length; j++) {
        if (contactsList[i] ==
            snapshot.data!.docs[j]['id']) {
          contacts.add(
            Contacts(
              contactsList[i],
              snapshot.data!.docs[j]['name'],
              snapshot.data!.docs[j]['image'],
            ),
          );
        }
      }
    }
  }

  void navigateToChatPage(BuildContext context,int index){
    Navigator.of(context).pushNamed(
      'texting',
      arguments: {
        'id': contacts[index].id,
        'name': contacts[index].name,
        'sender': id,
        'receiver': contacts[index].id,
        'image': contacts[index].image,
      },
    );
  }

  void addContactBottomSheet(BuildContext context){
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            CustomTextField(
              labelText: 'Add contact',
              hintText: 'Add someone to your contacts',
              controller: contactController.value,
              icon: Icon(Icons.person),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FloatingActionButton(
                onPressed: () async {
                  await addContacts(context);
                },
                child: const Icon(Icons.add_circle_outlined),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

}
