import 'package:flutter/material.dart';

import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class EditDeleteBottomsheet extends StatelessWidget {
  final String articleId;
  final VoidCallback onTapEdit;
  final VoidCallback onTapDelete;

  const EditDeleteBottomsheet(
      {super.key,
      required this.articleId,
      required this.onTapEdit,
      required this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppColors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
              onTap: onTapEdit,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.edit,
                    color: AppColors.grey92,
                  ),
                  component.spacer(width: 5),
                  component.text('Edit Post',
                      style: theme.publicSansFonts.regularStyle(
                          fontColor: AppColors.grey92, fontSize: 15)),
                ],
              )),
          component.divider(),
          InkWell(
              onTap: onTapDelete,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(
                  Icons.delete,
                  color: AppColors.error,
                ),
                component.spacer(width: 5),
                component.text('Delete Post',
                    style: theme.publicSansFonts
                        .regularStyle(fontColor: AppColors.error, fontSize: 15))
              ]))
        ],
      ),
    );
  }
}
