import 'package:flutter/material.dart';
import 'package:parking_controller/core/design/theme/color_helpers.dart';

class Palette {
  static const Color primary = Color(0xFF3B4CCA);
  static const Color secondary = Color(0xFFFFDE00);

  static const Color primaryTextColor = Color(0xFF131313);
  static const Color secondaryTextColor = Color(0xFF2C2925);

  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color onSecondaryColor = Color(0xFF2C2925);

  static const Color backgroundColor = Color(0xFFF5F5F5);

  static const Color inputBackground = Color(0xFF131313);
  static const Color inputBorderColor = secondary;

  static const Color disabledColor = Color(0xFF656565);
  static const Color dividerColor = Color(0xFFE5E5E5);

  // dark colors
  static const Color darkPrimary = Color(0xFF3B4CCA);
  static const Color darkSecondary = Color(0xFFFDC61E);

  static const Color darkPrimaryTextColor = Color(0xFFFFFFFF);
  static const Color darkSecondaryTextColor = Color(0xFFFDC61E);

  static const Color darkOnPrimaryColor = Color(0xFF2C2925);
  static const Color darkOnSecondaryColor = Color(0xFF2C2925);

  static const Color darkBackgroundColor = Color(0xFF2C2925);

  static const Color warning = Colors.yellow;
  static const Color error = Color(0xFFD95050);
  static const Color success = Color(0xFF68D391);

  static Color get backgroundSnackAlert => generateMaterialColor(const Color.fromRGBO(255, 248, 224, 1));
  static Color get backgroundSnackError => generateMaterialColor(error);
  static Color get backgroundSnackSuccess => generateMaterialColor(primary);

  static MaterialColor materialPrimary = generateMaterialColor(primary);
  static MaterialColor materialPrimaryDark = generateMaterialColor(darkPrimary);
}
