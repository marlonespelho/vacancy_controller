import 'package:parking_controller/core/protocols/use_case.dart';
import 'package:parking_controller/modules/parking/repositories/main.dart';

abstract interface class DeleteParkingUseCaseContract implements UseCase<void, String> {}

class DeleteParkingUseCase implements DeleteParkingUseCaseContract {
  final ParkingRepositoryContract repository;

  DeleteParkingUseCase(this.repository);

  @override
  Future<void> execute(String params) async {
    await repository.deleteParking(params);
  }
}
