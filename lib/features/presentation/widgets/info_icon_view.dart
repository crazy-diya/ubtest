import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../core/theme/text_styles.dart';
import '../../../core/theme/theme_data.dart';

class CommonToolTips extends StatefulWidget {
  String? title;
  List<String> content;
  bool? isReject;
  bool? successfullyValidated;
  double? rightPadding;
  bool? isShowingInTheFieldToolTip;
  bool? hasFocus;
  SuperTooltipController? controller;
  bool isReadOnlyTextFieldToolTip;
  bool isTextFieldEmpty;

  CommonToolTips(
      {this.title,
      required this.content,
      this.successfullyValidated = false,
      this.isReject = false,
      this.rightPadding = null,
      this.isShowingInTheFieldToolTip = false,
      this.hasFocus = false,
      this.controller = null,
      this.isReadOnlyTextFieldToolTip = false,
      this.isTextFieldEmpty = true,
      super.key});

  @override
  State<CommonToolTips> createState() => _CommonToolTipsState();
}

class _CommonToolTipsState extends State<CommonToolTips> {
  @override
  Widget build(BuildContext context) {
    return SuperTooltip(
      controller: widget.controller,
      hideTooltipOnTap: true,
      backgroundColor: colors(context).secondaryColor200,
      borderWidth: 5.0,
      left: (widget.title != null && widget.title != "" ? 20 : 26).w,
      right: widget.rightPadding,
      hasShadow: false,
      showBarrier: true,
      barrierColor: Colors.transparent,
      showDropBoxFilter: false,
      borderColor: Colors.transparent,
      popupDirection: TooltipDirection.down,
      showCloseButton: ShowCloseButton.inside,
      closeButtonColor: Colors.transparent,
      closeButtonSize: 0,
      content: Padding(
        padding: const EdgeInsets.all(1.24).w,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null && widget.title != "")
                Text(
                  widget.title ?? "",
                  textAlign: TextAlign.justify,
                  style: widget.content.length == 1
                      ? size16weight400
                      : size16weight700,
                ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: widget.content.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                            top: widget.content.length > 1 ? 1.3 : 0,
                            left: widget.content.length > 1 ? 2 : 0)
                        .w,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.content.length > 1)
                          Padding(
                            padding: EdgeInsets.only(top: 7.5.w, right: 5.w),
                            child: Column(
                              children: [
                                Container(
                                  height: 3.5.h,
                                  width: 3.5.w,
                                  decoration: BoxDecoration(
                                    color: colors(context).blackColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (widget.content.length > 1) 2.horizontalSpace,
                        Expanded(
                            child: Text(
                          widget.content[index],
                          textAlign: TextAlign.start,
                        )),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      child: widget.isReject == true
          ? Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, top: 4, bottom: 4),
              child: Text(
                AppLocalizations.of(context).translate("rejected"),
                style:
                    size16weight400.copyWith(color: colors(context).whiteColor),
              ))
          : PhosphorIcon(
              PhosphorIcons.info(PhosphorIconsStyle.bold),
              size: (widget.isShowingInTheFieldToolTip == true ? 24 : 20).w,
              color: widget.successfullyValidated == true
                  ?colors(context).negativeColor
                     :(widget.hasFocus == true
                        ?(widget.isReadOnlyTextFieldToolTip == true?colors(context).blackColor
                        :colors(context).primaryColor)
                     : widget.isTextFieldEmpty == false
                  ?colors(context).blackColor300
                  :colors(context).blackColor
              ),


              // color: widget.successfullyValidated == true
              //     ? colors(context).negativeColor
              //     : ((widget.isShowingInTheFieldToolTip == true &&
              //                 widget.successfullyValidated == false &&
              //                 widget.hasFocus == true &&
              //                 widget.isReadOnlyTextFieldToolTip == false) ||
              //             widget.isShowingInTheFieldToolTip == false &&
              //                 widget.successfullyValidated == false &&
              //                 widget.hasFocus == true)
              //         ? colors(context).primaryColor
              //         :widget.isTitleDarker== true?colors(context).blackColor: colors(context).blackColor300,
            ),
    );
  }
}
