import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class PaymentHistoryCard extends StatelessWidget {
  const PaymentHistoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 24,
              color: AppColors.color0xFF88A6FF.withOpacity(.05),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '17/09/2024',
            style: theme.publicSansFonts.regularStyle(
                fontSize: 14, height: 20, fontColor: AppColors.grey81),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Dr. Rita Rawat',
                  style: theme.publicSansFonts.mediumStyle(
                      fontSize: 16,
                      height: 20,
                      fontColor: AppColors.blackColor),
                ),
              ),
              Text(
                '₹ 200.0',
                style: theme.publicSansFonts.semiBoldStyle(
                    fontSize: 16, height: 20, fontColor: AppColors.blackColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Otologist',
                  style: theme.publicSansFonts.regularStyle(
                      fontSize: 14, height: 20, fontColor: AppColors.black01),
                ),
              ),
              Text(
                'Download receipt',
                style: theme.publicSansFonts.semiBoldStyle(
                    fontSize: 16, height: 20, fontColor: AppColors.color0xFF8338EC),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
