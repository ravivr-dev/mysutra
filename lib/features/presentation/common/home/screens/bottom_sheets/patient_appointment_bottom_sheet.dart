import 'package:flutter/material.dart';
import 'package:my_sutra/core/common_widgets/time_container.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/appointment_entity.dart';

import '../../../../../../ailoitte_component_injector.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../generated/assets.dart';

class PatientAppointmentBottomSheet extends StatelessWidget {
  const PatientAppointmentBottomSheet({super.key, required this.entity});

  final AppointmentEntity entity;

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
                  component.text(entity.username,
                      style: theme.publicSansFonts.mediumStyle(
                        fontSize: 16,
                      )),
                  Row(
                    children: [
                      component.assetImage(path: Assets.iconsPhone2),
                      component.spacer(width: 2),
                      component.text('${entity.countryCode} ${entity.phoneNumber}',
                          style: theme.publicSansFonts.regularStyle(
                            fontColor: AppColors.black81,
                          ))
                    ],
                  )
                ],
              ),
              const TimeContainer(time: 'Nov 24, 9:00 AM'),
            ],
          ),
          component.spacer(height: 4),
          component.text(
            entity.reason,
            style: theme.publicSansFonts.regularStyle(
              fontColor: AppColors.black81,
            ),
          ),
          component.spacer(height: 36),
          _buildItems(text: 'Join Video Consultation'),
          _buildDivider(),
          _buildItems(text: 'Send Message'),
          _buildDivider(),
          _buildItems(text: 'View patient history'),
          _buildDivider(),
          InkWell(
            onTap: () {},
            child: _buildItems(text: 'Reschedule Appointment'),
          ),
          _buildDivider(),
          _buildItems(
              text: 'Cancel Appointment', textColor: AppColors.color0xFFFF1100),
        ],
      ),
    );
  }

  Divider _buildDivider() {
    return const Divider(color: AppColors.color0xFFEAECF0, height: 15);
  }

  Widget _buildItems({required String text, Color? textColor}) {
    return component.text(text,
        style: theme.publicSansFonts.regularStyle(
            fontSize: 16, fontColor: textColor ?? AppColors.color0xFF1E293B));
  }
}
