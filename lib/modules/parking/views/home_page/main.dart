import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:parking_controller/core/design/widgets/loading_dialog.dart';
import 'package:parking_controller/core/services/main.dart';
import 'package:parking_controller/generated/l10n.dart';
import 'package:parking_controller/modules/app_store.dart';
import 'package:parking_controller/modules/parking/main.dart';
import 'package:parking_controller/modules/parking/stores/main.dart';
import 'package:parking_controller/modules/parking/stores/parking_store.dart';
import 'package:parking_controller/modules/parking/views/home_page/widgets/parking_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore homeStore = Modular.get();
  final AppStore appStore = Modular.get();
  final ParkingStore parkingStore = Modular.get();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      parkingStore.setupCallbacks(
        showProgressDialog: LoadingDialog.showLoading,
        hideProgressDialog: LoadingDialog.hideLoading,
      );
      scrollController.addListener(() {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {}
      });
      parkingStore.init();
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildContent(),
      floatingActionButton: buildHistoryFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildHistoryFAB() {
    return ElevatedButton(
      key: const Key("parkingHistoryFAB"),
      onPressed: () {
        pushNamed(routeName: ParkingModule.parkingHistoryRoute);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Icon(
            Icons.history,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 24,
          ),
          Text(
            S.current.parkingHistoryFABLabel,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(S.current.homeAppBarTitle),
      actions: [
        IconButton(
          onPressed: () {
            appStore.changeThemeMode();
          },
          icon: buildThemeModeAction(),
        ),
      ],
    );
  }

  Observer buildThemeModeAction() {
    return Observer(builder: (context) {
      return Icon(
        appStore.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
      );
    });
  }

  Observer buildContent() {
    return Observer(builder: (context) {
      return homeStore.isLoading
          ? buildLoading()
          : RefreshIndicator(
              onRefresh: () async {
                if (homeStore.isLoading) return;
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ParkingWidgetList(),
              ),
            );
    });
  }

  Widget buildLoading() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
