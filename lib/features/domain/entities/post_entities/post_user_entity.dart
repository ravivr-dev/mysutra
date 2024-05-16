class PostUserEntity {
  String? id;
  String? role;
  String? profilePic;
  String? fullName;
  String? username;
  bool isVerified;

  PostUserEntity({
    this.id,
    this.role,
    this.profilePic,
    this.fullName,
    this.username,
    required this.isVerified,
  });
}