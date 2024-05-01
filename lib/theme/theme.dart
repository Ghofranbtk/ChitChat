import 'package:flutter/material.dart';

import 'constants.dart';
import 'widget-theme/elevated_button_theme.dart';
import 'widget-theme/outlined_button_theme.dart';
import 'widget-theme/text_field_theme.dart';
import 'widget-theme/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  //mobile
  static ThemeData mobileTheme = ThemeData(
    elevatedButtonTheme: TElavatedButtonTheme.smallElevatedButtonTheme,
    outlinedButtonTheme: TOutlineButtonTheme.smallOutlineButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.inputDecorationTheme,
    textTheme: TTextTheme.mobileTextTheme,
  );
}
