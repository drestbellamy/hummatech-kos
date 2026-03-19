class Room {
  final String name;
  final String? tenant;
  final double price;
  final bool isOccupied;

  Room({
    required this.name,
    required this.price,
    this.tenant,
    this.isOccupied = false,
  });
}
