import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/debug_configuration.dart';

/// Localization class for loading different languages
class MyLocalizations extends AiloitteMyLocalizations {
  // /// Getting instance of this class
  static AiloitteMyLocalizations of(BuildContext context) {
    return AiloitteMyLocalizations.of(context);
  }

  /// This is for Dev purpose Only
  @override
  String getString(String key) =>
      DebugConfiguration.useLocalForString ? key : super.getString(key);
}
