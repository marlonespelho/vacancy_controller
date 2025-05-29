import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vacancy_controller/core/config/system.dart';
import 'package:vacancy_controller/modules/app_core.dart';
import 'package:vacancy_controller/modules/vacancy/views/home_page/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('should open vacancy page', (WidgetTester tester) async {
    await startApp();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });
}

Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await System().init();
  runApp(DefaultAssetBundle(bundle: TestAssetBundle(), child: AppCore()));
}

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async =>
      utf8.decode((await load(key)).buffer.asUint8List());

  @override
  Future<ByteData> load(String key) async => rootBundle.load(key);
}
