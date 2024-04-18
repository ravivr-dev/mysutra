import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/doctor_datasource.dart';
import 'package:my_sutra/features/domain/repositories/doctor_repository.dart';
import 'package:my_sutra/features/domain/usecases/doctor_usecases/update_time_slots_usecases.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';

class DoctorRepositoryImpl extends DoctorRepository {
  final LocalDataSource localDataSource;
  final DoctorDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DoctorRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> updateTimeSlots(
      UpdateTimeSlotsParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result =
            await remoteDataSource.updateTimeSlots(data.doctorTimeSlot.toJson);

        return Right(result);
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
