import 'package:my_sutra/core/network/network_info.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';
import 'package:my_sutra/features/data/datasource/remote_datasource/patient_datasource.dart';
import 'package:my_sutra/features/domain/repositories/patient_repository.dart';

class PatientRepositoryImpl extends PatientRepository {
  final LocalDataSource localDataSource;
  final PatientDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PatientRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});
}
