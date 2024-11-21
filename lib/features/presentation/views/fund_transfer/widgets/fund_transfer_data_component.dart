
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/theme/text_styles.dart';





class FTSummeryDataComponent extends StatelessWidget {
  final formatCurrency = NumberFormat.currency(symbol: '');

  final String title;
  final String data;
  final String subData;
  final String currencyType;
  final bool isCurrency;
  final bool? isLastItem;
  final double? amount;

  FTSummeryDataComponent(
      {this.title = '',
        this.data = '',
        this.subData = '',
        this.currencyType = '',
        this.isCurrency = false,
        this.isLastItem = false,
        this.amount});

  @override
  Widget build(BuildContext context) {
    return ((!isCurrency) || (isCurrency && amount != null))?
         Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0.w,16.h,0.w,16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                        title,
                        style: size14weight700.copyWith(color: colors(context).blackColor,
                        )),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                          Text(
                              isCurrency == false
                                  ?
                              data :
                                  amount == 0.00 || amount == null || amount == 0.0? "-" :
                              "${currencyType == "" ? AppLocalizations.of(context).translate("lkr") : currencyType} " + '${amount.toString().withThousandSeparator()}',
                            style: size14weight400.copyWith(color: colors(context).greyColor,),
                          textAlign: TextAlign.end,
                          ),
                        // RichText(
                        //   text: TextSpan(
                        //     children: [if (isCurrency)
                        //       TextSpan(
                        //         text: 'LKR ',
                        //         style: size14weight400.copyWith(color: colors(context).greyColor),
                        //       ),
                        //       WidgetSpan(
                        //         child: Text(
                        //           isCurrency
                        //               ? amount.toString().withThousandSeparator()
                        //           // '${formatCurrency.format(amount).split('.')[0]}.'
                        //               : data,
                        //           textAlign: TextAlign.end,
                        //           style: size14weight400.copyWith(color: colors(context).greyColor),
                        //         ),
                        //       ),
                        //       // if (isCurrency)
                        //       //   TextSpan(
                        //       //       text: formatCurrency
                        //       //           .format(amount)
                        //       //           .split('.')[1],
                        //       //     style: TextStyle(
                        //       //       fontSize: 18,
                        //       //       fontWeight: FontWeight.w600,
                        //       //       color: colors(context).blackColor,
                        //       //     ),),
                        //     ],
                        //   ),
                        // ),
                        if (subData.isNotEmpty)
                          Column(
                            children: [
                              Text(
                                subData,
                                style: size14weight400.copyWith(color: colors(context).greyColor),
                              ),
                            ],
                          )
                        else const SizedBox.shrink()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isLastItem == true? SizedBox.shrink():
            Divider(
              thickness: 1,
              height: 0,
              color: colors(context).greyColor100,
            ),
          ],
                 )
        : const SizedBox.shrink();
  }
}
