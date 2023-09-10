import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'loading state.dart';


class CustomImage extends StatelessWidget {
  const CustomImage({super.key,required this.user});

  final Future<QuerySnapshot> user;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingState();
        } else {
          return CachedNetworkImage(
            imageUrl: snapshot.data!.docs[0]['image'],
            placeholder: (context, url) => LoadingState(),
            errorWidget: (context, url, error) =>
                Icon(Icons.error),
          );
        }
      },
    );
  }
}
