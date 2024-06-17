import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/patient_appointments_usecase.dart';

part 'patient_appointment_state.dart';

class PatientAppointmentCubit extends Cubit<PatientAppointmentState> {
  final PatientAppointmentsUseCase usecase;
  PatientAppointmentCubit(this.usecase) : super(PatientAppointmentInitial());

  List<String?> appointments = [];

  void getData(GetPatientAppointmentsParams params) async {
    emit(PatientAppointmentLoading());
    final result = await usecase.call(params);
    result.fold((l) => emit(PatientAppointmentError(error: l.message)), (data) {
      appointments.clear();
      appointments.addAll(data);
      emit(PatientAppointmentLoaded());
    });
  }
}
