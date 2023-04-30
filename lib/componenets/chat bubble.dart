import 'package:flutter/material.dart';

Widget bubble(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [

            Color.fromRGBO(130, 203, 250, 1.0),
            Color.fromRGBO(23, 121, 235, 1.0),

          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    ),
  );
}
