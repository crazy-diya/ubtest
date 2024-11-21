import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/views/base_view.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_localizations.dart';

import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/splash/splash_bloc.dart';
import '../../../widgets/appbar.dart';

class OfferArgs {
  final List<String> offerImage;
  final String title;
  final String description;
  final String validTime;

  OfferArgs(
  {
    required this.offerImage,
    required this.title,
    required this.description,
    required this.validTime
}
  );
}

class OfferPreview extends BaseView {
  final OfferArgs offerArgs;

  OfferPreview({required this.offerArgs});
  @override
  State<OfferPreview> createState() => _OfferPreviewState();
}

class _OfferPreviewState extends BaseViewState<OfferPreview> {
  var bloc = injection<SplashBloc>();
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("promotions"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8).r,
                  color: colors(context).whiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     CarouselSlider.builder(
                        itemCount: widget.offerArgs.offerImage.length,
                        carouselController: _controller,
                        options: CarouselOptions(
                          disableCenter: true,
                          autoPlay: false,
                          enableInfiniteScroll: widget.offerArgs.offerImage.length==1?false:true,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                                _current = index;
                              },
                            );
                          },
                        ),
                        itemBuilder: (BuildContext context, int index, int realIndex) {
                          final imageUrl =  widget.offerArgs.offerImage[index];
                          return ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8).r),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl??"https://understandingcompassion.com/wp-content/uploads/2018/04/noimage.png",
                              imageBuilder: (context, imageProvider) => Container(
                                width:  MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(color: Colors.blue),
                                ),
                              ),
                              errorWidget: (context, url, error) =>  PhosphorIcon(
                                    PhosphorIcons.warningCircle(
                                        PhosphorIconsStyle.bold),
                                  ),
                            ),
                          );
                        },
                      ),
                      // const SizedBox(
                      //   height: 15.0,
                      // ),
                      // if (widget.offerArgs.offerImage.length > 0)
                      //   Column(
                      //     children: [
                      //       const SizedBox(
                      //         height: 15.0,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children:widget.offerArgs.offerImage
                      //             .asMap()
                      //             .entries
                      //             .map((entry) {
                      //           return GestureDetector(
                      //             onTap: () => _controller.animateToPage(entry.key),
                      //             child: Container(
                      //               width: 10.0,
                      //               height: 10.0,
                      //               margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      //               decoration: BoxDecoration(
                      //                 shape: BoxShape.circle,
                      //                 color: colors(context)
                      //                     .secondaryColor!
                      //                     .withOpacity(
                      //                     _current == entry.key ? 0.9 : 0.4),
                      //               ),
                      //             ),
                      //           );
                      //         }).toList(),
                      //       ),
                      //     ],
                      //   )
                      // else const SizedBox.shrink(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.verticalSpace,
                          Text(widget.offerArgs.title,style: size16weight700.copyWith(color: colors(context).primaryColor),),
                          20.verticalSpace,
                          Text(widget.offerArgs.description,style: size14weight400.copyWith(color: colors(context).greyColor),),
                          20.verticalSpace,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context).translate("offer_valid_till") , style: size14weight400.copyWith(color: colors(context).primaryColor),),
                              Text(widget.offerArgs.validTime  ,style: size14weight700.copyWith(color: colors(context).primaryColor),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
