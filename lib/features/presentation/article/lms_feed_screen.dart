import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/article/widgets/article_widget.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class LMSUserFeed extends StatefulWidget {
  const LMSUserFeed({super.key});

  @override
  State<LMSUserFeed> createState() => _LMSUserFeedState();
}

class _LMSUserFeedState extends State<LMSUserFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(context.stringForKey(StringKeys.learningManagement)),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const ScrollPhysics(),
        itemBuilder: (_, index) {
          return const ArticleWidget();
        },
        itemCount: 15,
      ),
      floatingActionButton:
          UserHelper.role != UserRole.patient ? _buildSendButton() : null,
    );
  }

  Widget _buildSendButton() {
    return InkWell(
      onTap: () {
        AiloitteNavigation.intent(context, AppRoutes.createArticleRoute);
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColor),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              component.assetImage(path: Assets.iconsPlusSign),
              component.spacer(width: 5),
              component.text(
                'Create New',
                style: theme.publicSansFonts
                    .semiBoldStyle(fontSize: 14, fontColor: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
