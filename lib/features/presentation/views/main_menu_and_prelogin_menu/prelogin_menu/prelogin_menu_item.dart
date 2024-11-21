import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import '../../../../../utils/app_localizations.dart';

import 'pre_login_carousel.dart';

class PreLoginCarouselItem extends StatelessWidget {
  final PreLogin menuItem;
  final int index;

  const PreLoginCarouselItem({required this.menuItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: <Widget>[
        Container(
         width: 70.w,
        height: 70.w,
          decoration: BoxDecoration(
            color: colors(context).primaryColor,
            borderRadius:  BorderRadius.all(
              Radius.circular(9.5).r,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(19).w,
            child:menuItem.isSvg==true
                    ? SvgPicture.asset(
                        menuItem.svg!,
                        width: 32,
                        height: 32,
                        fit: BoxFit.scaleDown,
                        colorFilter:
                            ColorFilter.mode(colors(context).whiteColor!, BlendMode.srcIn),
                      )
                    :  PhosphorIcon(menuItem.icon! ,size:32, color: colors(context).whiteColor,),
          ),
        ),
       8.verticalSpace,
        Text(
          AppLocalizations.of(context).translate(menuItem.title!),
           style:size14weight700.copyWith(
                color: colors(context).blackColor,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
