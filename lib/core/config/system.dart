import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:vacancy_controller/core/config/environment.dart';
import 'package:vacancy_controller/core/services/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class System {
  static final System _instance = System._internal();

  factory System() => _instance;

  bool isReady = false;

  final String _environment = Environment.staging;

  bool get isProduction => _environment == Environment.production;

  System._internal() {
    _preInit();
  }

  void _preInit() {}

  Future init() async {
    if (!GetIt.I.isRegistered<NavigationService>()) {
      GetIt.I.registerLazySingleton(() => NavigationService());
    }

    if (!GetIt.I.isRegistered<SharedPreferences>()) {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      GetIt.I.registerSingleton<SharedPreferences>(preferences);
    }

    if (isReady) {
      return;
    }
    _initEnvironment();
    isReady = true;
  }

  void _initEnvironment() => Environment().initConfig(_environment);
}
