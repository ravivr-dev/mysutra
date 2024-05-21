import 'package:my_sutra/features/data/model/patient_models/available_time_slot.dart';
import 'package:my_sutra/features/data/model/patient_models/follow_model.dart';
import 'package:my_sutra/features/data/model/patient_models/search_doctor_model.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/doctor_entity.dart';
import 'package:my_sutra/features/domain/entities/patient_entities/follow_entity.dart';

import '../../../domain/entities/patient_entities/appointment_entity.dart';
import '../../../domain/entities/patient_entities/available_time_slot_entity.dart';
import '../../../domain/entities/patient_entities/patient_entity.dart';
import '../../model/patient_models/get_appointment_response_model.dart';
import '../../model/patient_models/patient_model.dart';

class PatientRepoConv {
  static List<DoctorEntity> convSpecialisationModelToEntity(
      List<DoctorDataModel> data) {
    List<DoctorEntity> list = List<DoctorEntity>.empty(growable: true);

    for (DoctorDataModel item in data) {
      final firstTimeSlot = item.timings?.firstTimeSlot;
      final lastTimeSlot = item.timings?.lastTimeSlot;
      list.add(DoctorEntity(
        id: item.id,
        profilePic: item.profilePic,
        fullName: item.fullName,
        specialization: item.specialization,
        ratings: item.ratings,
        reviews: item.reviews,
        fees: item.fees,
        isVerified: item.isVerified,
        isFollowing: item.isFollowing,
        experience: item.experience,
        patients: item.patients,
        about: item.about,
        timings: TimingsEntity(
          firstTimeSlot: TimeSlotsEntity(
              id: firstTimeSlot?.id,
              day: firstTimeSlot?.day,
              startTime: firstTimeSlot?.startTime,
              endTime: firstTimeSlot?.endTime),
          lastTimeSlot: TimeSlotsEntity(
              id: lastTimeSlot?.id,
              day: lastTimeSlot?.day,
              startTime: lastTimeSlot?.startTime,
              endTime: lastTimeSlot?.endTime),
        ),
      ));
    }
    return list;
  }

  static FollowEntity followModelToEntity(FollowModel model) {
    return FollowEntity(followedUserId: model.followedUserId);
  }

  static DoctorEntity doctorModelToEntity(DoctorDataModel model) {
    final firstTimeSlot = model.timings?.firstTimeSlot;
    final lastTimeSlot = model.timings?.lastTimeSlot;

    return DoctorEntity(
      id: model.id,
      profilePic: model.profilePic,
      fullName: model.fullName,
      specialization: model.specialization,
      ratings: model.ratings,
      reviews: model.reviews,
      fees: model.fees,
      isVerified: model.isVerified,
      isFollowing: model.isFollowing,
      experience: model.experience,
      patients: model.patients,
      about: model.about,
      timings: TimingsEntity(
        firstTimeSlot: TimeSlotsEntity(
            id: firstTimeSlot?.id,
            day: firstTimeSlot?.day,
            startTime: firstTimeSlot?.startTime,
            endTime: firstTimeSlot?.endTime),
        lastTimeSlot: TimeSlotsEntity(
            id: lastTimeSlot?.id,
            day: lastTimeSlot?.day,
            startTime: lastTimeSlot?.startTime,
            endTime: lastTimeSlot?.endTime),
      ),
    );
  }

  static List<AvailableTimeSlotEntity> availableTimeSlotModelToEntity(
      List<AvailableTimeSlot> list) {
    return list
        .map((e) => AvailableTimeSlotEntity(
            id: e.id,
            day: e.day,
            startTime: e.startTime,
            slotType: e.slotType,
            endTime: e.endTime))
        .toList();
  }

  static List<PatientEntity> patientModelToEntity(List<PatientModel> patients) {
    return patients
        .map((e) => PatientEntity(
            date: e.date,
            time: e.time,
            id: e.id,
            userName: e.userName,
            countryCode: e.countryCode,
            phoneNumber: e.phoneNumber,
            profilePic: e.profilePic,
            timeInMinutes: e.timeInMinutes))
        .toList();
  }

  static List<AppointmentEntity> appointmentModelListToEntity(
      List<AppointmentModel> list) {
    return list
        .map((e) => AppointmentEntity(
              id: e.id ?? '',
              doctorId: e.doctorId,
              userId: e.userId,
              profilePic: e.profilePic,
              fullName: e.fullName,
              username: e.username,
              isVerified: e.isVerified,
              specialization: e.specialization,
              date: e.date,
              time: e.time,
              timeInMinutes: e.timeInMinutes,
              duration: e.duration ?? 0,
            ))
        .toList();
  }
}
