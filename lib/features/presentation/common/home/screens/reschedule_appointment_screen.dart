import 'package:ailoitte_components/ailoitte_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_sutra/ailoitte_component_injector.dart';
import 'package:my_sutra/core/common_widgets/custom_button.dart';
import 'package:my_sutra/core/extension/widget_ext.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/core/utils/app_colors.dart';
import 'package:my_sutra/core/utils/string_keys.dart';
import 'package:my_sutra/core/utils/utils.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/available_time_slot_entity.dart';
import 'package:my_sutra/features/presentation/common/home/cubit/home_cubit.dart';
import 'package:my_sutra/features/presentation/patient/widgets/week_picker.dart';
import 'package:my_sutra/routes/routes_constants.dart';

part 'reschedule_appointmnet_screen_state/doctor_reschedule_screen_state.dart';

part 'reschedule_appointmnet_screen_state/patient_reschedule_screen_state.dart';

class RescheduleAppointmentScreen extends StatefulWidget {
  const RescheduleAppointmentScreen({super.key, required this.appointmentId});

  final String appointmentId;

  @override
  State<RescheduleAppointmentScreen> createState() =>
      _RescheduleAppointmentScreenState.init();
}

abstract class _RescheduleAppointmentScreenState
    extends State<RescheduleAppointmentScreen> {
  _RescheduleAppointmentScreenState();

  factory _RescheduleAppointmentScreenState.init() {
    final isPatient = UserHelper.role == UserRole.patient;
    return isPatient ? _PatientRescheduleState() : _DoctorRescheduleState();
  }

  Widget _buildBody(HomeState state);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is RescheduleAppointmentLoadedState) {
          widget.showSuccessToast(context: context, message: state.message);
          AiloitteNavigation.intent(context, AppRoutes.homeRoute);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                AiloitteNavigation.back(context);
              },
              child: Icon(Icons.arrow_back,
                  color: AppColors.color0xFF00082F.withOpacity(.27)),
            ),
            title: component.text(
                context.stringForKey(StringKeys.rescheduleAppointment),
                style: theme.publicSansFonts.mediumStyle(
                  fontSize: 20,
                )),
          ),
          body: _buildBody(state),
        );
      },
    );
  }

// void _getDoctorAvailableSlots(
//     {required String doctorId, required String date}) {
//   context
//       .read<AppointmentCubit>()
//       .getAvailableSlotsForPatients(doctorId: doctorId, date: date);
// }
}
