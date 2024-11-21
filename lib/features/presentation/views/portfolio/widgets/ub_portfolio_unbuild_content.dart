import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/theme/text_styles.dart';


class UBPortfolioUnbuildContent extends StatelessWidget {
  final String? title;
  final String? data;
  final DateTime? subData;
  final String? subTitle;
  final String? currency;
  final String? time;
  final bool? isFromAcctSt;
   String? isCR;

  UBPortfolioUnbuildContent({
    this.title,
    this.data,
    this.subData,
    this.subTitle,
    this.currency,
    this.time,
    this.isFromAcctSt = false,
    this.isCR,
  });

  @override
  Widget build(BuildContext context) {
    String formattedSubData = '';

    if (subData != null) {
      if(isFromAcctSt == true){
        formattedSubData =DateFormat('dd-MMM-yyyy').format(subData!);
      } else {
        formattedSubData =DateFormat('dd-MMM-yyyy  HH:mm').format(subData!);
      }
    }

    String convertTo12HourFormat(String input) {
      if (input.length != 6) {
        return 'Invalid input'; // Check for valid 6-character time
      }

      int hours = int.parse(input.substring(0, 2));
      String minutes = input.substring(2, 4);

      // Determine AM or PM
      // String period = hours >= 12 ? 'PM' : 'AM';
      // hours = hours % 12;
      // if (hours == 0) hours = 12;
      return '${hours.toString().padLeft(2, '0')}:$minutes';
    }


    return Padding(
      padding: EdgeInsets.fromLTRB(0.w,16.h,0.w,16.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title ?? "-",
                  style: size14weight700.copyWith(color: colors(context).blackColor),
                ),
              ),
              Row(
                children: [
                  Icon(
                    isCR?.startsWith("C")??false ? Icons.add : Icons.remove,
                    size: 10,
                    color: isCR?.startsWith("C")??false
                        ? colors(context).positiveColor
                        : colors(context).negativeColor,
                  ),
                  Text(
                    "${currency == null || currency == "" ? AppLocalizations.of(context).translate("lkr") : currency} ${data}",
                    style:  isCR?.startsWith("C")??false
                        ? size14weight700.copyWith(color: colors(context).positiveColor):
                         size14weight700.copyWith(color: colors(context).negativeColor)
                  ),
                  // RichText(
                  //     text: TextSpan(children: [
                  //       TextSpan(
                  //         text: data ?? "-",
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //       fontWeight: FontWeight.w600,
                  //       color: isCR?.startsWith("C")??false
                  //           ? colors(context).positiveColor
                  //           : colors(context).negativeColor,
                  //     ),
                  //       ),
                  //     ])),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${AppLocalizations.of(context).translate("ref_id")}: ${subTitle ?? "-"}",
                  style: size12weight400.copyWith(color: colors(context).blackColor),
                ),
              ),
              Text(
                "$formattedSubData${isFromAcctSt == true ? "  ${convertTo12HourFormat(time ?? DateFormat('HHmmss').format(DateTime.now()))}":""}",
                style: size12weight400.copyWith(color: colors(context).blackColor),
              )
            ],
          ),
          // Divider(
          //   color: colors(context).greyColor400,
          //   thickness: 0.5,
          // )
        ],
      ),
    );
  }
}
