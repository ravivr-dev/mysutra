import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

import '../../entities/user_entities/user_entity.dart';

class GetUserDetailsUseCase {
  final DoctorRepository _doctorRepository;

  GetUserDetailsUseCase(this._doctorRepository);

  Future<Either<Failure, UserEntity>> call() {
    return _doctorRepository.getUserDetails();
  }
}
