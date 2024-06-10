class WithdrawalEntity {
  final num? booking;
  final num? earnings;
  final num? commision;
  final List<WithdrawalData> data;

  WithdrawalEntity(
      {required this.booking,
      required this.earnings,
      required this.commision,
      required this.data});
}

class WithdrawalData {
  final String? id;
  final String? payoutId;
  final String? date;
  final num? amount;
  final String? currency;
  final String? status;

  WithdrawalData({
    required this.payoutId,
    required this.date,
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
  });
}
