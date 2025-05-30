import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:parking_controller/core/services/main.dart';
import 'package:parking_controller/generated/l10n.dart';
import 'package:parking_controller/modules/parking/models/parking.dart';
import 'package:parking_controller/modules/parking/stores/parking_store.dart';

class RegisterParkingEntryDialog extends StatelessWidget {
  final Parking parking;

  final TextEditingController vehiclePlateController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ParkingStore store = Modular.get();

  RegisterParkingEntryDialog({super.key, required this.parking});

  static Future<void> show({required Parking parking}) {
    return showDialog(
      context: getCurrentContext(),
      builder: (context) => RegisterParkingEntryDialog(parking: parking),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(
        S.current.registerParkingEntryDialogTitle,
      ),
      content: Form(
        key: formKey,
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.current.registerParkingEntryDialogContent(parking.title),
            ),
            TextFormField(
              key: const Key("registerParkingEntryDialogTextField"),
              keyboardType: TextInputType.text,
              controller: vehiclePlateController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                LengthLimitingTextInputFormatter(7),
              ],
              validator: (value) =>
                  value == null || value.length < 7 ? S.current.registerParkingEntryDialogTextFieldErrorMessage : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.current.cancelButtonText),
        ),
        ElevatedButton(
          key: const Key('registerParkingEntryDialogButton'),
          onPressed: () {
            if (!formKey.currentState!.validate()) return;
            store.entryParking(
              vehiclePlate: vehiclePlateController.text.toUpperCase(),
              parking: parking,
            );
            Navigator.of(context).pop();
          },
          child: Text(
            S.current.registerParkingEntryButtonText,
          ),
        ),
      ],
    );
  }
}
