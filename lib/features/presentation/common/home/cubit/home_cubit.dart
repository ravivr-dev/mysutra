import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_entity.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/get_doctor_appointments_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/get_home_data_usecase.dart';

import '../../../../domain/entities/doctor_entities/get_doctor_appointment_entity.dart';
import '../../../../domain/entities/patient_entities/appointment_entity.dart';
import '../../../../domain/usecases/patient_usecases/get_appointments_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LocalDataSource localDataSource;
  final GetAppointmentUseCase getAppointmentUseCase;
  final GetHomeDataUseCase getHomeDataUseCase;
  final GetDoctorAppointmentsUseCase getDoctorAppointmentUseCase;

  HomeCubit({
    required this.localDataSource,
    required this.getAppointmentUseCase,
    required this.getHomeDataUseCase,
    required this.getDoctorAppointmentUseCase,
  }) : super(HomeInitial());

  void getAppointments(
      {required String date,
      required int pagination,
      required int limit}) async {
    emit(GetAppointmentsLoadingState());
    final result = await getAppointmentUseCase.call(GetAppointmentsParams(
        date: date, pagination: pagination, limit: limit));
    result.fold((l) => emit(GetAppointmentsErrorState(message: l.message)),
        (r) => emit(GetAppointmentsSuccessState(appointmentEntities: r)));
  }

  void getHomeData() async {
    emit(GetHomeDataLoadingState());
    final result = await getHomeDataUseCase.call();
    result.fold((l) => emit(GetHomeDataErrorState(message: l.message)),
        (r) => emit(GetHomeDataSuccessState(entity: r)));
  }

  void getDoctorAppointments({
    required String date,
    required int pagination,
    required int limit,
  }) async {
    emit(GetDoctorAppointmentLoadingState());
    final result = await getDoctorAppointmentUseCase.call(
        GetDoctorAppointmentsParams(
            date: date, pagination: pagination, limit: limit));
    result.fold((l) => emit(GetDoctorAppointmentErrorState(message: l.message)),
        (r) => emit(GetDoctorAppointmentSuccessState(entity: r)));
  }

  void getRescheduleAvailableSlotsForDoctors() {}

  void getRescheduleAvailableSlotsForPatients() {}

// FutureOr<void> _emitFailure(
//   Failure failure,
// ) async {
//   if (failure is ServerFailure) {
//     emit(HomeError(failure.message));
//   } else if (failure is CacheFailure) {
//     emit(HomeError(failure.message));
//   } else {
//     emit(HomeError(failure.message));
//   }
// }
}
