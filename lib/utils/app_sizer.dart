import 'package:flutter/material.dart';

class AppSizer{
 static SizedBox verticalSpacing(num height) => SizedBox(height: height.toDouble());
 static SizedBox horizontalSpacing(num width) => SizedBox(width: width.toDouble());
 static double getHomeIndicatorStatus(BuildContext context) {
  if (MediaQuery.of(context).padding.bottom > 0) {
   // homebar is present
   return 21;
  } else {
   // homebar is not present
   return 0;
  }
 }

 
}