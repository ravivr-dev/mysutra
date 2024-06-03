import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/appointment_entity.dart';
import 'package:my_sutra/features/presentation/patient/widgets/rate_appointment_screen.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class AppointmentBottomSheet extends StatelessWidget {
  final AppointmentEntity appointmentEntity;

  const AppointmentBottomSheet({super.key, required this.appointmentEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow(
              onTap: () {
                AiloitteNavigation.back(context);
                AiloitteNavigation.intentWithData(
                    context,
                    AppRoutes.rateAppointmentRoute,
                    RateAppointmentArgs(
                      appointmentId: appointmentEntity.id,
                      doctorId: appointmentEntity.doctorId!,
                      appointmentEntity: appointmentEntity,
                    ));
              },
              icon: Assets.iconsStar,
              text: context.stringForKey(StringKeys.rateTheAppointment)),
          component.spacer(height: 7),
          // Divider(color: AppColors.grey92.withOpacity(.2)),
          // component.spacer(height: 7),
          // _buildRow(
          //     icon: Assets.iconsDownload,
          //     text:
          //         context.stringForKey(StringKeys.downloadAttachedPrescription))
        ],
      ),
    );
  }

  Widget _buildRow(
      {required String icon,
      required String text,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          component.assetImage(path: icon, color: AppColors.color0xFF292D32),
          component.spacer(width: 8),
          component.text(text,
              style: theme.publicSansFonts.regularStyle(
                fontSize: 16,
                fontColor: AppColors.color0xFF1E293B,
              ))
        ],
      ),
    );
  }
}
