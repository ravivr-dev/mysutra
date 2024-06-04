import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/withdrawal_entity.dart';

class WithdrawCard extends StatelessWidget {
  final WithdrawalData data;
  const WithdrawCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "₹  ${data.amount}",
                style: theme.publicSansFonts.semiBoldStyle(
                    fontSize: 14, height: 22, fontColor: AppColors.black23),
              ),
              if (data.date != null)
                Text(
                  DateFormat('dd MMM yyyy').format(DateTime.parse(data.date!)),
                  style: theme.publicSansFonts.regularStyle(
                      fontSize: 14,
                      height: 22,
                      fontColor: AppColors.neutralAlpha.withOpacity(0.6)),
                ),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Text(data.status ?? ''))
      ],
    );
  }
}
