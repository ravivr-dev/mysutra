import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/generated/assets.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: component.networkImage(
                url: Constants.tempNetworkUrl, height: 80, width: 80),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Surya Pandey",
                  style: theme.publicSansFonts.mediumStyle(
                    fontSize: 25,
                    fontColor: AppColors.black37,
                    height: 30,
                  ),
                ),
                Text(
                  "29 Yr",
                  style: theme.publicSansFonts.regularStyle(
                    fontSize: 14,
                    fontColor: AppColors.black49,
                    height: 23,
                  ),
                ),
                const SizedBox(height: 5),
                component.assetImage(path: Assets.iconsUproarBadge)
              ],
            ),
          )
        ],
      ),
    );
  }
}
