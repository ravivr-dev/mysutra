class BatchesModel {
  String? message;
  int? count;
  List<BatchData>? data;

  BatchesModel({this.message, this.count, this.data});

  BatchesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <BatchData>[];
      json['data'].forEach((v) {
        data!.add(BatchData.fromJson(v));
      });
    }
  }
}

class BatchData {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  int? startMinutes;
  int? endMinutes;
  int? studentCapacity;
  int? enrolledStudents;
  bool? isCheckedIn;

  BatchData({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.startMinutes,
    this.endMinutes,
    this.studentCapacity,
    this.enrolledStudents,
    this.isCheckedIn,
  });

  BatchData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startMinutes = json['startMinutes'];
    endMinutes = json['endMinutes'];
    studentCapacity = json['studentCapacity'];
    enrolledStudents = json['enrolledStudents'];
    isCheckedIn = json['isCheckedIn'];
  }
}
