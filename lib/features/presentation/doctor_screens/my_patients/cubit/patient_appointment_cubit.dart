import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/patient_appointment_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/my_profile_entity.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/patient_appointments_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_profile_details_usecase.dart';

part 'patient_appointment_state.dart';

class PatientAppointmentCubit extends Cubit<PatientAppointmentState> {
  final PatientAppointmentsUseCase usecase;
  final GetProfileDetailsUseCase getProfileDetailsUseCase;
  PatientAppointmentCubit(this.usecase, this.getProfileDetailsUseCase)
      : super(PatientAppointmentInitial());

  List<PatientAppointmentEntity> appointments = [];

  void getData(GetPatientAppointmentsParams params) async {
    emit(PatientAppointmentLoading());
    final result = await usecase.call(params);
    result.fold((l) => emit(PatientAppointmentError(error: l.message)), (data) {
      appointments.clear();
      appointments.addAll(data);
      emit(PatientAppointmentLoaded());
    });
  }

  void getProfileDetails() async {
    emit(PatientAppointmentLoading());
    final result = await getProfileDetailsUseCase.call();
    result.fold((l) => emit(PatientAppointmentError(error: l.message)),
        (r) => emit(PatientAppointmentProfile(data: r)));
  }
}
