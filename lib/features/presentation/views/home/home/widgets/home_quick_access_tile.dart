import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/home/home/data/home_quick_access_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';


class HomeQuickAccessTile extends StatefulWidget {
  final int index;
  final HomeQuickAccessData homeQuickAccessData;
  const HomeQuickAccessTile({super.key, required this.index, required this.homeQuickAccessData});

  @override
  State<HomeQuickAccessTile> createState() => _HomeQuickAccessTileState();
}

class _HomeQuickAccessTileState extends State<HomeQuickAccessTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.homeQuickAccessData.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8).r,
              border: Border.all(color: colors(context).greyColor300!)
            ),
            child:  widget.homeQuickAccessData.icon != null
              ? PhosphorIcon(
                  widget.homeQuickAccessData.icon!,
                  color: colors(context).primaryColor,
                )
              : Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                    widget.homeQuickAccessData.imageIcon!,
                  fit: BoxFit.scaleDown,
                    color: colors(context).primaryColor,
                  ),
              ),
          ),
          8.verticalSpace,
          Expanded(
            child: Container(
              width: 60,
              child: Text(
                AppLocalizations.of(context).translate(widget.homeQuickAccessData.title),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: size12weight700.copyWith(color: colors(context).blackColor) ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
