import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/features/presentation/views/Manage_Payment_Intruments/data/manage_pay_design.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_assets.dart';
import '../../../../../utils/app_localizations.dart';

class UbCard extends StatelessWidget {
  String? accountNumber;
  String? productName;
  String? availableBalance;
  String? actualBalance;
  String? nickName;
  String? currency;
  ManagePayDesign design;
  final VoidCallback? onTap;


  UbCard(
      {
      this.accountNumber,
      this.productName,
      this.availableBalance,
      this.nickName,
      this.actualBalance,
      required this.design,
      this.currency,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.verticalSpace,
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8).w,
              color: design.backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16,24,16, 24).w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nickName ?? "-",
                              overflow: TextOverflow.ellipsis,
                              style: size14weight700.copyWith(color: design.fontColor),
                            ),
                            2.verticalSpace,
                            Text(
                              accountNumber ?? "-",
                              style: size14weight400.copyWith(color: design.fontColor),),
                            2.verticalSpace,
                            Text(
                              productName?.toUpperCase() ?? "-",
                              style: size14weight400.copyWith(color: design.fontColor),),
                          ],
                        ),
                      ),
                      8.horizontalSpace,
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8).r,
                          child: Image.asset(
                            AppAssets.ubBank,
                            width: 32,
                            height: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$currency ${availableBalance?.withThousandSeparator()}",
                            style: size14weight700.copyWith(color: design.fontColor),),
                          0.96.verticalSpace,
                          Text(
                            AppLocalizations.of(context).translate("available_balance"),
                            style: size12weight400.copyWith(color: design.fontColor),),
                        ],
                      ),
                      Container(
                        width: 1.w,
                        height: 44.w,
                        color: design.dividerColor,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "$currency ${actualBalance?.withThousandSeparator()}",
                            style: size14weight700.copyWith(color: design.fontColor),),
                          0.96.verticalSpace,
                          Text(
                            AppLocalizations.of(context).translate("actual_balance"),
                            style: size12weight400.copyWith(color: design.fontColor),),
                        ],
                      ),
                    ],
                  )
                ]
              ),
            ),
          ),
        ),
        16.verticalSpace,
      ],
    );
  }
}
