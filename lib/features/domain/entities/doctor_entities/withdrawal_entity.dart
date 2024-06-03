class WithdrawalEntity {
  final int? booking;
  final int? earnings;
  final int? commision;
  final List<WithdrawalData> data;

  WithdrawalEntity(
      {required this.booking,
      required this.earnings,
      required this.commision,
      required this.data});
}

class WithdrawalData {
  final String? id;
  final int? amount;
  final String? currency;
  final String? status;

  WithdrawalData(
      {required this.id,
      required this.amount,
      required this.currency,
      required this.status});
}
