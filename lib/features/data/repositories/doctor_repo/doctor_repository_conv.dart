import '../../../domain/entities/doctor_entities/get_time_slots_response_data_entity.dart';
import '../../model/doctor_models/get_time_slots_response_model.dart';

class DoctorRepositoryConv {
  static List<GetTimeSlotsResponseDataEntity>
      getTimeSlotsResponseModelListToEntity(
          List<GetTimeSlotsResponseData> model) {
    return model
        .map((e) => GetTimeSlotsResponseDataEntity(
              id: e.id,
              userId: e.userId,
              day: e.day,
              slotType: e.slotType,
              startTime: e.startTime,
              endTime: e.endTime,
            ))
        .toList();
  }
}
import 'package:my_sutra/features/data/model/user_models/following_response_model.dart';
import 'package:my_sutra/features/domain/entities/user_entities/follower_entity.dart';

class DoctorRepositoryConv {
  static List<FollowerEntity> convertFollowingModelToEntity(
      List<FollowerData> data) {
    return data.map((e) => FollowerEntity(
        id: e.id ?? '',
        role: e.role ?? '',
        profilePic: e.profilePic ?? '',
        fullName: e.fullName ?? '',
        username: e.username ?? '',
        isVerified: e.isVerified ?? false,
        specialization: e.specialization ?? '',
        isFollowing: e.isFollowing ?? false,
        totalFollowers: e.totalFollowers ?? 0)).toList();
  }
}
