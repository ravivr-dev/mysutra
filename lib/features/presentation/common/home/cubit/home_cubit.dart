import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_entity.dart';

import '../../../../domain/entities/patient_entities/appointment_entity.dart';
import '../../../../domain/usecases/doctor_usecases/get_user_details_usercase.dart';
import '../../../../domain/usecases/patient_usecases/get_appointments_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LocalDataSource localDataSource;
  final GetAppointmentUseCase getAppointmentUseCase;
  final GetUserDetailsUseCase getUserDetailsUseCase;

  HomeCubit({
    required this.localDataSource,
    required this.getAppointmentUseCase,
    required this.getUserDetailsUseCase,
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

  void getUserDetails() async {
    emit(GetUserDetailsLoadingState());
    final result = await getUserDetailsUseCase.call();
    result.fold((l) => emit(GetUserDetailsErrorState(message: l.message)),
        (r) => emit(GetUserDetailsSuccessState(entity: r)));
  }

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
