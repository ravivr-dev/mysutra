import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension WidgetFunction on Widget {
  void dismissKeyboard() {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  Future<void> cancelFlutterToast() async {
    await Fluttertoast.cancel();
  }

  Future<void> showSuccessToast(
      {required final BuildContext context,
      required final String message}) async {
    await cancelFlutterToast();
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }

  Future<void> showErrorToast({
    required final BuildContext context,
    required final String message,
  }) async {
    log(message, name: "testerrTe");
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }

  void showDebugToast(
      {required final BuildContext context, required final String message}) {
    Fluttertoast.showToast(
      msg: message,
      //textColor: AppColors.white,
      //backgroundColor: AppColors.app_color,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }
}
