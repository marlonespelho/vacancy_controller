// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$isLoadingAtom = Atom(name: 'HomeStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$selectDateAtom = Atom(name: 'HomeStoreBase.selectDate', context: context);

  @override
  DateTime get selectDate {
    _$selectDateAtom.reportRead();
    return super.selectDate;
  }

  @override
  set selectDate(DateTime value) {
    _$selectDateAtom.reportWrite(value, super.selectDate, () {
      super.selectDate = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
selectDate: ${selectDate}
    ''';
  }
}
