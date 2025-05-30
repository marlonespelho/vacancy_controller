import 'package:parking_controller/core/protocols/use_case.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/repositories/main.dart';

abstract interface class GetParkingsUseCaseContract implements UseCase<List<Parking>, void> {}

class GetParkingsUseCase implements GetParkingsUseCaseContract {
  final ParkingRepositoryContract repository;

  GetParkingsUseCase(this.repository);

  @override
  Future<List<Parking>> execute([void param]) async {
    return await repository.getParkings();
  }
}
