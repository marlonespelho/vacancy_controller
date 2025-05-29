import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vacancy_controller/core/design/widgets/loading_dialog.dart';
import 'package:vacancy_controller/generated/l10n.dart';
import 'package:vacancy_controller/modules/app_store.dart';
import 'package:vacancy_controller/modules/vacancy/stores/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore homeStore = Modular.get();
  final AppStore appStore = Modular.get();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      homeStore.setupCallbacks(
        showProgressDialog: LoadingDialog.showLoading,
        hideProgressDialog: LoadingDialog.hideLoading,
      );
      scrollController.addListener(() {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {}
      });
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
      return homeStore.isLoading ? buildLoading() : buildGrid();
    });
  }

  Widget buildGrid() {
    return RefreshIndicator(
      onRefresh: () async {
        if (homeStore.isLoading) return;
      },
      child: Scrollbar(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [],
          ),
        ),
      ),
    );
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
