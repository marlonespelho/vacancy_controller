import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:parking_controller/core/services/main.dart';
import 'package:parking_controller/generated/l10n.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/models/parking.dart';
import 'package:parking_controller/modules/parking/stores/parking_store.dart';

class ConfirmParkingDeleteDialog extends StatelessWidget {
  final Parking parking;

  final ParkingStore store = Modular.get();

  ConfirmParkingDeleteDialog({super.key, required this.parking});

  static Future<void> show({required Parking parking}) {
    return showDialog(
      context: getCurrentContext(),
      builder: (context) => ConfirmParkingDeleteDialog(parking: parking),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(
        S.current.confirmParkingDeleteDialogTitle,
      ),
      content: Text(
        S.current.confirmParkingDeleteDialogContent(parking.title),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.current.cancelButtonText),
        ),
        ElevatedButton(
          key: const Key('confirmParkingDeleteDialogButton'),
          onPressed: () {
            store.deleteParking(parking.id);
            Navigator.of(context).pop();
          },
          child: Text(
            S.current.confirmButtonText,
          ),
        ),
      ],
    );
  }
}
