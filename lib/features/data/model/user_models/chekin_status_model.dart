class CheckinStatusModel {
  String? message;
  int? count;
  String? currentCheckInBatchId;
  List<CheckinData>? data;

  CheckinStatusModel({this.message, this.count, this.data});

  CheckinStatusModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    currentCheckInBatchId = json['currentCheckInBatchId'];
    if (json['data'] != null) {
      data = <CheckinData>[];
      json['data'].forEach((v) {
        data!.add(CheckinData.fromJson(v));
      });
    }
  }
}

class CheckinData {
  String? id;
  String? role;
  String? attendenceId;
  String? userId;
  BatchId? batchId;
  String? date;
  String? checkInAt;
  String? checkOutAt;
  bool? isPresent;
  bool? isDelayed;
  String? createdAt;
  String? updatedAt;
  bool? isCheckedIn;

  CheckinData(
      {this.id,
      this.role,
      this.attendenceId,
      this.userId,
      this.batchId,
      this.date,
      this.checkInAt,
      this.checkOutAt,
      this.isPresent,
      this.isDelayed,
      this.createdAt,
      this.updatedAt,
      this.isCheckedIn});

  CheckinData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    role = json['role'];
    attendenceId = json['attendenceId'];
    userId = json['userId'];
    batchId =
        json['batchId'] != null ? BatchId.fromJson(json['batchId']) : null;
    date = json['date'];
    checkInAt = json['checkInAt'];
    checkOutAt = json['checkOutAt'];
    isPresent = json['isPresent'];
    isDelayed = json['isDelayed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isCheckedIn = json['isCheckedIn'];
  }
}

class BatchId {
  String? id;
  Sessions? sessions;

  BatchId({this.id, this.sessions});

  BatchId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    sessions =
        json['sessions'] != null ? Sessions.fromJson(json['sessions']) : null;
  }
}

class Sessions {
  String? startDate;
  String? endDate;
  Duration? duration;
  int? startMinutes;
  int? endMinutes;
  int? bufferStartMinutes;
  int? bufferEndMinutes;

  Sessions(
      {this.startDate,
      this.endDate,
      this.duration,
      this.startMinutes,
      this.endMinutes,
      this.bufferStartMinutes,
      this.bufferEndMinutes});

  Sessions.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
    duration =
        json['duration'] != null ? Duration.fromJson(json['duration']) : null;
    startMinutes = json['startMinutes'];
    endMinutes = json['endMinutes'];
    bufferStartMinutes = json['bufferStartMinutes'];
    bufferEndMinutes = json['bufferEndMinutes'];
  }
}

class Duration {
  int? hours;
  int? mins;

  Duration({this.hours, this.mins});

  Duration.fromJson(Map<String, dynamic> json) {
    hours = json['hours'];
    mins = json['mins'];
  }
}
