import 'package:my_sutra/features/data/model/patient_models/follow_model.dart';
import 'package:my_sutra/features/data/model/patient_models/search_doctor_model.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/follow_entity.dart';

class PatientRepoConv {
  static List<DoctorEntity> convSpecialisationModelToEntity(
      List<DoctorDataModel> data) {
    List<DoctorEntity> list = List<DoctorEntity>.empty(growable: true);

    for (DoctorDataModel item in data) {
      list.add(DoctorEntity(
        id: item.id,
        profilePic: item.profilePic,
        fullName: item.fullName,
        specialization: item.specialization,
        ratings: item.ratings,
        reviews: item.reviews,
        fees: item.fees,
        isFollowing: item.isFollowing,
      ));
    }
    return list;
  }

  static FollowEntity followModelToEntity(FollowModel model) {
    return FollowEntity(followedUserId: model.followedUserId);
  }
}
