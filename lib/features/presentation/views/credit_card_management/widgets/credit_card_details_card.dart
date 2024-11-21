import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_assets.dart';
import '../../../../../utils/app_localizations.dart';
import '../../Manage_Payment_Intruments/data/manage_pay_design.dart';

class CreditCardDetailsCard extends StatelessWidget {
  late final String? cardType;
  late final String? maskedCardNumber;
  final String? accountNumber;
  final String? availableBalance;
  final ManagePayDesign design;
  final String? crdPaymentAvailableBalance;
  final String? creditCardName;
  final String? resCardStatusWithDesc;
  final String? displayFlag;

  CreditCardDetailsCard(
      {this.cardType,
      this.maskedCardNumber,
      this.accountNumber,
      this.availableBalance,
      this.crdPaymentAvailableBalance,
      this.creditCardName,
      this.resCardStatusWithDesc,
      this.displayFlag,
      required this.design});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4).w,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8).r,
                color: colors(context).primaryColor400!),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cardType ?? "-",
                              style: size14weight700.copyWith(
                                  color: design.fontColor),
                            ),
                            Text(
                              maskedCardNumber ?? "-",
                              style: size14weight400.copyWith(
                                  color: design.fontColor),
                            ),
                            Text(
                              "${AppLocalizations.of(context).translate("account_no")}. ${accountNumber ?? "-"}",
                              style: size14weight400.copyWith(
                                  color: design.fontColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      8.horizontalSpace,
                      Container(
                        height: 48,
                        width: 48,
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
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  Text(
                    "LKR ${availableBalance?.withThousandSeparator()}",
                    style: size14weight700.copyWith(color: design.fontColor),
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .translate("outstanding_balance"),
                    style: size12weight400.copyWith(color: design.fontColor),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
