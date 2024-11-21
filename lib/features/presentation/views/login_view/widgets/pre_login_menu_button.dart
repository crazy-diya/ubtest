

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';


class PreLoginMenuButton extends StatefulWidget {
  final Function()? onTap;
  final bool isClose;
  final double? height;
  final double? width;

  const PreLoginMenuButton({
    this.onTap,
    this.isClose = false,  this.height = 47 ,  this.width = 70,
  });

  @override
  State<PreLoginMenuButton> createState() => _PreLoginMenuButtonState();
}

class _PreLoginMenuButtonState extends State<PreLoginMenuButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width!,
        height: widget.height!,
        decoration: BoxDecoration(
          color: colors(context).secondaryColor!,
          borderRadius: BorderRadius.circular(30).r,
        ),
        child: PhosphorIcon(
          size: 24,
           widget.isClose ?PhosphorIcons.xCircle(PhosphorIconsStyle.regular) :PhosphorIcons.squaresFour(PhosphorIconsStyle.bold),
        ),
      ),
    );
  }
}
