import 'package:mobx/mobx.dart';
import 'package:parking_controller/core/design/widgets/error_widget.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/use_cases/get_parking_registers_use_case.dart';

part 'parking_history_store.g.dart';

class ParkingHistoryStore = ParkingHistoryStoreBase with _$ParkingHistoryStore;

abstract class ParkingHistoryStoreBase with Store {
  final GetParkingRegistersUseCaseContract _getParkingRegistersUseCase;

  ParkingHistoryStoreBase({
    required GetParkingRegistersUseCaseContract getParkingRegistersUseCase,
  }) : _getParkingRegistersUseCase = getParkingRegistersUseCase;

  @observable
  bool loading = false;

  @observable
  List<ParkingRegister> parkingRegisters = [];

  @observable
  ObservableList<bool> expansionPanelState = ObservableList<bool>.of([]);

  @action
  Future<void> getParkingRegisters() async {
    loading = true;
    try {
      parkingRegisters = await _getParkingRegistersUseCase.execute(null);
      expansionPanelState.clear();
      expansionPanelState = ObservableList<bool>.of(
        List.generate(parkingRegisters.length, (_) => false),
      );
    } catch (e) {
      handleException(e);
    } finally {
      loading = false;
    }
  }

  List<DateTime> getDatesFromParkingRegisters() {
    if (parkingRegisters.isEmpty) return [];
    List<DateTime> uniqueDates = [];
    for (var register in parkingRegisters) {
      DateTime date = DateTime(register.entryDate.year, register.entryDate.month, register.entryDate.day);
      if (!uniqueDates.any((d) => d.isAtSameMomentAs(date))) {
        uniqueDates.add(date);
      }
    }
    return uniqueDates..sort((a, b) => b.compareTo(a));
  }

  List<ParkingRegister> getParkingRegistersByDate(DateTime date) {
    return parkingRegisters.where((register) {
      return register.entryDate.year == date.year &&
          register.entryDate.month == date.month &&
          register.entryDate.day == date.day;
    }).toList();
  }
}
