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
