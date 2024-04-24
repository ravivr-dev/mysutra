class FollowerEntity {
  final String id;
  final String role;
  final String profilePic;
  final String fullName;
  final String username;
  final bool isVerified;
  final String specialization;
  final bool isFollowing;
  final int totalFollowers;

  FollowerEntity({
      required this.id,
      required this.role,
      required this.profilePic,
      required this.fullName,
      required this.username,
      required this.isVerified,
      required this.specialization,
      required this.isFollowing,
      required this.totalFollowers});
}
