

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import '../../../../../core/theme/text_styles.dart';



class UBPortfolioBottomContainer extends StatelessWidget {
final String title;
final bool? isLastItem;
final PhosphorIcon icon;


UBPortfolioBottomContainer({required this.title,required this.icon , this.isLastItem = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0.w,16.h,0.w,16.h),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),),
            child: Row(
              children: [
                Container(
                  height: 48.w,
                  width: 48.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: colors(context).whiteColor,
                        border: Border.all(
                            color: colors(context).greyColor300!,
                          width: 1
                        ),
                    ),
                    child: icon),
                16.horizontalSpace,
                Text(
                 title,
                  style: size16weight700.copyWith(color: colors(context).blackColor)
                ),
                Spacer(),
                PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                    color: colors(context).greyColor300),
              ],
            ),
          ),
        ),
        if(isLastItem == false)
          Divider(
          height: 0,
          thickness: 1,
          color: colors(context).greyColor100,
        ),
      ],
    );
  }
}
