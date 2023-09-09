import 'package:flutter/material.dart';

import '../utils/constants.dart';


class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: kLightColor,
        backgroundColor: kDarkColor,
      ),
    );
  }
}
