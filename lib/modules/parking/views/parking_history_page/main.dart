import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:parking_controller/core/design/theme/palette.dart';
import 'package:parking_controller/core/design/widgets/shimmer_loading.dart';
import 'package:parking_controller/generated/l10n.dart';
import 'package:parking_controller/modules/parking/stores/parking_history_store.dart';
import 'package:parking_controller/modules/parking/views/parking_history_page/widgets/parking_history_card_widget.dart';

class ParkingHistoryPage extends StatefulWidget {
  const ParkingHistoryPage({super.key});

  @override
  State<ParkingHistoryPage> createState() => _ParkingHistoryPageState();
}

class _ParkingHistoryPageState extends State<ParkingHistoryPage> {
  final ParkingHistoryStore parkingHistoryStore = Modular.get();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      parkingHistoryStore.getParkingRegisters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.parkingHistoryAppBarTitle),
      ),
      body: Observer(builder: (context) {
        if (parkingHistoryStore.loading) {
          return loadingList();
        }

        if (parkingHistoryStore.parkingRegisters.isEmpty) {
          return emptyListWidget(context);
        }

        return SingleChildScrollView(
          child: buildDateExpansionList(),
        );
      }),
    );
  }

  Widget buildDateExpansionList() {
    final registerDates = parkingHistoryStore.getDatesFromParkingRegisters();
    return Column(
      children: [
        ...registerDates.map(
          (date) => ExpansionPanelList(
            elevation: 0,
            expandedHeaderPadding: const EdgeInsets.all(0),
            expandIconColor: Theme.of(context).primaryColor,
            expansionCallback: (index, isExpanded) {
              parkingHistoryStore.expansionPanelState[registerDates.indexOf(date)] = isExpanded;
            },
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return buildDateHeader(date);
                },
                canTapOnHeader: true,
                backgroundColor: Theme.of(context).colorScheme.surface,
                body: buildParkingRegistersList(date),
                isExpanded: parkingHistoryStore.expansionPanelState[registerDates.indexOf(date)],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildParkingRegistersList(DateTime date) {
    return Column(
      children: parkingHistoryStore.getParkingRegistersByDate(date).map(
        (parkingRegister) {
          return ParkingHistoryCardWidget(parkingRegister: parkingRegister);
        },
      ).toList(),
    );
  }

  Widget loadingList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShimmerLoading(
            height: 80,
            width: double.infinity,
          ),
        );
      },
    );
  }

  Widget emptyListWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Text(
            S.current.emptyParkingHistoryListMessage,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18),
          ),
          TextButton(
            onPressed: () {
              Modular.to.pop();
            },
            child: Text(S.current.backButtonLabel),
          ),
        ],
      ),
    );
  }

  buildDateHeader(DateTime date) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        dateFormat.format(date),
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
