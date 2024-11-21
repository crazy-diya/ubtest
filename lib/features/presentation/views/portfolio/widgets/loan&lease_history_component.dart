import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/theme/text_styles.dart';


class UBPortfolioUnbuildLoanLeaseContent extends StatelessWidget {
  final String title;
  final String data;
  final DateTime? subData;
  final String subTitle;
  final String currency;
  bool isLoan;


  UBPortfolioUnbuildLoanLeaseContent({
    this.title = '',
    this.data = '',
    this.subData,
    required this.isLoan,
    required this.currency,
    this.subTitle = '',

  });

  @override
  Widget build(BuildContext context) {
    String formattedSubData = '';
    if (subData != null) {
      formattedSubData = DateFormat('dd-MMM-yyyy  hh:mm').format(subData!);
    }
    return Column(
      children: [
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: size14weight700.copyWith(color: colors(context).blackColor)
              ),
            ),
            16.horizontalSpace,
            Row(
              children: [
                data.startsWith("-") ?
                Text(
                  "- ${currency ?? AppLocalizations.of(context).translate("lkr")} ${removeLeadingDash(data)}",
                  style: size14weight700.copyWith(color: colors(context).negativeColor)
                ) :
                Text(
                  "+ ${currency ?? AppLocalizations.of(context).translate("lkr")} ${removeLeadingDash(data)}",
                  style: size14weight700.copyWith(color: colors(context).positiveColor)
                ),
                // RichText(
                //     text: TextSpan(children: [
                //       TextSpan(
                //         text: data ,
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w600,
                //           color:colors(context).blackColor
                //         ),
                //       ),
                //
                //     ])),
              ],
            ),
          ],
        ),
        4.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "${AppLocalizations.of(context).translate("ref_id")}: $subTitle",
                overflow: TextOverflow.ellipsis,
                style: size12weight400.copyWith(color: colors(context).blackColor)
              ),
            ),
            Text(
              formattedSubData,
              style: size12weight400.copyWith(color: colors(context).blackColor)
            )
          ],
        ),
        12.verticalSpace,
        // Divider(
        //   color: colors(context).greyColor100,
        //   thickness: 1,
        //   height: 0,
        // )
      ],
    );
  }

  String removeLeadingDash(String text) {
    if (text.startsWith('-')) {
      return text.substring(1);
    }
    return text;
  }
}
