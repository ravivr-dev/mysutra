class GetTimeSlotsResponseEntity {
  final int? fees;
  final List<GetTimeSlotsResponseDataEntity> list;

  GetTimeSlotsResponseEntity({
    required this.fees,
    required this.list,
  });
}

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
