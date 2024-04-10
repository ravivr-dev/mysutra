class SpecializationModel {
  String? message;
  int? count;
  List<SpecializationItem>? data;

  SpecializationModel({this.message, this.count, this.data});

  SpecializationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <SpecializationItem>[];
      json['data'].forEach((v) {
        data!.add(SpecializationItem.fromJson(v));
      });
    }
  }
}

class SpecializationItem {
  String? id;
  String? name;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  SpecializationItem({this.id, this.name, this.createdAt, this.updatedAt});

  SpecializationItem.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
