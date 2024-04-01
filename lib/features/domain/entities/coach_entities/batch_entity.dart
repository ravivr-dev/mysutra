class BatchItem {
  final String id;
  final String? name;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? students;
  final bool? isCheckedIn;

  BatchItem({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.students,
    required this.isCheckedIn,
  });
}
