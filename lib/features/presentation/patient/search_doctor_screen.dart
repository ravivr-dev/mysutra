import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/search_with_filter_widget.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/core/utils/custom_inkwell.dart';
import 'package:my_sutra/core/utils/screentop_handler.dart';
import 'package:my_sutra/features/presentation/patient/search/bottomsheet/dr_bottom_sheet.dart';
import 'package:my_sutra/features/presentation/patient/widgets/dashboard_helper_items.dart';
import 'package:my_sutra/features/presentation/patient/widgets/date_widget.dart';
import 'package:my_sutra/generated/assets.dart';

class SearchDoctorScreen extends StatefulWidget {
  const SearchDoctorScreen({super.key});

  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomInkwell(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 40),
                decoration: AppDeco.drawerDecoration,
                width: context.screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ScreenTopHandler(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back",
                              style: theme.publicSansFonts.regularStyle(
                                fontColor: AppColors.blackColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Sahil Gopal",
                              style: theme.publicSansFonts.mediumStyle(
                                fontColor: AppColors.blackColor,
                                fontSize: 24,
                                height: 28,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              Constants.tempNetworkUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SearchWithFilter(
                      onTapFilter: () {},
                    ),
                    const SizedBox(height: 32),
                    const DashboardHelperItems(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Appointments",
                      style: theme.publicSansFonts.semiBoldStyle(
                          fontSize: 16, fontColor: AppColors.blackColor),
                    ),
                    const DateWidget()
                  ],
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 40, top: 20),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.showBottomSheet(
                          const DrBottomSheet(),
                          borderRadius: 22,
                        );
                      },
                      child: Container(
                        decoration: AppDeco.cardDecoration,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  Constants.tempNetworkUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Dr. Surya Pandey",
                                        style: theme.publicSansFonts
                                            .mediumStyle(
                                                fontSize: 12,
                                                height: 20,
                                                fontColor:
                                                    AppColors.blackColor),
                                      ),
                                      const SizedBox(width: 5),
                                      component.assetImage(
                                          path: Assets.iconsVerify),
                                    ],
                                  ),
                                  Text(
                                    "Physiotherapist",
                                    style: theme.publicSansFonts.regularStyle(
                                        fontSize: 10,
                                        height: 20,
                                        fontColor: AppColors.black81),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.blackF2,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.schedule_outlined,
                                          size: 11,
                                          color: AppColors.black81,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Nov 24, 9:00 AM",
                                          style: theme.publicSansFonts
                                              .regularStyle(
                                                  fontSize: 10,
                                                  fontColor: AppColors.black64),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            component.assetImage(path: Assets.iconsThreeDots),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
