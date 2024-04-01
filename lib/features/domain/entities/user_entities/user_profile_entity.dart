class UserProfileEntity {
  String? id;
  String? profilePic;
  String? name;
  String? countryCode;
  int? phoneNumber;
  String? email;

  UserProfileEntity(
      {this.id,
      this.profilePic,
      this.name,
      this.countryCode,
      this.phoneNumber,
      this.email});
}
