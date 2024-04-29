class UserEntity {
  final String? fullName;
  final String? username;
  final String? profilePic;
  final bool? isVerified;
  final String role;
  final String? gender;
  final String? age;

  UserEntity({
    required this.fullName,
    required this.username,
    required this.profilePic,
    required this.isVerified,
    required this.role,
    required this.gender,
    required this.age,
  });
}
