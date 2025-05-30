import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:parking_controller/modules/parking/repositories/main.dart';
import 'package:parking_controller/modules/parking/stores/home_store.dart';
import 'package:parking_controller/modules/parking/stores/parking_history_store.dart';
import 'package:parking_controller/modules/parking/stores/parking_store.dart';
import 'package:parking_controller/modules/parking/use_cases/main.dart';
import 'package:parking_controller/modules/parking/views/home_page/main.dart';
import 'package:parking_controller/modules/parking/views/parking_history_page/main.dart';

class ParkingModule extends Module {
  static const String homeRoute = "/parking";
  static const String parkingHistoryRoute = "/parking/history";

  @override
  List<Module> get imports {
    return [];
  }

  @override
  List<Bind> get binds => [
        Bind((i) => SharedPreferencesParkingRepository(GetIt.I.get())),
        Bind((i) => CreateParkingUseCase(i.get())),
        Bind((i) => DeleteParkingUseCase(i.get())),
        Bind((i) => GetParkingsUseCase(i.get())),
        Bind((i) => EntryParkingUseCase(i.get())),
        Bind((i) => ExitParkingUseCase(i.get())),
        Bind((i) => GetOpenParkingRegistersUseCase(i.get())),
        Bind(
          (i) => ParkingStore(
            createParkingUseCase: i.get(),
            deleteParkingUseCase: i.get(),
            getParkingsUseCase: i.get(),
            entryParkingUseCase: i.get(),
            exitParkingUseCase: i.get(),
            getOpenParkingRegistersUseCase: i.get(),
          ),
        ),
        Bind((i) => GetParkingRegistersUseCase(i.get())),
        Bind((i) => ParkingHistoryStore(getParkingRegistersUseCase: i.get())),
        Bind((i) => HomeStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, args) => const HomePage()),
        ChildRoute("/history", child: (_, args) => const ParkingHistoryPage()),
      ];
}
