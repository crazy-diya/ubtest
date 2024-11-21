import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';



class ContatctDetailsRow extends StatefulWidget {
  final String text;
  final String contact;
  final VoidCallback? onTap;

  const ContatctDetailsRow({required this.text, required this.contact, this.onTap});

  @override
  State<ContatctDetailsRow> createState() => _ContatctDetailsRowState();
}

class _ContatctDetailsRowState extends State<ContatctDetailsRow> {
  

  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
           AppLocalizations.of(context).translate(widget.text) ,
          style: size14weight400.copyWith (
            color: colors(context).blackColor,
          ),
        ),
         InkWell(
          onTap: widget.onTap,
          child: Text(
            widget.contact,
            style: size14weight700.copyWith(
              decoration:  TextDecoration.underline,
              decorationThickness: 4,
              color: colors(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
