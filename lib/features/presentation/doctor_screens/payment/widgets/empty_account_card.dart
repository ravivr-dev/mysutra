
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_small_button.dart';
import 'package:my_sutra/core/common_widgets/custom_small_outline_button.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

class EmptyAccountCard extends StatelessWidget {
  const EmptyAccountCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          component.assetImage(path: Assets.iconsWarning),
          const SizedBox(height: 12),
          component.text('No Payment methods found',
              style: theme.publicSansFonts.regularStyle(
                  fontSize: 16, fontColor: AppColors.black23)),
          const SizedBox(height: 17),
          CustomSmallOutlineButton(
            width: 230,
            onPressed: () {},
            text: 'Add Bank Account',
          ),
          const SizedBox(height: 10),
          CustomSmallButton(
            width: 230,
            onPressed: () {},
            text: "Add UPI Account",
          ),
        ],
      ),
    );
  }
}
