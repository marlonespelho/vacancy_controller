// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_history_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ParkingHistoryStore on ParkingHistoryStoreBase, Store {
  late final _$loadingAtom = Atom(name: 'ParkingHistoryStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$parkingRegistersAtom = Atom(name: 'ParkingHistoryStoreBase.parkingRegisters', context: context);

  @override
  List<ParkingRegister> get parkingRegisters {
    _$parkingRegistersAtom.reportRead();
    return super.parkingRegisters;
  }

  @override
  set parkingRegisters(List<ParkingRegister> value) {
    _$parkingRegistersAtom.reportWrite(value, super.parkingRegisters, () {
      super.parkingRegisters = value;
    });
  }

  late final _$expansionPanelStateAtom = Atom(name: 'ParkingHistoryStoreBase.expansionPanelState', context: context);

  @override
  ObservableList<bool> get expansionPanelState {
    _$expansionPanelStateAtom.reportRead();
    return super.expansionPanelState;
  }

  @override
  set expansionPanelState(ObservableList<bool> value) {
    _$expansionPanelStateAtom.reportWrite(value, super.expansionPanelState, () {
      super.expansionPanelState = value;
    });
  }

  late final _$getParkingRegistersAsyncAction =
      AsyncAction('ParkingHistoryStoreBase.getParkingRegisters', context: context);

  @override
  Future<void> getParkingRegisters() {
    return _$getParkingRegistersAsyncAction.run(() => super.getParkingRegisters());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
parkingRegisters: ${parkingRegisters},
expansionPanelState: ${expansionPanelState}
    ''';
  }
}
