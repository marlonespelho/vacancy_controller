import 'package:mobx/mobx.dart';
import 'package:vacancy_controller/core/models/main.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  Function? showProgressDialog;
  Function? hideProgressDialog;

  setupCallbacks({
    Function? showProgressDialog,
    Function? hideProgressDialog,
  }) {
    this.showProgressDialog = showProgressDialog;
    this.hideProgressDialog = hideProgressDialog;
  }

  @observable
  bool isLoading = false;

  @observable
  Paginate? paginate;
}
