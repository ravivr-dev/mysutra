import 'package:my_sutra/features/data/model/user_models/my_profile_model.dart';
import 'package:my_sutra/features/data/model/user_models/specialisation_model.dart';
import 'package:my_sutra/features/data/model/user_models/video_room_response_model.dart';
import 'package:my_sutra/features/domain/entities/doctor_entities/specialisation_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/user_entity.dart';
import 'package:my_sutra/features/domain/entities/user_entities/video_room_response_entity.dart';

import '../../../domain/entities/user_entities/my_profile_entity.dart';
import '../../../domain/entities/user_entities/user_data_entity.dart';
import '../../model/user_models/home_response_model.dart';
import '../../model/user_models/otp_model.dart';

class UserRepoConv {
  static List<SpecializationEntity> convSpecialisationModelToEntity(
      List<SpecializationItem> data) {
    List<SpecializationEntity> list =
        List<SpecializationEntity>.empty(growable: true);

    for (SpecializationItem e in data) {
      list.add(SpecializationEntity(
          name: e.name ?? "", id: e.id ?? "", image: e.imageUrl ?? ""));
    }
    return list;
  }

  static List<UserDataEntity> convertUserDataModelToEntity(
      List<UserData> data) {
    return data
        .map((e) => UserDataEntity(
            id: e.id!,
            role: e.role!,
            profilePic: e.profilePic ?? '',
            fullName: e.fullName,
            userName: e.userName,
            isVerified: e.isVerified ?? false,
            specialization: e.specialization,
            isFollowing: e.isFollowing ?? false,
            totalFollowers: e.totalFollowers ?? 0,
            socialProfileUrls: e.socialProfileUrls))
        .toList();
  }

  static MyProfileEntity myProfileModelToEntity(MyProfileModel model) {
    return MyProfileEntity(
      id: model.id,
      profilePic: model.profilePic,
      fullName: model.fullName,
      specialization: model.specialization,
      fees: model.fees,
      role: model.role,
      isVerified: model.isVerified,
      totalExperience: model.totalExperience,
      totalFollowers: model.totalFollowers,
      countryCode: model.countryCode,
      phoneNumber: model.phoneNumber,
      email: model.email,
      about: model.about,
      username: model.username!,
    );
  }

  static UserEntity userModelToEntity(UserModel model) {
    return UserEntity(
      fullName: model.fullName,
      username: model.username,
      profilePic: model.profilePic,
      isVerified: model.isVerified,
      role: model.role,
      gender: model.gender,
      age: model.age,
    );
  }

  static VideoRoomResponseEntity videoRoomResponseModelToEntity(
      VideoRoomResponseModel model) {
    return VideoRoomResponseEntity(
        videoSdkRoomId: model.videoSdkRoomId,
        videoSdkToken: model.videoSdkToken);
  }
}
