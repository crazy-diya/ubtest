
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../../utils/app_localizations.dart';





class CSISummeryDataComponent extends StatelessWidget {
  final formatCurrency = NumberFormat.currency(symbol: '');

  final String title;
  final String data;
  final String subData;
  final bool isCurrency;
  final bool isTitle;
  final bool isFromCSI;
  final double? amount;

  CSISummeryDataComponent(
      {this.title = '',
        this.data = '',
        this.subData = '',
        this.isCurrency = false,
        this.isTitle = false,
        this.isFromCSI = false,
        this.amount});

  @override
  Widget build(BuildContext context) {
    return ((!isCurrency) || (isCurrency && amount != null))?
    Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: title,
                    style: isTitle ? size16weight700.copyWith(color: colors(context).blackColor) :
                    size16weight400.copyWith(color: colors(context).blackColor)
                  ),
                ]),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [if (isCurrency)
                        TextSpan(
                          text: "${AppLocalizations.of(context).translate("lkr")} ",
                          style: size16weight700.copyWith(color: colors(context).blackColor),
                        ),
                        WidgetSpan(
                          child: Text(
                            isCurrency
                                ? amount.toString().withThousandSeparator()
                                : data,
                            textAlign: TextAlign.end,
                            style: size16weight700.copyWith(color: colors(context).blackColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(height: 10,),
                  if (subData.isNotEmpty)
                    Text(
                      subData,
                      style: size16weight700.copyWith(color: colors(context).blackColor),
                    )
                  else
                    const SizedBox.shrink()
                ],
              ),
            ),
            isTitle && isFromCSI?
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Center(child: Icon(Icons.arrow_forward_ios_outlined, size: 20, color: colors(context).blackColor,)),
            )
                : const SizedBox.shrink()
          ],
        ),
      ],
    )
        : const SizedBox.shrink();
  }
}
