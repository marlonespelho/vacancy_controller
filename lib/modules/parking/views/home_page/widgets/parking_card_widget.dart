import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_controller/core/design/theme/palette.dart';
import 'package:parking_controller/generated/l10n.dart';
import 'package:parking_controller/modules/parking/models/main.dart';

class ParkingCardWidget extends StatelessWidget {
  final Parking parking;
  final ParkingRegister? parkingRegister;
  final Function onTap;
  final Function onDelete;

  const ParkingCardWidget({
    super.key,
    required this.parking,
    this.parkingRegister,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Card(
          key: const Key('ParkingCardWidget'),
          color: parking.isOccupied ? Theme.of(context).colorScheme.error : Palette.success,
          child: InkWell(
            onTap: () => onTap(parking),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    parking.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  if (!parking.isOccupied) ...buildAvailableInfo(context),
                  if (parking.isOccupied) ...buildRegisterInfo(context)
                ],
              ),
            ),
          ),
        ),
        if (!parking.isOccupied)
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              key: const Key('parkingCardWidgetDeleteButton'),
              onPressed: () {
                onDelete(parking);
              },
              icon: Icon(
                Icons.delete_forever,
                color: Theme.of(context).colorScheme.onSurface,
                size: 24,
              ),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
      ],
    );
  }

  List<Widget> buildAvailableInfo(BuildContext context) {
    return [
      Text(
        S.current.parkingAvailableText,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
      Spacer(),
      Text(
        S.current.tapToAddParkingCardText,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
    ];
  }

  List<Widget> buildRegisterInfo(BuildContext context) {
    return [
      Text(
        "Veículo:",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
      Text(
        parkingRegister?.vehiclePlate ?? '',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
      Spacer(),
      Text(
        "Entrada em:",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
      Text(
        DateFormat('dd/MM/yyyy HH:mm').format(parkingRegister!.entryDate),
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
    ];
  }
}
