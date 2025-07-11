import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String text, required ToastStates state}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.success:
      return Colors.green;
    case ToastStates.error:
      return Colors.red;
    case ToastStates.warning:
      return Colors.amber;
  }
}
