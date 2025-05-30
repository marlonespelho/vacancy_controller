import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:parking_controller/core/services/main.dart';
import 'package:parking_controller/generated/l10n.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/models/parking.dart';
import 'package:parking_controller/modules/parking/stores/parking_store.dart';

class ConfirmParkingExitDialog extends StatelessWidget {
  final ParkingRegister parkingRegister;

  final ParkingStore store = Modular.get();

  ConfirmParkingExitDialog({super.key, required this.parkingRegister});

  static Future<void> show({required ParkingRegister parkingRegister}) {
    return showDialog(
      context: getCurrentContext(),
      builder: (context) => ConfirmParkingExitDialog(parkingRegister: parkingRegister),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(
        S.current.confirmParkingExitDialogTitle,
      ),
      content: Text(
        S.current.confirmParkingExitDialogContent(
          parkingRegister.vehiclePlate,
          parkingRegister.parking.title,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.current.cancelButtonText),
        ),
        ElevatedButton(
          key: const Key('confirmParkingExitDialogButton'),
          onPressed: () {
            store.exitParking(parkingRegister);
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
