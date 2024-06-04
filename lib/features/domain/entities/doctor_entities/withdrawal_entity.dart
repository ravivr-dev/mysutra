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
  final String? payoutId;
  final String? date;
  final int? amount;
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
