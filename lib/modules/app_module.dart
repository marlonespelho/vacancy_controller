import 'package:flutter_modular/flutter_modular.dart';
import 'package:vacancy_controller/core/config/environment.dart';

import 'package:vacancy_controller/core/services/api_service.dart';
import 'package:vacancy_controller/modules/app_store.dart';
import 'package:vacancy_controller/modules/vacancy/main.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => APIHttpService(baseUrl: Environment().config.apiBaseUrl)),
        Bind((i) => AppStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(HomeModule.homeRoute, module: HomeModule()),
      ];
}

class CartProduct {
  String id;
  String name;
  int quantity;
  int price;
  List<int> promotionAvailablePrices;
  CartProduct({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.promotionAvailablePrices,
  });
}
