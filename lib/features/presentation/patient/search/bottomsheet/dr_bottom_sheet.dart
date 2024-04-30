import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/appointment_entity.dart';
import 'package:my_sutra/features/presentation/common/home/screens/bottom_sheets/cancel_appointment_bottom_sheet.dart';
import 'package:my_sutra/features/presentation/patient/bloc/appointment_cubit.dart';
import 'package:my_sutra/injection_container.dart';
import 'package:my_sutra/routes/routes_constants.dart';

import 'package:my_sutra/core/utils/utils.dart';

import '../../schedule_appointment_screen.dart';

class DrBottomSheet extends StatelessWidget {
  final AppointmentEntity appointment;

  const DrBottomSheet({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              component.text('Dr ${appointment.fullName}',
                  style: theme.publicSansFonts.semiBoldStyle(
                    fontSize: 18,
                    fontColor: AppColors.color0xFF1E293B,
                  )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: AppColors.color0xFFF1F5F9,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time_outlined,
                      color: AppColors.color0xFF292D32,
                      size: 20,
                    ),
                    component.spacer(width: 3),
                    component.text(
                        '${Utils.getMonthDay(appointment.date)}, ${appointment.time}')
                  ],
                ),
              )
            ],
          ),
          component.text(appointment.specialization,
              style: theme.publicSansFonts
                  .regularStyle(fontColor: AppColors.black81)),
          component.spacer(height: 40),
          InkWell(
            onTap: () => _onRescheduleAppointmentClick(context),
            child: component.text(
                context.stringForKey(StringKeys.rescheduleAppointment),
                style: theme.publicSansFonts.regularStyle(
                    fontSize: 16, fontColor: AppColors.color0xFF1E293B)),
          ),
          component.spacer(height: 10),
          InkWell(
            onTap: () => AiloitteNavigation.intentWithData(
                context, AppRoutes.chatScreen, appointment),
            child: component.text('Send Message',
                style: theme.publicSansFonts.regularStyle(
                    fontSize: 16, fontColor: AppColors.color0xFF1E293B)),
          ),
          const Divider(color: AppColors.color0xFFEAECF0),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              context.showBottomSheet(
                BlocProvider<AppointmentCubit>(
                  create: (context) => sl<AppointmentCubit>(),
                  child: CancelAppointmentBottomSheet(
                      appointmentId: appointment.id!),
                ),
                borderRadius: 12,
              );
            },
            child: component.text(
                context.stringForKey(StringKeys.cancelAppointment),
                style: theme.publicSansFonts.regularStyle(
                    fontSize: 16, fontColor: AppColors.color0xFFFF1100)),
          ),
          component.spacer(height: 15)
        ],
      ),
    );
  }

  void _onRescheduleAppointmentClick(BuildContext context) {
    AiloitteNavigation.intentWithoutBack(
        context,
        AppRoutes.scheduleAppointment,
        ScheduleAppointmentScreenArgs(
            doctorId: appointment.doctorId!, appointmentId: appointment.id!));
  }
}
