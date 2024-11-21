import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';


import '../../../../../../utils/app_localizations.dart';
import '../../../../../../utils/navigation_routes.dart';
import '../../../../../data/models/responses/promotions_response.dart';

class HomePromotions extends StatefulWidget {
  final List<PromotionList> promoData;

  const HomePromotions({super.key, required this.promoData});
  @override
  State<HomePromotions> createState() => _HomePromotionsState();
}

class _HomePromotionsState extends State<HomePromotions> {
  List<CarouselItem> itemList = [];
  List<PromotionList> promotionList = [];
  int current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setPromoData();
    });
  }

  setPromoData() {
    setState(() {
      promotionList.addAll(widget.promoData.where((e) => e.channel?.toUpperCase() != "IB").toList());
      for (var element in promotionList) {
        itemList.add(CarouselItem(
          promoEntity: element,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors(context).whiteColor,
        borderRadius: BorderRadius.circular(8).r
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16).w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context).translate("promotions"),
                    style: size18weight700.copyWith(color:colors(context).blackColor ) ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.kPromotionsOffersView,arguments: false);
                  },
                  child: Text(AppLocalizations.of(context).translate("view_more"),
                      style: size14weight700.copyWith(color: colors(context).primaryColor)),
                ),
              ],
            ),
          ),
           Padding(
             padding: EdgeInsets.symmetric(horizontal: 12).w,
             child: CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      autoPlayAnimationDuration: Duration(seconds: 2),
                      height:  160,
                      autoPlay: true,
                      scrollPhysics: const BouncingScrollPhysics(),
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          current = index;
                        });
                      },
                    ),
                    items: itemList,
                  ),
           ),
           12.verticalSpace,
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: itemList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  margin: const EdgeInsets.symmetric(horizontal: 4).w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:  current ==entry.key?colors(context).secondaryColor: colors(context)
                        .secondaryColor800!
                        .withOpacity(0.4),
                  ),
                ),
              );
            }).toList(),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }

  // _getCategoryName(String code) {
  //   if (code == AppConstants.promotionTypeSeasonal) {
  //     return AppLocalizations.of(context).translate('seasonal_offers');
  //   } else if (code == AppConstants.promotionTypeCard) {
  //     return AppLocalizations.of(context).translate('credit_card_offers');
  //   } else if (code == AppConstants.promotionTypeOther) {
  //     return AppLocalizations.of(context).translate('other_offers');
  //   } else {
  //     return AppLocalizations.of(context).translate('offers');
  //   }
  // }
}

class CarouselItem extends StatefulWidget {
  final PromotionList promoEntity;
  const CarouselItem({super.key, required this.promoEntity});

  @override
  State<CarouselItem> createState() => _CarouselItemState();
}

class _CarouselItemState extends State<CarouselItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.kPromotionsAndOfferDetailsView,
          arguments: widget.promoEntity,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4).w,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors(context).greyColor?.withOpacity(.2),
            borderRadius: BorderRadius.circular(8).r,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8).r,
            child: CachedNetworkImage(
                    imageUrl:
                    widget.promoEntity.channel?.toUpperCase() != "IB" ?
                        widget.promoEntity.images!.where((e) => e.type?.toUpperCase() == "COVERIMAGEMB").first.imageKey! :
                        "",
                    // widget.promoEntity.images?.first.imageKey??"",
                    imageBuilder: (context, imageProvider) => Container(
                      width:  MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: SizedBox(height: 20.w,
                          width: 20.w,
                        child: CircularProgressIndicator(color: colors(context).primaryColor200),
                      ),
                    ),
                    errorWidget: (context, url, error) =>PhosphorIcon(
                                  PhosphorIcons.warningCircle(
                                      PhosphorIconsStyle.bold),
                                ),
                  )
            
            
            // Image.network(
            //   widget.promoEntity.images!.first.imageKey!,
            //   fit: BoxFit.fitWidth,
            // ),
          ),
        ),
      ),
    );
  }
}
