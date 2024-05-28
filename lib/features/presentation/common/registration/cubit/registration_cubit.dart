import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/specialisation_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/generate_username_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/registration_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/specialisation_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/upload_document_usecase.dart';

import '../../../../domain/usecases/user_usecases/generate_usernames_usecase.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final SpecialisationUsecase specialisationUsecase;
  final RegistrationUsecase registrationUsecase;
  final UploadDocumentUsecase uploadDocUsecase;
  final GenerateUsernamesUseCase generateUsernamesUseCase;

  RegistrationCubit(this.specialisationUsecase, this.registrationUsecase,
      this.uploadDocUsecase, this.generateUsernamesUseCase)
      : super(RegistrationInitial());

  getSpecialisations({int start = 1, int limit = 100}) async {
    final result = await specialisationUsecase
        .call(GeneralPagination(start: start, limit: limit));

    result.fold((l) => _emitFailure(l), (data) {
      emit(SpecializationLoaded(data));
    });
  }

  registration(RegistrationParams params) async {
    emit(RegistrationLoading());
    final result = await registrationUsecase.call(params);

    result.fold((l) => _emitFailure(l), (data) {
      emit(RegistrationSuccess(data));
    });
  }

  void uploadDoc(XFile file,
      {bool isLoading = false, bool isPdf = false}) async {
    if (isLoading) {
      emit(UploadDocLoading());
    }
    final result = await uploadDocUsecase.call(File(file.path));
    result.fold((l) => _emitFailure(l), (data) {
      emit(UploadDocumentSuccessState(data, file, isPdf));
    });
  }

  void generateUsernames({required String userName}) async {
    emit(GenerateUserNamesLoadingState());
    final result = await generateUsernamesUseCase.call(userName);
    result.fold((l) => emit(GenerateUserNamesErrorState(message: l.message)),
        (r) => emit(GenerateUserNamesSuccessState(entity: r)));
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) async {
    if (failure is ServerFailure) {
      emit(RegistrationError(failure.message));
    } else if (failure is CacheFailure) {
      emit(RegistrationError(failure.message));
    } else {
      emit(RegistrationError(failure.message));
    }
  }
}
