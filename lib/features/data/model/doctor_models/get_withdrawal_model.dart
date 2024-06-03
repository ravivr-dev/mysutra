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
  int? amount;
  String? currency;
  String? status;

  WithdrawalItem({this.sId, this.amount, this.currency, this.status});

  WithdrawalItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
  }
}
