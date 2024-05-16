import 'dart:convert';

class PostUserModel {
  final String id;
  final String role;
  final String? profilePic;
  final String fullName;
  final String username;
  final bool isVerified;

  PostUserModel({
    required this.id,
    required this.role,
    this.profilePic,
    required this.fullName,
    required this.username,
    required this.isVerified,
  });

  factory PostUserModel.fromRawJson(String str) =>
      PostUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostUserModel.fromJson(Map<String, dynamic> json) => PostUserModel(
        id: json["_id"],
        role: json["role"],
        profilePic: json["profilePic"],
        fullName: json["fullName"],
        username: json["username"],
        isVerified: json["isVerified"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "role": role,
        "profilePic": profilePic,
        "fullName": fullName,
        "username": username,
        "isVerified": isVerified,
      };
}
