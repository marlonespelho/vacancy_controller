import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:parking_controller/core/design/widgets/shimmer_loading.dart';
import 'package:parking_controller/generated/l10n.dart';
import 'package:parking_controller/modules/parking/models/main.dart';
import 'package:parking_controller/modules/parking/stores/parking_store.dart';
import 'package:parking_controller/modules/parking/views/home_page/widgets/add_parking_card_widget.dart';
import 'package:parking_controller/modules/parking/views/home_page/widgets/confirm_delete_parking_dialog.dart';
import 'package:parking_controller/modules/parking/views/home_page/widgets/confirm_exit_parking_dialog.dart';
import 'package:parking_controller/modules/parking/views/home_page/widgets/parking_card_widget.dart';
import 'package:parking_controller/modules/parking/views/home_page/widgets/register_parking_entry_dialog.dart';

class ParkingWidgetList extends StatefulWidget {
  const ParkingWidgetList({super.key});

  @override
  State<ParkingWidgetList> createState() => _ParkingWidgetListState();
}

class _ParkingWidgetListState extends State<ParkingWidgetList> {
  final ParkingStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (store.loading) {
        return loadingList();
      }

      if (store.parkingList.isEmpty) return emptyListWidget(context);
      return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.95,
        padding: EdgeInsets.only(bottom: 64, top: 16),
        children: [
          ...store.parkingList.map(
            (parking) => ParkingCardWidget(
              parking: parking,
              parkingRegister: store.getParkingRegister(parking),
              onTap: handleParkingOnTap,
              onDelete: handleParkingDelete,
            ),
          ),
          AddParkingCardWidget(
            onTap: () {
              store.createParking();
            },
          ),
        ],
      );
    });
  }

  handleParkingOnTap(Parking parking) {
    if (parking.isOccupied) {
      ConfirmParkingExitDialog.show(
        parkingRegister: store.getParkingRegister(parking)!,
      );
      return;
    }
    RegisterParkingEntryDialog.show(parking: parking);
  }

  Widget loadingList() {
    return GridView.count(
        crossAxisCount: 2,
        children: List.generate(6, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ShimmerLoading(
              height: 150,
              width: double.infinity,
            ),
          );
        }));
  }

  Widget emptyListWidget(BuildContext context) {
    return Center(
      key: const Key("parkingEmptyListWidget"),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Text(
            S.current.emptyParkingListMessage,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                ),
          ),
          TextButton(
            key: const Key("emptyListCreateParkingButton"),
            onPressed: handleCreateParking,
            child: Text(S.current.emptyParkingListButtonText),
          ),
        ],
      ),
    );
  }

  void handleCreateParking() {
    if (store.loading) return;
    store.createParking();
  }

  handleParkingDelete(Parking parking) {
    if (store.loading) return;
    ConfirmParkingDeleteDialog.show(parking: parking);
  }
}
