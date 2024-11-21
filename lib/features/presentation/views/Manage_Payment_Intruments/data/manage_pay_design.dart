// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ManagePayDesign {
  Color backgroundColor;
  Color fontColor;
  Color dividerColor;
  ManagePayDesign({
    required this.backgroundColor,
    required this.fontColor,
    required this.dividerColor,
  });

  @override
  String toString() => 'ManagePayDesign(backgroundColor: $backgroundColor, fontColor: $fontColor, dividerColor: $dividerColor)';

  @override
  bool operator ==(covariant ManagePayDesign other) {
    if (identical(this, other)) return true;
  
    return 
      other.backgroundColor == backgroundColor &&
      other.fontColor == fontColor &&
      other.dividerColor == dividerColor;
  }

  @override
  int get hashCode => backgroundColor.hashCode ^ fontColor.hashCode ^ dividerColor.hashCode;
}
