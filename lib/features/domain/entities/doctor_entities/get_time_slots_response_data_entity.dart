class GetTimeSlotsResponseDataEntity {
  String? id;
  String? userId;
  String? day;
  String? slotType;
  int? startTime;
  int? endTime;

  GetTimeSlotsResponseDataEntity({
    required this.id,
    required this.userId,
    required this.day,
    required this.slotType,
    required this.startTime,
    required this.endTime,
  });
}
