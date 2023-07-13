import 'package:flutter/material.dart';

class Bubble1 extends StatelessWidget {
  Bubble1({required this.data, required this.isText, super.key});

  String data;
  bool isText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(27, 150, 241, 1.0),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(10),
        child: isText
            ? Text(
                data,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
            : Image.network(data),
      ),
    );
  }
}

class Bubble2 extends StatelessWidget {
  Bubble2({required this.data, required this.isText, super.key});

  String data;
  bool isText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(230, 230, 236, 1.0),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(10),
        child: isText
            ? Text(
                data,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              )
            : Image.network(data),
      ),
    );
  }
}

//
// Widget bubble(String text) {
//   return Align(
//     alignment: Alignment.centerLeft,
//     child: Container(
//       decoration: const BoxDecoration(
//         color: Color.fromRGBO(27, 150, 241, 1.0),
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(20),
//           topLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//         ),
//       ),
//       padding: const EdgeInsets.all(15),
//       margin: const EdgeInsets.all(10),
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 18,
//         ),
//       ),
//     ),
//   );
// }
//
// Widget bubble2(String text) {
//   return Align(
//     alignment: Alignment.centerRight,
//     child: Container(
//       decoration: const BoxDecoration(
//         color: Color.fromRGBO(230, 230, 236, 1.0),
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(20),
//           topLeft: Radius.circular(20),
//           bottomLeft: Radius.circular(20),
//         ),
//       ),
//       padding: const EdgeInsets.all(15),
//       margin: const EdgeInsets.all(10),
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: Colors.black,
//           fontSize: 18,
//         ),
//       ),
//     ),
//   );
// }
