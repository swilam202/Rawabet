import 'package:flutter/material.dart';

class DefaultDrawer extends StatelessWidget {
  DefaultDrawer(
      {required this.context, required this.name, required this.image});

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
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
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
            onTap: () => Navigator.of(context).pushNamed('account'),
            leading: const Text(
              'Account',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            trailing: const Icon(
              Icons.account_circle_rounded,
              color: Colors.black,
            ),
          ),
          ListTile(
            onTap: () => Navigator.of(context).pushReplacementNamed('login'),
            leading: const Text(
              'Change account',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            trailing: const Icon(
              Icons.login,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
