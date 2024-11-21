import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import '../../../../../core/theme/text_styles.dart';



class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isSelected;
  Function? navigateToPage;

  CustomButton({
    required this.text,
    required this.onTap,
    required this.isSelected,
    this.navigateToPage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(9.74,12,9.74,12).w,
        decoration: BoxDecoration(
          color: isSelected ? colors(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0).w,
          border: Border.all(
            color: colors(context).primaryColor ?? Colors.blue
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: isSelected ? size14weight700.copyWith(color: colors(context).whiteColor) :
            size14weight700.copyWith(color: colors(context).primaryColor)
          ),
        ),
      ),
    );
  }
}
