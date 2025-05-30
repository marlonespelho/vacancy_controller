import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parking_controller/core/config/system.dart';
import 'package:parking_controller/modules/app_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await System().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(const AppCore());
}
