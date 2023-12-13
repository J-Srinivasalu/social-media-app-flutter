import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  void callToast(String? message, {MaterialColor? backgroundColor}) {
    Fluttertoast.showToast(
        msg: message ?? "",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor ?? Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}