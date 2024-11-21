import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/theme/text_styles.dart';



class FTSummeryDataComponent2 extends StatelessWidget {
  final String title;
  final String data;
  final String subData;
  final String subTitle;
  final bool? isLastItem;

  FTSummeryDataComponent2({
    this.title = '',
    this.data = '',
    this.subData = '',
    this.subTitle = '',
    this.isLastItem
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16).w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8).r,
                    border: Border.all(color: colors(context).greyColor300!)
                ),
                child: PhosphorIcon(
                  PhosphorIcons.caretDoubleUp(PhosphorIconsStyle.bold),
                  color: colors(context).primaryColor,
                ),
              ),
              12.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      title,
                      style: title == 'Success' ? size14weight700.copyWith(color: colors(context).positiveColor)
                          : size14weight700.copyWith(color: colors(context).negativeColor)
                  ),
                  8.verticalSpace,
                  Text(
                    "${AppLocalizations.of(context).translate("ref_id")} : $subTitle",
                    style: size12weight400.copyWith(color: colors(context).blackColor),
                  ),
                ],
              ),
             Spacer(),
             Column(
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                 RichText(
                   text: TextSpan(children: [
                     TextSpan(
                       text: "- ${AppLocalizations.of(context).translate("lkr")} ",
                       style: title == 'Success' ? size14weight700.copyWith(color: colors(context).negativeColor) :
                       size14weight700.copyWith(color: colors(context).greyColor),
                     ),
                     TextSpan(
                       text: data,
                       style: title == 'Success' ? size14weight700.copyWith(color: colors(context).negativeColor) :
                       size14weight700.copyWith(color: colors(context).greyColor),
                     )
                   ]),
                 ),
                 8.verticalSpace,
                 Text(
                   subData,
                   style: size12weight400.copyWith(color: colors(context).blackColor),
                 )
               ],
             ),
            ],
          ),
        ),
        isLastItem == true? SizedBox.shrink():
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,).w,
          child: Divider(
            color: colors(context).greyColor100,
            height: 1,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
