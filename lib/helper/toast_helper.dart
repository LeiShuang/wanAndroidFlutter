import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  //显示普通Toast
  static void showToast(String toastMessage) {
    Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIos: 1,
        fontSize: 16.0,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.black);
  }
  //显示警示信息
  static void showWarning(String toastMessage){
    Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIos: 1,
        fontSize: 16.0,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.amberAccent[300]);
  }
}
