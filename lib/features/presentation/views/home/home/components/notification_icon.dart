import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';


class NotificationIcon extends StatelessWidget {
  final bool showIndicator;
  final Color? indicatorColor;
  final int notificationCount;
  final VoidCallback? onPressed;

  const NotificationIcon({super.key,
    this.showIndicator = false,
    this.indicatorColor,
    this.onPressed,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 24.w,
        height: 24.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PhosphorIcon(

              PhosphorIcons.bell(PhosphorIconsStyle.bold),
              color: colors(context).whiteColor,size: 24.w,
            ),
            if (showIndicator)
              Positioned(
                top: 1.87.w,
                right: 2.63.w,
                child: Container(
                  height: 8.w,
                  width: 8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: indicatorColor,
                  ),

                ),
              ),
          ],
        ),
      ),
    );
  }
}
