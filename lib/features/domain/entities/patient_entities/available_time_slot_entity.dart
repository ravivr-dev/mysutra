class AvailableTimeSlotEntity {
  final String id;
  final String day;
  final String slotType;
  final int startTime;
  final int endTime;

  AvailableTimeSlotEntity({
    required this.id,
    required this.day,
    required this.startTime,
    required this.slotType,
    required this.endTime,
  });
}
