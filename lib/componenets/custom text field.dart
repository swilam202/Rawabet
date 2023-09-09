// import 'package:flutter/material.dart';
//
// class CustomTextField extends StatelessWidget {
//   CustomTextField({
//     required this.labelText,
//     required this.hintText,
//     required this.controller,
//     required this.icon,
//     this.obscure,
//     this.valid,
//     super.key,
//   });
//
//   String labelText;
//   String hintText;
//   TextEditingController controller;
//   bool? obscure;
//   Widget icon;
//   String? Function(String?)? valid;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//       child: TextFormField(
//
//         obscureText: obscure ?? false,
//         controller: controller,
//         obscuringCharacter: '*',
//         validator: valid,
//         decoration: InputDecoration(
//
//           hintText: hintText,
//           labelText: labelText,
//
//           suffixIcon: icon,
//           fillColor: const Color.fromRGBO(160, 211, 254, 0.2),
//           filled: true,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: const BorderSide(
//               color: Color.fromRGBO(23, 121, 235, 1.0),
//               width: 2,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
