
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../request_call_back/data/request_status.dart';





class RequestMoneyHistoryComponent extends StatelessWidget {
  final String? paytoNumber;
  final String amount;
  final String? date;
  final String? status;


  RequestMoneyHistoryComponent(
      {this.paytoNumber, required this.amount, this.date, this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8).r,
              color: colors(context).whiteColor,
                border: Border.all(
                  color: colors(context).greyColor300 ?? Colors.black // Border width
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0).w,
              child: PhosphorIcon(PhosphorIcons.deviceMobile(PhosphorIconsStyle.bold),
              color: colors(context).primaryColor,
              ),
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paytoNumber ?? "",
                  style: size16weight700.copyWith(color: colors(context).blackColor),
                  overflow: TextOverflow.ellipsis,
                ),
                8.verticalSpace,
                Text(
                  date ?? "",
                  style: size12weight400.copyWith(color: colors(context).blackColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "+ ${AppLocalizations.of(context).translate("lkr")} " + amount,
                  overflow: TextOverflow.ellipsis,
                  style: size16weight700.copyWith(color: colors(context).blackColor),
                ),
                4.verticalSpace,
                Container(
                  width: 72,
                  height: 24,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      border: Border.all(color:colors(context).greyColor200!),
                      color: getStatus(status!.toUpperCase(),context).color!
                  ),
                  child: Center(
                    child: Text(
                        getStatus(status!.toUpperCase(),context).status!,
                      overflow: TextOverflow.ellipsis,
                      style: size12weight700.copyWith(color: colors(context).whiteColor),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


