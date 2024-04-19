class AvailableTimeSlotEntity {
  final String doctorID;
  final String day;
  final String slotType;
  final int startTime;
  final int endTime;

  AvailableTimeSlotEntity({
    required this.doctorID,
    required this.day,
    required this.startTime,
    required this.slotType,
    required this.endTime,
  });
}
