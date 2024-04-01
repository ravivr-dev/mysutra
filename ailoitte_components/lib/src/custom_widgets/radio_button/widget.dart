import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';

const double defaultGap = 10;

class AiloitteRadioButtonWidget extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String? title;
  final TextStyle? titleStyle;
  final double? gap;

  const AiloitteRadioButtonWidget({
    Key? key,
    required this.isSelected,
    required this.onTap,
    this.title,
    this.titleStyle,
    this.gap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: gap??defaultGap),
          child: GestureDetector(
            onTap: onTap,
            child: Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            ),
          ),
        ),
        Visibility(
          visible: title != null,
          child: Flexible(
            child: AiloitteTextWidget(
              title,
              style: titleStyle,
            ),
          ),
        ),
      ],
    );
  }
}
