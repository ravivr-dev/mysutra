import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

class CenterNameWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const CenterNameWidget({
    super.key,
    required this.title,
   this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                style: theme.publicSansFonts.mediumStyle(
                  fontSize: 14,
                  fontColor: AppColors.black39,
                ),
              ),
            ),
            component.assetImage(path: Assets.iconsDropdown)
          ],
        ),
      ),
    );
  }
}
