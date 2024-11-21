// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:union_bank_mobile/utils/validator.dart';
// 
// import '../../../widgets/info_icon_view.dart';
//
// class CalculatorTextField extends StatefulWidget {
//   TextEditingController? controller;
//   final Widget? icon;
//   Widget? action;
//   final String? hint;
//   final String? errorMessage;
//   final Function(String)? onTextChanged;
//   final Function()? onSuffixIconTap;
//   final TextInputType? inputType;
//   final bool? isEnable;
//   final String? Function(String?)? validator;
//   final int? maxLength;
//   final String? guideTitle;
//   final bool? obscureText;
//   final bool? shouldRedirectToNextField;
//   final int? maxLines;
//   final FocusNode? focusNode;
//   final bool isLabel;
//   final List<TextInputFormatter>? inputFormatter;
//   final TextCapitalization? textCapitalization;
//   final bool isFirstItem;
//   final bool isReadOnly;
//   final String? initialValue;
//   final bool isCurrency;
//   final bool showCurrencySymbol;
//   final double? letterSpacing;
//   final TextStyle? inputTextStyle;
//   final bool? isInfoIconVisible;
//   final String? infoIconText;
//   final String? currencyType;
//
//   CalculatorTextField({
//     Key? key,
//     this.controller,
//     this.icon,
//     this.action,
//     this.hint,
//     this.guideTitle,
//     this.errorMessage,
//     this.maxLength = 50,
//     this.maxLines = 1,
//     this.onTextChanged,
//     this.inputType,
//     this.validator,
//     this.focusNode,
//     this.onSuffixIconTap,
//     this.isEnable = true,
//     this.obscureText = false,
//     this.shouldRedirectToNextField = true,
//     this.isLabel = false,
//     this.inputFormatter,
//     this.textCapitalization = TextCapitalization.none,
//     this.isFirstItem = false,
//     this.isReadOnly = false,
//     this.isCurrency = false,
//     this.showCurrencySymbol = true,
//     this.initialValue,
//     this.letterSpacing,
//     this.inputTextStyle,
//     this.isInfoIconVisible,
//     this.infoIconText,
//     this.currencyType = "LKR"
//   }) : super(key: key);
//
//   @override
//   State<CalculatorTextField> createState() => _CalculatorTextFieldState();
// }
//
// class _CalculatorTextFieldState extends State<CalculatorTextField> {
//   double borderRadius = 5;
//   Widget? action;
//   FocusNode? _focusNode;
//   bool _hasFocus = false;
//   bool passwordHidden = true;
//    late TextEditingController textController;
//
//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       textController = widget.controller ?? TextEditingController();
//       action = widget.action;
//       _focusNode = widget.focusNode ?? FocusNode();
//     });
//     _focusNode!.addListener(_onFocusChange);
//     init();
//   }
//
//   void init() {
//     if (widget.initialValue != null) {
//       textController.text = widget.initialValue!;
//     }
//   }
//
//   void _onFocusChange() {
//     setState(() {
//       _hasFocus = _focusNode!.hasFocus;
//     });
//   }
//
//   @override
//   void dispose() {
//     _focusNode!.dispose();
//     super.dispose();
//     textController.removeListener(() {});
//     textController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if(widget.guideTitle!=null) Column(
//           children: [
//             Text(
//               widget.guideTitle!,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: colors(context).greyColor,
//               ),
//             ),
//           ],
//         ),
//         widget.isLabel &&
//             (_hasFocus ||
//                 textController.text.isNotEmpty ||
//                 widget.isCurrency)
//             ? Row(
//           crossAxisAlignment:CrossAxisAlignment.start ,
//           children: [
//             Text(
//               widget.hint!,
//               style: _hasFocus
//                   ? TextStyle(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.w400,
//                 color: colors(context).primaryColor,
//               )
//                   : TextStyle(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.w400,
//                 color: colors(context).greyColor,
//               ),
//             ),
//             const SizedBox(height: 25.0),
//             if (widget.isInfoIconVisible == true)
//
//                     CommonToolTips(
//                      text: widget.infoIconText ?? "",
//
//                     ),
//
//           ],
//         )
//             : SizedBox(height: widget.isFirstItem ? 0 : 30),
//         TextFormField(
//           onChanged: (text) {
//             if (widget.onTextChanged != null) {
//               widget.onTextChanged!(text);
//             }
//           },
//           contextMenuBuilder: (context, editableTextState) {
//             return SizedBox.shrink();
//           },
//           focusNode: _focusNode,
//           autofocus: false,
//           controller: textController,
//           obscureText: widget.obscureText! ? passwordHidden : false,
//           obscuringCharacter: '•',
//           textInputAction: widget.shouldRedirectToNextField!
//               ? TextInputAction.next
//               : TextInputAction.done,
//           enabled: widget.isEnable,
//           readOnly: widget.isReadOnly,
//           validator: widget.validator ?? null,
//           maxLines: widget.maxLines,
//           textCapitalization: widget.textCapitalization!,
//           maxLength: widget.maxLength,
//           inputFormatters: [
//             if (widget.inputFormatter != null) ...widget.inputFormatter!,
//             FilteringTextInputFormatter.deny(
//               RegExp(Validator().emojiRegexp),
//             ),
//           ],
//           style: widget.inputTextStyle ??
//               TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: widget.letterSpacing,
//               ),
//           keyboardType: widget.inputType ?? TextInputType.text,
//           cursorColor: colors(context).primaryColor,
//           decoration: InputDecoration(
//               contentPadding: const EdgeInsets.only(bottom: 6),
//               errorText: widget.errorMessage,
//               counterText: "",
//               isCollapsed: true,
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(
//                     color: colors(context).greyColor!, width: 1.0),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(
//                     color: colors(context).primaryColor!, width: 1.0),
//               ),
//               disabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(
//                     color: colors(context).greyColor!, width: 1.0),
//               ),
//               prefixIcon:  _hasFocus
//                   ? Padding(
//                 padding: const EdgeInsets.only(right: 8),
//                 child: Text(
//                   widget.showCurrencySymbol ? widget.currencyType??"LKR" : "",
//                   style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 14,
//                     color: colors(context).blackColor,
//                   ),
//                 ),
//               ) : Text(
//                 widget.showCurrencySymbol ? widget.currencyType??"LKR": "",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                   color: colors(context).blackColor,
//                 ),
//               ),
//               prefixIconConstraints: const BoxConstraints(
//                 minWidth: 55,
//               ),
//               suffixIconConstraints: action == null
//                   ? BoxConstraints.tight(const Size(40, 30))
//                   : BoxConstraints.tight(const Size(40, 30)),
//               suffixIcon: widget.obscureText!
//                   ? passwordHidden
//                   ? IconButton(
//                 icon: const Icon(Icons.remove_red_eye_outlined),
//                 color: colors(context).primaryColor,
//                 onPressed: () {
//                   setState(() {
//                     passwordHidden = !passwordHidden;
//                   });
//                 },
//               )
//                   : IconButton(
//                 icon: const Icon(Icons.remove_red_eye_rounded),
//                 color: colors(context).primaryColor,
//                 onPressed: () {
//                   setState(() {
//                     passwordHidden = !passwordHidden;
//                   });
//                 },
//               )
//                   : action,
//               filled: true,
//               hintText: _hasFocus ? null : "0.00",
//               hintStyle: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.w600,
//                   color: colors(context).greyColor,
//                   letterSpacing: 0
//               ),
//               fillColor: colors(context).whiteColor
//           ),
//         ),
//       ],
//     );
//   }
// }
