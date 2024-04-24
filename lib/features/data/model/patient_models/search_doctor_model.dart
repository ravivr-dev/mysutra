import 'package:my_sutra/core/utils/constants.dart';

class SearchDoctorModel {
  String? message;
  int? count;
  List<DoctorDataModel>? data;

  SearchDoctorModel({this.message, this.count, this.data});

  SearchDoctorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <DoctorDataModel>[];
      json['data'].forEach((v) {
        data!.add(DoctorDataModel.fromJson(v));
      });
    }
  }
}

class DoctorDataModel {
  String? id;
  String? profilePic;
  String? fullName;
  String? specialization;
  int? ratings;
  int? reviews;
  int? fees;
  bool? isFollowing;
  int? patients;
  int? experience;
  String? about;
  Timings? timings;

  DoctorDataModel({
    this.id,
    this.profilePic,
    this.fullName,
    this.specialization,
    this.ratings,
    this.reviews,
    this.fees,
    this.isFollowing,
    this.patients,
    this.experience,
    this.about,
    this.timings,
  });

  DoctorDataModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
    specialization = json['specialization'];
    ratings = json['ratings'];
    reviews = json['reviews'];
    fees = json['fees'];
    isFollowing = json['isFollowing'];
    patients = json['patients'];
    experience = json['experience'];
    about = json['about'];
    timings =
        json['timings'] != null ? Timings.fromJson(json['timings']) : null;
  }
}

class Timings {
  final TimeSlots? firstTimeSlot;
  final TimeSlots? lastTimeSlot;

  Timings({
    required this.firstTimeSlot,
    required this.lastTimeSlot,
  });

  Timings.fromJson(Map<String, dynamic> json)
      : firstTimeSlot = json['firstTimeSlot'] != null
            ? TimeSlots.fromJson(json['firstTimeSlot'])
            : null,
        lastTimeSlot = json['lastTimeSlot'] != null
            ? TimeSlots.fromJson(json['lastTimeSlot'])
            : null;
}

class TimeSlots {
  final String id;
  final String day;
  final int startTime;
  final int endTime;

  TimeSlots({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  TimeSlots.fromJson(Map<String, dynamic> json)
      : id = json[Constants.id],
        day = json[Constants.day],
        startTime = json[Constants.startTime],
        endTime = json[Constants.endTime];
}
