import 'package:parking_controller/core/config/config.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String production = 'Production';
  static const String staging = 'Staging';

  BaseConfig config = ProductionConfig();

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) => environment == production ? ProductionConfig() : StagingConfig();
}
