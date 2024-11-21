
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../../utils/enums.dart';

class HomeCard extends StatefulWidget {
  final String currency;
  final String amount;
  final double topMargin;
  final Color? hintColor;
  final VoidCallback? onTap;
  final AccountType accountType;
  final int amountOfAccounts;
  final bool lastTile;
  final bool firstTile;

  const HomeCard({
    super.key,
    required this.currency,
    required this.amount,
    required this.topMargin,
    required this.hintColor,
    this.onTap,
    required this.accountType,
    required this.amountOfAccounts, 
    required this.lastTile, 
    required this.firstTile,
  });

  @override
  State<HomeCard> createState() => _HomeCardState();
}



class _HomeCardState extends State<HomeCard> {

  double margin = 0;

  @override
  void initState() {
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        margin = widget.topMargin;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.only(top: margin).w,
        child: SizedBox(
          child: Column(
            children: [
              Padding(
               padding:  EdgeInsets.only(top:16.w,bottom:  16.w ,left:16.w ,right: 16.w),
                             child: Center(
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                        decoration: BoxDecoration(
                            color: getAccountColor(widget.accountType),
                            borderRadius: BorderRadius.circular(5.33).r),
                        child: getAccountIcon(widget.accountType)  
                      ),
                      12.horizontalSpace,
                      Text(getAccountName(widget.accountType,widget.amountOfAccounts),
                         style:size14weight700.copyWith(color: colors(context).blackColor),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Spacer(),
                                Text(
                                  "${widget.currency} ${widget.amount}",
                                  style:size14weight700.copyWith(color: colors(context).blackColor) ,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                             ),
              ),
          widget.lastTile == true? SizedBox.shrink(): Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).w,
            child: Divider(
            height: 0,
            color: colors(context).greyColor100,
            thickness: 1,
                        ),
          ),
            ],
          ),
        ),
      ),
    );
  }

String  getAccountName(AccountType accountType,int accounts) {
    switch (accountType) {
      case AccountType.ACCOUNTS:
        return accounts == 1
            ? "$accounts ${AppLocalizations.of(context).translate("account")}"
            : "$accounts ${AppLocalizations.of(context).translate("accounts")}";
      case AccountType.LOAN:
        return accounts == 1
            ? "$accounts ${AppLocalizations.of(context).translate("loan")}"
            : "$accounts ${AppLocalizations.of(context).translate("loans")}";
      case AccountType.FIXED_DEPO:
        return accounts == 1
            ? "$accounts ${AppLocalizations.of(context).translate("investment")}"
            : "$accounts ${AppLocalizations.of(context).translate("investments")}";
      case AccountType.LEASE:
        return "$accounts ${AppLocalizations.of(context).translate("lease")}";
      case AccountType.CARDS:
        return accounts == 1
            ? "$accounts ${AppLocalizations.of(context).translate("card")}"
            : "$accounts ${AppLocalizations.of(context).translate("cards")}";
      default:
      return "";
    }
  }

  Widget getAccountIcon(AccountType accountType) {
    switch (accountType) {
      case AccountType.ACCOUNTS:
        return PhosphorIcon(PhosphorIcons.wallet(PhosphorIconsStyle.bold),color: colors(context).whiteColor,size: 16.w,
        );
      case AccountType.LOAN:
         return PhosphorIcon(PhosphorIcons.money(PhosphorIconsStyle.bold),color: colors(context).whiteColor,size: 16.w,
        );
      case AccountType.FIXED_DEPO:
         return PhosphorIcon(PhosphorIcons.chartLineUp(PhosphorIconsStyle.bold),color: colors(context).blackColor,size: 16.w,
        );
      case AccountType.LEASE:
         return PhosphorIcon(PhosphorIcons.carProfile(PhosphorIconsStyle.bold),color: colors(context).whiteColor,size: 16.w,
        );
      case AccountType.CARDS:
          return PhosphorIcon(PhosphorIcons.creditCard(PhosphorIconsStyle.bold),color: colors(context).whiteColor,size: 16.w,
        );
      default:
      return SizedBox.shrink();
    }
  }

  Color getAccountColor(AccountType accountType) {
    switch (accountType) {
      case AccountType.ACCOUNTS:
        return colors(context).primaryColor!;
      case AccountType.LOAN:
       return colors(context).greyColor!;
      case AccountType.FIXED_DEPO:
        return colors(context).primaryColor200!;
      case AccountType.LEASE:
        return colors(context).blackColor!;
      case AccountType.CARDS:
         return colors(context).primaryColor400!;
      default:
        return colors(context).whiteColor!;
    }
  }
}


