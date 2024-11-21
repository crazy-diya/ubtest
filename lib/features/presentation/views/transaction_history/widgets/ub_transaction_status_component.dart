
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';





class UBTransactionStatusComponent extends StatelessWidget {
  final formatCurrency = NumberFormat.currency(symbol: '');

  final String title;
  final String data;
  final String currency;
  final String subData;
  final bool isCurrency;
  final String? amount;
  final bool? isLastItem;
  final bool? isFirstItem;

  UBTransactionStatusComponent(
      {this.title = '',
      this.data = '',
      this.subData = '',
        this.currency = '' ,
      this.isLastItem =false,
      this.isFirstItem =false,
      this.isCurrency = false,
      this.amount});

  @override
  Widget build(BuildContext context) {
    return ((!isCurrency) || (isCurrency && amount != null))?
    Column(
      children: [
        if(isFirstItem==false) 16.verticalSpace,
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.end,
                  style: size14weight700.copyWith(
                      color: colors(context).blackColor),
                ),
                 16.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              isCurrency ?"${currency == "" ? AppLocalizations.of(context).translate("lkr") : currency} ${amount.toString()}" : data,
                              textAlign: TextAlign.end,
                              style: size14weight400.copyWith(
                                  color: colors(context).greyColor),
                            ),
                          ),
                        ],
                      ),
                      4.verticalSpace,
                      if (subData.isNotEmpty)
                        Text(
                          subData,
                          style: size14weight400.copyWith(color: colors(context).greyColor),
                        )
                      else
                        const SizedBox.shrink()
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        if(isLastItem==false) 16.verticalSpace,
        isLastItem == true? SizedBox.shrink(): Divider(
              height: 0,
              color: colors(context).greyColor100,
              thickness: 1.w,
            )
      ],
    )
        : const SizedBox.shrink();
  }
}
