import 'package:my_sutra/features/data/model/user_models/specialisation_model.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/specialisation_entity.dart';

class UserRepoConv {
  static List<SpecializationEntity> convSpecialisationModelToEntity(
      List<SpecializationItem> data) {
    List<SpecializationEntity> list =
        List<SpecializationEntity>.empty(growable: true);

    for (SpecializationItem e in data) {
      list.add(SpecializationEntity(e.name ?? ""));
    }
    return list;
  }
}
