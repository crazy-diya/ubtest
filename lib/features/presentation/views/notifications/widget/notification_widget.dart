import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/theme/text_styles.dart';

import '../notifications_view.dart';
import 'dart:math' as math;

class NotificationComponent extends StatefulWidget {
  final NotificationData data;
  final bool isNotices;
  final bool isOffer;
  final VoidCallback? onLongPress;
  final VoidCallback? onPressed;

  NotificationComponent({
    required this.data,
    required this.isNotices,
    required this.isOffer,
    this.onLongPress,
    this.onPressed,
  });

  @override
  _NotificationComponentState createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {
  // bool get isLongPressed => _isLongPressed;
  // void setIsLongPressed(bool value) {
  //   _isLongPressed = value;
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            GestureDetector(
              onLongPress: widget.onLongPress,
              onTap: widget.onPressed,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 0.w, 20.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.isNotices
                          ? ClipOval(
                              child: Container(
                                height: 48.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: ClipOval(
                                      child: Transform(
                                       alignment: Alignment.center,
                                        transform: Matrix4.rotationY(math.pi),
                                        child: Container(
                                          width: 48.h,
                                          height: 48.h,
                                          decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colors(context).secondaryColor,),
                                          child: PhosphorIcon(
                                        PhosphorIcons.megaphone(
                                            PhosphorIconsStyle.bold),
                                        color: colors(context).whiteColor,
                                        size: 24.w,
                                        // textDirection: TextDirection.rtl,
                                      ),
                                        ),
                                      )
                                      ),
                                ),
                              ),
                            )
                          : ClipOval(
                              child: Container(
                                height: 48.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(48).w,
                                  border: Border.all(
                                    color: ((widget.isOffer == true &&
                                                widget.data.promoIcon ==
                                                    null) ||
                                            widget.data.image?.length == 0)
                                        ? colors(context).secondaryColor800 ??
                                            Colors.black
                                        : Colors.transparent, // Border width
                                  ),
                                ),
                                child: Center(
                                    child: ClipOval(
                                        child: widget.isNotices
                                            ? Image.asset(
                                                widget.data.image ?? "",
                                                height: 48.h,
                                                fit: BoxFit
                                                    .fill, // Fill the entire circular area without cropping
                                              )
                                            : widget.isOffer == true
                                                ? widget.data.promoIcon != null
                                                    ? CachedNetworkImage(
                                                        imageUrl: widget.data
                                                                .promoIcon ??
                                                            "",
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          width: 48.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: colors(
                                                                    context)
                                                                .secondaryColor100,
                                                            borderRadius:
                                                                BorderRadius
                                                                        .circular(
                                                                            48)
                                                                    .w,
                                                            border: Border.all(
                                                                color: colors(
                                                                        context)
                                                                    .greyColor300!),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ),
                                                          ),
                                                        ),
                                                        placeholder:
                                                            (context, url) =>
                                                                Center(
                                                          child: SizedBox(
                                                            height: 48.h,
                                                            width: 48.h,
                                                            child: Center(
                                                              child: CircularProgressIndicator(
                                                                  color: colors(
                                                                          context)
                                                                      .primaryColor),
                                                            ),
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            SizedBox(
                                                              width: 48.h,
                                                              height: 48.h,
                                                              child: Center(
                                                                child: PhosphorIcon(
                                                                                                                          PhosphorIcons
                                                                  .warningCircle(
                                                                      PhosphorIconsStyle
                                                                          .bold),
                                                                                                                        ),
                                                              ),
                                                            ),
                                                      )
                                                    //  Image.network(
                                                    //                                   widget.data.promoIcon ?? "",
                                                    //                             height: 5.8.h,
                                                    //                                   fit: BoxFit.fill, // Fill the entire circular area without cropping
                                                    //                                 )

                                                    : CircleAvatar(
                                                        backgroundColor: colors(
                                                                context)
                                                            .secondaryColor100,
                                                        radius: 23.h,
                                                        child: Center(
                                                            child: Text(
                                                                widget.data
                                                                        .title
                                                                        .getNameInitial() ??
                                                                    "",
                                                                style: size16weight700.copyWith(
                                                                    color: colors(
                                                                            context)
                                                                        .secondaryColor800))),
                                                      )
                                                : widget.data.image?.length != 0
                                                    ?
                                                    // Image.network(
                                                    //   widget.data.image ?? "",
                                                    //   height: 5.8.h,
                                                    //   fit: BoxFit.fill, // Fill the entire circular area without cropping
                                                    // )
                                                    CachedNetworkImage(
                                                        imageUrl:
                                                            widget.data.image ??
                                                                "",
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          width: 48.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: colors(
                                                                    context)
                                                                .secondaryColor100,
                                                            borderRadius:
                                                                BorderRadius
                                                                        .circular(
                                                                            48)
                                                                    .w,
                                                            border: Border.all(
                                                                color: colors(
                                                                        context)
                                                                    .greyColor300!),
                                                            image: DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .fitWidth),
                                                          ),
                                                        ),
                                                        placeholder:
                                                            (context, url) =>
                                                                Center(
                                                          child:  Container(
                                                          width: 48.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                        .circular(
                                                                            48)
                                                                    .w,
                                                            border: Border.all(
                                                                color: colors(
                                                                        context)
                                                                    .greyColor300!)),
                                                            child: SizedBox(
                                                              width: 20.h,
                                                              height: 20.h,
                                                              child: CircularProgressIndicator(
                                                                  color: colors(
                                                                          context)
                                                                      .primaryColor),
                                                            ),
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                          width: 48.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                        .circular(
                                                                            48)
                                                                    .w,
                                                            border: Border.all(
                                                                color: colors(
                                                                        context)
                                                                    .greyColor300!)),
                                                              child: PhosphorIcon(
                                                                                                                        PhosphorIcons
                                                                .warningCircle(
                                                                    PhosphorIconsStyle
                                                                        .bold),
                                                                                                                      ),
                                                            ),
                                                      )
                                                    : CircleAvatar(
                                                        backgroundColor: colors(
                                                                context)
                                                            .secondaryColor100,
                                                        radius: 23.w,
                                                        child: Text("FT",
                                                            style: size16weight700.copyWith(
                                                                color: colors(
                                                                        context)
                                                                    .secondaryColor800)),
                                                      ))),
                              ),
                            ),
                      12.horizontalSpace,
                      Expanded(
                          child: Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(widget.data.title,
                                      style: size16weight700.copyWith(
                                          color: colors(context).primaryColor)),
                                ),
                              ),
                            ),
                            8.verticalSpace,
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.isOffer
                                          ? widget.data.body??""
                                          : widget.isNotices
                                              ? widget.data.body??""
                                              : widget.data.requestID != null
                                                  ? AppLocalizations.of(context).translate("money_request")
                                                  : widget.data.txnType ==
                                                          "BILLPAY"
                                                      ? AppLocalizations.of(context).translate("bill_payments")
                                                      : AppLocalizations.of(context).translate("fund_transfer"),
                                      // widget.data.category,
                                      style: size14weight700.copyWith(
                                          color: colors(context).blackColor),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                    ),
                                  ),
                                  // if (!widget.isOffer && !widget.isNotices)
                                    12.horizontalSpace,
                                  // const SizedBox(width: 5),
                                  // Image.asset(
                                  //   AppAssets.icEclips,
                                  //   scale: 2,
                                  // ),
                                  // const SizedBox(width: 5),
                                  Text(
                                    widget.data.time,
                                    style: size14weight400.copyWith(
                                        color: colors(context).greyColor),
                                  ),
                                   20.horizontalSpace,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // const Padding(
        //   padding: EdgeInsets.only(left: 25, right: 25),
        //   child: Divider(
        //     thickness: 1,
        //   ),
        // )
      ],
    );
  }
}
