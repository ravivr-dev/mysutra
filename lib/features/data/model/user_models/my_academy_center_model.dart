class MyAcademyCenterModel {
  String? message;
  int? count;
  List<Data>? data;

  MyAcademyCenterModel({this.message, this.count, this.data});

  MyAcademyCenterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? id;
  String? name;
  Location? location;

  Data({this.id, this.name, this.location});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }
}

class Location {
  String? address;
  String? state;
  String? city;
  String? pincode;

  Location({this.address, this.state, this.city, this.pincode});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
  }
}
