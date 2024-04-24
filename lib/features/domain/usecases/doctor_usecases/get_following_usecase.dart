import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/entities/user_entities/follower_entity.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';

class GetDoctorFollowingUseCase
    extends UseCase<List<FollowerEntity>, GetFollowingParams> {
  final DoctorRepository _doctorRepository;

  GetDoctorFollowingUseCase(this._doctorRepository);

  @override
  Future<Either<Failure, List<FollowerEntity>>> call(GetFollowingParams params) {
    return _doctorRepository.getFollowings(params);
  }
}

class GetFollowingParams {
  final int pagination;
  final int limit;

  const GetFollowingParams({required this.pagination, required this.limit});
}
