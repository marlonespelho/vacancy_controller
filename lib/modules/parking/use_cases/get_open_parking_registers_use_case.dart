import 'package:parking_controller/core/protocols/use_case.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/repositories/main.dart';

abstract interface class GetOpenParkingRegistersUseCaseContract implements UseCase<List<ParkingRegister>, void> {}

class GetOpenParkingRegistersUseCase implements GetOpenParkingRegistersUseCaseContract {
  final ParkingRepositoryContract repository;

  GetOpenParkingRegistersUseCase(this.repository);

  @override
  Future<List<ParkingRegister>> execute([void param]) async {
    return await repository.getOpenParkingRegisters();
  }
}
