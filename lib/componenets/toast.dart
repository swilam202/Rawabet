


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String msg){
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color.fromRGBO(100, 100, 103, 1.0),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
