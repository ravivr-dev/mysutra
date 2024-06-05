import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/payment_history_entity.dart';

class PaymentHistoryCard extends StatelessWidget {
  final PaymentHistoryEntity data;
  final VoidCallback onTapDownloadReceipt;

  const PaymentHistoryCard({
    super.key,
    required this.data,
    required this.onTapDownloadReceipt,
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
          if (data.date != null)
            Text(
              "${DateFormat('dd/MM/yyyy').format(DateTime.parse(data.date!))}  ${data.time ?? ''}",
              style: theme.publicSansFonts.regularStyle(
                  fontSize: 14, height: 20, fontColor: AppColors.grey81),
            ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  data.fullName ?? '',
                  style: theme.publicSansFonts.mediumStyle(
                      fontSize: 16,
                      height: 20,
                      fontColor: AppColors.blackColor),
                ),
              ),
              Text(
                '₹ ${data.amount}',
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
                  data.specialization ?? '',
                  style: theme.publicSansFonts.regularStyle(
                      fontSize: 14, height: 20, fontColor: AppColors.black01),
                ),
              ),
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: onTapDownloadReceipt,
                child: Text(
                  'Download receipt',
                  style: theme.publicSansFonts.semiBoldStyle(
                      fontSize: 16,
                      height: 20,
                      fontColor: AppColors.color0xFF8338EC),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
