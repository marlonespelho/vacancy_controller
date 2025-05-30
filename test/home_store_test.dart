import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parking_controller/core/models/main.dart';
import 'package:parking_controller/core/services/main.dart';
import 'package:parking_controller/modules/parking/stores/main.dart';

class PaginateMock extends Mock implements Paginate {}

class NavigationServiceMock extends Mock implements NavigationService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Faker faker;
  late HomeStore store;

  setUp(() {
    faker = Faker();
    setupDependencyInjection();
  });

  setUpAll(() {
    registerFallbackValue(PaginateMock());
  });

  group("Home Screen Store Unit tests", () {});
}

void setupDependencyInjection() {
  final NavigationServiceMock navigationServiceMock = NavigationServiceMock();
  when(() => navigationServiceMock.navigatorKey).thenReturn(GlobalKey<NavigatorState>());
  if (GetIt.instance.isRegistered<NavigationService>()) {
    GetIt.instance.unregister<NavigationService>();
  }
  GetIt.instance.registerSingleton<NavigationService>(navigationServiceMock);
}
