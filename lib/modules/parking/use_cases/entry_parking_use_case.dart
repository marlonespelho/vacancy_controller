import 'package:parking_controller/core/protocols/use_case.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/repositories/main.dart';

abstract interface class EntryParkingUseCaseContract implements UseCase<void, ParkingRegister> {}

class EntryParkingUseCase implements EntryParkingUseCaseContract {
  final ParkingRepositoryContract repository;

  EntryParkingUseCase(this.repository);

  @override
  Future<void> execute(ParkingRegister params) async {
    await repository.createParkingRegister(parkingRegister: params);
    await repository.updateParking(parking: params.parking, occupied: true);
  }
}
