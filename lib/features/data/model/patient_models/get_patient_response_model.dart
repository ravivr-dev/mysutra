import 'package:my_sutra/core/utils/constants.dart';
import 'package:my_sutra/features/data/model/patient_models/patient_model.dart';

class GetPatientResponseModel {
  final String message;
  final int count;
  final List<PatientModel> patients;

  GetPatientResponseModel({
    required this.message,
    required this.count,
    required this.patients,
  });

  GetPatientResponseModel.fromJson(Map<String, dynamic> map)
      : message = map[Constants.message],
        count = map[Constants.count],
        patients = (map[Constants.data] as List)
            .map((e) => PatientModel.fromJson(e))
            .toList();
}
