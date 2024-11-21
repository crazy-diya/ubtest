import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../utils/app_assets.dart';

import '../data/news_feed_response_entity.dart';

import 'package:timeago/timeago.dart' as timeago;

class NewsFeedComponent extends StatelessWidget {
  final NewsFeedViewEntity newsFeedViewEntity;
  final bool isBBC;

  const NewsFeedComponent({super.key, required this.newsFeedViewEntity, required this.isBBC});

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16,).h,
        child: Container(
           height: double.infinity,
          width: 27.w,
          decoration: BoxDecoration(
            color: colors(context).whiteColor,
            borderRadius: BorderRadius.circular(8).w,
            border: Border.all(color: colors(context).whiteColor!),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colors(context).negativeColor,
                        borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(8).w,
                          topRight: Radius.circular(8.0).w,
                        ),
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(12).w,
                        child: SvgPicture.asset(
                          alignment: Alignment.centerLeft,
                         isBBC? AppAssets.bbcLogo:AppAssets.cnnLogo,
                        ),
                      ),
                      width: double.infinity,
                      height: 41.w, // Adjust the height of the separator bar
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 12.w,right: 12.h, top: 12.h, bottom: 10.w),
                      child: Text(
                        newsFeedViewEntity.title,
                        style:size18weight700.copyWith(color: colors(context).blackColor) ,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12,right: 12, bottom: 12).w,
                        child: Text(
                          newsFeedViewEntity.subTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: size16weight400.copyWith(color: colors(context).greyColor400)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      
              Divider(
                height: 1, // Adjust the height of the separator
                color: colors(context).greyColor100, // Set the color you desire
              ),
              Padding(
                padding: const EdgeInsets.all(12).w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${timeago.format(newsFeedViewEntity.details??DateTime.now(), locale: 'en_short').replaceAll('~', '')} ago",
                    //  DateFormat('dd-MMM-yyyy | hh:mm a').format(newsFeedViewEntity.details??DateTime.now()),
                      style:size14weight400.copyWith(color: colors(context).blackColor),
                    ),
                    InkWell(
                      onTap: () {
                        String url = newsFeedViewEntity
                            .linkNews; // Get the URL from the entity
                        _launchURL(url); // Launch the URL when clicked
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context).translate("see_more"),
                            style: size14weight400.copyWith(color: colors(context).blackColor),
                          ),
                          PhosphorIcon(
                                  PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                                  size: 16.w,
                                  color: colors(context).blackColor,
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
