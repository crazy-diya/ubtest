import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import '../../../../../utils/app_localizations.dart';

import 'main_menu_carousel.dart';

class MainMenuCarouselItem extends StatelessWidget {
  final QuickAccess menuItem;
  final int index;
  // final VoidCallback onLongPress;
  const MainMenuCarouselItem({super.key, required this.menuItem, required this.index,
  // required this.onLongPress
  
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: menuItem.onTap,
      // onLongPress: onLongPress,
      highlightColor: colors(context).whiteColor,
      hoverColor: colors(context).whiteColor,
      splashColor: colors(context).secondaryColor,
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2.5).w,
        child: Column(
          children: <Widget>[
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                color: colors(context).primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(9.5).r,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(19.0).w,
                child: menuItem.isSvg!
                    ? SvgPicture.asset(
                        menuItem.svg!,
                        width: 32,
                        height: 32,
                        fit: BoxFit.scaleDown,
                        colorFilter:
                            ColorFilter.mode(colors(context).whiteColor!, BlendMode.srcIn),
                      )
                    :  PhosphorIcon(menuItem.icon! , color: colors(context).whiteColor,size:32, )
                    
                //     Image.asset(
                //   menuItem.icon,
                //   width: 44,
                //   height: 44,
                //   fit: BoxFit.scaleDown,
                // ),
              ),
            ),
           8.verticalSpace,
            Text(
              AppLocalizations.of(context).translate(menuItem.title),
              style:size14weight700.copyWith(
                color: colors(context).blackColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
