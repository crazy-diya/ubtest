import 'package:flutter/material.dart';

import '../../../../../utils/app_localizations.dart';

class CurrencyInputField extends StatefulWidget {
  final TextEditingController controller;

  CurrencyInputField({required this.controller});

  @override
  State<CurrencyInputField> createState() => _CurrencyInputFieldState();
}

class _CurrencyInputFieldState extends State<CurrencyInputField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.attach_money),
        const SizedBox(width: 8.0),
        Expanded(
          child: TextFormField(
            contextMenuBuilder: (context, editableTextState) {
              return SizedBox.shrink();
            },
            controller: widget.controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate("amount"),
              hintText: AppLocalizations.of(context).translate("enter_amount"),
              prefixText: "${AppLocalizations.of(context).translate("lkr")} ",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
