import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/usecase/usecase.dart';
import 'package:my_sutra/features/domain/repositories/user_repository.dart';

class UpdateDeviceTokenUsecase extends UseCase<dynamic, DeviceTokenParams> {
  final UserRepository repo;

  UpdateDeviceTokenUsecase(this.repo);

  @override
  Future<Either<Failure, dynamic>> call(DeviceTokenParams params) async {
    return await repo.updateDeviceToken(params);
  }
}

class DeviceTokenParams {
  final String deviceType;
  final String deviceToken;

  DeviceTokenParams({required this.deviceType, required this.deviceToken});
}
