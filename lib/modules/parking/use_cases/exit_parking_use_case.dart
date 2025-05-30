import 'package:parking_controller/core/protocols/use_case.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/repositories/main.dart';

abstract interface class ExitParkingUseCaseContract implements UseCase<void, ParkingRegister> {}

class ExitParkingUseCase implements ExitParkingUseCaseContract {
  final ParkingRepositoryContract repository;

  ExitParkingUseCase(this.repository);

  @override
  Future<void> execute(ParkingRegister params) async {
    params.exitDate = DateTime.now();
    await repository.updateParkingRegister(parkingRegister: params);
    await repository.updateParking(parking: params.parking, occupied: false);
  }
}
