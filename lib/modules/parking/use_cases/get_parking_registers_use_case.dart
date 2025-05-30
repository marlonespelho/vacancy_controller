import 'package:parking_controller/core/protocols/use_case.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/repositories/main.dart';

abstract interface class GetParkingRegistersUseCaseContract implements UseCase<List<ParkingRegister>, void> {}

class GetParkingRegistersUseCase implements GetParkingRegistersUseCaseContract {
  final ParkingRepositoryContract repository;

  GetParkingRegistersUseCase(this.repository);

  @override
  Future<List<ParkingRegister>> execute([void param]) async {
    return await repository.getParkingRegisters();
  }
}
