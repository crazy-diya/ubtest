import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:carousel_slider/carousel_slider.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/models/responses/promotions_response.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../core/service/app_permission.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../core/service/storage_service.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/promotion/promotion_bloc.dart';
import '../../bloc/promotion/promotion_event.dart';
import '../../bloc/promotion/promotion_state.dart';
import '../../widgets/toast_widget/toast_widget.dart';

class PromotionsAndOfferDetailsView extends StatefulWidget {
  final PromotionList promotionAndOffersEntity;

  const PromotionsAndOfferDetailsView({required this.promotionAndOffersEntity});

  @override
  State<PromotionsAndOfferDetailsView> createState() =>
      _PromotionsAndOfferDetailsViewState();
}

class _PromotionsAndOfferDetailsViewState
    extends State<PromotionsAndOfferDetailsView> {
  final _bloc = injection<PromotionBloc>();
  int _current = 0;
  bool _isLoading = false;

  final CarouselSliderController _controller = CarouselSliderController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate('promotions'),
        goBackEnabled: true,
        actions: [
          IconButton(
              onPressed: () async {
                _downloadEReceipt(false);
              },
              icon: _isLoading == false
                  ? PhosphorIcon(
                      PhosphorIcons.shareNetwork(PhosphorIconsStyle.bold),
                    )
                  : SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(
                        color: colors(context).secondaryColor,
                        strokeWidth: 2.0,
                      ),
                    ))
        ],
      ),
      body: BlocProvider<PromotionBloc>(
        create: (context) => _bloc,
        child: BlocListener<PromotionBloc, BaseState<PromotionState>>(
          bloc: _bloc,
          listener: (_, state) async {
            if (state is PromotionPdfShareSuccessState) {
              setState(() {
                _isLoading = false;
              });
              var data = base64.decode(state.document!);
              await StorageService(directoryName: 'UB').storeFile(
                  fileName: widget.promotionAndOffersEntity.subject!,
                  fileExtension: 'pdf',
                  fileData: data,
                  onComplete: (file) async {
                    if (state.shouldOpen!) {
                      await OpenFilex.open(file.path);
                    } else {
                      Share.shareXFiles(
                        [file],
                      );
                    }
                  },
                  onError: (error) {
                    ToastUtils.showCustomToast(
                        context, error, ToastStatus.FAIL);
                  });
            }
            if (state is PromotionsFailedState) {
              setState(() {
                _isLoading = false;
              });
              ToastUtils.showCustomToast(
                  context, state.message ?? AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, (20.h + AppSizer.getHomeIndicatorStatus(context))),
            child: Container(
              padding: EdgeInsets.all(16).w,
              decoration: BoxDecoration(
                  color: colors(context).whiteColor,
                  borderRadius: BorderRadius.circular(8).r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    itemCount: 1,
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: 159.73,
                      enableInfiniteScroll: false,
                      disableCenter: true,
                      autoPlay: false,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(
                          () {
                            _current = index;
                          },
                        );
                      },
                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      final imageUrl =
                      widget.promotionAndOffersEntity.channel?.toUpperCase() != "IB" ?
                          widget.promotionAndOffersEntity.images?.where((e) => e.type?.toUpperCase() == "COVERIMAGEMB").toList()[index].imageKey : "";
                          // widget.promotionAndOffersEntity.images![index].imageKey;
                      return ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8).r),
                        child: CachedNetworkImage(
                            imageUrl: imageUrl ?? "",
                            imageBuilder: (context, imageProvider) => Container(
                                  width: ScreenUtil().screenWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8).r),
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
                      );
                    },
                  ),
                  // if (widget.promotionAndOffersEntity.images!.length > 1)
                  //   Column(
                  //     children: [
                  //       2.40.verticalSpace,
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: widget.promotionAndOffersEntity.images!
                  //             .asMap()
                  //             .entries
                  //             .map((entry) {
                  //           return GestureDetector(
                  //             onTap: () => _controller.animateToPage(entry.key),
                  //             child: Container(
                  //               width: 2.w,
                  //               height: 2.w,
                  //               margin:
                  //                   const EdgeInsets.symmetric(horizontal: 1.0)
                  //                       .w,
                  //               decoration: BoxDecoration(
                  //                 shape: BoxShape.circle,
                  //                 color: colors(context)
                  //                     .primaryColor!
                  //                     .withOpacity(
                  //                         _current == entry.key ? 0.9 : 0.4),
                  //               ),
                  //             ),
                  //           );
                  //         }).toList(),
                  //       ),
                  //     ],
                  //   )
                  // else
                  //   const SizedBox.shrink(),
                  20.verticalSpace,
                  if(widget.promotionAndOffersEntity.typeDescription != "")
                    Padding(
                    padding: const EdgeInsets.only( bottom: 20).w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors(context).secondaryColor,
                        borderRadius: BorderRadius.circular(8).r,
                      ),
                      padding:
                           EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                      child:
                          Text(
                              widget.promotionAndOffersEntity.typeDescription ?? "",
                              // getOfferType(),
                              // widget.promotionAndOffersEntity.typeCode?.toTitleCase() ?? "",
                              style: size14weight700.copyWith(
                                color: colors(context).blackColor,
                              )),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.promotionAndOffersEntity.subject ?? "",
                          style: size16weight700.copyWith(
                            color: colors(context).primaryColor,
                          )),
                      8.verticalSpace,
                      Text(
                        widget.promotionAndOffersEntity.body ?? "",
                        style: size14weight400.copyWith(
                          color: colors(context).greyColor,
                        ),
                      ),
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
                                style: size14weight400.copyWith(
                                    color: colors(context).primaryColor),
                              ),
                              Center(
                                child: Text(
                                    DateFormat('dd MMM yyyy').format(
                                        DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ')
                                            .parse(
                                      widget.promotionAndOffersEntity.expiryDate
                                          .toString(),
                                    )),
                                    style: size14weight700.copyWith(
                                        color: colors(context).primaryColor)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

            ),

          ),
        ),
      ),
    );
  }

  // getOfferType(){
  //   if(widget.promotionAndOffersEntity.typeCode?.toUpperCase() == "CARD"){
  //     return AppLocalizations.of(context).translate("credit_card_offer");
  //   }
  //   else if(widget.promotionAndOffersEntity.typeCode?.toUpperCase() == "SEASONAL"){
  //     return AppLocalizations.of(context).translate("seasonal_offer");
  //   }
  //   else if(widget.promotionAndOffersEntity.typeCode?.toUpperCase() == "OTHER"){
  //     return AppLocalizations.of(context).translate("other_offer");
  //   } else {
  //     return "";
  //   }
  // }

  _downloadEReceipt(bool shouldStore) {
    setState(() {
      _isLoading = true; // Set loading to true when share operation starts
    });
    AppPermissionManager.requestExternalStoragePermission(context, () async {
      // final imgBase64Str = await networkImageToBase64(widget.promotionAndOffersEntity.image?.first.imageKey );

      _bloc.add(
        PromotionShareEvent(
          promotionId: widget.promotionAndOffersEntity.id.toString(),
          messageType: "getPromotionItemPdf",
        ),
      );
    });
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
