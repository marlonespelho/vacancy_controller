class Parking {
  final String id;
  final String title;
  bool isOccupied;

  Parking({
    required this.id,
    required this.title,
    this.isOccupied = false,
  });

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json['id'],
      title: json['title'],
      isOccupied: json['isOccupied'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isOccupied': isOccupied,
    };
  }
}
