class DoctorEntity {
  final String? id;
  final String? profilePic;
  final String? fullName;
  final String? specialization;
  final num? ratings;
  final int? reviews;
  final int? fees;
  bool? isFollowing;
  bool? isVerified;
  final int? experience;
  final int? patients;
  final String? about;

  final TimingsEntity timings;

  DoctorEntity({
    required this.id,
    required this.profilePic,
    required this.fullName,
    required this.specialization,
    required this.ratings,
    required this.reviews,
    required this.fees,
    required this.isVerified,
    required this.isFollowing,
    required this.experience,
    required this.patients,
    required this.about,
    required this.timings,
  });

  void reInitIsFollowing() {
    if (isFollowing != null) {
      isFollowing = !isFollowing!;
    }
  }
}

class TimingsEntity {
  final TimeSlotsEntity? firstTimeSlot;
  final TimeSlotsEntity? lastTimeSlot;

  TimingsEntity({
    required this.firstTimeSlot,
    required this.lastTimeSlot,
  });
}

class TimeSlotsEntity {
  final String? id;
  final String? day;
  final int? startTime;
  final int? endTime;

  TimeSlotsEntity({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
  });
}
