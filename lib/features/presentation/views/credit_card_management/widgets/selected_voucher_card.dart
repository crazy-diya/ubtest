import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_localizations.dart';

class SelectedVoucherCard extends StatefulWidget {
  final String? voucherName;
  final num? noOfVouchers;
  final num? costOfVouchers;

  const SelectedVoucherCard({
    this.voucherName,
    this.noOfVouchers,
    this.costOfVouchers,
  });

  @override
  State<SelectedVoucherCard> createState() => _SelectedVoucherCardState();
}

class _SelectedVoucherCardState extends State<SelectedVoucherCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: colors(context).primaryColor400!),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.voucherName ?? "-",
                      style: size14weight700.copyWith(
                          color: colors(context).whiteColor!),
                    ),
                    Text(
                      "${AppLocalizations.of(context).translate("point")} - ${widget.costOfVouchers?.toStringAsFixed(0)}",
                      style: size14weight400.copyWith(
                          color: colors(context).whiteColor!),
                    ),
                  ],
                ),
                Container(
                  height: 40.w,
                  width: 40.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8).r,
                    color: colors(context).whiteColor,
                  ),
                  child: Center(
                    child: Text(widget.noOfVouchers.toString() ?? "0",
                      style: size16weight700.copyWith(
                          color: colors(context).primaryColor!),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
