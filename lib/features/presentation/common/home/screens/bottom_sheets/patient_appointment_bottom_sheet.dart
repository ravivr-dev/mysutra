import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/core/common_widgets/time_container.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/appointment_entity.dart';
import 'package:my_sutra/routes/routes_constants.dart';

import '../../../../../../ailoitte_component_injector.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../generated/assets.dart';

class PatientAppointmentBottomSheet extends StatelessWidget {
  final AppointmentEntity entity;
  const PatientAppointmentBottomSheet({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  component.text('Anika Rawat',
                      style: theme.publicSansFonts.mediumStyle(
                        fontSize: 16,
                      )),
                  Row(
                    children: [
                      component.assetImage(path: Assets.iconsPhone2),
                      component.spacer(width: 2),
                      component.text('+91 9898767656',
                          style: theme.publicSansFonts.regularStyle(
                            fontColor: AppColors.black81,
                          ))
                    ],
                  )
                ],
              ),
              TimeContainer(time: '')
            ],
          ),
          component.spacer(height: 4),
          component.text(
            'Reason for visit here',
            style: theme.publicSansFonts.regularStyle(
              fontColor: AppColors.black81,
            ),
          ),
          component.spacer(height: 36),
          _buildItems(callback: () {}, text: 'Join Video Consultation'),
          _buildDivider(),
          _buildItems(
              callback: () => AiloitteNavigation.intentWithData(
                  context, AppRoutes.chatScreen, entity),
              text: 'Send Message'),
          _buildDivider(),
          _buildItems(callback: () {}, text: 'View patient history'),
          _buildDivider(),
          _buildItems(callback: () {}, text: 'Reschedule Appointment'),
          _buildDivider(),
          _buildItems(
              callback: () {},
              text: 'Cancel Appointment',
              textColor: AppColors.color0xFFFF1100),
        ],
      ),
    );
  }

  Divider _buildDivider() {
    return const Divider(color: AppColors.color0xFFEAECF0, height: 15);
  }

  Widget _buildItems(
      {required VoidCallback callback,
      required String text,
      Color? textColor}) {
    return InkWell(
      onTap: callback,
      child: component.text(text,
          style: theme.publicSansFonts.regularStyle(
              fontSize: 16, fontColor: textColor ?? AppColors.color0xFF1E293B)),
    );
  }
}
