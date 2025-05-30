import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parking_controller/core/config/system.dart';
import 'package:parking_controller/modules/app_core.dart';
import 'package:parking_controller/modules/parking/views/home_page/main.dart';
import 'package:parking_controller/modules/parking/views/home_page/widgets/confirm_delete_parking_dialog.dart';
import 'package:parking_controller/modules/parking/views/home_page/widgets/confirm_exit_parking_dialog.dart';
import 'package:parking_controller/modules/parking/views/home_page/widgets/parking_card_widget.dart';
import 'package:parking_controller/modules/parking/views/home_page/widgets/register_parking_entry_dialog.dart';
import 'package:parking_controller/modules/parking/views/parking_history_page/main.dart';
import 'package:parking_controller/modules/parking/views/parking_history_page/widgets/parking_history_card_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('should open parking page', (WidgetTester tester) async {
    await startApp();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('should create and delete an parking slot', (WidgetTester tester) async {
    await startApp();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    await tester.tap(find.byKey(const Key("emptyListCreateParkingButton")));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key("parkingCardWidgetDeleteButton")), findsOneWidget);
    await tester.tap(find.byKey(const Key("parkingCardWidgetDeleteButton")));
    await tester.pumpAndSettle();
    expect(find.byType(ConfirmParkingDeleteDialog), findsOne);
    await tester.tap(find.byKey(const Key('confirmParkingDeleteDialogButton')));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(ConfirmParkingDeleteDialog), findsNothing);
    expect(find.byType(ParkingCardWidget), findsNothing);
    expect(find.byKey(const Key("parkingEmptyListWidget")), findsOneWidget);
  });

  testWidgets('should create, register and exit parking slot', (WidgetTester tester) async {
    await startApp();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    await tester.tap(find.byKey(const Key("emptyListCreateParkingButton")));
    await tester.pumpAndSettle();
    var parkingCardWidget = find.byType(ParkingCardWidget);
    expect(parkingCardWidget, findsOneWidget);
    await tester.tap(parkingCardWidget);
    await tester.pumpAndSettle();
    expect(find.byType(RegisterParkingEntryDialog), findsOneWidget);
    await tester.enterText(find.byKey(const Key("registerParkingEntryDialogTextField")), "ABC1234");
    await tester.tap(find.byKey(const Key("registerParkingEntryDialogButton")));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(RegisterParkingEntryDialog), findsNothing);
    expect(parkingCardWidget, findsOneWidget);
    expect(find.text("ABC1234"), findsOneWidget);
    await tester.tap(parkingCardWidget);
    await tester.pumpAndSettle();
    expect(find.byType(ConfirmParkingExitDialog), findsOneWidget);
    await tester.tap(find.byKey(const Key("confirmParkingExitDialogButton")));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(ConfirmParkingExitDialog), findsNothing);
    expect(find.byType(ParkingCardWidget), findsOneWidget);
    expect(find.text("ABC1234"), findsNothing);
    expect(find.byKey(const Key("parkingCardWidgetDeleteButton")), findsOneWidget);
    await tester.tap(find.byKey(const Key("parkingCardWidgetDeleteButton")));
    await tester.pumpAndSettle();
    expect(find.byType(ConfirmParkingDeleteDialog), findsOne);
    await tester.tap(find.byKey(const Key('confirmParkingDeleteDialogButton')));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(ConfirmParkingDeleteDialog), findsNothing);
    expect(find.byType(ParkingCardWidget), findsNothing);
    expect(find.byKey(const Key("parkingEmptyListWidget")), findsOneWidget);
  });

  testWidgets('should create, register and show parking history page', (WidgetTester tester) async {
    await startApp();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    await tester.tap(find.byKey(const Key("emptyListCreateParkingButton")));
    await tester.pumpAndSettle();
    var parkingCardWidget = find.byType(ParkingCardWidget);
    expect(parkingCardWidget, findsOneWidget);
    await tester.tap(parkingCardWidget);
    await tester.pumpAndSettle();
    expect(find.byType(RegisterParkingEntryDialog), findsOneWidget);
    await tester.enterText(find.byKey(const Key("registerParkingEntryDialogTextField")), "ABC1234");
    await tester.tap(find.byKey(const Key("registerParkingEntryDialogButton")));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    expect(find.byType(RegisterParkingEntryDialog), findsNothing);
    expect(parkingCardWidget, findsOneWidget);
    expect(find.text("ABC1234"), findsOneWidget);
    await tester.tap(find.byKey(const Key("parkingHistoryFAB")));
    await tester.pumpAndSettle();
    expect(find.byType(ParkingHistoryPage), findsOneWidget);
    await tester.pumpAndSettle();
    var expansionPanel = find.byType(ExpansionPanelList);
    expect(expansionPanel, findsOneWidget);
    await tester.tap(find.byType(ExpansionPanelList).first);
    await tester.pumpAndSettle();
    expect(find.byType(ParkingHistoryCardWidget), findsWidgets);
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
