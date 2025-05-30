import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:parking_controller/generated/l10n.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/views/home_page/widgets/add_parking_card_widget.dart';
import 'package:parking_controller/modules/parking/views/home_page/widgets/parking_card_widget.dart';
import 'package:parking_controller/modules/parking/views/parking_history_page/widgets/parking_history_card_widget.dart';

void main() {
  group('ParkingCardWidget', () {
    testWidgets('exibe informações de vaga disponível', (tester) async {
      final parking = Parking(id: '1', title: 'A1', isOccupied: false);

      await tester.pumpWidget(
        wrapWithMaterialApp(
          ParkingCardWidget(
            parking: parking,
            onTap: (_) {},
            onDelete: (_) {},
          ),
        ),
      );

      expect(find.text('A1'), findsOneWidget);
      expect(find.textContaining('disponível'), findsOneWidget);
      expect(find.byIcon(Icons.delete_forever), findsOneWidget);
    });

    testWidgets('exibe informações de vaga ocupada', (tester) async {
      final parking = Parking(id: '2', title: 'B2', isOccupied: true);
      final parkingRegister = ParkingRegister(
        parking: parking,
        entryDate: DateTime(2024, 6, 1, 10, 30),
        vehiclePlate: 'ABC1234',
      );

      await tester.pumpWidget(
        wrapWithMaterialApp(
          ParkingCardWidget(
            parking: parking,
            parkingRegister: parkingRegister,
            onTap: (_) {},
            onDelete: (_) {},
          ),
        ),
      );

      expect(find.text('B2'), findsOneWidget);
      expect(find.text('Veículo:'), findsOneWidget);
      expect(find.text('ABC1234'), findsOneWidget);
      expect(find.text('Entrada em:'), findsOneWidget);
      expect(find.byIcon(Icons.delete_forever), findsNothing);
    });

    testWidgets('aciona onTap ao tocar no card', (tester) async {
      bool tapped = false;
      final parking = Parking(id: '3', title: 'C3', isOccupied: false);

      await tester.pumpWidget(
        wrapWithMaterialApp(
          ParkingCardWidget(
            parking: parking,
            onTap: (_) => tapped = true,
            onDelete: (_) {},
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('ParkingCardWidget')));
      expect(tapped, isTrue);
    });

    testWidgets('aciona onDelete ao tocar no ícone de exclusão', (tester) async {
      bool deleted = false;
      final parking = Parking(id: '4', title: 'D4', isOccupied: false);

      await tester.pumpWidget(
        wrapWithMaterialApp(
          ParkingCardWidget(
            parking: parking,
            onTap: (_) {},
            onDelete: (_) => deleted = true,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.delete_forever));
      expect(deleted, isTrue);
    });
  });

  group('AddParkingCardWidget', () {
    testWidgets('exibe ícone de adicionar vaga', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          AddParkingCardWidget(
            onTap: () {},
          ),
        ),
      );

      expect(find.byIcon(Icons.add_circle), findsOneWidget);
    });

    testWidgets('aciona onTap ao tocar no card', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        wrapWithMaterialApp(
          AddParkingCardWidget(
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(AddParkingCardWidget));
      expect(tapped, isTrue);
    });
  });

  group('ParkingHistoryCardWidget test', () {
    testWidgets('exibe informações de histórico de estacionamento', (tester) async {
      final parkingRegister = ParkingRegister(
        parking: Parking(id: '1', title: 'A1', isOccupied: true),
        entryDate: DateTime(2024, 6, 1, 10, 30),
        exitDate: DateTime(2024, 6, 1, 12, 30),
        vehiclePlate: 'ABC1234',
      );

      await tester.pumpWidget(
        wrapWithMaterialApp(
          ParkingHistoryCardWidget(parkingRegister: parkingRegister),
        ),
      );

      expect(find.text("${parkingRegister.parking.title} - ${parkingRegister.vehiclePlate}"), findsOneWidget);
      final DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
      expect(
        find.text(
          "${S.current.entryDateLabel} ${dateFormat.format(parkingRegister.entryDate)}",
        ),
        findsOneWidget,
      );
      expect(
        find.text("${S.current.exitDateLabel} ${dateFormat.format(parkingRegister.entryDate)}"),
        findsOneWidget,
      );
    });
  });
}

Widget wrapWithMaterialApp(Widget child) {
  return MaterialApp(
    locale: const Locale('pt'),
    localizationsDelegates: const [
      S.delegate,
      // Adicione outros delegates se necessário
    ],
    home: child,
  );
}
