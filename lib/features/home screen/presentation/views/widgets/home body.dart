import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/user data.dart';
import '../../../../../core/widgets/loading state.dart';
import '../../controller/home page controller.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.put(HomePageController(
      id: UserData.getData('id'),
    ));
    Stream<QuerySnapshot<Map<String, dynamic>>> users =
        FirebaseFirestore.instance.collection('users').snapshots();
    return StreamBuilder(
      stream: users,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingState();
        } else {
          homePageController.loadContacts(snapshot);

          return ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 2,
                endIndent: 15,
                indent: 15,
              );
            },
            itemCount: homePageController.contacts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: ListTile(
                  onTap: () {
                    homePageController.navigateToChatPage(context, index);
                  },
                  splashColor: kLightColor,
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    backgroundImage: CachedNetworkImageProvider(
                      homePageController.contacts[index].image,
                    ),
                  ),
                  title: Text(
                    '  ${homePageController.contacts[index].name}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
