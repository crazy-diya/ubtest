import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/features/presentation/views/Manage_Payment_Intruments/data/manage_pay_design.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_assets.dart';
import '../../../../../utils/app_localizations.dart';

class PortfolioCard extends StatelessWidget {
  String? accountNumber;
  String? productName;
  String? availableBalance;
  String? actualBalance;
  String? nickName;
  String? cardType;
  String? maskedCardNumber;
  String? maturityDate;
  String? tenure;
  String currency;
  ManagePayDesign design;
  final VoidCallback? onTap;


  PortfolioCard(
      {
        this.accountNumber,
        this.productName,
        this.availableBalance,
        this.nickName,
        this.actualBalance,
        this.cardType,
        this.maturityDate,
        this.maskedCardNumber,
        this.tenure,
        required this.currency,
        required this.design,
        this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8).r,
              color: design.backgroundColor,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w,24.h,16.w,24.h),
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
                                style: size14weight700.copyWith(color: design.fontColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                              if(cardType == "Cards")
                                Column(
                                children: [
                                  Text(
                                    maskedCardNumber ?? "-",
                                    style: size14weight400.copyWith(color: design.fontColor),
                                  ),
                                  // 0.96.verticalSpace,
                                ],
                              ),
                              if(cardType == "Accounts" || cardType == "Investments" || cardType == "Loans")
                                Column(
                                  children: [
                                    Text(
                                      accountNumber ?? "-",
                                      style: size14weight400.copyWith(color: design.fontColor),),
                                    // 0.96.verticalSpace,
                                  ],
                                ),
                              if(cardType == "Investments")
                                Column(
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context).translate("maturity_date")}: " + "${maturityDate ?? ""}",
                                      style: size14weight400.copyWith(color: design.fontColor),),
                                    // 0.96.verticalSpace,
                                  ],
                                ),
                              if(cardType == "Investments")
                                Column(
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context).translate("tenure_m")}: " + "${tenure ?? ""}",
                                      style: size14weight400.copyWith(color: design.fontColor),),
                                    // 0.96.verticalSpace,
                                  ],
                                ),
                              if(cardType == "Accounts")
                                Column(
                                  children: [
                                    Text(
                                    productName ?? "-",
                                    style: size14weight400.copyWith(color: design.fontColor),),
                                    // 0.96.verticalSpace,
                                  ],
                                ),
                              if(cardType == "Cards" && accountNumber != "")
                                Column(
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context).translate("acc_no")} " + "${accountNumber ?? ""}",
                                      style: size14weight400.copyWith(color: design.fontColor),
                                    ),
                                    // 0.96.verticalSpace,
                                  ],
                                ),
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
                              // "${AppLocalizations.of(context).translate("lkr")} ${availableBalance?.withThousandSeparator()}",
                              "${currency} ${availableBalance?.withThousandSeparator()}",
                              style: size14weight700.copyWith(color: design.fontColor),),
                            // 0.96.verticalSpace,
                            Text(
                                cardType == "Accounts" ?
                              AppLocalizations.of(context).translate("available_balance") :
                                cardType == "Cards" ?
                              AppLocalizations.of(context).translate("card_limit") :
                                cardType == "Investments" ?
                                AppLocalizations.of(context).translate("deposit_amount") : AppLocalizations.of(context).translate("outstanding_balance"),
                              style: size12weight400.copyWith(color: design.fontColor),),
                          ],
                        ),
                        Container(
                          width: 0.3.w,
                          height: 44.h,
                          color: design.dividerColor,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              cardType == "Investments" ?
                              "${actualBalance?.withThousandSeparator()}%":
                              cardType == "Loans" ? "${actualBalance} ${AppLocalizations.of(context).translate("months")}" :
                              // "${AppLocalizations.of(context).translate("lkr")} ${actualBalance?.withThousandSeparator()}",
                              "${currency} ${actualBalance?.withThousandSeparator()}",
                              style: size14weight700.copyWith(color: design.fontColor),),
                            // 0.96.verticalSpace,
                            Text(
                              cardType == "Accounts" ?
                              AppLocalizations.of(context).translate("actual_balance") :
                              cardType == "Cards" ?
                              AppLocalizations.of(context).translate("available_balance") :
                              cardType == "Investments" ?
                              AppLocalizations.of(context).translate("interest_rate_apr") : AppLocalizations.of(context).translate("period"),
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
      ],
    );
  }
}
