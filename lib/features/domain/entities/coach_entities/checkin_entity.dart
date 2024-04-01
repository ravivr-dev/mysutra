class CheckinItem {
  final String? id;
  final String? date;
  final String? checkInAt;
  final String? checkOutAt;
  final String? batchId;
  final String? startDate;
  final String? endaDate;

  CheckinItem({
    required this.id,
    required this.date,
    required this.checkInAt,
    required this.checkOutAt,
    required this.batchId,
    required this.startDate,
    required this.endaDate,
  });
}

class CheckinEntity {
  final String? currentCheckingBatchId;
  final List<CheckinItem> items;

  CheckinEntity({
    required this.currentCheckingBatchId,
    required this.items,
  });
}
