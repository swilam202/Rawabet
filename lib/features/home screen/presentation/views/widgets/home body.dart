import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/loading state.dart';
import '../../controller/home page controller.dart';


class HomeBody extends StatelessWidget {
   HomeBody({super.key,required this.id});
   final String id;

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.put(HomePageController(id: id));
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
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        homePageController.contacts[index].image),
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
