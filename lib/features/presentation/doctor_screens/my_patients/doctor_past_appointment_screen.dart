import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/patient_appointment_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/patient_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/my_profile_entity.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/patient_appointments_usecase.dart';
import 'package:my_sutra/features/presentation/common/chat_screen/chat_screen.dart';
import 'package:my_sutra/features/presentation/doctor_screens/my_patients/cubit/patient_appointment_cubit.dart';
import 'package:my_sutra/generated/assets.dart';
import 'package:my_sutra/routes/routes_constants.dart';

class DoctorPastAppointmentScreen extends StatefulWidget {
  final PatientEntity data;
  const DoctorPastAppointmentScreen({super.key, required this.data});

  @override
  State<DoctorPastAppointmentScreen> createState() =>
      _DoctorPastAppointmentScreenState();
}

class _DoctorPastAppointmentScreenState
    extends State<DoctorPastAppointmentScreen> {
  late MyProfileEntity profileInfo;

  @override
  void initState() {
    context.read<PatientAppointmentCubit>().getProfileDetails();
    context.read<PatientAppointmentCubit>().getData(
        GetPatientAppointmentsParams(
            id: widget.data.id, pageNumber: 1, limit: 100));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        child: BlocConsumer<PatientAppointmentCubit, PatientAppointmentState>(
          listener: (_, state) {
            if (state is PatientAppointmentError) {
              widget.showErrorToast(context: _, message: state.error);
            } else if (state is PatientAppointmentProfile) {
              profileInfo = state.data;
            }
          },
          builder: (_, state) {
            List<PatientAppointmentEntity> appointments =
                _.read<PatientAppointmentCubit>().appointments;

            if (state is PatientAppointmentLoading) {
              const Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _patientInfo(),
                component.spacer(height: 12),
                component.divider(color: AppColors.dividerColor),
                component.spacer(height: 12),
                component.text('Past Appointments',
                    style: theme.publicSansFonts.regularStyle(fontSize: 16)),
                component.spacer(height: 12),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return _appointmentCard(appointments[index]);
                    },
                    separatorBuilder: (_, i) {
                      return component.spacer(height: 12);
                    },
                    itemCount: appointments.length),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _patientInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        component.networkImage(
          url: widget.data.profilePic ?? '',
          height: 72,
          width: 72,
          borderRadius: 8,
          errorWidget: component.assetImage(path: Assets.imagesDefaultAvatar),
        ),
        component.spacer(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            component.text(widget.data.userName,
                style: theme.publicSansFonts.mediumStyle(fontSize: 16)),
            component.spacer(height: 4),
            Row(
              children: [
                component.assetImage(path: Assets.iconsCallReceivedIcon),
                component.spacer(width: 2),
                component.text(
                  '+91 ${widget.data.phoneNumber}',
                  style: theme.publicSansFonts
                      .regularStyle(fontSize: 14, fontColor: AppColors.black81),
                ),
              ],
            ),
            component.text(
                'Last appointment on ${DateFormat("").format(DateTime.parse(widget.data.date ?? ''))}, ${widget.data.time}',
                style: theme.publicSansFonts.regularStyle(
                    fontSize: 14, fontColor: AppColors.color0xFF85799E))
          ],
        ),
      ],
    );
  }

  Widget _appointmentCard(PatientAppointmentEntity data) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${data.date != null ? DateFormat('dd MMM yyyy').format(DateTime.parse(data.date!)) : '--'}  ${data.time}",
            style: theme.publicSansFonts
                .regularStyle(fontColor: AppColors.color09, fontSize: 14),
          ),
          InkWell(
            onTap: () => _goToChatScreen(),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(6)),
              child: component.assetImage(
                  path: Assets.iconsChat, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _goToChatScreen() {
    AiloitteNavigation.intentWithData(
      context,
      AppRoutes.chatScreen,
      ChatScreenArgs(
          roomId: '${profileInfo.id}${widget.data.id}',
          username: widget.data.userName ?? '',
          currentUserId: profileInfo.id ?? '',
          profilePic: widget.data.profilePic,
          remoteUserId: widget.data.id,
          showChatHistory: true,
          date: " "),
    );
  }
}
