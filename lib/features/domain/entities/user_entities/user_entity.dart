class UserEntity {
  final String? fullName;
  final String username;
  final String? profilePic;
  final bool isVerified;

  UserEntity({
    required this.fullName,
    required this.username,
    required this.profilePic,
    required this.isVerified,
  });
}
