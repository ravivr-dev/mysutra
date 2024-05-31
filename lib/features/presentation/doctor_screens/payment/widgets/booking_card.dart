import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
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
                "Sahil Rana",
                style: theme.publicSansFonts.mediumStyle(
                    fontSize: 16, height: 22, fontColor: AppColors.black23),
              ),
            ),
            Text(
              "₹ 800",
              style: theme.publicSansFonts.semiBoldStyle(
                  fontSize: 14, height: 22, fontColor: AppColors.black23),
            ),
          ],
        ),
        Text(
          "13 Mar 2024",
          style: theme.publicSansFonts.regularStyle(
              fontSize: 14,
              height: 22,
              fontColor: AppColors.neutralAlpha.withOpacity(0.6)),
        ),
      ],
    );
  }
}
