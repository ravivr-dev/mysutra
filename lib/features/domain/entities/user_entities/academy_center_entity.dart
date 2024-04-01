class AcademyCenter {
  final String? id;
  final String? name;
  final String? state;
  final String? city;
  final String? address;

  AcademyCenter({
    required this.id,
    required this.name,
    this.state,
    this.city,
    this.address,
  });
}
