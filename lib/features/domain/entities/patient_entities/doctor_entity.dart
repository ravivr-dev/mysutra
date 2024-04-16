class DoctorEntity {
  final String? id;
  final String? profilePic;
  final String? fullName;
  final String? specialization;
  final int? ratings;
  final int? reviews;
  final int? fees;
  bool? isFollowing;

  DoctorEntity({
    required this.id,
    required this.profilePic,
    required this.fullName,
    required this.specialization,
    required this.ratings,
    required this.reviews,
    required this.fees,
    required this.isFollowing,
  });

  void reInitIsFollowing() {
    if (isFollowing != null) {
      isFollowing = !isFollowing!;
    }
  }
}
