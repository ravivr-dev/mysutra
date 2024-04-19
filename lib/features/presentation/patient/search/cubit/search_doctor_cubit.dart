import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/follow_entity.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';

import '../../../../domain/usecases/patient_usecases/follow_doctor_usecase.dart';
import '../../../../domain/usecases/patient_usecases/get_doctor_details_usecase.dart';

part 'search_doctor_state.dart';

class SearchDoctorCubit extends Cubit<SearchDoctorState> {
  final SearchDoctorUsecase searchDoctorUsecase;
  final FollowDoctorUseCase followDoctorUseCase;
  final GetDoctorDetailsUseCase getDoctorDetailsUseCase;

  SearchDoctorCubit({
    required this.searchDoctorUsecase,
    required this.followDoctorUseCase,
    required this.getDoctorDetailsUseCase,
  }) : super(SearchDoctorInitial());

  getData(SearchDoctorParams params) async {
    emit(SearchDoctorLoading());
    final result = await searchDoctorUsecase(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(SearchDoctorLoaded(data));
    });
  }

  Future<void> followDoctor(
      {required FollowDoctorParams params,
      required int followedDoctorIndex}) async {
    emit(FollowDoctorLoading());
    final result = await followDoctorUseCase.call(params);

    result.fold(
        (l) => emit(FolowDoctorErrorState(message: l.message)),
        (r) => emit(FollowDoctorSuccessState(
            followEntity: r, followedDoctorIndex: followedDoctorIndex)));
  }

  void getDoctorDetails({required String doctorId}) async {
    emit(GetDoctorDetailsLoadingState());
    final result = await getDoctorDetailsUseCase
        .call(GetDoctorDetailsParams(doctorID: doctorId));
    result.fold((l) => emit(GetDoctorDetailsErrorState(message: l.message)),
        (r) => emit(GetDoctorDetailsSuccessState(doctorEntity: r)));
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(SearchDoctorError(failure.message));
    } else if (failure is CacheFailure) {
      emit(SearchDoctorError(failure.message));
    } else {
      emit(SearchDoctorError(failure.message));
    }
  }
}
