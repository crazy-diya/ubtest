import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/enums.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/toast_widget/toast_widget.dart';

class VoucherSelectorCard extends StatefulWidget {
  final String? voucherName;
  final int? voucherId;
  final int? qtyAvailable;
  final int? noOfVouchers;
  final num? costOfVouchers;
  final num? availablePoints;
  final Function(int) onTapSelected;

  const VoucherSelectorCard({
    this.voucherName,
    this.noOfVouchers,
    this.qtyAvailable,
    this.voucherId,
    this.costOfVouchers,
    this.availablePoints,
    required this.onTapSelected
  });

  @override
  State<VoucherSelectorCard> createState() => _VoucherSelectorCardState();
}

class _VoucherSelectorCardState extends State<VoucherSelectorCard> {
  late int _noOfVouchers;
  bool isSelectVoucher = false;


  @override
  void initState() {
    super.initState();
    _noOfVouchers = widget.noOfVouchers??0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 16.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: colors(context).whiteColor,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8).r,
                    color: colors(context).primaryColor400!),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          _noOfVouchers == 0
                              ? InkWell(
                                  onTap: () {
                                    if(AppConstants.selectedVoucherId== null || AppConstants.selectedVoucherId == widget.voucherId.toString()){
                                    setState(() {
                                        _noOfVouchers += 1;
                                        AppConstants.selectedVoucherId =
                                            widget.voucherId.toString();
                                    });
                                    }
                                  },
                                  child: Container(
                                    height: 40.w,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).whiteColor,
                                    ),
                                    child: PhosphorIcon(
                                      size: 16.w,
                                      PhosphorIcons.plus(PhosphorIconsStyle.bold),
                                      color: colors(context).primaryColor,
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _noOfVouchers -= 1;
                                          if(_noOfVouchers == 0){
                                            AppConstants.selectedVoucherId = null;
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 40.w,
                                        width: 40.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8).r,
                                          color: colors(context).whiteColor,
                                        ),
                                        child: PhosphorIcon(
                                          size: 16.w,
                                          PhosphorIcons.minus(
                                              PhosphorIconsStyle.bold),
                                          color: colors(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40.w,
                                      child: Center(
                                        child: Text(
                                          _noOfVouchers.toString(),
                                          style: size16weight700.copyWith(
                                              color: colors(context).whiteColor),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if(_noOfVouchers==widget.qtyAvailable){
                                            ToastUtils.showCustomToast(
                                                context, "Exceed the Available Quantity", ToastStatus.FAIL);
                                          }else if((_noOfVouchers * widget.costOfVouchers!)>= widget.availablePoints!){
                                            ToastUtils.showCustomToast(
                                                context, "Exceed the Available Points", ToastStatus.FAIL);
                                          }else {
                                            _noOfVouchers += 1;
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 40.w,
                                        width: 40.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8).r,
                                          color: colors(context).whiteColor,
                                        ),
                                        child: PhosphorIcon(
                                          size: 16.w,
                                          PhosphorIcons.plus(PhosphorIconsStyle.bold),
                                          color: colors(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _noOfVouchers != 0 ? 16.verticalSpace : SizedBox.shrink(),
              _noOfVouchers != 0
                  ? AppButton(
                      buttonText: "${AppLocalizations.of(context).translate("selected")} (${_noOfVouchers})",
                      onTapButton: ()  {
                        if((_noOfVouchers * widget.costOfVouchers!)>= widget.availablePoints!){
                          ToastUtils.showCustomToast(
                              context, "Exceed the Available Points", ToastStatus.FAIL);
                        }else {
                          widget.onTapSelected(_noOfVouchers);
                        }
                      },
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
