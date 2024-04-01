import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/pages/coach/dashboard/widgets/icon_container.dart';
import 'package:my_sutra/generated/assets.dart';

class RateNowDashboardWidget extends StatelessWidget {
  const RateNowDashboardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              IconContainer(
                icon: Assets.iconsQuote,
                backgroundColor: AppColors.purple.withOpacity(0.16),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  "Review performance",
                  style: theme.publicSansFonts.semiBoldStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primaryColor),
            child: Text(
              "Rate now",
              style: theme.publicSansFonts
                  .semiBoldStyle(fontSize: 14, fontColor: AppColors.white),
            ),
          ),
        )
      ],
    );
  }
}
