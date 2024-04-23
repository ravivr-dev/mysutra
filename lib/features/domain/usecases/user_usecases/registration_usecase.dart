import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class RegistrationUsecase extends UseCase<String, RegistrationParams> {
  final UserRepository repo;

  RegistrationUsecase(this.repo);

  @override
  Future<Either<Failure, String>> call(RegistrationParams params) async {
    return await repo.registration(params);
  }
}

class RegistrationParams {
  final String role;
  final String? profilePic;
  final String? fullName;
  final String? countryCode;
  final int? phoneNumber;
  final String? email;
  final String? specializationId;
  final String? registrationNumber;
  final int? experience;
  final String? age;
  final String userName;

  final List<String>? socialUrls;

  RegistrationParams({
    required this.role,
    required this.profilePic,
    required this.fullName,
    required this.countryCode,
    required this.phoneNumber,
    required this.email,
    required this.specializationId,
    required this.registrationNumber,
    required this.socialUrls,
    required this.experience,
    required this.age,
    required this.userName,
  });
}
