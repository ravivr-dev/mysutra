
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class WithdrawCard extends StatelessWidget {
  const WithdrawCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "₹  8,000.00",
          style: theme.publicSansFonts.semiBoldStyle(
              fontSize: 14,
              height: 22,
              fontColor: AppColors.black23),
        ),
        Text(
          "13 Mar 2024",
          style: theme.publicSansFonts.regularStyle(
              fontSize: 14,
              height: 22,
              fontColor:
                  AppColors.neutralAlpha.withOpacity(0.6)),
        ),
      ],
    );
  }
}
