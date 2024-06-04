import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/booking_entity.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity data;
  const BookingCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                data.userId ?? '',
                style: theme.publicSansFonts.mediumStyle(
                    fontSize: 16, height: 22, fontColor: AppColors.black23),
              ),
            ),
            Text(
              "₹ ${data.totalAmount}",
              style: theme.publicSansFonts.semiBoldStyle(
                  fontSize: 14, height: 22, fontColor: AppColors.black23),
            ),
          ],
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
    );
  }
}
