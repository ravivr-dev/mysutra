import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/batch_entity.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/checkin_entity.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/training_program.dart';
import 'package:my_sutra/features/domain/entities/user_entities/academy_center_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_profile_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<AcademyCenter>>> getAcademyCentres(
      {int? pageNumber, int? limit});

  Future<Either<Failure, String>> login(
      {required String academy,
      required String countryCode,
      required String phoneNumber});

  Future<Either<Failure, String>> sendOtp(
      {required String academy,
      required String countryCode,
      required String phoneNumber,
      required String otp});

  Future<Either<Failure, List<AcademyCenter>>> getMyAcademyCentres(
      {int? pageNumber, int? limit});

  Future<Either<Failure, List<BatchItem>>> getMyBatches(
      {int? pageNumber, int? limit});

  Future<Either<Failure, List<TrainingProgram>>> getTrainingProgram(
      String academyId);

  Future<Either<Failure, String>> checkIn();

  Future<Either<Failure, String>> checkOut();

  Future<Either<Failure, UserProfileEntity>> getProfile();

  Future<Either<Failure, String>> changePhone(
      {required String countryCode, required int phoneNumber});

  Future<Either<Failure, String>> changePhoneOtp({required int otp});

  Future<Either<Failure, String>> changeEmail({required String email});

  Future<Either<Failure, String>> changeEmailOtp({required int otp});
  Future<Either<Failure, List<UserProfileEntity>>> getBatchStudents(
      {int? pageNumber, int? limit});

  Future<Either<Failure, String>> markAttendance(
      String? date, List<String>? studentIds);

  Future<Either<Failure, CheckinEntity>> getCheckinStatus(
      {int? pageNumber, int? limit});
}
