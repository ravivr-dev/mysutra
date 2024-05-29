class ArticleUserModel {
  String? id;
  String? role;
  String? profilePic;
  String? fullName;
  String? username;
  bool? isVerified;

  ArticleUserModel(
      {this.id,
        this.role,
        this.profilePic,
        this.fullName,
        this.username,
        this.isVerified});

  ArticleUserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    role = json['role'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
    username = json['username'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['role'] = role;
    data['profilePic'] = profilePic;
    data['fullName'] = fullName;
    data['username'] = username;
    data['isVerified'] = isVerified;
    return data;
  }
}