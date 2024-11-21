
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/bottom_sheet.dart';
import 'package:union_bank_mobile/features/presentation/widgets/date_pickers/app_date_picker.dart';
import 'package:union_bank_mobile/features/presentation/widgets/filtered_chip.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/promo_and_offers_category_entity.dart';
import '../../bloc/promotion/promotion_bloc.dart';
import '../../bloc/promotion/promotion_event.dart';
import '../../bloc/promotion/promotion_state.dart';

import '../base_view.dart';
import 'data/filtered_data.dart';
import 'widget/promotion_and%20offers_widget.dart';
import 'widget/promotion_categories_widget.dart';

class PromotionsOffersView extends BaseView {
  final bool isFromPreLogin;

  PromotionsOffersView({
    super.key,
    this.isFromPreLogin = false,
  });

  @override
  State<PromotionsOffersView> createState() => _PromotionsOffersView();
}

class _PromotionsOffersView extends BaseViewState<PromotionsOffersView> {
  final _bloc = injection<PromotionBloc>();

  List<PromoAndOffersCategoryEntity> offerCategoryList = [];
  FilteredData promotionList = FilteredData(promotionData: []);
  FilteredData dynamicPromotionList = FilteredData(promotionData: []);

  FilteredData filterdData = FilteredData(promotionData: []);

  String currentTab = "ALL";

  String? toDate;
  DateTime? fromDateV;
  DateTime? toDateV;
  String? fromDate;

  String? toDateTemp;
  DateTime? fromDateVTemp;
  DateTime? toDateVTemp;
  String? fromDateTemp;

