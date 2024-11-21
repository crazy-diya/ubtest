
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';





class ReqMSummeryHistoryComponent extends StatelessWidget {
  final formatCurrency = NumberFormat.currency(symbol: '');

  final String title;
  final String data;
  final String subData;
  final bool isCurrency;
  final double? amount;

  ReqMSummeryHistoryComponent(
      {this.title = '',
        this.data = '',
        this.subData = '',
        this.isCurrency = false,
        this.amount});

  @override
  Widget build(BuildContext context) {
    return ((!isCurrency) || (isCurrency && amount != null))?
    Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colors(context).greyColor300,
                    ),),
                  // if (isCurrency)
                  //   TextSpan(
                  //     text: ' (LKR)',
                  //     style: TextStyle(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w400,
                  //       color: colors(context).blackColor,
                  //     ),
                  //   ),
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
                          text: '${AppLocalizations.of(context).translate("lkr")} ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: colors(context).blackColor,
                          ),
                        ),
                        WidgetSpan(
                          child: Text(
                            isCurrency
                                ? amount.toString().withThousandSeparator()
                            // '${formatCurrency.format(amount).split('.')[0]}.'
                                : data,

                            textAlign: TextAlign.end,

                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: colors(context).blackColor,
                            ),
                          ),
                        ),
                        // if (isCurrency)
                        //   TextSpan(
                        //     text: formatCurrency
                        //         .format(amount)
                        //         .split('.')[1],
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.w600,
                        //       color: colors(context).blackColor,
                        //     ),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  if (subData.isNotEmpty)
                    Text(
                      subData,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: colors(context).blackColor,
                      ),
                    )
                  else
                    const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h,)
      ],
    )
        : const SizedBox.shrink();
  }
}
