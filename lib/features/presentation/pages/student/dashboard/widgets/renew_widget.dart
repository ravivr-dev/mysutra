import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

class RenewWidget extends StatelessWidget {
  final int remainingDays;
  const RenewWidget({
    super.key,
    required this.remainingDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: AppColors.purple.withOpacity(0.16),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          component.assetImage(path: Assets.iconsSubscriptionAlert),
          const SizedBox(width: 10),
          Text(
            "$remainingDays days left",
            style: theme.publicSansFonts.semiBoldStyle(fontSize: 14),
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primaryColor),
              child: Text(
                "Renew Now",
                style: theme.publicSansFonts
                    .semiBoldStyle(fontSize: 14, fontColor: AppColors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
