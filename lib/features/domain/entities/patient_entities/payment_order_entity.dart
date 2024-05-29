import 'package:my_sutra/features/data/model/patient_models/payment_order_model.dart';

class PaymentOrderEntity {
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

  PaymentOrderEntity(
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
}
