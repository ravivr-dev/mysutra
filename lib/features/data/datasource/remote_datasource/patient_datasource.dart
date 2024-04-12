import 'package:my_sutra/features/data/client/patient_client.dart';
import 'package:my_sutra/features/data/datasource/local_datasource/local_datasource.dart';

abstract class PatientDataSource {}

class PatientDataSourceImpl extends PatientDataSource {
  final PatientRestClient client;
  final LocalDataSource localDataSource;

  PatientDataSourceImpl({required this.client, required this.localDataSource});
}
