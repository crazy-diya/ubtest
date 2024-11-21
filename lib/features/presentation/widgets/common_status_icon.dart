// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';


class CommonStatusIcon extends StatelessWidget {
 final Color backGroundColor;
 final Color? iconColor;
 final PhosphorIconData? icon;
 final String? svgIcon;
 final double? iconSize;
  const CommonStatusIcon({
    Key? key,
    required this.backGroundColor,
    this.iconColor,
    this.icon,
    this.svgIcon, this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(color: backGroundColor, shape: BoxShape.circle),
        child: Padding(
          padding: const EdgeInsets.all(16).w,
          child: icon != null
              ? PhosphorIcon(
                  size:iconSize?? 32.w,
                  icon!,
                  color: iconColor,
                )
              : SvgPicture.asset(svgIcon!),
        ),
      );
  }
}
