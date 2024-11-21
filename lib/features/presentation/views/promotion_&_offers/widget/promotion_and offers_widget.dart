import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/models/responses/promotions_response.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../../utils/app_localizations.dart';

class PromotionAndOffersWidget extends StatefulWidget {
  final PromotionList selectedPromo;
  final String promotionType;

  const PromotionAndOffersWidget({required this.selectedPromo, required this.promotionType});

  @override
  State<PromotionAndOffersWidget> createState() =>
      _PromotionAndOffersWidgetState();
}

class _PromotionAndOffersWidgetState extends State<PromotionAndOffersWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16).w,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).w,
          color: colors(context).whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack(
            //   children: [
                Container(
                  height: 159.73,
                  decoration: BoxDecoration(
                      color: colors(context).whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      )),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ).w,
                    child: CachedNetworkImage(
                        imageUrl: widget.selectedPromo.images!.first.imageKey ?? "",
                        imageBuilder: (context, imageProvider) => Container(
                          width: ScreenUtil().screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(
                          child: SizedBox(
                            height: 20.w,
                            width: 20.w,
                            child: CircularProgressIndicator(
                              color: colors(context).primaryColor400,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => PhosphorIcon(
                          PhosphorIcons.warningCircle(
                              PhosphorIconsStyle.bold),
                        )),
                    // AspectRatio(
                    //     aspectRatio: 17 / 9,
                    //     child: Image.network(
                    //       widget.selectedPromo.images!.isNotEmpty
                    //           ? widget.selectedPromo.images!.first.imageKey!
                    //           : "https://understandingcompassion.com/wp-content/uploads/2018/04/noimage.png",
                    //       scale: 5,
                    //       fit: BoxFit.cover,
                    //     )),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(12).w,
                //   child: Container(
                //       decoration: BoxDecoration(
                //         color: colors(context).secondaryColor,
                //         borderRadius: BorderRadius.circular(8).w,
                //       ),
                //       padding: const EdgeInsets.symmetric( vertical: 4,horizontal: 8).w,
                //       child:
                //           Text(
                //               widget.promotionType.toTitleCase(),
                //               style: size14weight700.copyWith(
                //                 color: colors(context).blackColor,
                //               )),
                //     ),
                // ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.all(16).w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.selectedPromo.subject!,
                      style: size16weight700.copyWith(
                        color: colors(context).primaryColor,
                      )),
                  8.verticalSpace,
                  Text(
                    widget.selectedPromo.shortDes??"",
                    style: size14weight400.copyWith(color:  colors(context).greyColor, ),),
                   20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('offer_valid_till'),
                            style: size14weight400.copyWith(color: colors(context).primaryColor),),
                          Center(
                            child: Text(DateFormat('dd MMM yyyy').format(
                                DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(
                                  widget.selectedPromo.expiryDate.toString(),
                                )),

                              style: size14weight700.copyWith( color: colors(context).primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterPercentage(String text) {
    RegExp regex = RegExp(r'\d+\.?\d*%');
    Iterable<Match> matches = regex.allMatches(text);

    List<TextSpan> textSpans = [];

    int prevEndIndex = 0;
    for (Match match in matches) {
      int start = match.start;
      int end = match.end;

      textSpans.add(
        TextSpan(
          text: text.substring(prevEndIndex, start),
          style: TextStyle(
            color: colors(context).blackColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

      textSpans.add(
        TextSpan(
          text: match.group(0),
          style: TextStyle(
            color: colors(context).blackColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

      prevEndIndex = end;
    }

    textSpans.add(
      TextSpan(
        text: text.substring(prevEndIndex),
        style: TextStyle(
          color: colors(context).blackColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

    return RichText(
      text: TextSpan(children: textSpans),
    );
  }


}
