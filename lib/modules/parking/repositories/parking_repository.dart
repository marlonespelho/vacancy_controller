import 'dart:convert';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ParkingRepositoryContract {
  Future<List<Parking>> getParkings();

  Future<void> createParking(Parking parking);

  Future<void> deleteParking(String id);

  Future<void> createParkingRegister({
    required ParkingRegister parkingRegister,
  });

  Future<void> updateParkingRegister({
    required ParkingRegister parkingRegister,
  });

  Future<List<ParkingRegister>> getOpenParkingRegisters();

  Future<List<ParkingRegister>> getParkingRegisters({DateTime? date});

  Future<void> updateParking({required Parking parking, required bool occupied}) async {}
}

class SharedPreferencesParkingRepository implements ParkingRepositoryContract {
  final SharedPreferences sharedPreferences;

  SharedPreferencesParkingRepository(this.sharedPreferences);

  @override
  Future<List<Parking>> getParkings() async {
    final String? parkingsJson = sharedPreferences.getString('parkings');
    if (parkingsJson == null) {
      return [];
    }

    final List<dynamic> parkingsList = jsonDecode(parkingsJson);
    return parkingsList.map((json) => Parking.fromJson(json)).toList();
  }

  @override
  Future<void> createParking(Parking parking) async {
    final List<Parking> parkings = await getParkings();
    parkings.add(parking);

    final String parkingsJson = jsonEncode(parkings.map((v) => v.toJson()).toList());
    await sharedPreferences.setString('parkings', parkingsJson);
  }

  @override
  Future<void> deleteParking(String id) async {
    final List<Parking> parkings = await getParkings();
    parkings.removeWhere((parking) => parking.id == id);

    final String parkingsJson = jsonEncode(parkings.map((v) => v.toJson()).toList());
    await sharedPreferences.setString('parkings', parkingsJson);
  }

  @override
  Future<List<ParkingRegister>> getParkingRegisters({DateTime? date}) async {
    final String? jsonList = sharedPreferences.getString('parkingRegisters');
    if (jsonList == null) {
      return [];
    }

    final List<dynamic> registersList = jsonDecode(jsonList);

    final List<ParkingRegister> allRegisters = registersList.map((json) => ParkingRegister.fromJson(json)).toList();

    if (date == null) {
      return allRegisters;
    }

    return allRegisters
        .where(
          (register) =>
              register.entryDate.day == date.day &&
              register.entryDate.month == date.month &&
              register.entryDate.year == date.year,
        )
        .toList();
  }

  @override
  Future<List<ParkingRegister>> getOpenParkingRegisters() async {
    final String? jsonList = sharedPreferences.getString('parkingRegisters');
    if (jsonList == null) {
      return [];
    }

    final List<dynamic> registersList = jsonDecode(jsonList);
    return registersList
        .map((json) => ParkingRegister.fromJson(json))
        .toList()
        .where(
          (register) => register.exitDate == null,
        )
        .toList();
  }

  @override
  Future<void> createParkingRegister({
    required ParkingRegister parkingRegister,
  }) async {
    final List<ParkingRegister> registers = await getParkingRegisters();
    registers.add(parkingRegister);

    final String jsonList = jsonEncode(registers.map((r) => r.toJson()).toList());
    await sharedPreferences.setString('parkingRegisters', jsonList);
  }

  @override
  Future<void> updateParkingRegister({
    required ParkingRegister parkingRegister,
  }) async {
    final List<ParkingRegister> registers = await getParkingRegisters();

    final index = registers.indexWhere(
      (r) => r.parking.id == parkingRegister.parking.id && r.entryDate.isAtSameMomentAs(parkingRegister.entryDate),
    );
    if (index != -1) {
      registers[index] = parkingRegister;
      final String jsonList = jsonEncode(registers.map((r) => r.toJson()).toList());
      await sharedPreferences.setString('parkingRegisters', jsonList);
    }
  }

  @override
  Future<void> updateParking({required Parking parking, required bool occupied}) async {
    final List<Parking> parkings = await getParkings();
    final index = parkings.indexWhere((p) => p.id == parking.id);
    if (index != -1) {
      parkings[index].isOccupied = occupied;
      final String parkingsJson = jsonEncode(parkings.map((v) => v.toJson()).toList());
      await sharedPreferences.setString('parkings', parkingsJson);
    }
  }
}
