import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/user data.dart';
import '../../../../core/widgets/default drawer.dart';
import '../controller/home page controller.dart';
import 'widgets/home body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

 HomePageController homePageController = Get.put(HomePageController(
  id: UserData.getData('id'),
));

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //homePageController.loadContacts(snapshot)
    updateToken();

  }

  Future<void> updateToken() async {
    String? token = await FirebaseMessaging.instance.getToken();


    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: UserData.getData('id'))
        .get();
    querySnapshot.docs.forEach(
      (doc) async {
        await doc.reference.update(
          {
            'token': token,
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Rawabet'),
        centerTitle: true,

      ),
      body: const HomeBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kLightColor,
        onPressed: () {
          homePageController.addContactBottomSheet(context);
        },
        child: const Icon(Icons.message),
      ),
      drawer: const DefaultDrawer(),
    );
  }
}
