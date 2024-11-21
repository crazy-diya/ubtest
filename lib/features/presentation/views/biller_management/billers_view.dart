// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/bill_payment/widgets/biller_component.dart';
import 'package:union_bank_mobile/features/presentation/views/biller_management/pay_bill_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
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
import '../../widgets/text_fields/app_search_text_field.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';
import 'more_details_add_biller_view.dart';

class SavedBillerData {
  String image;
  String nickname;
  String accountNumber;

  //bool isSelected;
  bool isRead;

  SavedBillerData({
    required this.image,
    required this.nickname,
    required this.accountNumber,
    //this.isSelected = false,
    this.isRead = false,
  });
}

class BillersView extends BaseView {
  // final SavedBillerEntity? savedBillerEntity;
  final String? route;

  BillersView({
    this.route,
  });

  @override
  _BillersViewState createState() => _BillersViewState();
}

class _BillersViewState extends BaseViewState<BillersView> {
  var _bloc = injection<BillerManagementBloc>();
  bool? isSelected;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetSavedBillersEvent());
  }

  List<String> tabs = [
    "All",
    "Favourites",
  ];
  int current = 0;

  List<SavedBillerEntity> allBillerList = [];
  List<SavedBillerEntity> searchedAllBillerList = [];

  List<SavedBillerEntity> favoriteBillerList = [];
  List<SavedBillerEntity> searchedFavoriteBillerList = [];

  List<String> selectedallBillerList = [];
  List<String> selectedfavoriteBillerList = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerSearch = TextEditingController();
  final FocusNode _focusNodeSearch = FocusNode();

  String message = '';

  initBillerData(List<BillerList> billerList, bool isAll) {
    isAll
        ? allBillerList.addAll(addData(billerList))
        : favoriteBillerList.addAll(addData(billerList));
  }

  List<SavedBillerEntity> addData(List<BillerList> billerList) {
    return billerList
        .map(
          (e) => SavedBillerEntity(
            id: e.id,
            nickName: e.nickName,
            value: e.value,
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
        .toList();
  }

  bool getUnselectStatus() {
    return (favoriteBillerList.map((e) => e.value!).length ==
            selectedfavoriteBillerList.length) ||
        (allBillerList.map((e) => e.value).length ==
            selectedallBillerList.length);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        actions: [
          if (searchedAllBillerList.any((element) => element.isSelected) ||
              searchedFavoriteBillerList.any((element) => element.isSelected))
            IconButton(
                onPressed: () {
                  showAppDialog(
                      alertType: AlertType.DELETE,
                      isSessionTimeout: true,
                      title: AppLocalizations.of(context).translate("delete_biller"),
                      message:
                      selectedallBillerList.length == 1 || selectedfavoriteBillerList.length == 1 ?
                          AppLocalizations.of(context).translate("delete_biller_des_1") :
                          "${AppLocalizations.of(context).translate("delete_biller_des_2")} \n${current == 0 ? selectedallBillerList.length : selectedfavoriteBillerList.length} ${AppLocalizations.of(context).translate("delete_biller_des_3")}",
                      negativeButtonText: AppLocalizations.of(context).translate("no"),
                      positiveButtonText: AppLocalizations.of(context).translate("yes_delete"),
                      onPositiveCallback: () {
                        _bloc.add(DeleteBillerEvent(
                            deleteAccountList: current == 0
                                ? selectedallBillerList
                                    .map((e) => int.parse(e))
                                    .toList()
                                : selectedfavoriteBillerList
                                    .map((e) => int.parse(e))
                                    .toList()));
                      });
                },
                icon:
                    PhosphorIcon(PhosphorIcons.trash(PhosphorIconsStyle.bold)))
        ],
        title: AppLocalizations.of(context).translate("billers"),
      ),
      body: BlocProvider<BillerManagementBloc>(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {
            if (state is GetSavedBillersSuccessState) {
              ///All List
              allBillerList.clear();
              for (var element in state.response!.billerList!) {
                element.billerIsFave = element.isFavourite! ? 1 : 0;
              }
              state.response!.billerList!
                  .sort((a, b) => a.billerIsFave!.compareTo(b.billerIsFave!));
              initBillerData(state.response!.billerList!, true);

              //state.response!.billerList!.sort((a, b) => a.nickName!.toLowerCase().compareTo(b.nickName!.toLowerCase()));

              ///Favourite List
              favoriteBillerList.clear();
              for (var element in state.response!.favoriteBillerList!) {
                element.billerIsFave = element.isFavourite! ? 0 : 1;
              }
              state.response!.favoriteBillerList!
                  .sort((a, b) => a.billerIsFave!.compareTo(b.billerIsFave!));
              initBillerData(state.response!.favoriteBillerList!, false);
              setState(() {});

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
              allBillerList.clear();
              initBillerData(state.response!.billerList!, true);
              favoriteBillerList.clear();
              initBillerData(state.response!.favoriteBillerList!, false);

              searchedAllBillerList = allBillerList;
              searchedFavoriteBillerList = favoriteBillerList;

              if (current == 0) {
                if (message.isNotEmpty) {
                  searchFromListAll(message);
                }
              }
              if (current == 1) {
                if (message.isNotEmpty) {
                  searchFromFavList(message);
                }
              }

              setState(() {});
            }
            if (state is GetSavedBillersFailedState) {
              // isDeleteAvailable = false;
              setState(() {
                allBillerList.clear();
                favoriteBillerList.clear();
              });
            }
            if (state is DeleteBillerSuccessState) {
              selectedfavoriteBillerList.clear();
              selectedallBillerList.clear();
              Navigator.pushNamed(context, Routes.kOtpView,
                      arguments: OTPViewArgs(
                          phoneNumber:
                              AppConstants.profileData.mobileNo.toString(),
                          appBarTitle: 'otp_verification',
                          requestOTP: true,
                          otpType: kBillerMange,
                          // successFieldIds: state.id,
                          ids: state.id!,
                          action: "delete"))
                  .then((value) {
                if (value == true) {
                  ToastUtils.showCustomToast(
                      context, state.message.toString(), ToastStatus.SUCCESS);
                  _bloc.add(GetSavedBillersEvent());
                }
              });
            }
            if (state is FavouriteBillerSuccessState) {
              _bloc.add(GetSavedBillersEvent());
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Stack(
              children: [
              (current == 0 && allBillerList.isEmpty)?  Center(
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
              ):(current == 1 && favoriteBillerList.isEmpty)?Center(
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
                Column(
                  children: [
                    24.verticalSpace,
                    SizedBox(
                      height: 44,
                      child: SlidingSegmentedBar(
                        selectedTextStyle: size14weight700.copyWith(
                            color: colors(context).whiteColor),
                        textStyle: size14weight700.copyWith(
                            color: colors(context).blackColor),
                        backgroundColor: colors(context).whiteColor,
                        onChanged: (int value) {
                          current = value;
                          message = '';
                          searchedAllBillerList.forEach((element) {
                            element.isSelected = false;
                          });
                          searchedFavoriteBillerList.forEach((element) {
                            element.isSelected = false;
                          });
                          _controller.clear();
                          _controllerSearch.clear();
                          _focusNodeSearch.unfocus();
                          selectedfavoriteBillerList.clear();
                          selectedallBillerList.clear();
                          searchedAllBillerList = allBillerList;
                          searchedFavoriteBillerList = favoriteBillerList;
                          setState(() {});
                        },
                        selectedIndex: current,
                        children: [
                          AppLocalizations.of(context).translate("all"),
                          AppLocalizations.of(context).translate("favourites"),
                        ],
                      ),
                    ),
                    16.verticalSpace,
                    Expanded(
                      child: Column(
                        children: [
                          if ((current == 0 && allBillerList.isNotEmpty) ||
                              (current == 1 && favoriteBillerList.isNotEmpty))
                            SearchTextField(
                              textEditingController: _controllerSearch,
                              focusNode: _focusNodeSearch,
                              hintText: AppLocalizations.of(context)
                                  .translate("search"),
                              isBorder: false,
                              onChange: (value) {
                                message = value;
                                setState(() {
                                  if (current == 0) {
                                    searchFromListAll(message);
                                  } else if (current == 1) {
                                    searchFromFavList(message);
                                  }
                                });
                              },
                            ),
                          24.verticalSpace,
                         if(current == 0 && allBillerList.isNotEmpty) Expanded(
                            child: SingleChildScrollView(
                              key: Key("all"),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                                child: Column(
                                  children: [
                                    Column(
                                            children: [
                                              Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(8)
                                                              .r,
                                                      color: colors(context)
                                                          .whiteColor,
                                                    ),
                                                    child: ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            searchedAllBillerList
                                                                .length,
                                                        shrinkWrap: true,
                                                        padding: EdgeInsets.zero,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final allBill =
                                                              searchedAllBillerList[
                                                                  index];
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                        16,
                                                                        0,
                                                                        16,
                                                                        0)
                                                                    .w,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    if (searchedAllBillerList.any(
                                                                        (element) =>
                                                                            element.isSelected))
                                                                      Padding(
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                                8,
                                                                                0,
                                                                                20,
                                                                                0)
                                                                            .w,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              20.w,
                                                                          height:
                                                                              20.w,
                                                                          child:
                                                                              Checkbox(
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(1).r),
                                                                            checkColor:
                                                                                colors(context).whiteColor,
                                                                            activeColor:
                                                                                colors(context).primaryColor,
                                                                            value:
                                                                                searchedAllBillerList[index].isSelected,
                                                                            onChanged:
                                                                                (value) {
                                                                              searchedAllBillerList[index].isSelected = !searchedAllBillerList[index].isSelected;
                                                                              if (selectedallBillerList.isNotEmpty) {
                                                                                if (selectedallBillerList.any((element) => element == allBill.id.toString())) {
                                                                                  selectedallBillerList.remove(allBill.id.toString());
                                                                                  searchedAllBillerList[index].isSelected = false;
                                                                                } else {
                                                                                  selectedallBillerList.add(allBill.id.toString());
                                                                                  searchedAllBillerList[index].isSelected = true;
                                                                                }
                                                                                setState(() {});
                                                                              }
                                                                              setState(() {});
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    Expanded(
                                                                      child:
                                                                          BillerComponent(
                                                                        onTap:
                                                                            () {
                                                                          // if (selectedallBillerList.isNotEmpty) {
                                                                          //   if (selectedallBillerList.any(
                                                                          //           (element) => element == allBill.id.toString()
                                                                          //   )) {
                                                                          //     selectedallBillerList.remove(allBill.id.toString());
                                                                          //     searchedAllBillerList[index].isSelected = false;
                                                                          //   } else {
                                                                          //     selectedallBillerList.add(allBill.id.toString());
                                                                          //   }
                                                                          //   setState(() {});
                                                                          // }
                                                                        },
                                                                        onFavorite:
                                                                            (val) {
                                                                          _bloc.add(
                                                                              FavouriteBillerEvent(
                                                                            billerId:
                                                                                searchedAllBillerList[index].id,
                                                                            messageType:
                                                                                kBillerFavReq,
                                                                            isFavourire: searchedAllBillerList[index].isFavorite == true
                                                                                ? false
                                                                                : true,
                                                                          ));
                                                                          //_bloc.add();
                                                                        },
                                                                        isSelected: selectedallBillerList.any((element) =>
                                                                            element ==
                                                                            allBill.id.toString()),
                                                                        //allBill.customFieldEntityList?.first.customFieldId
                                                                        onPressed:
                                                                            () async {
                                                                          if (selectedallBillerList
                                                                              .isNotEmpty) {
                                                                            if (selectedallBillerList.any((element) =>
                                                                                element ==
                                                                                allBill.id.toString())) {
                                                                              selectedallBillerList.remove(allBill.id.toString());
                                                                              searchedAllBillerList[index].isSelected = false;
                                                                            } else {
                                                                              selectedallBillerList.add(allBill.id.toString());
                                                                              searchedAllBillerList[index].isSelected = true;
                                                                            }
                                                                            setState(() {});
                                                                          } else {
                                                                            setState(() {});
                                                                            selectedallBillerList.clear();
                                                                            setState(() {});
                                                                            final result = await Navigator.pushNamed(context,
                                                                                Routes.kEditBillerMoreDetailsView,
                                                                                arguments: EditBillerDetailsViewArgs(
                                                                                  route: widget.route!,
                                                                                  isEditView: true,
                                                                                  savedBillerEntity: allBill,
                                                                                  billerId: searchedAllBillerList[index].id!.toInt(),
                                                                                  //billerId: allBill.id!,
                                                                                ));
                                                                            if (result ==
                                                                                true) {
                                                                              // bloc.add(GetViewMailEvent(page: 0,size: 100,readStatus: selectedFilter));
                                                                            }
                                                                          }
                                                                        },
                                                                        savedBillerEntity:
                                                                            searchedAllBillerList[index],
                                                                        onLongPress:
                                                                            () {
                                                                          searchedAllBillerList[index].isSelected =
                                                                              true;
                                                                          if (selectedallBillerList
                                                                              .isEmpty) {
                                                                            if (!selectedallBillerList.any((element) =>
                                                                                element ==
                                                                                allBill.id)) {
                                                                              // allBill.customFieldEntityList?.first.customFieldId
                                                                              selectedallBillerList.add(allBill.id.toString());
                                                                              //allBill.customFieldEntityList!.first.customFieldId!
                                                                            }
                                                                          }
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                if (searchedAllBillerList
                                                                            .length -
                                                                        1 !=
                                                                    index)
                                                                  Divider(
                                                                    thickness: 1,
                                                                    height: 0,
                                                                    color: colors(
                                                                            context)
                                                                        .greyColor100,
                                                                  )
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                  )
                                            ],
                                          )
                                    
                                  ],
                                ),
                              ),
                            ),
                          ),
                         if(current == 1 && favoriteBillerList.isNotEmpty) 
                          Expanded(
                            child: SingleChildScrollView(
                              key: Key("favourite"),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                                child: Column(
                                  children: [
                                    Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8)
                                                      .r,
                                              color: colors(context)
                                                  .whiteColor,
                                            ),
                                            child: Column(
                                              children: [
                                                ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      searchedFavoriteBillerList
                                                          .length,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final favoriteBill =
                                                        searchedFavoriteBillerList[
                                                            index];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets
                                                                  .fromLTRB(
                                                                  16,
                                                                  0,
                                                                  16,
                                                                  0)
                                                              .w,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              if (searchedFavoriteBillerList.any(
                                                                  (element) =>
                                                                      element.isSelected))
                                                                Padding(
                                                                  padding: const EdgeInsets.fromLTRB(
                                                                          8,
                                                                          0,
                                                                          20,
                                                                          0)
                                                                      .w,
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        20.w,
                                                                    height:
                                                                        20.w,
                                                                    child:
                                                                        Checkbox(
                                                                      shape:
                                                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(1).r),
                                                                      checkColor:
                                                                          colors(context).whiteColor,
                                                                      activeColor:
                                                                          colors(context).primaryColor,
                                                                      value:
                                                                          searchedFavoriteBillerList[index].isSelected,
                                                                      onChanged:
                                                                          (value) {
                                                                        searchedFavoriteBillerList[index].isSelected = !searchedFavoriteBillerList[index].isSelected;
                                                                        if (selectedfavoriteBillerList.isNotEmpty) {
                                                                          if (selectedfavoriteBillerList.any((element) => element == favoriteBill.id.toString())) {
                                                                            selectedfavoriteBillerList.remove(favoriteBill.id.toString());
                                                                            searchedFavoriteBillerList[index].isSelected = false;
                                                                          } else {
                                                                            selectedfavoriteBillerList.add(favoriteBill.id.toString());
                                                                            searchedFavoriteBillerList[index].isSelected = true;
                                                                          }
                                                                          setState(() {});
                                                                        }
                                                                        setState(() {});
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              Expanded(
                                                                child:
                                                                    BillerComponent(
                                                                  onFavorite:
                                                                      (val) {
                                                                    _bloc.add(
                                                                        FavouriteBillerEvent(
                                                                      billerId:
                                                                          searchedFavoriteBillerList[index].id,
                                                                      messageType: searchedFavoriteBillerList[index].isFavorite == true
                                                                          ? kBillerFavReq
                                                                          : kBillerUnFavReq,
                                                                      isFavourire: searchedFavoriteBillerList[index].isFavorite == true
                                                                          ? false
                                                                          : true,
                                                                    ));
                                                                  },
                                                                  isSelected: selectedfavoriteBillerList.any((element) =>
                                                                      element ==
                                                                      favoriteBill.id.toString()),
                                                                  onPressed:
                                                                      () async {
                                                                    if (selectedfavoriteBillerList
                                                                        .isNotEmpty) {
                                                                      if (selectedfavoriteBillerList.any((element) =>
                                                                          element ==
                                                                          favoriteBill.id.toString())) {
                                                                        selectedfavoriteBillerList.remove(favoriteBill.id.toString());
                                                                        searchedFavoriteBillerList[index].isSelected = false;
                                                                      } else {
                                                                        selectedfavoriteBillerList.add(favoriteBill.id.toString());
                                                                        searchedFavoriteBillerList[index].isSelected = true;
                                                                      }
                                                                      setState(() {});
                                                                    } else {
                                                                      setState(() {});
                                                                      selectedfavoriteBillerList.clear();
                                                                      setState(() {});
                                                                      final result = await Navigator.pushNamed(context,
                                                                          Routes.kEditBillerMoreDetailsView,
                                                                          arguments: EditBillerDetailsViewArgs(route: widget.route!, billerId: searchedFavoriteBillerList[index].id!.toInt(), isEditView: true, savedBillerEntity: favoriteBill));
                                                                      if (result ==
                                                                          true) {
                                                                        // bloc.add(GetViewMailEvent(page: 0,size: 100,readStatus: selectedFilter));
                                                                      }
                                                                    }
                                                                  },
                                                                  savedBillerEntity:
                                                                      searchedFavoriteBillerList[index],
                                                                  onLongPress:
                                                                      () {
                                                                    searchedFavoriteBillerList[index].isSelected =
                                                                        true;
                                                                    if (selectedfavoriteBillerList
                                                                        .isEmpty) {
                                                                      if (!selectedfavoriteBillerList.any((element) =>
                                                                          element ==
                                                                          favoriteBill.id)) {
                                                                        selectedfavoriteBillerList.add(favoriteBill.id.toString());
                                                                      }
                                                                    }
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          if (searchedFavoriteBillerList
                                                                      .length -
                                                                  1 !=
                                                              index)
                                                            Divider(
                                                              thickness: 1,
                                                              height: 0,
                                                              color: colors(
                                                                      context)
                                                                  .greyColor100,
                                                            )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 64.0+AppSizer.getHomeIndicatorStatus(context),
                  right:0 ,
                  child: InkWell(
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        Routes.kPayBillView,
                        arguments: PayBillerData(routeType: widget.route!),
                      );
                      //     .then((value) {
                      //   _bloc!.add(GetSavedBillersEvent());
                      // });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors(context).primaryColor),
                        child: Padding(
                          padding: const EdgeInsets.all(14).w,
                          child: PhosphorIcon(
                            PhosphorIcons.plus(PhosphorIconsStyle.bold),
                            color: colors(context).whiteColor,
                            size: 28,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return LayoutBuilder(builder: (context, size) {
      final TextSpan text = TextSpan(
        text: _controller.text,
      );
      final TextPainter tp = TextPainter(
        text: text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
      );
      tp.layout(maxWidth: size.maxWidth);

      final int lines = (tp.size.height / tp.preferredLineHeight).ceil();
      const int maxLines = 1;

      return Scrollbar(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            // Hide the default border
            hintText: AppLocalizations.of(context).translate("search"),
            hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            suffixIcon: Icon(Icons.search, color: colors(context).blackColor),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
          scrollPhysics: const BouncingScrollPhysics(),
          controller: _controller,
          // maxLines: lines < maxLines ? null : maxLines,
          contextMenuBuilder: (context, editableTextState) {
            return SizedBox.shrink();
          },
          onChanged: (value) {
            message = value;
            setState(() {
              if (current == 0) {
                searchFromListAll(message);
              } else if (current == 1) {
                searchFromFavList(message);
              }
            });
          },

          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: colors(context).blackColor),
        ),
      );
    });
  }

  void searchFromListAll(String message) {
    if (message.trim().isEmpty) {
      searchedAllBillerList = allBillerList;
    } else {
      searchedAllBillerList = allBillerList
          .where((element) =>
              element.nickName!.toLowerCase().contains(message.toLowerCase())).toSet()
          .toList();
    }
    setState(() {});
  }

  void searchFromFavList(String message) {
    if (message.trim().isEmpty) {
      searchedFavoriteBillerList = favoriteBillerList;
    } else {
      searchedFavoriteBillerList = favoriteBillerList
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
