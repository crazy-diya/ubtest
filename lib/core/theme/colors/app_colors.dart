import 'package:flutter/material.dart';
 class AppColors extends ThemeExtension<AppColors> {
  final Color? whiteColor;

  final Color? primaryColor;
  final Color? primaryColor400;
  final Color? primaryColor300;
  final Color? primaryColor200;
  final Color? primaryColor100;
  final Color? primaryColor50;

  final Color? secondaryColor;
  final Color? secondaryColor800;
  final Color? secondaryColor700;
  final Color? secondaryColor400;
  final Color? secondaryColor300;
  final Color? secondaryColor200;
  final Color? secondaryColor100;
  final Color? secondaryColor50;

  final Color? blackColor;
  final Color? blackColor400;
  final Color? blackColor300;
  final Color? blackColor200;
  final Color? blackColor100;
  final Color? blackColor50;

  final Color? greyColor;
  final Color? greyColor400;
  final Color? greyColor300;
  final Color? greyColor200;
  final Color? greyColor100;
  final Color? greyColor50;

  final Color? positiveColor;
  final Color? positiveColor400;
  final Color? positiveColor300;
  final Color? positiveColor200;
  final Color? positiveColor100;
  final Color? positiveColor50;

  final Color? warningColor;
  final Color? warningColor400;
  final Color? warningColor300;
  final Color? warningColor200;
  final Color? warningColor100;
  final Color? warningColor50;

  final Color? negativeColor;
  final Color? negativeColor400;
  final Color? negativeColor300;
  final Color? negativeColor200;
  final Color? negativeColor100;
  final Color? negativeColor50;


  const AppColors({
    required this.whiteColor,

    required this.primaryColor,
    required this.primaryColor400,
    required this.primaryColor300,
    required this.primaryColor200,
    required this.primaryColor100,
    required this.primaryColor50,

    required this.secondaryColor,
    required this.secondaryColor800,
    required this.secondaryColor700,
    required this.secondaryColor400,
    required this.secondaryColor300,
    required this.secondaryColor200,
    required this.secondaryColor100,
    required this.secondaryColor50,

    required this.blackColor,
    required this.blackColor400,
    required this.blackColor300,
    required this.blackColor200,
    required this.blackColor100,
    required this.blackColor50,

    required this.greyColor,
    required this.greyColor400,
    required this.greyColor300,
    required this.greyColor200,
    required this.greyColor100,
    required this.greyColor50,
 
    required this.positiveColor,
    required this.positiveColor400,
    required this.positiveColor300,
    required this.positiveColor200,
    required this.positiveColor100,
    required this.positiveColor50,

    required this.warningColor,
    required this.warningColor400,
    required this.warningColor300,
    required this.warningColor200,
    required this.warningColor100,
    required this.warningColor50,


    required this.negativeColor,
    required this.negativeColor400,
    required this.negativeColor300,
    required this.negativeColor200,
    required this.negativeColor100,
    required this.negativeColor50,
  });

  @override
  AppColors copyWith({
    Color? whiteColor,

    Color? primaryColor,
    Color? primaryColor400,
    Color? primaryColor300,
    Color? primaryColor200,
    Color? primaryColor100,
    Color? primaryColor50,

    Color? secondaryColor,
    Color? secondaryColor800,
    Color? secondaryColor700,
    Color? secondaryColor400,
    Color? secondaryColor300,
    Color? secondaryColor200,
    Color? secondaryColor100,
    Color? secondaryColor50,

    Color? blackColor,
    Color? blackColor400,
    Color? blackColor300,
    Color? blackColor200,
    Color? blackColor100,
    Color? blackColor50,

    Color? greyColor,
    Color? greyColor400,
    Color? greyColor300,
    Color? greyColor200,
    Color? greyColor100,
    Color? greyColor50,
 
    Color? positiveColor,
    Color? positiveColor400,
    Color? positiveColor300,
    Color? positiveColor200,
    Color? positiveColor100,
    Color? positiveColor50,

    Color? warningColor,
    Color? warningColor400,
    Color? warningColor300,
    Color? warningColor200,
    Color? warningColor100,
    Color? warningColor50,


    Color? negativeColor,
    Color? negativeColor400,
    Color? negativeColor300,
    Color? negativeColor200,
    Color? negativeColor100,
    Color? negativeColor50,
  }) {
    return AppColors(
      whiteColor: whiteColor ?? this.whiteColor,

      primaryColor: primaryColor ?? this.primaryColor,
      primaryColor400: primaryColor400 ?? this.primaryColor400,
      primaryColor300: primaryColor300 ?? this.primaryColor300,
      primaryColor200: primaryColor200 ?? this.primaryColor200,
      primaryColor100: primaryColor100 ?? this.primaryColor100,
      primaryColor50: primaryColor50 ?? this.primaryColor50,

      secondaryColor: secondaryColor ?? this.secondaryColor,
      secondaryColor800 : secondaryColor800 ?? this.secondaryColor800,
      secondaryColor700 : secondaryColor700 ?? this.secondaryColor700,
      secondaryColor400: secondaryColor400 ?? this.secondaryColor400,
      secondaryColor300: secondaryColor300 ?? this.secondaryColor300,
      secondaryColor200: secondaryColor200 ?? this.secondaryColor200,
      secondaryColor100: secondaryColor100 ?? this.secondaryColor100,
      secondaryColor50: secondaryColor50 ?? this.secondaryColor50,

      blackColor: blackColor ?? this.blackColor,
      blackColor400: blackColor400 ?? this.blackColor400,
      blackColor300: blackColor300 ?? this.blackColor300,
      blackColor200: blackColor200 ?? this.blackColor200,
      blackColor100: blackColor100 ?? this.blackColor100,
      blackColor50: blackColor50 ?? this.blackColor50,

      greyColor: greyColor ?? greyColor,
      greyColor400: greyColor400 ?? this.greyColor400,
      greyColor300: greyColor300 ?? this.greyColor300,
      greyColor200: greyColor200 ?? this.greyColor200,
      greyColor100: greyColor100 ?? this.greyColor100,
      greyColor50: greyColor50 ?? this.greyColor50,

      positiveColor: positiveColor ?? positiveColor,
      positiveColor400: positiveColor400 ?? this.positiveColor400,
      positiveColor300: positiveColor300 ?? this.positiveColor300,
      positiveColor200: positiveColor200 ?? this.positiveColor200,
      positiveColor100: positiveColor100 ?? this.positiveColor100,
      positiveColor50: positiveColor50 ?? this.positiveColor50,

      warningColor: warningColor ?? warningColor,
      warningColor400: warningColor400 ?? this.warningColor400,
      warningColor300: warningColor300 ?? this.warningColor300,
      warningColor200: warningColor200 ?? this.warningColor200,
      warningColor100: warningColor100 ?? this.warningColor100,
      warningColor50: warningColor50 ?? this.warningColor50,

      negativeColor: negativeColor ?? negativeColor,
      negativeColor400: negativeColor400 ?? this.negativeColor400,
      negativeColor300: negativeColor300 ?? this.negativeColor300,
      negativeColor200: negativeColor200 ?? this.negativeColor200,
      negativeColor100: negativeColor100 ?? this.negativeColor100,
      negativeColor50: negativeColor50 ?? this.negativeColor50, 
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t),
      
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
       primaryColor400: Color.lerp(primaryColor400, other.primaryColor400, t),
        primaryColor300: Color.lerp(primaryColor300, other.primaryColor300, t),
         primaryColor200: Color.lerp(primaryColor200, other.primaryColor200, t),
          primaryColor100: Color.lerp(primaryColor100, other.primaryColor100, t),
           primaryColor50: Color.lerp(primaryColor50, other.primaryColor50, t),

      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      secondaryColor800: Color.lerp(secondaryColor800, other.secondaryColor800, t),
        secondaryColor700: Color.lerp(secondaryColor700, other.secondaryColor700, t),
         secondaryColor400: Color.lerp(secondaryColor400, other.secondaryColor400, t),
          secondaryColor300: Color.lerp(secondaryColor300, other.secondaryColor300, t),
           secondaryColor200: Color.lerp(secondaryColor200, other.secondaryColor200, t),
           secondaryColor100: Color.lerp(secondaryColor100, other.secondaryColor100, t),
            secondaryColor50: Color.lerp(secondaryColor50, other.secondaryColor50, t),

      blackColor: Color.lerp(blackColor, other.blackColor, t),
       blackColor400: Color.lerp(blackColor400, other.blackColor400, t),
        blackColor300: Color.lerp(blackColor300, other.blackColor300, t),
         blackColor200: Color.lerp(blackColor200, other.blackColor200, t),
          blackColor100: Color.lerp(blackColor100, other.blackColor100, t),
           blackColor50: Color.lerp(blackColor50, other.blackColor50, t),

      greyColor: Color.lerp(greyColor, other.greyColor, t),
       greyColor400: Color.lerp(greyColor400, other.greyColor400, t),
        greyColor300: Color.lerp(greyColor300, other.greyColor300, t),
         greyColor200: Color.lerp(greyColor200, other.greyColor200, t),
          greyColor100: Color.lerp(greyColor100, other.greyColor100, t),
           greyColor50: Color.lerp(greyColor50, other.greyColor50, t),

      positiveColor: Color.lerp(positiveColor, other.positiveColor, t),
       positiveColor400: Color.lerp(positiveColor400, other.positiveColor400, t),
        positiveColor300: Color.lerp(positiveColor300, other.positiveColor300, t),
         positiveColor200: Color.lerp(positiveColor200, other.positiveColor200, t),
          positiveColor100: Color.lerp(positiveColor100, other.positiveColor100, t),
           positiveColor50: Color.lerp(positiveColor50, other.positiveColor50, t),

      warningColor: Color.lerp(warningColor, other.warningColor, t),
       warningColor400: Color.lerp(warningColor400, other.warningColor400, t),
        warningColor300: Color.lerp(warningColor300, other.warningColor300, t),
         warningColor200: Color.lerp(warningColor200, other.warningColor200, t),
          warningColor100: Color.lerp(warningColor100, other.warningColor100, t),
           warningColor50: Color.lerp(warningColor50, other.warningColor50, t),

      negativeColor: Color.lerp(negativeColor, other.negativeColor, t),
       negativeColor400: Color.lerp(negativeColor400, other.negativeColor400, t),
        negativeColor300: Color.lerp(negativeColor300, other.negativeColor300, t),
         negativeColor200: Color.lerp(negativeColor200, other.negativeColor200, t),
          negativeColor100: Color.lerp(negativeColor100, other.negativeColor100, t),
           negativeColor50: Color.lerp(negativeColor50, other.negativeColor50, t),
    );
  }
  
}