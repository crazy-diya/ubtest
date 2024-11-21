import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

class QRPaymentSummeryDataComponent extends StatelessWidget {
  final formatCurrency = NumberFormat.currency(symbol: '');

  final String title;
  final String data;
  final String subData;
  final bool isCurrency;
  final String? amount;
  final bool? isLastItem;

  QRPaymentSummeryDataComponent(
      {this.title = '',
      this.data = '',
      this.subData = '',
      this.isCurrency = false,
      this.amount,
      this.isLastItem = false});

  @override
  Widget build(BuildContext context) {
    return ((!isCurrency) || (isCurrency && amount != null))
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16).w,
                child: Column(
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
                        4.horizontalSpace,
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
                                      isCurrency
                                          ? "${AppLocalizations.of(context).translate("lkr")} ${amount.toString()}"
                                          : data,
                                      textAlign: TextAlign.end,
                                      style: size14weight400.copyWith(
                                          color: colors(context).greyColor),
                                    ),
                                  ),
                                ],
                              ),
                              .48.verticalSpace,
                              if (subData.isNotEmpty)
                                Text(
                                  subData,
                                  style: size14weight400.copyWith(
                                      color: colors(context).greyColor),
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
              ),
              if (isLastItem == false) 16.verticalSpace,
              isLastItem == true
                  ? SizedBox.shrink()
                  : Divider(
                      height: 0,
                      color: colors(context).greyColor100,
                      thickness: 1,
                    )
            ],
          )
        : const SizedBox.shrink();
  }
}
