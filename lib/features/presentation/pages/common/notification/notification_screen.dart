import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_app_bar.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(
        isTransparentAppbar: true,
        title: "Notifications",
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    foregroundImage: NetworkImage(Constants.tempNetworkUrl),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Annette Black",
                      style: theme.publicSansFonts.mediumStyle(
                          fontColor: AppColors.black39, fontSize: 18),
                    ),
                    Text(
                      "This is a dummy message.",
                      style: theme.publicSansFonts.regularStyle(
                          fontColor: AppColors.black1C.withOpacity(0.6),
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "2h ago",
                style: theme.publicSansFonts.regularStyle(
                    fontColor: AppColors.black1C.withOpacity(0.6),
                    fontSize: 14),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: AppColors.greyEC,
          );
        },
        itemCount: 12,
      ),
    );
  }
}
