import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/user data.dart';
import '../../../../../core/widgets/loading state.dart';
import '../../controller/home page controller.dart';


class HomeBody extends StatelessWidget {
   HomeBody({super.key});


  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.put(HomePageController(id:  getIt.get<String>()));
    return StreamBuilder(
      stream: homePageController.users.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingState();
        } else {
          homePageController.loadContacts(snapshot);

          return ListView.separated(
            separatorBuilder: (context,index){
              return Divider(
                thickness: 1,
                endIndent: 15,
                indent: 15,
              );
            },
            itemCount: homePageController.contacts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
                child: ListTile(
                  onTap:  () {
                    homePageController.navigateToChatPage(context, index);
                  },
                  splashColor: kLightColor,
                  leading: CachedNetworkImage(
                     imageUrl: homePageController.contacts[index].image,
                     placeholder: (context, url) => LoadingState(),
                     errorWidget: (context, url, error) => Icon(Icons.error),

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
