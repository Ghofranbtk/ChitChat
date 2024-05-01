import 'package:flutter/material.dart';

import '../constants.dart';

class TElavatedButtonTheme {
  TElavatedButtonTheme._();

  static final smallElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      foregroundColor: kWhiteColor,
      backgroundColor: kBlueColor,
      side: BorderSide(style: BorderStyle.none),
      padding: EdgeInsets.symmetric(vertical: 5),
    ),
  );
}
