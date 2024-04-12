import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/generated/assets.dart';

import '../../../../core/utils/app_colors.dart';

class DoctorResultScreen extends StatelessWidget {
  const DoctorResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: component.assetImage(
                path: Assets.iconsInfluencer,
                height: 160,
                width: 160,
                fit: BoxFit.fill,
              ),
            ),
            component.spacer(height: 12),
            Align(
              alignment: Alignment.center,
              child: component.text('Dr. Rita Rawat',
                  style: theme.publicSansFonts.mediumStyle(
                    fontSize: 16,
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: component.text('AndroLogist | ₹2000.0 - ₹ 5000.0',
                  style: theme.publicSansFonts.regularStyle(
                    fontColor: AppColors.color0xFF526371,
                  )),
            ),
            component.spacer(height: 12),
            Row(
              children: [
                Expanded(child: _buildFollowButton()),
                component.spacer(width: 12),
                Expanded(child: _buildBookAppointmentButton()),
              ],
            ),
            component.spacer(height: 24),
            Row(children: [
              Expanded(
                  child: _buildDecoratedContainer(
                color: AppColors.color0xFF55ACEE,
                text: '1000+',
                subText: 'Patients',
                iconPath: Assets.iconsUser,
              )),
              component.spacer(width: 12),
              Expanded(
                  child: _buildDecoratedContainer(
                color: AppColors.color0xFFFB5607,
                text: '10 Years',
                subText: 'Experience',
                iconPath: Assets.iconsMedal,
              )),
              component.spacer(width: 12),
              Expanded(
                  child: _buildDecoratedContainer(
                color: AppColors.color0xFF8338EC,
                text: '4.5',
                subText: 'Ratings',
                iconPath: Assets.iconsStar,
              )),
            ]),
            component.spacer(height: 24),
            component.text('About doctor',
                style: theme.publicSansFonts.mediumStyle(
                  fontSize: 16,
                )),
            component.spacer(height: 8),
            component.text(
                'Gases or vapors that are accidentally released from industrial activities, such as factory operations or oil and gas extraction. These emissions contribute to climate change and air pollution and may pose health risks to nearby communities',
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.black81,
                )),
            component.spacer(height: 24),
            component.text('Working time',
                style: theme.publicSansFonts.mediumStyle(
                  fontSize: 16,
                )),
            component.spacer(height: 8),
            component.text('Mon-Sat (08:30 AM-9:00 PM)',
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.black81,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildDecoratedContainer({
    required String text,
    required String subText,
    required Color color,
    required String iconPath,
  }) {
    return Container(
      height: 101,
      width: 108,
      padding: const EdgeInsets.only(top: 12),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          component.text(text,
              style: theme.publicSansFonts.mediumStyle(
                fontSize: 16,
                fontColor: AppColors.blackColor,
              )),
          component.text(subText,
              style: theme.publicSansFonts.regularStyle(
                fontSize: 12,
                fontColor: AppColors.black81,
              )),
          component.spacer(height: 4),
          Expanded(
            child: Container(
              width: double.infinity,
              color: color.withOpacity(.1),
              child: component.assetImage(path: iconPath),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBookAppointmentButton() {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.color0xFF8338EC,
      ),
      child: component.text('Book Appointment',
          style: theme.publicSansFonts.semiBoldStyle(
            fontSize: 14,
            fontColor: AppColors.white,
          )),
    );
  }

  Widget _buildFollowButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add, color: AppColors.color0xFF8338EC),
          component.text(
            'Follow',
            style: theme.publicSansFonts.regularStyle(
              fontColor: AppColors.color0xFF8338EC,
            ),
          )
        ],
      ),
    );
  }
}
