import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class SaveButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const SaveButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 24),
      height: 36,
      width: 73,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AppColors.color0xFFEBE2FF),
      child: Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: onTap,
          child: component.text('Save',
              textAlign: TextAlign.center,
              style: theme.publicSansFonts.semiBoldStyle(
                  fontColor: AppColors.primaryColor, fontSize: 14)),
        ),
      ),
    );
  }
}
