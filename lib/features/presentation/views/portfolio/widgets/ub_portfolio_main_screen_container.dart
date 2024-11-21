import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/theme/text_styles.dart';


class UBPortfolioContainer extends StatelessWidget {
  bool? isTabAccount;
  bool? isTabCards;
  bool? isTabInvestments;
  bool? isLoans;
  bool? isLease;
  int? length;
  final String title;
  final String tab;
  final String amount;
  final PhosphorIcon icon;

  UBPortfolioContainer({
    this.isTabAccount,
    this.isTabCards,
    this.isTabInvestments,
    this.isLoans,
    this.isLease,
    this.length,
    required this.icon,
    this.title = '',
    this.tab = '',
    this.amount = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        color: colors(context).whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${length.toString()} " + title,
              style: size16weight700.copyWith(color: colors(context).blackColor),
            ),
            12.verticalSpace,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8).r,
                color: colors(context).greyColor50,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16).w,
                child: Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                            border: Border.all(color: colors(context).greyColor300!)
                        ),
                        child: icon),
                    12.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AppLocalizations.of(context).translate("lkr")} ",
                                style: size16weight700.copyWith(color: colors(context).blackColor),
                              ),
                              Text(
                                amount,
                                style: size16weight700.copyWith(color: colors(context).blackColor),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          (title == AppLocalizations.of(context).translate("accounts") || title == AppLocalizations.of(context).translate("account"))
                              ? AppLocalizations.of(context).translate("total_balance")
                              : (title == AppLocalizations.of(context).translate("cards") || title == AppLocalizations.of(context).translate("card"))
                                  ? AppLocalizations.of(context).translate("total_balance")
                                  : title == AppLocalizations.of(context).translate("investments")
                                      ? AppLocalizations.of(context).translate("total_deposit_balance")
                                      : title == AppLocalizations.of(context).translate("loans")
                                          ? AppLocalizations.of(context).translate("total_outstanding_balance")
                                          : AppLocalizations.of(context).translate("total_lease_balance"),
                          style: size12weight400.copyWith(color: colors(context).greyColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
