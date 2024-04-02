import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class AccountTypeItemWidget extends StatelessWidget {
  final AcountType data;
  const AccountTypeItemWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              component.assetImage(path: data.icon),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.neutral,
                size: 20,
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            data.title,
            style: theme.publicSansFonts.semiBoldStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            data.subtitle,
            style: theme.publicSansFonts
                .regularStyle(fontSize: 14, fontColor: AppColors.black49),
          ),
        ],
      ),
    );
  }
}

class AcountType {
  final String icon;
  final String title;
  final String subtitle;

  AcountType({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
