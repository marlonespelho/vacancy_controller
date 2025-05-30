import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:parking_controller/core/services/main.dart';
import 'package:parking_controller/generated/l10n.dart';

part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  AppStoreBase();

  @observable
  ThemeMode themeMode = ThemeMode.light;

  changeThemeMode() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    NativeToast.showToast(S.current.changeThemeModeMessage(
      themeMode == ThemeMode.light ? S.current.lightThemeModeLabel : S.current.darkThemeModeLabel,
    ));
  }
}
