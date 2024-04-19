import 'package:my_sutra/features/data/model/patient_models/available_time_slot.dart';
import 'package:my_sutra/features/data/model/patient_models/follow_model.dart';
import 'package:my_sutra/features/data/model/patient_models/search_doctor_model.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/follow_entity.dart';

import '../../../domain/entities/patient_entities/available_time_slot_entity.dart';

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
        experience: item.experience,
        patients: item.patients,
        about: item.about,
        timings: item.timings,
      ));
    }
    return list;
  }

  static FollowEntity followModelToEntity(FollowModel model) {
    return FollowEntity(followedUserId: model.followedUserId);
  }

  static DoctorEntity doctorModelToEntity(DoctorDataModel model) {
    return DoctorEntity(
      id: model.id,
      profilePic: model.profilePic,
      fullName: model.fullName,
      specialization: model.specialization,
      ratings: model.ratings,
      reviews: model.reviews,
      fees: model.fees,
      isFollowing: model.isFollowing,
      experience: model.experience,
      patients: model.patients,
      about: model.about,
      timings: model.timings,
    );
  }

  static List<AvailableTimeSlotEntity> availableTimeSlotModelToEntity(
      List<AvailableTimeSlot> list) {
    return list
        .map((e) => AvailableTimeSlotEntity(
            doctorID: e.doctorID,
            day: e.day,
            startTime: e.startTime,
            slotType: e.slotType,
            endTime: e.endTime))
        .toList();
  }
}
