class TrainingProgramModel {
  String? message;
  TrainingData? data;

  TrainingProgramModel({this.message, this.data});

  TrainingProgramModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? TrainingData.fromJson(json['data']) : null;
  }
}

class TrainingData {
  String? id;
  String? name;
  Location? location;
  List<Batches>? batches;
  List<CoachingProgram>? coachingProgram;

  TrainingData(
      {this.id, this.name, this.location, this.batches, this.coachingProgram});

  TrainingData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    if (json['batches'] != null) {
      batches = <Batches>[];
      json['batches'].forEach((v) {
        batches!.add(Batches.fromJson(v));
      });
    }
    if (json['coachingProgram'] != null) {
      coachingProgram = <CoachingProgram>[];
      json['coachingProgram'].forEach((v) {
        coachingProgram!.add(CoachingProgram.fromJson(v));
      });
    }
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

class Batches {
  String? id;
  String? name;
  int? studentCapacity;
  String? startDate;
  String? endDate;
  int? startMinutes;
  int? endMinutes;
  int? enrolledStudents;

  Batches(
      {this.id,
      this.name,
      this.studentCapacity,
      this.startDate,
      this.endDate,
      this.startMinutes,
      this.endMinutes,
      this.enrolledStudents});

  Batches.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    studentCapacity = json['studentCapacity'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startMinutes = json['startMinutes'];
    endMinutes = json['endMinutes'];
    enrolledStudents = json['enrolledStudents'];
  }
}

class CoachingProgram {
  String? id;
  String? sportsId;
  String? name;
  String? date;

  CoachingProgram({this.id, this.sportsId, this.name, this.date});

  CoachingProgram.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    sportsId = json['sportsId'];
    name = json['name'];
    date = json['date'];
  }
}
