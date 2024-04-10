import 'package:flutter/material.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/presentation/patient/widgets/icon_container.dart';
import 'package:my_sutra/generated/assets.dart';

class DashboardHelperItems extends StatefulWidget {
  const DashboardHelperItems({
    super.key,
  });

  @override
  State<DashboardHelperItems> createState() => _DashboardHelperItemsState();
}

class _DashboardHelperItemsState extends State<DashboardHelperItems> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconContainer(
          icon: Assets.iconsFreeze,
          backgroundColor: AppColors.colorFF9F12.withOpacity(0.16),
          title: "Obstetrician",
          onTap: () {
            // AiloitteNavigation.intent(context, AppRoutes.markAttendanceRoute);
          },
        ),
        IconContainer(
          icon: Assets.iconsCheckup,
          backgroundColor: AppColors.color56CA7E.withOpacity(0.16),
          title: "Andrologist",
          onTap: () {
            // AiloitteNavigation.intent(context, AppRoutes.attendanceStatusRoute);
          },
        ),
        IconContainer(
          icon: Assets.iconsVirus,
          backgroundColor: AppColors.colorFF6161.withOpacity(0.16),
          title: "Urologist",
          onTap: () {
            // getCenterBottomSheet(
            //   callback: (center) {
            //     Navigator.pop(context);
            //     AiloitteNavigation.intentWithData(
            //         context, AppRoutes.coachingScheduleRoute, center);
            //   },
            // );
          },
        ),
        IconContainer(
            icon: Assets.iconsVirus,
            backgroundColor: AppColors.purple.withOpacity(0.16),
            title: "Pediatric ",
            onTap: () {}
            // AiloitteNavigation.intent(context, AppRoutes.leaderboardRoute),
            ),
      ],
    );
  }

  // getCenterBottomSheet({required Function(CenterItem) callback}) {
  //   context.showBottomSheet(
  //     isScrollControlled: false,
  //     isDismissible: true,
  //     SelectCenterBottomSheet(
  //       callback: callback,
  //     ),
  //   );
  // }
}
