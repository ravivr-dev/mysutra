import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class EditDeleteBottomsheet extends StatelessWidget {
  const EditDeleteBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: AppColors.white,
      child: Column(
        children: [component.text('Edit Post'), component.text('Delete Post')],
      ),
    );
  }
}
