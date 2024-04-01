import 'package:ailoitte_components/src/config/config.dart';
import 'package:flutter/material.dart';

extension AiloitteContextExtensions on BuildContext {
  bool get keyboardIsOpened {
    return MediaQuery.of(this).viewInsets.bottom != 0.0;
  }

  String stringForKeyObsolete(final String localizationKey) {
    return AiloitteMyLocalizations.of(this).getString(localizationKey);
  }

  String stringForKey(final String key) {
    return AiloitteMyLocalizations.of(this).getString(key);
  }

  List<String> listOfStringForKey(final String localizationKey) {
    return AiloitteMyLocalizations.of(this).getList(localizationKey);
  }

  Map getMapForKey(final String localizationKey) {
    return AiloitteMyLocalizations.of(this).getMap(localizationKey);
  }

  List<Map> getListOfMapForKey(final String localizationKey) {
    return AiloitteMyLocalizations.of(this).getMapList(localizationKey);
  }

  double get screenHeight {
    return MediaQuery.of(this).size.height;
  }

  double get screenWidth {
    return MediaQuery.of(this).size.width;
  }

  double get statusBarHeight {
    return MediaQuery.of(this).viewPadding.top;
  }

  void showBottomSheet(
    Widget widget, {
    bool isDismissible = false,
    double borderRadius = 20,
    Color? backgroundColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
  }) {
    showModalBottomSheet(
      context: this,
      backgroundColor: backgroundColor ?? const Color(0xFFF1F1F1),
      isScrollControlled: isScrollControlled,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      builder: (sheetContext) {
        return widget;
      },
    );
  }

  void navigateIntent(String route, {Object? args}) {
    AiloitteNavigation.intentWithData(this, route, args);
  }
}
