// ignore_for_file: unnecessary_new

class OtpResponseModel {
  String? message;
  OtpData? otpData;

  OtpResponseModel({this.message, this.otpData});

  OtpResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    otpData = json['data'] != null ? OtpData.fromJson(json['data']) : null;
  }
}

class OtpData {
  String? id;
  String? role;
  String? profilePic;
  String? name;
  String? countryCode;
  int? phoneNumber;
  String? newCountryCode;
  int? newPhoneNumber;
  String? email;
  String? newEmail;
  String? dob;
  String? description;
  String? idCard;
  bool? otpVerified;
  bool? isDisabled;
  bool? isLocked;
  String? lockedAt;
  String? status;
  CoachDetails? coachDetails;
  List<StudentDetails>? studentDetails;
  String? levelId;
  String? loggedInAcademyId;
  String? loggedInAcademyCenterId;
  String? currentCheckInBatchId;
  String? createdAt;
  String? updatedAt;
  String? accessToken;

  OtpData(
      {this.id,
      this.role,
      this.profilePic,
      this.name,
      this.countryCode,
      this.phoneNumber,
      this.newCountryCode,
      this.newPhoneNumber,
      this.email,
      this.newEmail,
      this.dob,
      this.description,
      this.idCard,
      this.otpVerified,
      this.isDisabled,
      this.isLocked,
      this.lockedAt,
      this.status,
      this.coachDetails,
      this.studentDetails,
      this.levelId,
      this.loggedInAcademyId,
      this.loggedInAcademyCenterId,
      this.currentCheckInBatchId,
      this.createdAt,
      this.updatedAt,
      this.accessToken});

  OtpData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    role = json['role'];
    profilePic = json['profilePic'];
    name = json['name'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    newCountryCode = json['newCountryCode'];
    newPhoneNumber = json['newPhoneNumber'];
    email = json['email'];
    newEmail = json['newEmail'];
    dob = json['dob'];
    description = json['description'];
    idCard = json['idCard'];
    otpVerified = json['otpVerified'];
    isDisabled = json['isDisabled'];
    isLocked = json['isLocked'];
    lockedAt = json['lockedAt'];
    status = json['status'];
    coachDetails = json['coachDetails'] != null
        ? CoachDetails.fromJson(json['coachDetails'])
        : null;
    if (json['studentDetails'] != null) {
      studentDetails = <StudentDetails>[];
      json['studentDetails'].forEach((v) {
        studentDetails!.add(new StudentDetails.fromJson(v));
      });
    }
    levelId = json['levelId'];
    loggedInAcademyId = json['loggedInAcademyId'];
    loggedInAcademyCenterId = json['loggedInAcademyCenterId'];
    currentCheckInBatchId = json['currentCheckInBatchId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    accessToken = json['accessToken'];
  }
}

class CoachDetails {
  String? designation;
  List<AssignedBatches>? assignedBatches;

  CoachDetails({this.designation, this.assignedBatches});

  CoachDetails.fromJson(Map<String, dynamic> json) {
    designation = json['designation'];
    if (json['assignedBatches'] != null) {
      assignedBatches = <AssignedBatches>[];
      json['assignedBatches'].forEach((v) {
        assignedBatches!.add(AssignedBatches.fromJson(v));
      });
    }
  }
}

class AssignedBatches {
  String? academyId;
  String? academyCenterId;
  String? batchId;

  AssignedBatches({this.academyId, this.academyCenterId, this.batchId});

  AssignedBatches.fromJson(Map<String, dynamic> json) {
    academyId = json['academyId'];
    academyCenterId = json['academyCenterId'];
    batchId = json['batchId'];
  }
}

class StudentDetails {
  String? academyId;
  String? academyCenterId;
  List<String>? batchIds;
  String? levelId;

  StudentDetails(
      {this.academyId, this.academyCenterId, this.batchIds, this.levelId});

  StudentDetails.fromJson(Map<String, dynamic> json) {
    academyId = json['academyId'];
    academyCenterId = json['academyCenterId'];
    batchIds = json['batchIds'].cast<String>();
    levelId = json['levelId'];
  }
}
