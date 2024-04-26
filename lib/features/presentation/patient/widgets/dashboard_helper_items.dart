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
    return SizedBox(
      height: 76,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          IconContainer(
            icon: Assets.iconsFreeze,
            firstColor: AppColors.color0xFF5892FD,
            secondColor: AppColors.color0xFF246EF8,
            title: "Obstetrician",
            onTap: () {
              // AiloitteNavigation.intent(context, AppRoutes.markAttendanceRoute);
            },
          ),
          IconContainer(
            icon: Assets.iconsCheckup,
            firstColor: AppColors.color0xFF15C0B6,
            secondColor: AppColors.color0xFF1FD1C7,
            title: "Andrologist",
            onTap: () {
              // AiloitteNavigation.intent(context, AppRoutes.attendanceStatusRoute);
            },
          ),
          IconContainer(
            icon: Assets.iconsVirus,
            firstColor: AppColors.color0xFF8338EC,
            secondColor: AppColors.color0xFF9C64EA,
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
              firstColor: AppColors.color0xFFFF1100,
              secondColor: AppColors.color0xFFD66C65,
              title: "Pediatric ",
              onTap: () {}
              // AiloitteNavigation.intent(context, AppRoutes.leaderboardRoute),
              ),
        ],
      ),
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
