import 'package:flutter/material.dart';

Widget customTextField({
  required String labelText,
  required String hintText,
  required TextEditingController controller,
  required bool obscure,
  required Widget icon,
  required String? Function(String?) valid,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    child: TextFormField(
      obscureText: obscure,
      controller: controller,
      obscuringCharacter: '*',
        validator: valid,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(23, 121, 235, 1.0),
            width: 2,
          ),
        ),
        suffixIcon: icon,
        fillColor: const Color.fromRGBO(160, 211, 254, 0.2),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color.fromRGBO(23, 121, 235, 1.0),
            width: 2,
          ),
        ),
      ),
    ),
  );
}
