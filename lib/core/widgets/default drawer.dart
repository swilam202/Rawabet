import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../features/account screen/presentation/views/account page.dart';
import '../utils/constants.dart';
import '../utils/user data.dart';
import 'loading state.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Future<QuerySnapshot> user = FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: UserData.getData('id'))
        .get();
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingState();
                } else {
                  return Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: snapshot.data!.docs[0]['image'],
                          placeholder: (context, url) => const LoadingState(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data!.docs[0]['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AccountPage(
                  id: UserData.getData('id')!,
                  isSelfAccount: true,
                ),
              ),
            ),
            leading: const Icon(
              Icons.account_circle_rounded,
              color: kDarkColor,
            ),
            title: const Text(
              'Account',
              style: TextStyle(
                fontSize: 20,
                color: kDarkColor,
              ),
            ),
          ),
          ListTile(
            onTap: () async{
              UserData.deleteData('id');
            
              Navigator.of(context).pushReplacementNamed('login');
            },
            leading: const Icon(
              Icons.login,
              color: kDarkColor,
            ),
            title: const Text(
              'Change account',
              style: TextStyle(
                fontSize: 20,
                color: kDarkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
