class DoctorTimeSlot {
  final String slotType;
  final List<TimeSlot> timeSlots;

  const DoctorTimeSlot({required this.timeSlots, required this.slotType});

  Map<String, dynamic> get toJson {
    return {
      'slotType': slotType,
      'timeSlots': timeSlots.map((e) => e.toJson).toList(),
    };
  }
}

class TimeSlot {
  final String day;
  final List<Slots> slots;

  TimeSlot({required this.day, required this.slots});

  Map<String, dynamic> get toJson {
    return {'day': day, 'slots': slots.map((e) => e.toJson).toList()};
  }
}

class Slots {
  final int startTime;
  final int endTime;

  Slots({required this.startTime, required this.endTime});

  Map<String, dynamic> get toJson {
    return {'startTime': startTime, 'endTime': endTime};
  }
}
