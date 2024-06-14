import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/utils.dart';
import 'package:my_sutra/generated/assets.dart';

class AppLogoWithTermsConditionWidget extends StatelessWidget {
  const AppLogoWithTermsConditionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        component.assetImage(
            path: Assets.iconsLogo1, height: 50, width: 100, fit: BoxFit.contain),
        InkWell(
          onTap: () => Utils.openTermsAndConditionPage(),
          child: Text(
            "T&C | Privacy policy",
            style: theme.publicSansFonts
                .semiBoldStyle(fontSize: 14, fontColor: AppColors.primaryColor),
          ),
        )
      ],
    );
  }
}
