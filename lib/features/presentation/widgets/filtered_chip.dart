
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

class FilteredChip extends StatefulWidget {
  final double? height;
  final VoidCallback onTap;
  final List<Widget> children;
  const FilteredChip(
      {super.key,
      this.height = 12,
      required this.onTap,
      required this.children});

  @override
  State<FilteredChip> createState() => _FilteredChipState();
}

class _FilteredChipState extends State<FilteredChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w,top: widget.height!.h),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: colors(context).primaryColor200!,width: 1.w),
          borderRadius: BorderRadius.circular(8).r,
          color: colors(context).whiteColor,
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ...widget.children,
              4.horizontalSpace,
              GestureDetector(
                onTap: widget.onTap,
                child: Center(
                  child: PhosphorIcon(
                    size: 20.w,
                    PhosphorIcons.xCircle(PhosphorIconsStyle.bold),
                    color: colors(context).greyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
