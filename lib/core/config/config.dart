import 'package:vacancy_controller/core/config/constants.dart';

abstract class BaseConfig {
  String get environmentName;

  String get apiBaseUrl;
}

class ProductionConfig extends BaseConfig {
  @override
  String get environmentName => 'Production';

  @override
  String get apiBaseUrl => String.fromEnvironment(
        Constants.pokeApiBaseUrl,
        defaultValue: '',
      );
}

class StagingConfig extends BaseConfig {
  @override
  String get environmentName => 'Staging';

  @override
  String get apiBaseUrl => String.fromEnvironment(
        Constants.pokeApiBaseUrl,
        defaultValue: '',
      );
}
