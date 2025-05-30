import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_controller/core/services/main.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/repositories/main.dart';
import 'package:parking_controller/modules/parking/stores/parking_store.dart';
import 'package:parking_controller/modules/parking/use_cases/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationServiceMock extends Mock implements NavigationService {}

class ParkingRepositoryMock extends Mock implements ParkingRepositoryContract {}

class ParkingFake extends Fake implements Parking {}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Faker faker;
  late ParkingStore store;
  late ParkingRepositoryContract parkingRepositoryMock;
  late CreateParkingUseCaseContract createParkingUseCase;
  late DeleteParkingUseCaseContract deleteParkingUseCase;
  late GetParkingsUseCaseContract getParkingsUseCase;
  late EntryParkingUseCaseContract entryParkingUseCase;
  late ExitParkingUseCaseContract exitParkingUseCase;
  late GetOpenParkingRegistersUseCaseContract getParkingRegistersUseCase;
  SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();

  setUp(() async {
    faker = Faker();
    setupDependencyInjection();
  });

  setUpAll(() {
    registerFallbackValue(ParkingFake());

    parkingRepositoryMock = SharedPreferencesParkingRepository(prefs);
    createParkingUseCase = CreateParkingUseCase(parkingRepositoryMock);
    deleteParkingUseCase = DeleteParkingUseCase(parkingRepositoryMock);
    getParkingsUseCase = GetParkingsUseCase(parkingRepositoryMock);
    entryParkingUseCase = EntryParkingUseCase(parkingRepositoryMock);
    exitParkingUseCase = ExitParkingUseCase(parkingRepositoryMock);
    getParkingRegistersUseCase = GetOpenParkingRegistersUseCase(parkingRepositoryMock);

    store = ParkingStore(
      createParkingUseCase: createParkingUseCase,
      deleteParkingUseCase: deleteParkingUseCase,
      getParkingsUseCase: getParkingsUseCase,
      entryParkingUseCase: entryParkingUseCase,
      exitParkingUseCase: exitParkingUseCase,
      getOpenParkingRegistersUseCase: getParkingRegistersUseCase,
    );
  });

  group("Parking Store Unit tests", () {
    test("Should get parking empty list when prefs no has data", () async {
      await prefs.remove("parkings");
      await store.getParkingList();
      expect(store.parkingList.isEmpty, true);
    });

    test("Should get parking list with success", () async {
      List parkingListMock = [
        Parking(
          id: faker.guid.guid(),
          title: faker.lorem.sentence(),
        ),
      ];
      await prefs.setString("parkings", jsonEncode(parkingListMock));
      await store.getParkingList();
      expect(store.parkingList.isNotEmpty, true);
    });

    test("Should create a parking with success", () async {
      await store.createParking();
      expect(store.parkingList.isNotEmpty, true);
    });

    test("Should delete a parking with success", () async {
      await store.createParking();
      final parking = store.parkingList.last;
      await store.deleteParking(parking.id);
      expect(store.parkingList.contains(parking), false);
    });

    test("Should entry parking with success", () async {
      await store.createParking();
      final parking = store.parkingList.last;
      await store.entryParking(parking: parking, vehiclePlate: "ABC1234");
      expect(store.parkingList.last.isOccupied, true);
    });

    test("Should exit parking with success", () async {
      await store.createParking();
      final parking = store.parkingList.last;
      await store.entryParking(parking: parking, vehiclePlate: "ABC1234");
      expect(store.parkingList.last.isOccupied, true);
      await store.exitParking(store.parkingRegisters.last);
      expect(store.parkingList.last.isOccupied, false);
    });

    test("Should get parkingRegister from occupied parking", () async {
      await store.createParking();
      final parking = store.parkingList.last;
      await store.entryParking(parking: parking, vehiclePlate: "ABC1234");
      expect(store.parkingList.last.isOccupied, true);
      final parkingRegister = store.getParkingRegister(parking);
      expect(parkingRegister, isNotNull);
    });

    test("Should get parkingRegister from unoccupied parking", () async {
      await store.createParking();
      final parking = store.parkingList.last;
      final parkingRegister = store.getParkingRegister(parking);
      expect(parkingRegister, isNull);
    });

    test("Should get parking registers with success", () async {
      await store.createParking();
      final parking = store.parkingList.last;
      await store.entryParking(parking: parking, vehiclePlate: "ABC1234");
      await store.getOpenParkingRegisters();
      expect(store.parkingRegisters.isNotEmpty, true);
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
