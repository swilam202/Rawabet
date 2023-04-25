import 'package:flutter/material.dart';

Widget bubble(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 166, 183, 1.0),
            Color.fromRGBO(52, 143, 217, 1.0),
            Color.fromRGBO(94, 128, 213, 1.0),
            Color.fromRGBO(40, 88, 215, 1.0),
            Color.fromRGBO(73, 17, 218, 1.0),
          ],
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
