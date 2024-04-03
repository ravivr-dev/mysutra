import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/text_form_field_widget.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/presentation/patient/widgets/calendar_widget.dart';

class FindDoctorScreen extends StatefulWidget {
  const FindDoctorScreen({super.key});

  @override
  State<FindDoctorScreen> createState() => _FindDoctorScreenState();
}

class _FindDoctorScreenState extends State<FindDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 40),
              decoration: AppDeco.drawerDecoration,
              width: context.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppDeco.screenTopHandler,
                  Text(
                    "Let's find your\ndoctor",
                    style: theme.publicSansFonts.mediumStyle(
                      fontColor: AppColors.blackColor,
                      fontSize: 24,
                      height: 28,
                    ),
                  ),
                  const TextFormFieldWidget(hintText: "Search"),
                  const SizedBox(height: 20),
                  const CalendarWidget(),
                ],
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 40, top: 20),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: AppDeco.cardDecoration,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              NetworkImage(Constants.tempNetworkUrl),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dr. Surya Pandey",
                                style: theme.publicSansFonts.mediumStyle(
                                    fontSize: 12,
                                    fontColor: AppColors.blackColor),
                              ),
                              Text(
                                "Physiotherapist",
                                style: theme.publicSansFonts.regularStyle(
                                    fontSize: 10, fontColor: AppColors.black81),
                              ),
                              Text(
                                "02:30 AM",
                                style: theme.publicSansFonts.regularStyle(
                                    fontSize: 10,
                                    fontColor: AppColors.blackColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.blackF2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Start in 2 hours",
                            style: theme.publicSansFonts.regularStyle(
                                fontSize: 10, fontColor: AppColors.black64),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
