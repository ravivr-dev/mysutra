import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/patient_entities/patient_entity.dart';
import '../../../../domain/entities/user_entities/my_profile_entity.dart';
import '../../../../domain/usecases/doctor_usecases/get_patient_usecase.dart';
import '../../../../domain/usecases/user_usecases/get_profile_details_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileDetailsUseCase getProfileDetailsUseCase;
  final GetPatientUseCaseUseCase getPatientUseCaseUseCase;

  ProfileCubit({
    required this.getProfileDetailsUseCase,
    required this.getPatientUseCaseUseCase,
  }) : super(ProfileInitial());

  void getProfileDetails() async {
    emit(GetProfileDetailsLoadingState());
    final result = await getProfileDetailsUseCase.call();
    result.fold((l) => emit(GetProfileDetailsErrorState(message: l.message)),
        (r) => emit(GetProfileDetailsSuccessState(entity: r)));
  }

  void getPatients({
    required int pagination,
    required int limit,
  }) async {
    emit(GetPatientLoadingState());
    final result = await getPatientUseCaseUseCase
        .call(GetPatientsParams(pagination: pagination, limit: limit));
    result.fold((l) => emit(GetPatientErrorState(message: l.message)),
        (r) => emit(GetPatientSuccessState(patients: r)));
  }
}
