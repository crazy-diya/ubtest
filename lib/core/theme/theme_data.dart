import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/theme/colors/app_colors.dart';
import 'package:union_bank_mobile/core/theme/colors/dark_colors.dart';
import 'package:union_bank_mobile/core/theme/colors/light_colors.dart';
import 'package:union_bank_mobile/core/theme/theme_service.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';



AppColors colors(context) => Theme.of(context).extension<AppColors>()!;

ThemeData getAppTheme(ThemeType themeType) {
  AppColors colors;
  switch (themeType) {
    case ThemeType.LIGHT:
      colors = LightColors.lightTheme() ;
      break;
    case ThemeType.DARK:
      colors = DarkColors.darkTheme();
      break;
    case ThemeType.RED:
      colors = LightColors.lightTheme() ;
      break;
    default: 
      colors = LightColors.lightTheme() ;
  }

  return ThemeData(
    fontFamily: AppConstants.kFontFamily,
    useMaterial3: false,
    extensions: <ThemeExtension<AppColors>>[
      colors
    ],
    scaffoldBackgroundColor:colors.whiteColor,
    primaryColor: colors.primaryColor,
  );
}


