class BookingEntity {
  final String? id;
  final String? userId;
  final String? date;
  final String? time;
  final int? timeInMinutes;
  final int? totalAmount;

  BookingEntity(
      {required this.id,
      required this.userId,
      required this.date,
      required this.time,
      required this.timeInMinutes,
      required this.totalAmount});
}
