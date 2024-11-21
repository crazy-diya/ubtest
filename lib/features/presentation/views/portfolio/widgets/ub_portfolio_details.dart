import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';


class UBPortfolioDetails extends StatelessWidget {
  final formatCurrency = NumberFormat.currency(symbol: '');
  final String title;
  final String data;
  final String subTitle;
  final String availableBalance;
  final String amount;
  final bool isCurrency;

  UBPortfolioDetails({
    this.isCurrency = false,
    this.title = '',
    this.availableBalance = '',
    this.subTitle = '',
    this.amount='',
    this.data = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 35),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colors(context).greyColor,
                ),
              ),
              // isCurrency ?
              // Text("LKR ${amount!}"):Text(subTitle)
              isCurrency?
              RichText(

                text: TextSpan(children: [

                  TextSpan(
                    text: "${AppLocalizations.of(context).translate("lkr")} ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color:
                      colors(context).blackColor,
                    ),
                  ),
                  TextSpan(
                    text: amount,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color:
                      colors(context).blackColor,
                    ),
                  )
                ]),
              ):Expanded(
                child: Align(
                  alignment: Alignment.centerRight, // Aligns the Text to the right horizontally
                  child: Text(
                    subTitle,
                    textAlign: TextAlign.right, // Aligns the text content within the Text widget to the right
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: colors(context).blackColor,
                    ),
                  ),
                ),
              )

            ],
          ),
        )
      ],
    );
  }
}
