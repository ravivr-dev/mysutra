class GetBookingsModel {
  String? message;
  num? booking;
  num? earnings;
  num? commision;
  num? count;
  List<BookingItem>? data;

  GetBookingsModel({
    this.message,
    this.booking,
    this.earnings,
    this.commision,
    this.count,
    this.data,
  });

  GetBookingsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    booking = json['booking'];
    earnings = json['earnings'];
    commision = json['commision'];
    count = json['count'];
    if (json['data'] != null) {
      data = <BookingItem>[];
      json['data'].forEach((v) {
        data!.add(BookingItem.fromJson(v));
      });
    }
  }
}

class BookingItem {
  String? id;
  UserId? userId;
  String? date;
  String? time;
  int? timeInMinutes;
  int? totalAmount;

  BookingItem(
      {this.id,
      this.userId,
      this.date,
      this.time,
      this.timeInMinutes,
      this.totalAmount});

  BookingItem.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    date = json['date'];
    time = json['time'];
    timeInMinutes = json['timeInMinutes'];
    totalAmount = json['totalAmount'];
  }
}

class UserId {
  String? id;
  String? username;

  UserId({this.id, this.username});

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
  }
}
