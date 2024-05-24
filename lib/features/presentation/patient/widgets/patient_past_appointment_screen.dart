import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/app_decoration.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/features/presentation/patient/bloc/appointment_cubit.dart';
import 'package:my_sutra/features/presentation/patient/bottom_sheets/appointment_bottom_sheet.dart';
import 'package:my_sutra/generated/assets.dart';

import '../../../../routes/routes_constants.dart';
import '../../../domain/entities/patient_entities/appointment_entity.dart';
import '../../common/chat_screen/chat_screen.dart';

class PatientPastAppointmentsScreen extends StatefulWidget {
  const PatientPastAppointmentsScreen({super.key});

  @override
  State<PatientPastAppointmentsScreen> createState() =>
      _PatientPastAppointmentsScreenState();
}

class _PatientPastAppointmentsScreenState
    extends State<PatientPastAppointmentsScreen> {
  final List<AppointmentEntity> _appointmentEntities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: InkWell(
            onTap: () => AiloitteNavigation.back(context),
            child: const Icon(Icons.arrow_back)),
        title: component.text(context.stringForKey(StringKeys.pastAppointments),
            style: theme.publicSansFonts.mediumStyle(
              fontSize: 20,
            )),
      ),
      body: BlocConsumer<AppointmentCubit, AppointmentState>(
          listener: (context, state) {
        if (state is PastAppointmentErrorState) {
          widget.showErrorToast(context: context, message: state.message);
        } else if (state is PastAppointmentSuccessState) {
          _appointmentEntities.addAll(state.appointmentEntities);
        }
      }, builder: (_, state) {
        if (_appointmentEntities.isEmpty) {
          return Center(
            child: component.text('No Past Appointment Fund',
                style: theme.publicSansFonts.mediumStyle(
                  fontSize: 20,
                )),
          );
        }
        return ListView.separated(
          itemBuilder: (_, index) {
            return _buildCard(context, _appointmentEntities[index]);
          },
          separatorBuilder: (_, __) => component.spacer(height: 12),
          itemCount: _appointmentEntities.length,
        );
      }),
    );
  }

  Widget _buildCard(BuildContext context, AppointmentEntity entity) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final date = dateFormat.format(DateTime.parse(entity.date));
    return InkWell(
      onTap: () {
        context.showBottomSheet(const AppointmentBottomSheet());
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 23),
        decoration: AppDeco.cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            component.text(date,
                style: theme.publicSansFonts.regularStyle(
                  fontColor: AppColors.black81,
                )),
            component.spacer(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                component.networkImage(
                    url: entity.profilePic ?? '',
                    height: 72,
                    width: 72,
                    borderRadius: 8,
                    errorWidget:
                        component.assetImage(path: Assets.imagesDefaultAvatar)),
                component.spacer(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: component.text(
                              'Dr. ${entity.fullName}',
                              style: theme.publicSansFonts.mediumStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.more_horiz,
                            color: AppColors.color0xFFC4C4C4,
                            size: 20,
                          )
                        ],
                      ),
                      component.text(entity.specialization ?? '',
                          style: theme.publicSansFonts.regularStyle(
                            fontColor: AppColors.black81,
                          )),
                      component.spacer(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.color0xFF8338EC,
                            ),
                            child: component.text(
                              context.stringForKey(StringKeys.bookAppointment),
                              style: theme.publicSansFonts.regularStyle(
                                fontColor: AppColors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          // component.spacer(width: 19),
                          _buildChatIcon(context, entity)
                        ],
                      ),
                      component.spacer(width: 5)
                    ],
                  ),
                ),
              ],
            ),
            // component.spacer(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildChatIcon(BuildContext context, AppointmentEntity appointment) {
    return InkWell(
      onTap: () {
        AiloitteNavigation.intentWithData(
          context,
          AppRoutes.chatScreen,
          ChatScreenArgs(
            roomId: '${appointment.doctorId}${appointment.userId}',
            username: appointment.fullName ?? appointment.username ?? '',
            currentUserId: appointment.userId!,
            profilePic: appointment.profilePic,
            remoteUserId: appointment.doctorId!,
            showChatHistory: true,
          ),
        );
      },
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: AppColors.color0xFF8338EC,
            borderRadius: BorderRadius.circular(6)),
        child: component.assetImage(
          path: Assets.iconsChat,
          color: AppColors.white,
        ),
      ),
    );
  }
}
