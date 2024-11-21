
import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import '../../../core/theme/theme_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/enums.dart';

class AppButton extends StatefulWidget {
  final String buttonText;
  final Function onTapButton;
  final double? buttonWidth;
  final ButtonType buttonType;
  final Widget? prefixIcon;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final double? buttonHeight;

  AppButton({
    required this.buttonText,
    required this.onTapButton,
    this.buttonWidth,
    this.prefixIcon,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.buttonType = ButtonType.PRIMARYENABLED,
    this.buttonHeight,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
         height: widget.buttonHeight == null ? 56 : widget.buttonHeight,
        width: widget.buttonWidth == null ? double.infinity : widget.buttonWidth,
        decoration: BoxDecoration(
           border: Border.all(
            width: 1.w,
            color: widget.borderColor == null
                ? getBorderColor(widget.buttonType, context)
                : widget.borderColor!,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ).r,
          color: widget.buttonColor == null
              ? getprimaryColor(widget.buttonType, context)
              : widget.buttonColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.prefixIcon ?? const SizedBox.shrink(),
              widget.prefixIcon != null ?  5.horizontalSpace : const SizedBox.shrink(),
              Expanded(
                child: Text(
                  widget.buttonText,
                  textAlign: TextAlign.center,
                  style: size16weight700.copyWith(color: widget.textColor == null? getTextColor(widget.buttonType, context) : widget.textColor) 
                ),
              ),
            ],
          ),

        ),
      ),
      onTap: () {
        if (widget.buttonType == ButtonType.PRIMARYENABLED || widget.buttonType == ButtonType.OUTLINEENABLED ) {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          widget.onTapButton();
        }
      },
    );
  }
}



Color getprimaryColor(ButtonType buttonType, BuildContext context) {
  switch (buttonType) {
    case ButtonType.PRIMARYENABLED:
      return colors(context).primaryColor!;
    case ButtonType.PRIMARYDISABLED:
      return colors(context).primaryColor300!;
    case ButtonType.OUTLINEENABLED:
      return colors(context).whiteColor!;
    case ButtonType.OUTLINEDISABLED:
      return colors(context).whiteColor!;
  }
}

Color getTextColor(ButtonType buttonType, BuildContext context) {
  switch (buttonType) {
    case ButtonType.PRIMARYENABLED:
      return colors(context).whiteColor!;
    case ButtonType.PRIMARYDISABLED:
      return colors(context).primaryColor100!;
    case ButtonType.OUTLINEENABLED:
      return colors(context).primaryColor!;
    case ButtonType.OUTLINEDISABLED:
      return colors(context).primaryColor300!;
  }
}

Color getBorderColor(ButtonType buttonType, BuildContext context) {
  switch (buttonType) {
    case ButtonType.PRIMARYENABLED:
      return Colors.transparent;
    case ButtonType.PRIMARYDISABLED:
      return Colors.transparent;
    case ButtonType.OUTLINEENABLED:
      return colors(context).primaryColor!;
    case ButtonType.OUTLINEDISABLED:
      return colors(context).primaryColor300!;
  }
}
