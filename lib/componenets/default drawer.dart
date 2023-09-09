import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/widgets/loading state.dart';
import '../pages/Account.dart';

class DefaultDrawer extends StatelessWidget {
  DefaultDrawer({
    required this.id,
    required this.context,
    required this.name,
    required this.image,
  });

  String id;
  String image;
  String name;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,

                    imageUrl: image,
                    placeholder: (context, url) => LoadingState(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Account(
                  id: id,
                  name: name,
                  image: image,
                  isSelfAccount: true,
                ),
              ),
            ),
            leading: const Icon(
              Icons.account_circle_rounded,
              color: Color.fromRGBO(18, 109, 171, 1.0),
            ),
            title: const Text(
              'Account',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(18, 109, 171, 1.0),
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.of(context).pushReplacementNamed('login'),
            leading: const Icon(
              Icons.login,
              color: Color.fromRGBO(18, 109, 171, 1.0),
            ),
            title: const Text(
              'Change account',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(18, 109, 171, 1.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
