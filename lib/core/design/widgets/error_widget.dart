import 'package:dio/dio.dart';

import 'package:parking_controller/core/design/widgets/snack_bar.dart';
import 'package:parking_controller/core/http/http_service.dart';

handleException(Object e, [Function? onError, stack]) async {
  if (onError != null) {
    onError(e);
    return;
  }

  if (e is DioException && e.error is HttpError) {
    HttpError error = e.error as HttpError;
    showSnackBarMessage(message: error.message, type: SnackBarTypeEnum.error);
    return;
  }

  showSnackBarMessage(message: e.toString(), type: SnackBarTypeEnum.error);
  return;
}
