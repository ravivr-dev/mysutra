class PaymentOrderModel {
  int? amount;
  int? amountDue;
  int? amountPaid;
  int? attempts;
  int? createdAt;
  String? currency;
  String? entity;
  String? id;
  Notes? notes;
  String? receipt;
  String? status;

  PaymentOrderModel(
      {this.amount,
      this.amountDue,
      this.amountPaid,
      this.attempts,
      this.createdAt,
      this.currency,
      this.entity,
      this.id,
      this.notes,
      this.receipt,
      this.status});

  PaymentOrderModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    amountDue = json['amount_due'];
    amountPaid = json['amount_paid'];
    attempts = json['attempts'];
    createdAt = json['created_at'];
    currency = json['currency'];
    entity = json['entity'];
    id = json['id'];
    notes = json['notes'] != null ? Notes.fromJson(json['notes']) : null;
    receipt = json['receipt'];
    status = json['status'];
  }
}

class Notes {
  String? appointmentId;

  Notes({this.appointmentId});

  Notes.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointmentId'];
  }
}
