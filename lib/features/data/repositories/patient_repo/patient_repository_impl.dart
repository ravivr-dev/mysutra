import 'package:dartz/dartz.dart';
import 'package:my_sutra/core/error/exceptions.dart';
import 'package:my_sutra/core/error/failures.dart';
import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/patient_datasource.dart';
import 'package:my_sutra/features/data/repositories/patient_repo/patient_repository_conv.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';
import 'package:my_sutra/features/domain/usecases/patient_usecases/search_doctor_usecase.dart';

class PatientRepositoryImpl extends PatientRepository {
  final LocalDataSource localDataSource;
  final PatientDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PatientRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<DoctorEntity>>> searchDoctors(
      SearchDoctorParams data) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.searchDoctors(data);

        return Right(
            PatientRepoConv.convSpecialisationModelToEntity(result.data ?? []));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