  @override
  void initState() {
    super.initState();
    if (widget.isFromPreLogin) {
      _bloc.add(GetPromotionsEvent(
        isFromHome: false,
      ));
    } else {
      _bloc.add(GetPromotionsEvent(
        isFromHome: true,
      ));
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate('promotions'),
        goBackEnabled: true,
        actions: [
          IconButton(
              onPressed: () async {
               final result = await showModalBottomSheet<bool>(
                    isScrollControlled: true,
                    useRootNavigator: true,
                    useSafeArea: true,
                    context: context,
                    barrierColor: colors(context).blackColor?.withOpacity(.85),
                    backgroundColor: Colors.transparent,
                    builder: (context,) => StatefulBuilder(
                      builder: (context,changeState) {
                        return BottomSheetBuilder(
                          isTwoButton: true,
                            title: AppLocalizations.of(context).translate('filter_promotions'),
                            buttons: [
                                Expanded(
                                  child: AppButton(
                                      buttonType: ButtonType.OUTLINEENABLED,
                                      buttonText: AppLocalizations.of(context) .translate("reset"),
                                      onTapButton: () {
                                      changeState(() {
                                        toDate = null;
                                        toDateTemp = null;
                                        fromDate = null;
                                        fromDateTemp = null;
                                        toDateV = null;
                                        toDateVTemp = null;
                                        fromDateV = null;
                                        fromDateVTemp = null;
                                      });
                                      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                      if (widget.isFromPreLogin) {
                                          _bloc.add(GetPromotionsEvent(
                                              isFromHome: false,
                                              fromDate: fromDate,
                                              toDate: toDate));
                                        } else {
                                          _bloc.add(GetPromotionsEvent(
                                              isFromHome: true,
                                              fromDate: fromDate,
                                              toDate: toDate));
                                        }
                                    }),
                                ),
                                16.horizontalSpace,
                                Expanded(
                                  child: AppButton(
                                    buttonType: fromDateTemp == null ||
                                            toDateTemp == null ||
                                            _isDateRangeValid()
                                        ? ButtonType.PRIMARYDISABLED
                                        : ButtonType.PRIMARYENABLED,
                                    buttonText: AppLocalizations.of(context)
                                        .translate("apply"),
                                    onTapButton: () {
                                      changeState(() {
                                      toDate = toDateTemp;
                                      fromDate = fromDateTemp;
                                      toDateV = toDateVTemp;
                                      fromDateV = fromDateVTemp;
                                    });

                                        if (widget.isFromPreLogin) {
                                          _bloc.add(GetPromotionsEvent(
                                              isFromHome: false,
                                              fromDate: fromDate,
                                              toDate: toDate));
                                        } else {
                                          _bloc.add(GetPromotionsEvent(
                                              isFromHome: true,
                                              fromDate: fromDate,
                                              toDate: toDate));
                                        }
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ),
                              ],
                              children: [
                                  AppDatePicker(
                                    isFromDateSelected: true,
                                    firstDate: DateTime.now(),
                                     initialValue:ValueNotifier(fromDateTemp != null ?DateFormat('dd-MMM-yyyy').format( DateTime.parse(fromDateTemp!)):null) ,
                                    labelText: AppLocalizations.of(context).translate("from_date"),
                                    onChange: (value) {
                                      changeState(() {
                                        fromDateTemp = value;
                                        fromDateVTemp = DateTime.parse(fromDateTemp!);
                                      });
                                    },
                                  initialDate: fromDateVTemp?? DateTime.parse(fromDateTemp ??DateTime.now().toString()),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const SizedBox.shrink(),
                                      fromDateTemp != null &&
                                          toDateTemp != null &&
                                          toDateVTemp!.isBefore(fromDateVTemp!)
                                          ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3).w,
                                          child: Text(
                                            "${AppLocalizations.of(context).translate("date_cannot_greater_than")} $toDateTemp",
                                            textAlign: TextAlign.end,
                                            style: size14weight400.copyWith(
                                              color: toDateVTemp!
                                                      .isBefore(fromDateVTemp!)
                                                  ? colors(context)
                                                      .negativeColor
                                                  : colors(context).blackColor,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                                   24.verticalSpace,
                                  AppDatePicker(
                                    initialValue: ValueNotifier(toDateTemp != null ?DateFormat('dd-MMM-yyyy').format( DateTime.parse(toDateTemp!)):null) ,
                                    isFromDateSelected: true,
                                    firstDate: fromDateVTemp,
                                    labelText: AppLocalizations.of(context).translate("to_date"),
                                    onChange: (value) {
                                      changeState(() {
                                        toDateTemp = value;
                                        toDateVTemp = DateTime.parse(toDateTemp!);
                                      });
                                    },
                                    initialDate:toDateVTemp?? DateTime.parse(fromDateTemp ??DateTime.now().toString()),
                                  ),
                                   20.verticalSpace
                              ],
                            );
                      }
                    ));
              },
              icon: PhosphorIcon(
                PhosphorIcons.funnel(PhosphorIconsStyle.bold),
              ))
        ],
      ),
      body: BlocListener<PromotionBloc, BaseState<PromotionState>>(
        bloc: _bloc,
        listener: (_, state) {
          if (state is PromotionsSuccessState) {
            if (state.category != []) {
              offerCategoryList = List.generate(
                  state.category!.length + 1,
                  (index) => index == 0
                      ? PromoAndOffersCategoryEntity(
                          label: "All Offers",
                          code: "ALL",
                          isSelected: true,
                          isInitialItem: true,
                        )
                      : PromoAndOffersCategoryEntity(
                          label: state.category![index - 1].description,
                          code: state.category![index - 1].code,
                          isSelected: false,
                          isInitialItem: false,
                        ));
            }

            if (state.promotions != []) {
              promotionList.promotionData.clear();
              // promotionList.promotionData.addAll([...?state.promotions?.where((e)=>e.channel!="IB" && e.status =="active").toList()]);
              promotionList.promotionData.addAll(
                  state.promotions?.where((e) => e.channel != "IB" && e.status == "active").map((promotion) {
                    var filteredImages = promotion.images?.where((image) => image.type?.toUpperCase() == "COVERIMAGEMB").toList();
                    return promotion.copyWith(images: filteredImages);
                  }).toList() ?? []
              );

              dynamicPromotionList =promotionList;
              setState(() {});
            }
            ///////////////////////////////////
          } else {}
        },
        child: Stack(
          children: [
            if(dynamicPromotionList.promotionData.isEmpty) Center(
                    child: Column(
                             mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                            children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors(context).secondaryColor300),
                            padding: EdgeInsets.all(14).w,
                            child: Center(
                              child: PhosphorIcon(
                                    PhosphorIcons.sealCheck(PhosphorIconsStyle.bold),
                                    color: colors(context).whiteColor,
                                size: 28.w,
                                  ),
                            ),
                          ),
                          16.verticalSpace,
                              Text(
                                AppLocalizations.of(context).translate('no_promo'),
                                style: size18weight700.copyWith(
                                  color: colors(context).blackColor
                                ),
                              ),
                              4.verticalSpace,
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 7).w,
                                child: Text(
                                  AppLocalizations.of(context).translate('no_promo_des'),
                                  textAlign: TextAlign.center,
                                  style: size14weight400.copyWith(
                                    color: colors(context).greyColor
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
            Padding(
              padding:  EdgeInsets.fromLTRB(20.w,24.h,20.w,0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                if(offerCategoryList.isNotEmpty)
                 SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(color: colors(context).whiteColor,borderRadius: BorderRadius.circular(8).w),
                      child: Row(
                        children: [
                          for (int index = 0; index < offerCategoryList.length; index++)
                          GestureDetector(
                                  onTap: () {
                                    if(index!=0){
                                      dynamicPromotionList = FilteredData(promotionData: [...promotionList.promotionData.where((element) => element.typeCode==offerCategoryList[index].code)]);
                                      _toggleCategory(offerCategoryList[index].code!);
                                    }else{
                                      dynamicPromotionList = promotionList;
                                      _toggleCategory("ALL");
                                    }
                                        
                                    setState(() {
                                        
                                    });
                                        
                                  },
                                  child: PromoCategories(offerCategoryList[index]),
                                )
                        ],
                      ),
                    ),
                  ),
                 (dynamicPromotionList.promotionData.isEmpty || (fromDate != null && toDate != null)) ?Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Align(
                         alignment: Alignment.topLeft,
                       child: Visibility(
                         visible: fromDate != null && toDate != null,
                         child: FilteredChip(
                           onTap: () {
                             setState(() {
                               toDate = null;
                               toDateTemp = null;
                               fromDate = null;
                               fromDateTemp = null;
                               toDateV = null;
                               toDateVTemp = null;
                               fromDateV = null;
                               fromDateVTemp = null;
                             });
                             _bloc.add(GetPromotionsEvent(
                                 isFromHome:
                                     widget.isFromPreLogin == true ? false : true,
                                 fromDate: fromDate,
                                 toDate: toDate));
                           },
                           children: [
                             if (fromDate != null && toDate != null)
                               Text(
                                 "${DateFormat("dd-MMM-yyyy").format(DateTime.parse(fromDate!))} to ${DateFormat("dd-MMM-yyyy").format(DateTime.parse(toDate!))}",
                                 style: size14weight400.copyWith(color: colors(context).greyColor),
                               ),
                           ],
                         ),
                       ),
                     ),
                   ],
                 ):SizedBox.shrink(),
                 if(dynamicPromotionList.promotionData.isNotEmpty) Expanded(
                    child:  Padding(
                          padding: EdgeInsets.only(top: 24.h ,),
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: dynamicPromotionList.promotionData.length,
                              padding: EdgeInsets.only(bottom: (4 + AppSizer.getHomeIndicatorStatus(context))),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:  EdgeInsets.only(bottom:(dynamicPromotionList.promotionData.length-1) == index ?0: 4).w,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.kPromotionsAndOfferDetailsView,
                                        arguments: dynamicPromotionList.promotionData[index],
                                      );
                                    },
                                    child: PromotionAndOffersWidget(
                                      selectedPromo: dynamicPromotionList.promotionData[index],
                                      promotionType: dynamicPromotionList.promotionData[index].typeCode??"",
                                    ),
                                  ),
                                );
                              },
                            ),
                        )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  _toggleCategory(String code) {
    setState(() {
      for (final element in offerCategoryList) {
        if (element.code == code) {
          element.isSelected = true;
        } else {
          element.isSelected = false;
        }
      }
    });
  }

    bool _isDateRangeValid() {
    if (fromDateVTemp != null && toDateVTemp != null) {
      return toDateVTemp!.isBefore(fromDateVTemp!);
    }
    return true; // Return true if either fromDateV or toDateV is null.
  }


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}

