import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/bill_payment/bill_payment_billers_view.dart';
import 'package:union_bank_mobile/features/presentation/views/bill_payment/bill_payment_process_view.dart';
import 'package:union_bank_mobile/features/presentation/views/bill_payment/widgets/biller_component.dart';
import 'package:union_bank_mobile/features/presentation/views/bill_payment/widgets/pay_bills_component.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_search_text_field.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/responses/get_biller_list_response.dart';
import '../../../domain/entities/response/biller_category_entity.dart';
import '../../../domain/entities/response/biller_entity.dart';
import '../../../domain/entities/response/charee_code_entity.dart';
import '../../../domain/entities/response/saved_biller_entity.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_event.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/sliding_segmented_bar.dart';
import '../base_view.dart';

class SavedCategory {
  String imageCategory;
  String title;
  bool isSelected;
  bool isRead;

  SavedCategory({
    required this.imageCategory,
    required this.title,
    this.isSelected = false,
    this.isRead = false,
  });
}

class PayBillsMenuView extends BaseView {
  final String? route;

  PayBillsMenuView({this.route});

  @override
  _PayBillsMenuViewState createState() => _PayBillsMenuViewState();
}

class _PayBillsMenuViewState extends BaseViewState<PayBillsMenuView> {
  var _bloc = injection<BillerManagementBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetBillerCategoryListEvent());
    _bloc.add(GetSavedBillersEvent());

    log(widget.route.toString());
  }

  bool isCat = true;
  bool isSav = false;
  bool isFav = false;

  bool isMarked = false;

  double? chargeAmount;

  List<String> tabs = [
    "Categories",
    "Saved",
    "Favourites",
  ];
  int current = 0;
  List<BillerCategoryEntity> filteredList = [];
  List<BillerCategoryEntity> SearchedfilteredCatList = [];

  List<SavedBillerEntity> savedBillers = [];
  List<SavedBillerEntity> searchSavedBillers = [];

  List<SavedBillerEntity> favoriteBillerList = [];
  List<SavedBillerEntity> searchFavoriteBillerList = [];

  List<SavedBillerEntity> filteredSaveList = [];

  final TextEditingController _controller = TextEditingController();

  initBillerData(List<BillerList> billerList) {
    savedBillers.addAll(
      billerList
          .map(
            (e) => SavedBillerEntity(
              id: e.id,
              value: e.value,
              nickName: e.nickName,
              //userId: e.userId,
              referenceNumber: e.referenceNumber,
              billerCategory: BillerCategoryEntity(
                  categoryName: e.categoryName,
                  categoryCode: e.categoryCode,
                  categoryId: e.categoryId),
              serviceProvider: BillerEntity(
                  billerId: e.serviceProviderId,
                  billerName: e.serviceProviderName,
                  billerCode: e.serviceProviderCode,
                  billerImage: e.imageUrl),
              chargeCodeEntity: ChargeCodeEntity(
                  chargeAmount: e.serviceCharge, chargeCode: e.categoryCode),
              isFavorite: e.isFavourite,
            ),
          )
          .toList(),
    );
  }

  initFvBillerData(List<BillerList> billerList) {
    favoriteBillerList.addAll(
      billerList
          .map(
            (e) => SavedBillerEntity(
              id: e.id,
              value: e.value,
              nickName: e.nickName,
              //userId: e.userId,
              referenceNumber: e.referenceNumber,
              billerCategory: BillerCategoryEntity(
                  categoryName: e.categoryName,
                  categoryCode: e.categoryCode,
                  categoryId: e.categoryId),
              serviceProvider: BillerEntity(
                  billerId: e.serviceProviderId,
                  billerName: e.serviceProviderName,
                  billerCode: e.serviceProviderCode,
                  billerImage: e.imageUrl),
              chargeCodeEntity: ChargeCodeEntity(
                  chargeAmount: e.serviceCharge, chargeCode: e.categoryCode),
              isFavorite: e.isFavourite,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("bill_payments"),
        goBackEnabled: true,
      ),
      body: BlocProvider<BillerManagementBloc>(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (_, state) {
            if (state is GetBillerCategorySuccessState) {
              filteredList = state.billerCategoryList!
                  .where((biller) => biller.categoryName!
                      .toLowerCase()
                      .contains(_controller.text.toLowerCase())).toSet()
                  .toList();
              SearchedfilteredCatList = filteredList;
              setState(() {});
            } else if (state is GetBillerCategoryListFailedState) {
              return;
            } else if (state is GetSavedBillersSuccessState) {
              savedBillers.clear();
              state.response!.billerList!.forEach((element) {
                element.billerIsFave = element.isFavourite! ? 0 : 1;
              });
              state.response!.billerList!
                  .sort((a, b) => a.billerIsFave!.compareTo(b.billerIsFave!));

              ///sort alphabitic oder
              // Sort all Billers with priority to favorites and then alphabetically
              state.response!.billerList!.sort((a, b) {
                if (a.isFavourite! && !b.isFavourite!) {
                  return -1; // a comes before b
                } else if (!a.isFavourite! && b.isFavourite!) {
                  return 1; // b comes before a
                } else {
                  return a.nickName!
                      .toLowerCase()
                      .compareTo(b.nickName!.toLowerCase());
                  //return a.nickName!.compareTo(b.nickName!); // Alphabetical order if both are favorites or both are not favorites
                }
              });
              // Sort favorite Billers alphabetically
              state.response!.favoriteBillerList!.sort((a, b) => a.nickName!
                  .toLowerCase()
                  .compareTo(b.nickName!.toLowerCase()));
              // Clear and initialize allBillerList and favoriteBillerList
              searchSavedBillers.clear();
              initBillerData(state.response!.billerList!);
              filteredSaveList = savedBillers
                  .where((biller) => biller.nickName!
                      .toLowerCase()
                      .contains(_controller.text.toLowerCase())).toSet()
                  .toList();
              initFvBillerData(state.response!.favoriteBillerList!);
              searchSavedBillers = savedBillers;
              searchFavoriteBillerList = favoriteBillerList;
              setState(() {});
            } else if (state is GetSavedBillersFailedState) {
              setState(() {
                savedBillers.clear();
              });
              return;
            }
          },
          child: Stack(
            children: [
              (current == 1 && savedBillers.isEmpty)?  Center(
                child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colors(context).secondaryColor300,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: PhosphorIcon(
                              PhosphorIcons.fileText(PhosphorIconsStyle.bold),
                              color: colors(context).whiteColor,
                              size: 28,
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        Text(
                          AppLocalizations.of(context).translate("no_saved_billers"),
                          textAlign: TextAlign.center,
                          style: size18weight700.copyWith(color: colors(context).blackColor),
                        ),
                        4.verticalSpace,
                        Text(
                          AppLocalizations.of(context).translate("no_saved_billers_des"),
                          textAlign: TextAlign.center,
                          style: size14weight400.copyWith(color: colors(context).greyColor300),
                        ),
                      ],
                    ),
              ):(current == 2 && favoriteBillerList.isEmpty)?Center(
                child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: colors(context).secondaryColor300,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: PhosphorIcon(
                              PhosphorIcons.fileText(PhosphorIconsStyle.bold),
                              color: colors(context).whiteColor,
                              size: 28,
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        Text(
                          AppLocalizations.of(context).translate("no_favourite_billers"),
                          textAlign: TextAlign.center,
                          style: size18weight700.copyWith(color: colors(context).blackColor),
                        ),
                        4.verticalSpace,
                        Text(
                          AppLocalizations.of(context).translate("no_favourite_billers_des"),
                          textAlign: TextAlign.center,
                          style: size14weight400.copyWith(color: colors(context).greyColor300),
                        ),
                      ],
                    ),
              ):SizedBox.shrink(),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 44,
                      child: SlidingSegmentedBar(
                        borderRadius: BorderRadius.circular(8).r,
                        selectedTextStyle: size14weight700.copyWith(
                            color: colors(context).whiteColor),
                        textStyle: size14weight700.copyWith(
                            color: colors(context).blackColor),
                        backgroundColor: colors(context).whiteColor,
                        // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        onChanged: (int value) {
                          setState(() {
                            current = value;
              
                            SearchedfilteredCatList = filteredList;
                            searchSavedBillers = savedBillers;
                            searchFavoriteBillerList = favoriteBillerList;
                            _controller.clear();
                          });
                        },
                        selectedIndex: current,
                        children: [
                          AppLocalizations.of(context).translate("categories"),
                          AppLocalizations.of(context).translate("saved"),
                          AppLocalizations.of(context).translate("favourites"),
                        ],
                      ),
                    ),
                    16.verticalSpace,
                    if (current == 0)
                      Expanded(
                        child: Column(
                          children: [
                            _buildTextField(),
                            24.verticalSpace,
                            Expanded(
                              child: SingleChildScrollView(
                                key: Key("cat"),
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8).r,
                                          color: colors(context).whiteColor),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                                horizontal: 16)
                                            .w,
                                        child: ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: SearchedfilteredCatList.length,
                                           padding: EdgeInsets.zero,
                                          itemBuilder: (_, index) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              PayBillsComponent(
                                                billerCategoryEntity:
                                                    SearchedfilteredCatList[index],
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    Routes.kBillPaymentBillersView,
                                                    arguments:
                                                        BillPaymentBillersViewArgs(
                                                      route: widget.route!,
                                                      biller:
                                                          SearchedfilteredCatList[
                                                              index],
                                                      chargeAmount: chargeAmount,
                                                    ),
                                                  );
                                                },
                                              ),
                                              if (SearchedfilteredCatList.length -
                                                      1 !=
                                                  index)
                                                Divider(
                                                  thickness: 1,
                                                  height: 0,
                                                  color:
                                                      colors(context).greyColor100,
                                                )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    20.verticalSpace,
                                    AppSizer.verticalSpacing(
                                        AppSizer.getHomeIndicatorStatus(context)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (current == 1)
                      Expanded(
                        child: Column(
                          children: [
                            if (savedBillers.isNotEmpty)
                              Column(
                                children: [
                                  _buildTextField(),
                                  24.verticalSpace,
                                ],
                              ),
                            savedBillers.isNotEmpty
                                ? Expanded(
                                    child: SingleChildScrollView(
                                      key: Key("saved"),
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8).r,
                                                color: colors(context).whiteColor),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                      horizontal: 16)
                                                  .w,
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                 padding: EdgeInsets.zero,
                                                itemCount:
                                                    searchSavedBillers.length,
                                                itemBuilder: (_, index) => Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        BillerComponent(
                                                          savedBillerEntity:
                                                              searchSavedBillers[
                                                                  index],
                                                          onLongPress: () {},
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                              context,
                                                              Routes
                                                                  .kBillPaymentProcessView,
                                                              arguments:
                                                                  BillPaymentViewArgs(
                                                                savedBillerEntity:
                                                                    searchSavedBillers[
                                                                        index],
                                                                route:
                                                                    widget.route!,
                                                                billerEntity:
                                                                    searchSavedBillers[
                                                                            index]
                                                                        .serviceProvider,
                                                                isSaved: true,
                                                                billerCategoryEntity:
                                                                    searchSavedBillers[
                                                                            index]
                                                                        .billerCategory,
                                                                chargeAmount: searchSavedBillers[
                                                                            index]
                                                                        .chargeCodeEntity
                                                                        ?.chargeAmount ??
                                                                    0.0,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        if (searchSavedBillers
                                                                    .length -
                                                                1 !=
                                                            index)
                                                          Divider(
                                                            height: 0,
                                                            thickness: 1,
                                                            color: colors(context)
                                                                .greyColor100,
                                                          )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                         20.verticalSpace,
                                      AppSizer.verticalSpacing(
                                        AppSizer.getHomeIndicatorStatus(context)),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    if (current == 2)
                      Expanded(
                        child: Column(
                          children: [
                            if (favoriteBillerList.isNotEmpty)
                              Column(
                                children: [
                                  _buildTextField(),
                                  24.verticalSpace,
                                ],
                              ),
                            favoriteBillerList.isNotEmpty
                                ? Expanded(
                                    child: SingleChildScrollView(
                                       key: Key("favourite"),
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8).r,
                                                color: colors(context).whiteColor),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                      horizontal: 16)
                                                  .w,
                                              child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                 padding: EdgeInsets.zero,
                                                itemCount:
                                                    searchFavoriteBillerList.length,
                                                itemBuilder: (_, index) => Column(
                                                  children: [
                                                    BillerComponent(
                                                      savedBillerEntity:
                                                          searchFavoriteBillerList[
                                                              index],
                                                      onLongPress: () {},
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                          context,
                                                          Routes
                                                              .kBillPaymentProcessView,
                                                          arguments:
                                                              BillPaymentViewArgs(
                                                            savedBillerEntity:
                                                                searchFavoriteBillerList[
                                                                    index],
                                                            route: widget.route!,
                                                            billerEntity:
                                                                searchFavoriteBillerList[
                                                                        index]
                                                                    .serviceProvider,
                                                            isSaved: true,
                                                            billerCategoryEntity:
                                                                searchFavoriteBillerList[
                                                                        index]
                                                                    .billerCategory,
                                                            chargeAmount:
                                                                searchFavoriteBillerList[
                                                                            index]
                                                                        .chargeCodeEntity
                                                                        ?.chargeAmount ??
                                                                    0.0,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    if (searchFavoriteBillerList
                                                                .length -
                                                            1 !=
                                                        index)
                                                      Divider(
                                                        height: 0,
                                                        thickness: 1,
                                                        color: colors(context)
                                                            .greyColor100,
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          20.verticalSpace,
                                    AppSizer.verticalSpacing(
                                        AppSizer.getHomeIndicatorStatus(context)),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      )
                  ],
                ),
              ),
           Visibility(
                visible: (current == 1 || current == 2),
                child: Positioned(
                  bottom: 64.0 + AppSizer.getHomeIndicatorStatus(context),
                  right: 20,
                  child: InkWell(
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          Routes.kBillersView,
                          arguments: Routes.kPayBillsMenuView,
                        ).then((value) {
                          _bloc.add(GetBillerCategoryListEvent());
                          _bloc.add(GetSavedBillersEvent());
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors(context).primaryColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: PhosphorIcon(
                                    PhosphorIcons.plus(PhosphorIconsStyle.bold),
                                    size: 28,
                                    color: colors(context).whiteColor,
                                  ),
                                ))),
                      ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return SearchTextField(
      textEditingController: _controller,
      hintText: AppLocalizations.of(context).translate("search"),
      isBorder: false,
      onChange: (value) {
        setState(() {
          if (current == 0) {
            searchFromCat(value);
          } else if (current == 1) {
            searchFromListAll(value);
          } else if (current == 2) {
            searchFromFavList(value);
          }
        });
      },
    );
  }

  void searchFromCat(String message) {
    if (message.trim().isEmpty) {
      SearchedfilteredCatList = filteredList;
    } else {
      SearchedfilteredCatList = filteredList
          .where((element) => element.categoryName!
              .toLowerCase()
              .contains(message.toLowerCase())).toSet()
          .toList();
    }
    setState(() {});
  }

  void searchFromListAll(String message) {
    if (message.trim().isEmpty) {
      searchSavedBillers = savedBillers;
    } else {
      searchSavedBillers = savedBillers
          .where((element) =>
              element.nickName!.toLowerCase().contains(message.toLowerCase())).toSet()
          .toList();
    }
    setState(() {});
  }

  void searchFromFavList(String message) {
    if (message.trim().isEmpty) {
      searchFavoriteBillerList = favoriteBillerList;
    } else {
      searchFavoriteBillerList = favoriteBillerList
          .where((element) =>
              element.nickName!.toLowerCase().contains(message.toLowerCase())).toSet()
          .toList();
    }
    setState(() {});
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
