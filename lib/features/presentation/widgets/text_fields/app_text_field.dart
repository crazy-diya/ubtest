import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/validator.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/input_formatters.dart';
import '../info_icon_view.dart';

class AppTextField extends StatefulWidget {
  TextEditingController? controller;

  // MoneyMaskedTextController? moneyMaskedTextController;
  final Widget? icon;
  Widget? action;
  final String? hint;
  final String? title;
  final String? errorMessage;
  final Function(String)? onTextChanged;
  final Function()? onSuffixIconTap;
  final TextInputType? inputType;
  final bool? isEnable;
  final String? Function(String?)? validator;
  final int? maxLength;
  final String? guideTitle;
  final bool? obscureText;
  final bool? shouldRedirectToNextField;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool isLabel;
  final List<TextInputFormatter>? inputFormatter;
  final TextCapitalization? textCapitalization;
  final bool isFirstItem;
  final bool isReadOnly;
  final String? initialValue;
  final bool isCurrency;
  final bool showCurrencySymbol;
  final String? currencySymbol;
  final double? letterSpacing;
  final TextStyle? inputTextStyle;
  final bool? isInfoIconVisible;
  final List<String>? infoIconText;
  final String? toolTipTitle;
  final bool? successfullyValidated;
  final bool? isNationalFlag;
  final double? toolTipRightPadding;
  final bool isShowingInTheField;
  SuperTooltipController? superToolTipController;

