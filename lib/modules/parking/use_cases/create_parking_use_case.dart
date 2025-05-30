import 'dart:math';

import 'package:parking_controller/core/protocols/use_case.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/repositories/main.dart';

abstract interface class CreateParkingUseCaseContract implements UseCase<void, void> {}

class CreateParkingUseCase implements CreateParkingUseCaseContract {
  final ParkingRepositoryContract repository;

  CreateParkingUseCase(this.repository);

  @override
  Future<void> execute([void param]) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final title = _generateRandomTitle();
    await repository.createParking(Parking(id: id, title: title));
  }

  String _generateRandomTitle() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    return List.generate(4, (index) => chars[rand.nextInt(chars.length)]).join();
  }
}
