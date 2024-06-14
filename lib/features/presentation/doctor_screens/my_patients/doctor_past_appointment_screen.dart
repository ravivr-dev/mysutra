import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/generated/assets.dart';

class DoctorPastAppointmentScreen extends StatelessWidget {
  const DoctorPastAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _patientInfo(),
              // component.text('+ Add Prescription',
              //     style: theme.publicSansFonts.regularStyle(
              //         fontSize: 14, fontColor: AppColors.color0xFF8338EC)),
              component.spacer(height: 12),
              component.divider(color: AppColors.dividerColor),
              component.spacer(height: 12),
              component.text('Past Appointments',
                  style: theme.publicSansFonts.regularStyle(fontSize: 16)),
              component.spacer(height: 12),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _appointmentCard();
                  },
                  separatorBuilder: (_, i) {
                    return component.spacer(height: 12);
                  },
                  itemCount: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _patientInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        component.assetImage(
            path: Assets.imagesDefaultAvatar,
            height: 72,
            width: 72,
            borderRadius: 8),
        component.spacer(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            component.text('Kathryn Murphy',
                style: theme.publicSansFonts.mediumStyle(fontSize: 16)),
            component.spacer(
              height: 4,
            ),
            Row(
              children: [
                component.assetImage(path: Assets.iconsCallReceivedIcon),
                component.spacer(width: 2),
                component.text(
                  '+91 9525273890',
                  style: theme.publicSansFonts
                      .regularStyle(fontSize: 14, fontColor: AppColors.black81),
                ),
              ],
            ),
            component.text('Last appointment on Nov 24, 9:00 AM',
                style: theme.publicSansFonts.regularStyle(
                    fontSize: 14, fontColor: AppColors.color0xFF85799E))
          ],
        ),
      ],
    );
  }

  Widget _appointmentCard() {
    return Container(
      height: 152,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(12)),
    );
  }
}
