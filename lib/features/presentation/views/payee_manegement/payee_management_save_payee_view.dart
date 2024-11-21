import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/payee_manegement/data/saved_payee_list.dart';
import 'package:union_bank_mobile/features/presentation/views/payee_manegement/widget/saved_payee_component.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/pop_scope/ub_pop_scope.dart';
import 'package:union_bank_mobile/features/presentation/widgets/sliding_segmented_bar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_search_text_field.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/model/bank_icons.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/saved_payee_entity.dart';
import '../../bloc/payee_management/payee_management_bloc.dart';
import '../../bloc/payee_management/payee_management_event.dart';
import '../../bloc/payee_management/payee_management_state.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';

class PayeeManagementSavedPayeeViewArgs {
  final bool isFromFundTransfer;

  PayeeManagementSavedPayeeViewArgs({
    this.isFromFundTransfer = false,
  });
}

class PayeeManagementSavedPayeeView extends BaseView {
  final PayeeManagementSavedPayeeViewArgs? payeeManagementSavedPayeeViewArgs;

  //final SavedPayeeEntity? payeeDetails;
  PayeeManagementSavedPayeeView({
    this.payeeManagementSavedPayeeViewArgs,
  });

  @override
  _PayeeManagementSavedPayeeViewState createState() =>
      _PayeeManagementSavedPayeeViewState();
}

