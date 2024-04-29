import 'package:my_sutra/core/utils/constants.dart';

class AvailableTimeSlotResponse {
  final String message;
  final List<AvailableTimeSlot> timeSlots;

  AvailableTimeSlotResponse({
    required this.message,
    required this.timeSlots,
  });

  AvailableTimeSlotResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        timeSlots = (json['data'] as List)
            .map((e) => AvailableTimeSlot.fromJson(e))
            .toList();
}

class AvailableTimeSlot {
  final String id;
  final String day;
  final String slotType;
  final int startTime;
  final int endTime;

  AvailableTimeSlot({
    required this.id,
    required this.day,
    required this.startTime,
    required this.slotType,
    required this.endTime,
  });

  AvailableTimeSlot.fromJson(Map<String, dynamic> map)
      : id = map[Constants.id],
        day = map[Constants.day],
        slotType = map[Constants.slotType],
        startTime = map[Constants.startTime],
        endTime = map[Constants.endTime];
}
