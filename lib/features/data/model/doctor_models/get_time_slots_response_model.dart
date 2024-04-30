import 'package:my_sutra/core/utils/constants.dart';

class GetTimeSlotsResponseModel {
  final String message;
  final int count;
  final List<GetTimeSlotsResponseData> list;
  final int? fees;

  GetTimeSlotsResponseModel({
    required this.message,
    required this.count,
    required this.list,
    required this.fees,
  });

  GetTimeSlotsResponseModel.fromJson(Map<String, dynamic> json)
      : message = json[Constants.message],
        count = json[Constants.count],
        list = (json[Constants.data] as List)
            .map((e) => GetTimeSlotsResponseData.fromJson(e))
            .toList(),
        fees = json[Constants.fees];
}

class GetTimeSlotsResponseData {
  String? id;
  String? userId;
  String? day;
  String? slotType;
  int? startTime;
  int? endTime;

  GetTimeSlotsResponseData(
      {this.id,
      this.userId,
      this.day,
      this.slotType,
      this.startTime,
      this.endTime});

  GetTimeSlotsResponseData.fromJson(Map<String, dynamic> json) {
    id = json[Constants.id];
    userId = json[Constants.userId];
    day = json[Constants.day];
    slotType = json[Constants.slotType];
    startTime = json[Constants.startTime];
    endTime = json[Constants.endTime];
  }
}
