// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ParkingStore on ParkingStoreBase, Store {
  late final _$loadingAtom = Atom(name: 'ParkingStoreBase.loading', context: context);

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

  late final _$parkingListAtom = Atom(name: 'ParkingStoreBase.parkingList', context: context);

  @override
  List<Parking> get parkingList {
    _$parkingListAtom.reportRead();
    return super.parkingList;
  }

  @override
  set parkingList(List<Parking> value) {
    _$parkingListAtom.reportWrite(value, super.parkingList, () {
      super.parkingList = value;
    });
  }

  late final _$parkingRegistersAtom = Atom(name: 'ParkingStoreBase.parkingRegisters', context: context);

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

  late final _$createParkingAsyncAction = AsyncAction('ParkingStoreBase.createParking', context: context);

  @override
  Future<void> createParking() {
    return _$createParkingAsyncAction.run(() => super.createParking());
  }

  late final _$getParkingListAsyncAction = AsyncAction('ParkingStoreBase.getParkingList', context: context);

  @override
  Future getParkingList() {
    return _$getParkingListAsyncAction.run(() => super.getParkingList());
  }

  late final _$deleteParkingAsyncAction = AsyncAction('ParkingStoreBase.deleteParking', context: context);

  @override
  Future<void> deleteParking(String id) {
    return _$deleteParkingAsyncAction.run(() => super.deleteParking(id));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
parkingList: ${parkingList},
parkingRegisters: ${parkingRegisters}
    ''';
  }
}
