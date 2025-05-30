import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_controller/core/services/main.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/repositories/main.dart';
import 'package:parking_controller/modules/parking/stores/parking_history_store.dart';
import 'package:parking_controller/modules/parking/use_cases/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationServiceMock extends Mock implements NavigationService {}

class ParkingRepositoryMock extends Mock implements ParkingRepositoryContract {}

class ParkingFake extends Fake implements Parking {}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Faker faker;
  late ParkingHistoryStore store;
  late ParkingRepositoryContract parkingRepositoryMock;
  late GetParkingRegistersUseCaseContract getParkingRegistersUseCase;
  SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();

  setUp(() async {
    faker = Faker();
    setupDependencyInjection();
  });

  setUpAll(() {
    registerFallbackValue(ParkingFake());

    parkingRepositoryMock = SharedPreferencesParkingRepository(prefs);

    getParkingRegistersUseCase = GetParkingRegistersUseCase(parkingRepositoryMock);

    store = ParkingHistoryStore(
      getParkingRegistersUseCase: getParkingRegistersUseCase,
    );
  });

  group("Parking History Store Unit tests", () {
    test("should get parking history list", () async {
      final parking = Parking(
        id: faker.guid.guid(),
        title: faker.lorem.word(),
      );
      await prefs.setString("parkings", jsonEncode([parking]));

      final parkingRegister = ParkingRegister(
        parking: parking,
        entryDate: DateTime(2024, 6, 1, 10, 0),
        vehiclePlate: "ABC1234",
        exitDate: DateTime(2024, 6, 1, 12, 0),
      );

      await prefs.setString("parkingRegisters", jsonEncode([parkingRegister]));

      await store.getParkingRegisters();

      expect(store.loading, false);
      expect(store.parkingRegisters.length, 1);
      expect(store.parkingRegisters.first.vehiclePlate, "ABC1234");
      expect(store.expansionPanelState.length, 1);
    });

    test("should handle empty parking registers", () async {
      await prefs.setString("parkingRegisters", jsonEncode([]));

      await store.getParkingRegisters();

      expect(store.loading, false);
      expect(store.parkingRegisters.isEmpty, true);
      expect(store.expansionPanelState.isEmpty, true);
    });
  });
}

void setupDependencyInjection() {
  final NavigationServiceMock navigationServiceMock = NavigationServiceMock();
  when(() => navigationServiceMock.navigatorKey).thenReturn(GlobalKey<NavigatorState>());
  if (GetIt.instance.isRegistered<NavigationService>()) {
    GetIt.instance.unregister<NavigationService>();
  }
  GetIt.instance.registerSingleton<NavigationService>(navigationServiceMock);
}
