import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/data/model/user_models/otp_model.dart';
import 'package:my_sutra/features/data/model/user_models/upload_doc_model.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/specialisation_entity.dart';
import 'package:my_sutra/features/domain/usecases/user_usecases/registration_usecase.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> login(
      {required String countryCode, required String phoneNumber});

  Future<Either<Failure, UserModel>> verifyOtp(int otp);

  Future<Either<Failure, List<UserData>>> getUserAccounts();

  Future<Either<Failure, UserData>> getSelectedUserAccounts(String id);

  Future<Either<Failure, List<SpecializationEntity>>> getSpecialisation(
      {int? start, int? limit});

  Future<Either<Failure, String>> registration(RegistrationParams params);

  Future<Either<Failure, UploadDocModel>> uploadDocument(File file);
}
