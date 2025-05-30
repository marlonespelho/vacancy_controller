import 'package:flutter/services.dart';
import 'package:parking_controller/core/design/widgets/snack_bar.dart';
import 'package:parking_controller/generated/l10n.dart';

class NativeToast {
  static const MethodChannel _channel = MethodChannel('message/toast');

  static Future<void> showToast(String message) async {
    try {
      await _channel.invokeMethod('showToast', {'message': message});
    } on PlatformException catch (e) {
      showSnackBarMessage(
        message: S.current.showToastErrorMessage,
        type: SnackBarTypeEnum.error,
      );
    }
  }
}
