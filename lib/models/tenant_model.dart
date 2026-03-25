class Tenant {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String roomNumber;
  final String kostName;
  final String kostLocation;
  final DateTime moveInDate;
  final double monthlyRent;

  Tenant({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.roomNumber,
    required this.kostName,
    required this.kostLocation,
    required this.moveInDate,
    required this.monthlyRent,
  });
}
