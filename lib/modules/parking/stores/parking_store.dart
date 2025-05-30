import 'package:mobx/mobx.dart';
import 'package:parking_controller/core/design/widgets/error_widget.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/use_cases/main.dart';
import 'package:collection/collection.dart';

part 'parking_store.g.dart';

class ParkingStore = ParkingStoreBase with _$ParkingStore;

abstract class ParkingStoreBase with Store {
  final CreateParkingUseCaseContract _createParkingUseCase;
  final DeleteParkingUseCaseContract _deleteParkingUseCase;
  final GetParkingsUseCaseContract _getParkingsUseCase;
  final EntryParkingUseCaseContract _entryParkingUseCase;
  final ExitParkingUseCaseContract _exitParkingUseCase;
  final GetOpenParkingRegistersUseCaseContract _getOpenParkingRegistersUseCase;

  ParkingStoreBase({
    required CreateParkingUseCaseContract createParkingUseCase,
    required DeleteParkingUseCaseContract deleteParkingUseCase,
    required GetParkingsUseCaseContract getParkingsUseCase,
    required EntryParkingUseCaseContract entryParkingUseCase,
    required ExitParkingUseCaseContract exitParkingUseCase,
    required GetOpenParkingRegistersUseCaseContract getOpenParkingRegistersUseCase,
  })  : _createParkingUseCase = createParkingUseCase,
        _deleteParkingUseCase = deleteParkingUseCase,
        _getParkingsUseCase = getParkingsUseCase,
        _entryParkingUseCase = entryParkingUseCase,
        _exitParkingUseCase = exitParkingUseCase,
        _getOpenParkingRegistersUseCase = getOpenParkingRegistersUseCase;

  Function? showProgressDialog;

  Function? hideProgressDialog;

  setupCallbacks({
    Function? showProgressDialog,
    Function? hideProgressDialog,
  }) {
    this.showProgressDialog = showProgressDialog;
    this.hideProgressDialog = hideProgressDialog;
  }

  @observable
  bool loading = false;

  @observable
  List<Parking> parkingList = [];

  @observable
  List<ParkingRegister> parkingRegisters = [];

  init() async {
    await getParkingList();
  }

  @action
  Future<void> createParking() async {
    showProgressDialog?.call();
    try {
      await _createParkingUseCase.execute(null);
      hideProgressDialog?.call();
      await getParkingList();
    } catch (e) {
      hideProgressDialog?.call();
      handleException(e);
    }
  }

  @action
  getParkingList() async {
    loading = true;
    try {
      final result = await _getParkingsUseCase.execute(null);
      parkingList = result;
      await getOpenParkingRegisters();
    } catch (e) {
      handleException(e);
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> deleteParking(String id) async {
    showProgressDialog?.call();
    try {
      await _deleteParkingUseCase.execute(id);
      hideProgressDialog?.call();
      await getParkingList();
    } catch (e) {
      hideProgressDialog?.call();
      handleException(e);
    }
  }

  ParkingRegister? getParkingRegister(Parking parking) {
    var parkingReg = parkingRegisters.firstWhereOrNull(
      (element) => element.parking.id == parking.id,
    );
    if (parkingReg == null) {
      return null;
    }
    return parkingReg;
  }

  entryParking({required String vehiclePlate, required Parking parking}) async {
    showProgressDialog?.call();
    try {
      await _entryParkingUseCase.execute(
        ParkingRegister(
          parking: parking,
          entryDate: DateTime.now(),
          vehiclePlate: vehiclePlate,
        ),
      );
      hideProgressDialog?.call();
      await getParkingList();
    } catch (e) {
      hideProgressDialog?.call();
      handleException(e);
    }
  }

  exitParking(ParkingRegister parkingRegister) async {
    showProgressDialog?.call();
    try {
      await _exitParkingUseCase.execute(parkingRegister);
      hideProgressDialog?.call();
      await getParkingList();
    } catch (e) {
      hideProgressDialog?.call();
      handleException(e);
    }
  }

  getOpenParkingRegisters() async {
    final result = await _getOpenParkingRegistersUseCase.execute(null);
    parkingRegisters = result;
  }
}
