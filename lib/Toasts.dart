import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  static void showSucssesToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white);
  }

  static void showFailedToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
   static void showWarningToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.yellow,
        textColor: Colors.black);
  }
}
