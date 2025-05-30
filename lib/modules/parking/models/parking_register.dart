import 'package:parking_controller/modules/parking/models/parking.dart';

class ParkingRegister {
  final Parking parking;
  final DateTime entryDate;
  DateTime? exitDate;
  final String vehiclePlate;

  ParkingRegister({
    required this.parking,
    required this.entryDate,
    this.exitDate,
    required this.vehiclePlate,
  });

  factory ParkingRegister.fromJson(Map<String, dynamic> json) {
    return ParkingRegister(
      parking: Parking.fromJson(json['parking'] as Map<String, dynamic>),
      entryDate: DateTime.parse(json['entryDate'] as String),
      exitDate: json['exitDate'] != null ? DateTime.parse(json['exitDate'] as String) : null,
      vehiclePlate: json['vehiclePlate'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parking': parking.toJson(),
      'entryDate': entryDate.toIso8601String(),
      'exitDate': exitDate?.toIso8601String(),
      'vehiclePlate': vehiclePlate,
    };
  }
}
