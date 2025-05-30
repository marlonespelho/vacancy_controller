import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_controller/core/design/theme/palette.dart';
import 'package:parking_controller/generated/l10n.dart';
import 'package:parking_controller/modules/parking/models/main.dart';

class ParkingHistoryCardWidget extends StatelessWidget {
  final ParkingRegister parkingRegister;

  const ParkingHistoryCardWidget({super.key, required this.parkingRegister});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            "${parkingRegister.parking.title} - ${parkingRegister.vehiclePlate}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                "${S.current.entryDateLabel} ${dateFormat.format(parkingRegister.entryDate)}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                parkingRegister.exitDate == null
                    ? S.current.parkingNotExitedYet
                    : "${S.current.exitDateLabel} ${dateFormat.format(parkingRegister.entryDate)}",
                style: parkingRegister.exitDate == null
                    ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Palette.error,
                          fontWeight: FontWeight.bold,
                        )
                    : Theme.of(context).textTheme.bodyMedium!.copyWith(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
