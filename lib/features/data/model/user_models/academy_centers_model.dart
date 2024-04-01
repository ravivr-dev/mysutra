class AcademyCentersModel {
  String? message;
  int? count;
  List<Center>? data;

  AcademyCentersModel({this.message, this.count, this.data});

  AcademyCentersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Center>[];
      json['data'].forEach((v) {
        data!.add(Center.fromJson(v));
      });
    }
  }
}

class Center {
  String? id;
  String? name;

  Center({this.id, this.name});

  Center.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }
}
