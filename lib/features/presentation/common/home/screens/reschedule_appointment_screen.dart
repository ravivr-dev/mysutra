import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/models/user_helper.dart';
import 'package:my_sutra/features/presentation/patient/bloc/appointment_cubit.dart';

part 'reschedule_appointmnet_screen_state/doctor_reschedule_screen_state.dart';

part 'reschedule_appointmnet_screen_state/patient_reschedule_screen_state.dart';

class RescheduleAppointmentScreen extends StatefulWidget {
  const RescheduleAppointmentScreen({super.key});

  @override
  State<RescheduleAppointmentScreen> createState() => _RescheduleAppointmentScreenState.init();
}

abstract class _RescheduleAppointmentScreenState extends State<RescheduleAppointmentScreen> {

  _RescheduleAppointmentScreenState();

  factory _RescheduleAppointmentScreenState.init() {
    final isPatient = UserHelper.role == UserRole.patient;
    return isPatient ? _DoctorRescheduleState() : _PatientRescheduleState();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _getDoctorAvailableSlots(
      //     doctorId: widget.args.doctorId,
      //     date: _serverDateFormat.format(_selectedDate));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reschedule Appointment'),
      ),
      body: const Placeholder(),
    );
  }

  void _getDoctorAvailableSlots(
      {required String doctorId, required String date}) {
    context.read<AppointmentCubit>()
        .getAvailableSlots(doctorId: doctorId, date: date);
  }
}
