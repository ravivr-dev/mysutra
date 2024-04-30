import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class IconContainer extends StatelessWidget {
  final String icon;
  final Color firstColor;
  final Color secondColor;

  final String title;
  final Function()? onTap;

  const IconContainer({
    super.key,
    required this.icon,
    required this.firstColor,
    required this.secondColor,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 50,
            width: 50,
            // foregroundDecoration: BoxDecoration(
            //   color: backgroundColor,
            //   borderRadius: BorderRadius.circular(6),
            // ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [firstColor, secondColor]),
              // color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: component.assetImage(path: icon),
          ),
        ),
        // if (title != null) ...[
        const SizedBox(height: 10),
        SizedBox(
          width: 80,
          child: component.text(
            title,
            textAlign: TextAlign.center,
            style: theme.publicSansFonts.mediumStyle(
                fontSize: 12, fontColor: AppColors.color0xFF1E293B),
          ),
        )
        // ]
      ],
    );
  }
}
