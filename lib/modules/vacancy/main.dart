import 'package:flutter_modular/flutter_modular.dart';
import 'package:vacancy_controller/modules/vacancy/stores/home_store.dart';
import 'package:vacancy_controller/modules/vacancy/views/home_page/main.dart';

class HomeModule extends Module {
  static const String homeRoute = "/vacancy";
  static const String detailsRoute = "/vacancy/details";

  @override
  List<Module> get imports {
    return [];
  }

  @override
  List<Bind> get binds => [
        Bind((i) => HomeStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, args) => const HomePage()),
      ];
}
