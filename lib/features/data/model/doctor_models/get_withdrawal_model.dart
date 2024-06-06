class GetWithdrawalModel {
  String? message;
  int? booking;
  int? earnings;
  int? commision;
  int? count;
  List<WithdrawalItem>? data;

  GetWithdrawalModel(
      {this.message,
      this.booking,
      this.earnings,
      this.commision,
      this.count,
      this.data});

  GetWithdrawalModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    booking = json['booking'];
    earnings = json['earnings'];
    commision = json['commision'];
    count = json['count'];
    if (json['data'] != null) {
      data = <WithdrawalItem>[];
      json['data'].forEach((v) {
        data!.add(WithdrawalItem.fromJson(v));
      });
    }
  }
}

class WithdrawalItem {
  String? sId;
  String? userId;
  String? payoutId;
  String? date;
  num? amount;
  num? commision;
  String? currency;
  Null? utr;
  String? mode;
  String? status;
  // StatusDetails? statusDetails;
  String? createdAt;
  String? updatedAt;

  WithdrawalItem(
      {this.sId,
      this.userId,
      this.payoutId,
      this.date,
      this.amount,
      this.commision,
      this.currency,
      this.utr,
      this.mode,
      this.status,
      this.createdAt,
      this.updatedAt});

  WithdrawalItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    payoutId = json['payoutId'];
    date = json['date'];
    amount = json['amount'];
    commision = json['commision'];
    currency = json['currency'];
    utr = json['utr'];
    mode = json['mode'];
    status = json['status'];
    // statusDetails = json['statusDetails'] != null
    //     ? new StatusDetails.fromJson(json['statusDetails'])
    //     : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
