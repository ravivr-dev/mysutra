class RateAppointmentEntity {
  String? appointmentId;
  String? doctorId;
  String? userId;
  int? ratings;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RateAppointmentEntity(
      {this.appointmentId,
      this.doctorId,
      this.userId,
      this.ratings,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.iV});
}
