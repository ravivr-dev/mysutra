import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? showDrawer;
  final bool? centerTitle;
  final bool isTransparentAppbar;
  final bool? showNotification;
  final bool? showAddEnrollments;

  const CustomAppBar({
    super.key,
    this.title,
    this.showDrawer = false,
    this.centerTitle = false,
    this.isTransparentAppbar = false,
    this.showNotification = false,
    this.showAddEnrollments = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      scrolledUnderElevation: 0.0,
      backgroundColor: isTransparentAppbar ? null : AppColors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          if (showDrawer!) {
            Scaffold.of(context).openDrawer();
          } else {
            Navigator.pop(context);
          }
        },
        icon: showDrawer!
            ? const Icon(
                color: AppColors.grey92,
                Icons.menu_rounded,
                size: 30,
              )
            : const Icon(
                Icons.arrow_back,
                color: AppColors.grey92,
              ),
      ),
      title: Text(
        title ?? "",
        // style: theme.publicSansFonts.semiBoldStyle(fontSize: 25),
      ),
      actions: [
        if (showNotification!)
          IconButton(
            onPressed: () {
              // AiloitteNavigation.intent(context, AppRoutes.notificationRoute);
            },
            icon: const Icon(
              color: AppColors.grey92,
              Icons.notifications_none,
              size: 30,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
