import 'package:my_sutra/features/data/model/user_models/academy_centers_model.dart';
import 'package:my_sutra/features/data/model/user_models/batches_model.dart';
import 'package:my_sutra/features/data/model/user_models/chekin_status_model.dart';
import 'package:my_sutra/features/data/model/user_models/my_academy_center_model.dart';
import 'package:my_sutra/features/data/model/user_models/training_program_model.dart';
import 'package:my_sutra/features/data/model/user_models/user_profile_model.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/batch_entity.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/checkin_entity.dart';
import 'package:my_sutra/features/domain/entities/coach_entities/training_program.dart';
import 'package:my_sutra/features/domain/entities/user_entities/academy_center_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_profile_entity.dart';

class UserRepositoryConv {
  static List<AcademyCenter> convertAcademicCentersModelToEntity(
      AcademyCentersModel data) {
    List<AcademyCenter> list = [];

    for (Center elemnet in data.data ?? []) {
      list.add(AcademyCenter(id: elemnet.id, name: elemnet.name));
    }

    return list;
  }

  static List<AcademyCenter> convertMyAcademicCentersModelToEntity(
      MyAcademyCenterModel data) {
    List<AcademyCenter> list = [];

    for (Data elemnet in data.data ?? []) {
      list.add(AcademyCenter(
          id: elemnet.id,
          name: elemnet.name,
          state: elemnet.location?.state,
          city: elemnet.location?.city,
          address: elemnet.location?.address));
    }

    return list;
  }

  static List<BatchItem> convertBatchesModelToEntity(BatchesModel data) {
    List<BatchItem> list = [];

    for (BatchData elemnet in data.data ?? []) {
      list.add(
        BatchItem(
          id: elemnet.id ?? '',
          name: elemnet.name,
          startTime: dateTimeConv(elemnet.startDate),
          endTime: dateTimeConv(elemnet.endDate),
          students: elemnet.enrolledStudents,
          isCheckedIn: elemnet.isCheckedIn,
        ),
      );
    }

    return list;
  }

  static List<TrainingProgram> convertTrainingModelToEntity(
      List<CoachingProgram>? data) {
    List<TrainingProgram> list = [];

    for (CoachingProgram elemnet in data ?? []) {
      list.add(
        TrainingProgram(
          id: elemnet.id ?? "",
          sportsId: elemnet.sportsId,
          name: elemnet.name,
          date: dateTimeConv(elemnet.date),
        ),
      );
    }

    return list;
  }

  static UserProfileEntity convertUserProfileModelToEntity(
      UserProfileData data) {
    UserProfileEntity res = UserProfileEntity(
      id: data.id,
      profilePic: data.profilePic,
      name: data.name,
      countryCode: data.countryCode,
      phoneNumber: data.phoneNumber,
      email: data.email,
    );

    return res;
  }

  static dateTimeConv(String? date) {
    if (date == null || date == "") {
      return null;
    } else {
      return DateTime.parse(date).toLocal();
    }
  }

  static List<UserProfileEntity> convertBatchStudentsModelToEntity(
      List<UserProfileData>? data) {
    List<UserProfileEntity> list = [];

    for (UserProfileData student in data ?? []) {
      list.add(
        UserProfileEntity(
          id: student.id,
          profilePic: student.profilePic,
          name: student.name,
        ),
      );
    }

    return list;
  }

  static CheckinEntity connvertCheckingData(CheckinStatusModel data) {
    List<CheckinItem> list = [];

    for (CheckinData e in data.data ?? []) {
      list.add(
        CheckinItem(
          id: e.id,
          date: e.date,
          checkInAt: e.checkInAt,
          checkOutAt: e.checkOutAt,
          batchId: e.batchId?.id,
          startDate: e.batchId?.sessions?.startDate,
          endaDate: e.batchId?.sessions?.endDate,
        ),
      );
    }

    return CheckinEntity(
      currentCheckingBatchId: data.currentCheckInBatchId,
      items: list,
    );
  }
}