  AppTextField({
    Key? key,
    this.controller,
    this.icon,
    this.action,
    this.hint,
    this.title,
    this.guideTitle,
    this.errorMessage,
    this.maxLength = 50,
    this.maxLines = 1,
    this.onTextChanged,
    this.inputType,
    this.validator,
    this.focusNode,
    this.onSuffixIconTap,
    this.isEnable = true,
    this.obscureText = false,
    this.shouldRedirectToNextField = true,
    this.isLabel = false,
    this.inputFormatter,
    this.textCapitalization = TextCapitalization.sentences,
    this.isFirstItem = false,
    this.isReadOnly = false,
    this.isCurrency = false,
    this.showCurrencySymbol = true,
    this.currencySymbol = "LKR",
    this.initialValue,
    this.letterSpacing,
    this.inputTextStyle,
    this.isInfoIconVisible = false,
    this.infoIconText,
    this.toolTipTitle,
    this.successfullyValidated = true,
    this.isNationalFlag = false,
    this.toolTipRightPadding = null,
    this.isShowingInTheField = false,
    this.superToolTipController = null,
    // this.moneyMaskedTextController,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  double borderRadius = 5;
  Widget? action;
  FocusNode? _focusNode;
  bool _hasFocus = false;
  bool passwordHidden = true;

  // bool isValid = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.controller = widget.controller ?? TextEditingController();
      action = widget.action;
      _focusNode = widget.focusNode ?? FocusNode();
    });
    _focusNode!.addListener(_onFocusChange);
    // if (widget.isCurrency) {
    //   setState(() {
    //     widget.moneyMaskedTextController = MoneyMaskedTextController(
    //       decimalSeparator: '.',
    //       thousandSeparator: ',',
    //       initialValue: widget.initialValue == null
    //           ? 0.0
    //           : double.parse(widget.initialValue!.replaceAll(",", "")),
    //     );
    //   });
    // }
    init();
  }

  void init() {
    if (widget.initialValue != null) {
      widget.controller?.text = widget.initialValue!;
    }
  }

  void _onFocusChange() {
    if (mounted)
      setState(() {
        _hasFocus = _focusNode!.hasFocus;
      });
  }

  // @override
  // void dispose() {
  //   _focusNode!.dispose();
  //   super.dispose();
  //   // widget.controller?.removeListener(() {});
  //   // widget.controller?.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: widget.validator,
        builder: (formFieldState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title != null
                  ? Row(
                      children: [
                        Text(
                          widget.title!,
                          style: formFieldState.hasError &&
                                  (formFieldState.value != null || formFieldState.value != "")
                              ? size14weight700.copyWith(
                                  color: colors(context).negativeColor)
                              : _hasFocus
                                  ? widget.isReadOnly == true
                                      ? size14weight700.copyWith(
                                          color: colors(context).blackColor300)
                                      : size14weight700.copyWith(
                                          color: colors(context).primaryColor)
                                  : ((formFieldState.value != null && formFieldState.value != "") || (widget.controller?.text.isNotEmpty ?? false))
                                         ?widget.isCurrency== true
                              ?(widget.controller?.text != "0.00" && widget.controller?.text != null &&
                              widget.controller?.text != "")
                              ? size14weight700.copyWith(color: colors(context).blackColor300)
                              :size14weight700.copyWith(color: colors(context).blackColor)
                              :size14weight700.copyWith(color: colors(context).blackColor300)
                              :   widget.isEnable == false
                                 ? size14weight700.copyWith(color: colors(context).blackColor300)
                                 : size14weight700.copyWith(color: colors(context).blackColor)
                        ),
                        if (widget.isInfoIconVisible == true)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                CommonToolTips(
                                  isTextFieldEmpty :(formFieldState.value != null || (widget.controller?.text.isNotEmpty ?? false))? false:true,
                                  controller: widget.superToolTipController,
                                  hasFocus: _hasFocus,
                                  rightPadding: widget.toolTipRightPadding,
                                  title: widget.toolTipTitle ?? "",
                                  content: widget.infoIconText ?? [],
                                  successfullyValidated:
                                  formFieldState.hasError &&
                                      (formFieldState.value != null || formFieldState.value != "")
                                          ? true
                                          : false,
                                ),
                              ],
                            ),
                          ),
                      ],
                    )
                  : const SizedBox.shrink(),
              if (widget.guideTitle != null)
                Column(
                  children: [
                    Text(widget.guideTitle!,
                        style: size16weight400.copyWith(
                            color: colors(context).blackColor)),
                  ],
                ),

              widget.isLabel &&
                      (_hasFocus ||
                          (widget.controller?.text.isNotEmpty ?? false) ||
                          widget.isCurrency)
                  ? Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.hint!,
                                style: _hasFocus
                                    ? widget.successfullyValidated == false
                                        ? size14weight700.copyWith(
                                            color: colors(context).negativeColor)
                                        : size14weight700.copyWith(
                                            color: colors(context).primaryColor)
                                    : widget.successfullyValidated == false
                                        ? size14weight700.copyWith(
                                            color: colors(context).negativeColor)
                                        : size14weight700.copyWith(
                                            color: colors(context).blackColor300)),
                            2.horizontalSpace,
                            if (widget.isInfoIconVisible == true)
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  children: [
                                    CommonToolTips(
                                      isTextFieldEmpty :(formFieldState.value != null || (widget.controller?.text.isNotEmpty ?? false))? false:true,
                                      controller: widget.superToolTipController,
                                      title: widget.toolTipTitle ?? "",
                                      content: widget.infoIconText ?? [],
                                      successfullyValidated:
                                      formFieldState.hasError &&
                                          (formFieldState.value != null || formFieldState.value != "")
                                          ? true
                                          : false,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      12.verticalSpace,
                    ],
                  )
                  : widget.isFirstItem
                      ? 0.verticalSpace
                      : 12.verticalSpace,
              // SizedBox(height: widget.isFirstItem ? 0 : 30),
              TextFormField(
                onChanged: (text) {
                  formFieldState.didChange(text);
                  setState(() {});
                  if (widget.onTextChanged != null) {
                    widget.onTextChanged!(text);
                  }
                },
                contextMenuBuilder: (context, editableTextState) {
                  return SizedBox.shrink();
                },
                focusNode: _focusNode,
                enableInteractiveSelection: false,
                autocorrect: false,
                enableSuggestions: false,
                autofocus: false,
                controller: widget.controller,
                obscureText: widget.obscureText! ? passwordHidden : false,
                obscuringCharacter: '•',
                textInputAction: widget.shouldRedirectToNextField!
                    ? TextInputAction.next
                    : TextInputAction.done,
                enabled: widget.isEnable,
                readOnly: widget.isReadOnly,
                validator: widget.validator,
                maxLines: widget.maxLines,
                textCapitalization: widget.textCapitalization!,
                textAlignVertical: TextAlignVertical.center,
                maxLength: widget.maxLength,
                inputFormatters: [
                  if (widget.inputFormatter != null) ...widget.inputFormatter!,
                  FilteringTextInputFormatter.deny(
                    RegExp(Validator().emojiRegexp),
                  ),
                  if (widget.isCurrency) CurrencyBackSpaceClearStopFormatter()
                ],
                style: widget.inputTextStyle != null
                    ? widget.inputTextStyle
                    : widget.isCurrency
                        ? (widget.controller?.text != "0.00" && widget.controller?.text != null &&
                    widget.controller?.text != "")
                            ? size16weight700.copyWith(
                                color: colors(context).greyColor,
                                letterSpacing: widget.letterSpacing)
                            : size16weight400.copyWith(
                                color: colors(context).greyColor,
                                letterSpacing: widget.letterSpacing,height: 1.25)
                        : size16weight700.copyWith(
                            color: colors(context).greyColor,
                            letterSpacing: widget.letterSpacing),
                keyboardType: widget.inputType ?? TextInputType.text,
                cursorColor: colors(context).blackColor,
                decoration: InputDecoration(
                    errorMaxLines: 2,
                     contentPadding:  EdgeInsets.only(bottom: 4),
                    errorText: widget.errorMessage,
                    counterText: "",
                    isCollapsed: true,
                    errorStyle: size14weight400.copyWith(
                        color: colors(context).negativeColor),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: colors(context).negativeColor!, width: 2),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: colors(context).negativeColor!, width: 2),
                    ),
                    enabledBorder: widget.isReadOnly == true
                        ? UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colors(context).greyColor50!,
                                width: 1),
                          )
                        : UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: formFieldState.value != null ||
                                        (widget.controller?.text.isNotEmpty ??
                                            false)
                                    ? colors(context).blackColor300!
                                    : colors(context).blackColor!,
                                width: 1),
                          ),
                    focusedBorder: widget.isReadOnly == true
                        ? UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colors(context).greyColor50!,
                                width: 1),
                          )
                        : UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colors(context).primaryColor!,
                                width: 2),
                          ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: colors(context).greyColor50!, width: 1),
                    ),
                    prefixIcon: widget.isCurrency
                        ? Padding(
                            padding:  EdgeInsets.only(right: 8,bottom: 4),
                            child: Text(
                              widget.showCurrencySymbol
                                  ? widget.currencySymbol ?? AppLocalizations.of(context).translate("lkr")
                                  : "",
                              style:(widget.controller?.text != "0.00" && widget.controller?.text != null &&
                                  widget.controller?.text != "")
                                  ? size16weight700.copyWith(
                                      color: colors(context).greyColor)
                                  : size16weight400.copyWith(
                                      color: colors(context).greyColor),
                            ),
                          )
                        : widget.isNationalFlag == true
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.srilankanFlag,
                                    width: 22,
                                  ),
                                  4.horizontalSpace,
                                  Text(
                                    "+94",
                                    style: size16weight700.copyWith(
                                      color: colors(context).greyColor,
                                    ),
                                  ),
                                  4.horizontalSpace,
                                  Container(
                                    width: 1,
                                    height: 24,
                                    color: colors(context).greyColor300,
                                  ),
                                  16.horizontalSpace,
                                ],
                              )
                            : null,
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 2,
                    ),
                    suffixIconConstraints: BoxConstraints.tightFor(width: 24, height: 28),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: widget.obscureText!
                          ? passwordHidden
                              ? InkWell(
                                  child: PhosphorIcon(
                                    PhosphorIcons.eye(PhosphorIconsStyle.bold),
                                    size: 24,
                                    color: colors(context).blackColor,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      passwordHidden = !passwordHidden;
                                    });
                                  },
                                )
                              : InkWell(
                                  child: PhosphorIcon(
                                    PhosphorIcons.eyeSlash(
                                        PhosphorIconsStyle.bold),
                                    size: 24,
                                    color: colors(context).blackColor,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      passwordHidden = !passwordHidden;
                                    });
                                  },
                                )
                          : widget.isShowingInTheField == true
                              ? CommonToolTips(
                                  isTextFieldEmpty :(formFieldState.value != null || (widget.controller?.text.isNotEmpty ?? false))? false:true,
                                  isReadOnlyTextFieldToolTip: widget.isReadOnly,
                                  controller: widget.superToolTipController,
                                  hasFocus: _hasFocus,
                                  isShowingInTheFieldToolTip:
                                      widget.isShowingInTheField,
                                  title: widget.toolTipTitle ?? "",
                                  content: widget.infoIconText ?? [],
                                  successfullyValidated: formFieldState.hasError &&
                                      (formFieldState.value != null || formFieldState.value != "")
                                      ? true : false,
                                )
                              : action,
                    ),
                    filled: true,
                    hintText: _hasFocus ? null : widget.hint,
                    hintStyle: size16weight400.copyWith(
                        color: colors(context).greyColor),
                    fillColor: colors(context).whiteColor),
              ),
            ],
          );
        });
  }
}
