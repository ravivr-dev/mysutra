class DoctorEntity {
  final String? id;
  final String? profilePic;
  final String? fullName;
  final String? specialization;
  final int? ratings;
  final int? reviews;
  final int? fees;
  bool? isFollowing;
  final int? experience;
  final int? patients;
  final String? about;

  //todo change its type (and Change from UI also)
  final dynamic timings;

  DoctorEntity({
    required this.id,
    required this.profilePic,
    required this.fullName,
    required this.specialization,
    required this.ratings,
    required this.reviews,
    required this.fees,
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
