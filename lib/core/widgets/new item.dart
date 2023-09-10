import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../componenets/snack bar.dart';
import 'custom text field.dart';


class AddNewItem extends StatelessWidget {
  const AddNewItem({super.key,required this.label,required this.onPressed,required this.controller,required this.hint,});

  final Function() onPressed;
  final TextEditingController controller;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          CustomTextField(
            labelText: label,
            hintText: hint,
            controller: controller,
            icon: const Icon(Icons.drive_file_rename_outline),
          ),
          FloatingActionButton(
            onPressed: onPressed,
            child: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
