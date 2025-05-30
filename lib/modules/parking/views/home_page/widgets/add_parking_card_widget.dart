import 'package:flutter/material.dart';
import 'package:parking_controller/generated/l10n.dart';

class AddParkingCardWidget extends StatelessWidget {
  final Function onTap;

  const AddParkingCardWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 4,
        ),
      ),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(
                S.current.addParkingCardTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8, right: 8),
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.add_circle,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
