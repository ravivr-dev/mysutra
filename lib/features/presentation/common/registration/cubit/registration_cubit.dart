import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/data/model/user_models/specialisation_model.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/specialisation_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/registration_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/specialisation_usecase.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/upload_document_usecase.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final SpecialisationUsecase specialisationUsecase;
  final RegistrationUsecase registrationUsecase;
  final UploadDocumentUsecase uploadDocUsecase;
  RegistrationCubit(this.specialisationUsecase, this.registrationUsecase,
      this.uploadDocUsecase)
      : super(RegistrationInitial());

  getSpecialisations(GeneralPagination params) async {
    final result = await specialisationUsecase.call(params);

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

  uploadDoc(XFile file) async {
    final result = await uploadDocUsecase.call(File(file.path));
    result.fold((l) => _emitFailure(l), (data) {
      emit(UploadDocument(data, file));
    });
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
