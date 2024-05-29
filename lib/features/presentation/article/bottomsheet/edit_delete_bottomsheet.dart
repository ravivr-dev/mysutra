import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/article/cubit/article_cubit.dart';

class EditDeleteBottomsheet extends StatelessWidget {
  final String articleId;

  const EditDeleteBottomsheet({super.key, required this.articleId});

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
              onTap: () {},
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
              onTap: () => _confirmDeleteDialog(context),
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

  void _confirmDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            iconPadding: const EdgeInsets.only(top: 40, bottom: 25),
            content: component.text(
              "Are you sure you want to delete ?",
              style: theme.publicSansFonts
                  .regularStyle(fontSize: 16, fontColor: Colors.grey),
              textAlign: TextAlign.center,
            ),
            actionsPadding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      context
                          .read<ArticleCubit>()
                          .deleteArticle(articleId: articleId);
                      AiloitteNavigation.back(context);
                    },
                    child: Text(
                      'Yes',
                      style: theme.publicSansFonts.mediumStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    child: Text(
                      "No",
                      style: theme.publicSansFonts.mediumStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }
}
