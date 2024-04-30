class UserDataEntity {
  final String id;
  final String role;
  final String profilePic;
  final String? fullName;
  final String? specialization;
  final List<String>? socialProfileUrls;
  final bool isVerified;
  final String? userName;
  final bool? isFollowing;
  final int? totalFollowers;

  UserDataEntity({
    required this.id,
    required this.role,
    required this.profilePic,
    required this.fullName,
    required this.specialization,
    required this.socialProfileUrls,
    required this.userName,
    required this.isFollowing,
    required this.isVerified,
    required this.totalFollowers,
  });
}
