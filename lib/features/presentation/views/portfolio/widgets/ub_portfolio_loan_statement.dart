import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';



class UBPortfolioLoanStatement extends StatelessWidget {
  final String title;
  final String data;
  final String subData;
  final String subTitle;

  UBPortfolioLoanStatement({
    this.title = '',
    this.data = '',
    this.subData = '',
    this.subTitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( bottom: 0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colors(context).blackColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate("lkr"),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: colors(context).blackColor,
                    ),
                  ),
                  const SizedBox(width: 15,),
                  RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text:data + '.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w600,
                            color: colors(context)
                                .blackColor,
                          ),
                        ),
                        TextSpan(
                          text: '00',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w400,
                            color: colors(context)
                                .blackColor,
                          ),
                        )
                      ])),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${AppLocalizations.of(context).translate("from")} : ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: colors(context).greyColor,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: colors(context).greyColor,
                    ),
                  ),
                ],
              ),
              Text(
                subData,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: colors(context).greyColor
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: colors(context).greyColor400,
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