class _PayeeManagementSavedPayeeViewState
    extends BaseViewState<PayeeManagementSavedPayeeView> {
  var _bloc = injection<PayeeManagementBloc>();
  final searchController = TextEditingController();
  final FocusNode _focusNodeSearch = FocusNode();
  bool isDeleteAvailable = false;
  String _searchString = '';
  List<SavedPayeeEntity> savedPayees = [];
  List<SavedPayeeEntity> favoriteList = [];
  List<SavedPayeeEntity> selectedList = [];

  //SavedPayeeEntity? savedPayeeEntity ;

  bool isMarked = false;

  // List<String> tabs = [
  //   "All",
  //   "Favourites",
  // ];
  int current = 0;

  List<String> deleteMultipleAccount = [];

  @override
  void initState() {
    super.initState();
    _bloc.add(GetSavedPayeesEvent());
    searchController.addListener(() {
      setState(() {
        _searchString = searchController.text;
      });
    });
  }

  Widget _getItemByFavorite(int index) {
    if (current == 0) {
      return SavedPayeeComponent(
        isLastItem: (savedPayees.length - 1) == index,
        isDeleteAvailable: isDeleteAvailable,
        savedPayeeEntity: savedPayees[index],
        onFavorite: (val) {
          _bloc.add(FavoriteUnFavoritePayeeEvent(
              id: savedPayees[index].id,
              favorite: savedPayees[index].isFavorite == true ? false : true));
        },
        onTap: () {
          _onTapPayee(savedPayees[index]);
        },
        onLongTap: () {
          _onLongTapPayee(savedPayees[index]);
        },
        onDeleteItem: () {
          _onDeletePayee(savedPayees[index]);
        },
      );
    } else {
      return favoriteList[index].isFavorite
          ? SavedPayeeComponent(
              isLastItem: (favoriteList.length - 1) == index,
              isDeleteAvailable: isDeleteAvailable,
              savedPayeeEntity: favoriteList[index],
              onFavorite: (val) {
                _bloc.add(FavoriteUnFavoritePayeeEvent(
                    id: favoriteList[index].id,
                    favorite: favoriteList[index].isFavorite == true ? false : true));
              },
              onTap: () {
                _onTapPayee(favoriteList[index]);
              },
              onLongTap: () {
                _onLongTapPayee(favoriteList[index]);
              },
              onDeleteItem: () {
                _onDeletePayee(favoriteList[index]);
              },
            )
          : const SizedBox.shrink();
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
              if (widget.payeeManagementSavedPayeeViewArgs!.isFromFundTransfer) {
                 Navigator.pop(context,SavedPayeeWithList(savedPayeeEntities: savedPayees ) );
               }
               else{
                Navigator.pop(context);
               }
        return true;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          onBackPressed: () {
             if (widget.payeeManagementSavedPayeeViewArgs!.isFromFundTransfer) {
                    Navigator.pop(context,SavedPayeeWithList(savedPayeeEntities: savedPayees ) );
            }else{
                Navigator.pop(context);
               }
          },
          title: AppLocalizations.of(context).translate("saved_payee_list"),
          actions: [deleteMultipleAccount.length == 0?SizedBox.shrink():IconButton(
                onPressed: () async {
                      isDeleteAvailable
                          ? _onMultipleDeletePayee()
                          : const SizedBox.shrink();
                    },
                icon: PhosphorIcon(
                  PhosphorIcons.trash(PhosphorIconsStyle.bold),
                ))],
        ),
        body: BlocProvider(
          create: (context) => _bloc,
          child: BlocListener<PayeeManagementBloc,
              BaseState<PayeeManagementState>>(
            listener: (context, state) {
              if (state is GetSavedPayeesSuccessState) {
                setState(() {
                  savedPayees.clear();
                  favoriteList.clear();
                  state.savedPayees!.sort((a, b) => a.nickName!.compareTo(b.nickName!));
                  List<SavedPayeeEntity> favoriteItems = state.savedPayees!
                      .where((element) => element.favourite == true)
                      .map(
                        (e) => SavedPayeeEntity(
                          bankCode: e.bankCode,
                          branchCode: e.branchCode,
                          branchName: e.branchName,
                          accountNumber: e.accountNumber,
                          nickName: e.nickName,
                          bankName: e.bank,
                          isFavorite: e.favourite!,
                          payeeImageUrl:bankIcons.firstWhere((element) => element.bankCode == e.bankCode,orElse: () => BankIcon() ,).icon,
                          accountHolderName: e.name,
                          id: e.id,
                        ),
                      )
                      .toList();
      
                  List<SavedPayeeEntity> nonFavoriteItems = state.savedPayees!
                      .where((element) => element.favourite != true)
                      .map(
                        (e) => SavedPayeeEntity(
                          bankCode: e.bankCode,
                          branchCode: e.branchCode,
                          branchName: e.branchName,
                          accountNumber: e.accountNumber,
                          nickName: e.nickName,
                          bankName: e.bank,
                          isFavorite: e.favourite!,
                          payeeImageUrl: bankIcons
                              .firstWhere(
                                (element) => element.bankCode == e.bankCode,
                                orElse: () => BankIcon(),
                              )
                              .icon,
                          accountHolderName: e.name,
                          id: e.id,
                        ),
                      )
                      .toList();
      
                  favoriteItems
                      .sort((a, b) => a.nickName!.compareTo(b.nickName!));
                  nonFavoriteItems
                      .sort((a, b) => a.nickName!.compareTo(b.nickName!));
                  savedPayees.addAll(favoriteItems);
                  savedPayees.addAll(nonFavoriteItems);
                  savedPayees.forEach((element) {
                    if (element.isFavorite == true) favoriteList.add(element);
                    if (element.isSelected == true) selectedList.add(element);
                  });
                });
              }
              else if (state is DeletePayeeSuccessState) {
                setState(() {
                  setState(() {
                    Navigator.pushNamed(context, Routes.kOtpView,
                            arguments: OTPViewArgs(
                                phoneNumber:
                                    AppConstants.profileData.mobileNo.toString(),
                                appBarTitle: 'otp_verification',
                                requestOTP: true,
                                otpType: kPayeeOTPType,
                                ids: state.deletePayees
                                    ?.map((e) => e.id!)
                                    .toList(),
                                action: "delete"))
                        .then((value) {
                      if (value == true) {
                        isDeleteAvailable = false;
                        deleteMultipleAccount.clear();
                        _bloc.add(GetSavedPayeesEvent());
                        ToastUtils.showCustomToast(context,
                            state.message.toString(), ToastStatus.SUCCESS);
                      }
                    });
                  });
                });
              }
              else if (state is FavoritePayeeSuccessState) {
                _bloc.add(GetSavedPayeesEvent());
              }
              else if (state is GetSavedPayeeFailedState) {
                isDeleteAvailable = false;
                //   deleteMultipleAccount.clear();
                // setState(() { });
      
                //_bloc.add(GetSavedPayeesEvent());
                ToastUtils.showCustomToast(
                    context, state.message.toString(), ToastStatus.FAIL);
              }
              else if (state is DeletePayeeFailedState) {
                 isDeleteAvailable = false;
                deleteMultipleAccount.clear();
                setState(() {});
                ToastUtils.showCustomToast(
                    context, state.message.toString(), ToastStatus.FAIL);
              }
              else if (state is FavoritePayeeFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message.toString(), ToastStatus.FAIL);
              }
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20,right: 20,),
              child: Stack(
                children: [
                (current == 0 && savedPayees.isEmpty)?   Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: colors(context).secondaryColor300,
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: PhosphorIcon(
                              PhosphorIcons.userPlus(PhosphorIconsStyle.bold),
                              color: colors(context).whiteColor,
                              size: 28,
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        Text(
                          AppLocalizations.of(context).translate("no_saved_payees"),
                          textAlign: TextAlign.center,
                          style: size18weight700.copyWith(color: colors(context).blackColor),
                        ),
                        4.verticalSpace,
                        Text(
                          AppLocalizations.of(context).translate('you_have_not_add'),
                          textAlign: TextAlign.center,
                          style: size14weight400.copyWith(color: colors(context).greyColor),
                        )
                      ],
                    ),
                  ):(favoriteList.isEmpty && current == 1)? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: colors(context).secondaryColor300,
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: PhosphorIcon(
                              PhosphorIcons.userPlus(PhosphorIconsStyle.bold),
                              color: colors(context).whiteColor,
                              size: 28,
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        Text(
                          AppLocalizations.of(context).translate("no_favourite_payees"),
                          textAlign: TextAlign.center,
                          style: size18weight700.copyWith(color: colors(context).blackColor),
                        ),
                        4.verticalSpace,
                        Text(
                          AppLocalizations.of(context).translate('you_have_not_add_favourite'),
                          textAlign: TextAlign.center,
                          style: size14weight400.copyWith(color: colors(context).greyColor),
                        )
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
                            deleteMultipleAccount.clear();
                            savedPayees.forEach((element) {
                              element.isSelected = false;
                            });
                            isDeleteAvailable = false;
                            searchController.clear();
                            _focusNodeSearch.unfocus();
                            setState(() {
                              current = value;
                            });
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
                        child: current == 0
                            ? savedPayees.isNotEmpty
                                ? Column(
                                    children: [
                                      SearchTextField(
                                        isBorder: false,
                                        hintText: AppLocalizations.of(context)
                                            .translate("search"),
                                        textEditingController: searchController,
                                        focusNode: _focusNodeSearch,
                                        onChange: (p0) {},
                                      ),
                                      24.verticalSpace,
                                      Expanded(
                                        child: SingleChildScrollView(
                                          key: Key("o"),
                                           physics: ClampingScrollPhysics(),
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 20.h +  ((isDeleteAvailable == true && deleteMultipleAccount.length != 0)?0:AppSizer.getHomeIndicatorStatus(context))),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8).r,
                                                  color: colors(context).whiteColor),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                        horizontal: 16)
                                                    .w,
                                                child: ListView.builder(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: savedPayees.length,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder: (_, index) =>
                                                      Column(
                                                        children: [
                                                          _searchString.isEmpty
                                                              ? _getItemByFavorite(
                                                                  index)
                                                              : savedPayees[index]
                                                                      .nickName!
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          _searchString
                                                                              .toLowerCase())
                                                                  ? _getItemByFavorite(
                                                                      index)
                                                                  : const SizedBox
                                                                      .shrink(),
                  
                                                          if(savedPayees.length-1 != index)
                                                            Divider(height: 0,
                                                              thickness: 1,
                                                              color: colors(
                                                                      context)
                                                                  .greyColor100,
                                                            )
                                                        ],
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      isDeleteAvailable == true && deleteMultipleAccount.length != 0
                                          ? Column(
                                              children: [
                                                20.verticalSpace,
                                                AppButton(
                                                  buttonType:
                                                      ButtonType.PRIMARYENABLED,
                                                  buttonText:
                                                      AppLocalizations.of(context)
                                                          .translate("select_all"),
                                                  onTapButton: () {
                                                    deleteMultipleAccount.clear();
                                                    savedPayees.forEach((element) {
                                                      setState(() {
                                                        element.isSelected = true;
                                                        deleteMultipleAccount.add(
                                                            element.accountNumber!);
                                                      });
                                                    });
                                                  },
                                                ),
                                                16.verticalSpace,
                                                AppButton(
                                                    buttonColor: Colors.transparent,
                                                    buttonType:
                                                        ButtonType.OUTLINEENABLED,
                                                    buttonText:
                                                        AppLocalizations.of(context)
                                                            .translate("cancel"),
                                                    onTapButton: () {
                                                      isDeleteAvailable = false;
                                                      deleteMultipleAccount.clear();
                                                      savedPayees.forEach((element) {
                                                        element.isSelected = false;
                                                      });
                                                      setState(() {});
                                                    }),
                                                AppSizer.verticalSpacing(20+AppSizer.getHomeIndicatorStatus(context))
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  )
                                : SizedBox.shrink() 
                            : favoriteList.isNotEmpty
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SearchTextField(
                                        isBorder: false,
                                        hintText: AppLocalizations.of(context).translate("search"),
                                        textEditingController: searchController,
                                        onChange: (p0) {},
                                      ),
                                      //else
                                     24.verticalSpace,
                                      Expanded(
                                        child: SingleChildScrollView(
                                          key: Key("p"),
                                           physics: ClampingScrollPhysics(),
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 20.h +  ((isDeleteAvailable == true && deleteMultipleAccount.length != 0)?0:AppSizer.getHomeIndicatorStatus(context))),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8).r,
                                                  color: colors(context).whiteColor),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16).w,
                                                child: ListView.builder(
                                                   physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: favoriteList.length,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder: (_, index) =>
                                                      Column(
                                                        children: [
                                                          _searchString.isEmpty
                                                              ? _getItemByFavorite(index)
                                                              : favoriteList[index]
                                                                      .nickName!
                                                                      .toLowerCase()
                                                                      .contains(_searchString
                                                                          .toLowerCase())
                                                                  ? _getItemByFavorite(index)
                                                                  : const SizedBox.shrink(),
                                                            if(favoriteList.length-1 != index)
                                                            Divider(height: 0,
                                                              thickness: 1,
                                                              color: colors(context).greyColor100,
                                                            )
                  
                                                        ],
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      isDeleteAvailable == true && deleteMultipleAccount.length != 0
                                          ? Column(
                                              children: [
                                                 20.verticalSpace,
                                                AppButton(
                                                  buttonType: ButtonType.PRIMARYENABLED,
                                                  buttonText: AppLocalizations.of(context).translate("select_all"),
                                                  onTapButton: () {
                                                     deleteMultipleAccount.clear();
                                                      favoriteList.forEach((element) {
                                                        setState(() {
                                                          element.isSelected = true;
                                                            deleteMultipleAccount
                                                                .add(element.accountNumber!);
                                                         
                                                        });
                                                      });
                                                  },
                                                ),
                                                16.verticalSpace,
                                                AppButton(
                                                    buttonColor: Colors.transparent,
                                                    buttonType: ButtonType.OUTLINEENABLED,
                                                    buttonText: AppLocalizations.of(context).translate("cancel"),
                                                    onTapButton: () {
                                                      isDeleteAvailable = false;
                                                      deleteMultipleAccount.clear();
                                                      savedPayees.forEach((element) {
                                                        element.isSelected = false;
                                                      });
                                                      setState(() {});
                                                    }),
                                                    AppSizer.verticalSpacing(20+AppSizer.getHomeIndicatorStatus(context))
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  )
                                :SizedBox.shrink(),
                      ),
                    ],
                  ),
                  deleteMultipleAccount.length == 0? Positioned(
                    bottom: 64.0+AppSizer.getHomeIndicatorStatus(context),
                    right: 0,
                    child: InkWell(
                      onTap: () async {
                        Navigator.pushNamed(
                          context,
                          Routes.kPayeeManagementAddPayeeView , arguments: widget.payeeManagementSavedPayeeViewArgs!.isFromFundTransfer,
                        ).then((value) {
                          if (value != null && value is bool && value) {
                            _bloc.add(GetSavedPayeesEvent());
                          }
                        });
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
                  ):SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTapPayee(SavedPayeeEntity savedPayeeEntity) {
    if (widget.payeeManagementSavedPayeeViewArgs!.isFromFundTransfer) {
      Navigator.pop(context,SavedPayeeWithList(savedPayeeEntity:savedPayeeEntity,savedPayeeEntities: savedPayees ) );
    } else {
     
      if (isDeleteAvailable) {
        if (savedPayees.where((element) => element.isSelected).length == 1 &&
            savedPayeeEntity.isSelected == true) {
          setState(() {
            savedPayeeEntity.isSelected = false;
            isDeleteAvailable = false;
            deleteMultipleAccount.remove(savedPayeeEntity.accountNumber);
          });
        } else {
          setState(() {
            savedPayeeEntity.isSelected = !savedPayeeEntity.isSelected;

            if (savedPayeeEntity.isSelected) {
              deleteMultipleAccount.add(savedPayeeEntity.accountNumber!);
            } else if (deleteMultipleAccount
                .contains(savedPayeeEntity.accountNumber)) {
              deleteMultipleAccount.remove(savedPayeeEntity.accountNumber);
            }
          });
        }
      } else {
        Navigator.pushNamed(
          context,
          Routes.kPayeeDetailsView,
          arguments:  savedPayeeEntity,
        ).then((value) {
          if(value!=null){
            final result = value as bool;
            if(result){
              _bloc.add(GetSavedPayeesEvent());

            }
          
          }
        });
      }
    }
  }

  _onLongTapPayee(SavedPayeeEntity savedPayeeEntity) {
    if (!widget.payeeManagementSavedPayeeViewArgs!.isFromFundTransfer) {
      try {
        HapticFeedback.lightImpact();
      } catch (e) {}

      setState(() {
        isDeleteAvailable = true;

        // Clear the deleteMultipleAccount list before adding new selections
        deleteMultipleAccount.clear();

        savedPayeeEntity.isSelected = !savedPayeeEntity.isSelected;
        if (savedPayeeEntity.isSelected) {
          deleteMultipleAccount.add(savedPayeeEntity.accountNumber!);
        } else if (deleteMultipleAccount
            .contains(savedPayeeEntity.accountNumber)) {
          deleteMultipleAccount.remove(savedPayeeEntity.accountNumber);
        }
      });
    }
  }

  _onDeletePayee(SavedPayeeEntity savedPayeeEntity) {
    showAppDialog(
      title: AppLocalizations.of(context).translate("delete_schedule"),
      alertType: AlertType.DELETE,
      message: AppLocalizations.of(context).translate("delete_schedule_des"),
      positiveButtonText: AppLocalizations.of(context).translate("yes_delete"),
      negativeButtonText: AppLocalizations.of(context).translate("no"),
      onPositiveCallback: () {
        Navigator.pushNamed(context, Routes.kOtpView,
            arguments: OTPViewArgs(
              phoneNumber: AppConstants.profileData.mobileNo.toString(),
              appBarTitle: 'payee_details',
              requestOTP: true,
              otpType: kPayeeOTPType,
            )).then((value) {
          if(value != null){
            _bloc.add(DeleteFundTransferPayeeEvent(
                deleteAccountList: [savedPayeeEntity.accountNumber.toString()]));
          }
        });
      },
    );
  }

  _onMultipleDeletePayee() {
    showAppDialog(
      title: AppLocalizations.of(context).translate("delete_payee"),
      alertType: AlertType.DELETE,
      message:
      deleteMultipleAccount.length == 1 ? AppLocalizations.of(context).translate("delete_single_payee"):
      "${AppLocalizations.of(context).translate("delete_biller_des_2")}\n${deleteMultipleAccount.length} ${AppLocalizations.of(context).translate("payees")}?",
      positiveButtonText: AppLocalizations.of(context).translate("yes_delete"),
      negativeButtonText: AppLocalizations.of(context).translate("no"),
      onPositiveCallback: () {
        _bloc.add(DeleteFundTransferPayeeEvent(
            deleteAccountList: deleteMultipleAccount));

      },
    );
  }





  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
    }
