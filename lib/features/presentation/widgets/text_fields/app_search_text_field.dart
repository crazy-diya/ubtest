import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';


import '../../../../utils/validator.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField(
      {this.hintText, this.onChange, this.textEditingController, this.isBorder = true, this.focusNode});

  final String? hintText;
  final void Function(String)? onChange;
  final TextEditingController? textEditingController;
  final bool? isBorder;
final FocusNode? focusNode;
  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  FocusNode? _focusNode;
  bool _hasFocus = false;

   void _onFocusChange() {
    if(mounted)
    setState(() {
      _hasFocus = _focusNode!.hasFocus;
    });
  }

  @override
  void initState() {
    super.initState();
     setState(() {
      _focusNode = widget.focusNode ?? FocusNode();
    });
    _focusNode!.addListener(_onFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: size16weight400.copyWith(color: colors(context).blackColor),
      contextMenuBuilder: (context, editableTextState) {
        return SizedBox.shrink();
      },
      cursorColor: colors(context).primaryColor,
      controller: widget.textEditingController,
      onChanged: widget.onChange!,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(Validator().emojiRegexp),
        ),
      ],
      textAlign: TextAlign.left,
      focusNode: _focusNode,
      decoration: InputDecoration(
        prefixIcon: PhosphorIcon(
              PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.regular),
              color: colors(context).greyColor
            ),
       contentPadding: const EdgeInsets.only(bottom: 2 , top:2),
        border: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.none
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        enabledBorder: widget.isBorder==false? OutlineInputBorder(
          borderSide: BorderSide(
        style: BorderStyle.none
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        )
            : OutlineInputBorder(
          borderSide: BorderSide(
         color: colors(context).greyColor300!, width: 1
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors(context).primaryColor!, width: 1,
          
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        disabledBorder: OutlineInputBorder(
           borderSide: BorderSide(
            color: colors(context).greyColor50!,width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),)
              ,
        filled: true,
        hintStyle:  size16weight400.copyWith(color: colors(context).greyColor),
        hintText: widget.hintText,
        fillColor: colors(context).whiteColor,
      ),
    );
  }
}
