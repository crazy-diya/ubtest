
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';


class AppLoginTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? icon;
  final Widget? action;
  final String? title;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onTextChanged;
  final Function()? onSuffixIconTap;
  final TextInputType? inputType;
  final bool? isEnable;
  final int? maxLength;
  final String? guideTitle;
  final bool? obscureText;
  final bool? shouldRedirectToNextField;
  final int? maxLines;
  final bool? isCurrency;
  final FocusNode? focusNode;
  final Function(String)? onSubmit;
  final bool? isLabel;

  AppLoginTextField({
    this.controller,
    this.icon,
    this.action,
    this.title,
    this.hint,
    this.guideTitle,
    this.errorMessage,
    this.maxLength = 50,
    this.maxLines = 1,
    this.onTextChanged,
    this.inputType,
    this.focusNode,
    this.onSubmit,
    this.onSuffixIconTap,
    this.isEnable = true,
    this.obscureText = false,
    this.isCurrency = false,
    this.shouldRedirectToNextField = true,
    this.isLabel = false,
  });

  @override
  State<AppLoginTextField> createState() => _AppLoginTextFieldState();
}

class _AppLoginTextFieldState extends State<AppLoginTextField> {
  double borderRadius = 5;
  Widget? action;
  FocusNode? _focusNode;
  bool _hasFocus = false;
  bool passwordHidden = true;
  String updateText = '';

  @override
  void initState() {
    super.initState();
    log(widget.isEnable!.toString());
    setState(() {
      action = widget.action;
      _focusNode = widget.focusNode ?? FocusNode();
    });
    _focusNode!.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode!.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Text(
                widget.title!,
                style: size14weight700.copyWith(color: _hasFocus
                      ? colors(context).primaryColor
                      :  updateText.isNotEmpty
                          ? colors(context).blackColor300
                          : colors(context).blackColor)
              )
            : const SizedBox.shrink(),
       12.verticalSpace,
        TextField(
          cursorColor: colors(context).blackColor,
          onChanged: (value) {
            updateText = value;
            setState(() {});
            if (widget.onTextChanged != null) {
              widget.onTextChanged!(value);
              
            }
          },
          contextMenuBuilder: (context, editableTextState) {
            return SizedBox.shrink();
          },
          onSubmitted: (value) {
            if (widget.onSubmit != null) widget.onSubmit!(value);
          },
          focusNode: _focusNode,
          autofocus: false,
          controller: widget.controller,
          obscureText: widget.obscureText! ? passwordHidden : false,
          obscuringCharacter: '•',
          textInputAction: widget.shouldRedirectToNextField!
              ? TextInputAction.next
              : TextInputAction.done,
          enabled: widget.isEnable,
          maxLines: widget.maxLines,
          textCapitalization: TextCapitalization.sentences,
          maxLength: widget.maxLength,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.maxLength),
          ],
          style: size16weight700.copyWith(color: colors(context).blackColor,),
          keyboardType: widget.inputType ?? TextInputType.text,
          decoration: InputDecoration(
            errorMaxLines: 2,
              labelText: widget.isLabel == true ? widget.hint : null,
              labelStyle: size16weight400.copyWith(color: colors(context).blackColor), 
              floatingLabelStyle: size16weight400.copyWith(color: colors(context).greyColor),
              contentPadding:  EdgeInsets.only(bottom: 4),
              isDense: true,
              errorText: widget.errorMessage,
              counterText: "",
              isCollapsed: true,
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: colors(context).greyColor50!, width: 1),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: updateText.isNotEmpty||
                                (widget.controller?.text.isNotEmpty ?? false)
                            ? colors(context).blackColor300!
                            : colors(context).blackColor!,
                       width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: colors(context).primaryColor!, width: 1),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: colors(context).greyColor!, width: 1),
              ),
              prefixIcon: widget.icon,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 55,
              ),
              suffixIconConstraints: BoxConstraints.tightFor(width:24,height: 28),
              suffixIcon: Padding(
                padding:  EdgeInsets.only(bottom: 4),
                child: widget.obscureText!
                    ? passwordHidden
                        ?  InkWell(
                            child: PhosphorIcon(PhosphorIcons.eye(PhosphorIconsStyle.bold),size: 24,color:  colors(context).blackColor,),
                            onTap: () {
                              setState(() {
                                passwordHidden = !passwordHidden;
                              });
                            },
                          )
                        : InkWell(
                            child: PhosphorIcon(PhosphorIcons.eyeSlash(PhosphorIconsStyle.bold),size: 24,color:  colors(context).blackColor,),
                            onTap: () {
                              setState(() {
                                passwordHidden = !passwordHidden;
                              });
                            },
                          ) 
                    : action,
              ),
              filled: true,
              hintText: !_hasFocus
                  ? widget.isLabel == false
                      ? widget.hint
                      : null
                  : null,
              hintStyle:size16weight400.copyWith(color: colors(context).greyColor), 
              fillColor: colors(context).whiteColor),
        ),
      ],
    );
  }
}
