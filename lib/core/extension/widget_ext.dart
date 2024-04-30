import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

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

  void showProgressDialog(BuildContext context, final String progressTitle) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PopScope(
            canPop: false,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.blackColor.withOpacity(.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          strokeWidth: 4,
                        ),
                        component.spacer(height: 20),
                        component.text(
                          progressTitle,
                          style: theme.publicSansFonts.semiBoldStyle(
                            fontSize: 16,
                            fontColor: AppColors.greyD9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
