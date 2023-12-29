import 'package:flutter/material.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:toast/toast.dart';

class ToastUiFake {
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static simpleToast(BuildContext context, String message) {
    ToastContext().init(context);
    return Toast.show(
      message,
      border: Border.all(color: ThemeConfig.fontColor, width: 1),
      backgroundColor: ThemeConfig.white,
      textStyle: StyleConfig.fs14fwNormal,
      duration: Toast.lengthLong,
      gravity: Toast.center,
    );
  }

  static show(BuildContext mainContext, String message) {
    showDialog(
      context: mainContext,
      builder: (context) {
        Future.delayed(Duration(seconds: 2)).then((value) {
          Navigator.pop(context); // Use the dialog's context, not the mainContext
        });
        return AlertDialog(
          content: Text(
            message,
            style: StyleConfig.fs14fwNormal,
          ),
        );
      },
    );
  }

  static showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
