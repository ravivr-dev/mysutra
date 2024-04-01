import 'package:intl/intl.dart';

extension DoubleFunctions on double {
  String percentage() {
    return "${toStringAsFixed(1)} %";
  }

  String inAmount() {
    return "\$ ${toStringAsFixed(2)}";
  }

  String compactTheNumber() {
    return NumberFormat.compact().format(this);
  }
}
