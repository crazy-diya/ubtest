import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/payee_management/payee_management_event.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/pop_scope/ub_pop_scope.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/responses/city_response.dart';
import '../../../domain/entities/response/saved_payee_entity.dart';
import '../../bloc/payee_management/payee_management_bloc.dart';
import '../../bloc/payee_management/payee_management_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/drop_down_widgets/drop_down.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../base_view.dart';
import 'add_payee_confirm_view.dart';

class PayeeManagementAddPayeeView extends BaseView {
  final bool isFromFundTransfer;

  PayeeManagementAddPayeeView(
      {this.isFromFundTransfer =
          false}); // PayeeManagementAddPayeeView({Key? key}) : super(key: key);

  @override
  _PayeeManagementAddPayeeViewState createState() =>
      _PayeeManagementAddPayeeViewState();
}

class _PayeeManagementAddPayeeViewState
    extends BaseViewState<PayeeManagementAddPayeeView> {
  var bloc = injection<PayeeManagementBloc>();
  SavedPayeeEntity savedPayeeEntity = SavedPayeeEntity();
  bool saveEnableButton = false;

  CommonDropDownResponse? selectedBank;
  CommonDropDownResponse? selectedBranch;
  bool isOtherBankSelected = false;
  String? bankName, bankCode, bankNameTemp, bankCodeTemp;
  bool isNickNameFilled = false;
  bool isBankSelected = false;
  bool isAccountNumberFilled = false;
  bool isAccountHolderNameFilled = false;
  bool isBranchSelected = false;
  List<CommonDropDownResponse>? branchList = [];
  List<CommonDropDownResponse>? searchBranchList = [];
  List<CommonDropDownResponse> searchBankList = [];
  final _formKey = GlobalKey<FormState>();
  String? branchName;
  String? branchCode;
  String? branchNameTemp;
  String? branchCodeTemp;

  @override
  void initState() {
    searchBankList = kBankList;
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        if (isNickNameFilled ||
            isBankSelected ||
            isAccountNumberFilled ||
            isAccountHolderNameFilled == true) {
          showAppDialog(
              title: AppLocalizations.of(context)
                  .translate("cancel_the_add_payee"),
              alertType: AlertType.USER3,
              message:
                  AppLocalizations.of(context).translate("cancel_the_edit_des"),
              positiveButtonText:
                  AppLocalizations.of(context).translate("yes,_cancel"),
              negativeButtonText: AppLocalizations.of(context).translate("no"),
              onPositiveCallback: () {
                Navigator.pop(context);
              });
        } else {
          Navigator.of(context).pop();
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("add_payee"),
          onBackPressed: () {
            if (isNickNameFilled ||
                isBankSelected ||
                isAccountNumberFilled ||
                isAccountHolderNameFilled == true) {
              showAppDialog(
                  title: AppLocalizations.of(context)
                      .translate("cancel_the_add_payee"),
                  alertType: AlertType.USER3,
                  message: AppLocalizations.of(context)
                      .translate("cancel_the_edit_des"),
                  positiveButtonText:
                      AppLocalizations.of(context).translate("yes,_cancel"),
                  negativeButtonText:
                      AppLocalizations.of(context).translate("no"),
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  });
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        body: BlocProvider(
          create: (context) => bloc,
          child: BlocListener<PayeeManagementBloc,
              BaseState<PayeeManagementState>>(
            bloc: bloc,
            listener: (context, state) {
              if (state is AddPayeeSuccessState) {
                Navigator.pushNamed(context, Routes.kAddPayDetailsConfirmView);
              }
              else if (state is AddPayeeFailedState) {
                AppButton(
                  buttonType: ButtonType.OUTLINEENABLED,
                  buttonText: AppLocalizations.of(context).translate("Cancel"),
                  onTapButton: () {
                    showAppDialog(
                        title: "Cancel the Fund Transfer",
                        message:
                            "Do you really want to cancel this add payee process?",
                        alertType: AlertType.WARNING,
                        onPositiveCallback: () {
                          Navigator.pushNamed(
                              context, Routes.kFundTransferView);
                        },
                        negativeButtonText: "No",
                        positiveButtonText: "Yes, Cancel");
                  },
                );
              }
              if (state is GetPayeeBranchSuccessState) {
                branchList = state.data;
                searchBranchList = branchList;
                setState(() {});
              }
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w,0.h,20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.0.h),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8).r,
                                    color: colors(context).whiteColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(16).w,
                                  child: Column(
                                    children: [
                                      AppDropDown(
                                        validator: (value) {
                                          if (savedPayeeEntity.bankName == null ||
                                              savedPayeeEntity.bankName == "") {
                                            return AppLocalizations.of(context)
                                                .translate(
                                                    "mandatory_field_msg_selection");
                                          } else {
                                            return null;
                                          }
                                        },
                                        label: AppLocalizations.of(context)
                                            .translate("bank"),
                                        labelText: AppLocalizations.of(context)
                                            .translate("Select_Bank"),
                                        onTap: () async {
                                          final result =
                                              await showModalBottomSheet<bool>(
                                                  isScrollControlled: true,
                                                  useRootNavigator: true,
                                                  useSafeArea: true,
                                                  context: context,
                                                  barrierColor: colors(context).blackColor?.withOpacity(.85),
                                                  backgroundColor: Colors.transparent,
                                                  builder: (
                                                    context,
                                                  ) =>
                                                      StatefulBuilder(builder:
                                                          (context, changeState) {
                                                        return BottomSheetBuilder(
                                                          isSearch: true,
                                                          onSearch: (p0) {
                                                            changeState(() {
                                                              if (p0.isEmpty ||
                                                                  p0 == '') {
                                                                searchBankList =
                                                                    kBankList;
                                                              } else {
                                                                searchBankList = kBankList
                                                                    .where((element) => element
                                                                        .description!
                                                                        .toLowerCase()
                                                                        .contains(
                                                                            p0.toLowerCase())).toSet()
                                                                    .toList();
                                                                
                                                                log(searchBankList.toString());
                                                              }
                                                            });
                                                          },
                                                          title: AppLocalizations
                                                                  .of(context)
                                                              .translate(
                                                                  'Select_Bank'),
                                                          buttons: [
                                                            Expanded(
                                                              child: AppButton(
                                                                  buttonType:
                                                                      ButtonType
                                                                          .PRIMARYENABLED,
                                                                  buttonText: AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          "continue"),
                                                                  onTapButton:
                                                                      () {
                                                                        
                                                                    bankCode =
                                                                        bankCodeTemp;
                                                                    bankName =
                                                                        bankNameTemp;
                                                                    savedPayeeEntity
                                                                            .bankCode =
                                                                        bankCode;
                                                                    savedPayeeEntity
                                                                            .bankName =
                                                                        bankName;
                                                                   
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            true);
                                                                            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                    changeState(
                                                                        () {});
                                                                    setState(
                                                                        () {});
                                                                  }),
                                                            ),
                                                          ],
                                                          children: [
                                                            ListView.builder(
                                                              itemCount:
                                                                  searchBankList
                                                                      .length,
                                                              shrinkWrap: true,
                                                              padding: EdgeInsets.zero,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    bankCodeTemp =
                                                                        searchBankList[
                                                                                index]
                                                                            .key;
                                                                    bankNameTemp =
                                                                        searchBankList[
                                                                                index]
                                                                            .description;
                                                                    changeState(
                                                                        () {});
                                                                  },
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                          padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:12,0,12).w,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              width:
                                                                                  48.w,
                                                                              height:
                                                                                  48.w,
                                                                              decoration:
                                                                                  BoxDecoration(borderRadius: BorderRadius.circular(8).r, border: Border.all(color: colors(context).greyColor300!)),
                                                                              child: (searchBankList[index].icon == null)
                                                                                  ? Center(
                                                                                      child: Text(
                                                                                        searchBankList[index].description?.toString().getNameInitial() ?? "",
                                                                                        style: size20weight700.copyWith(color: colors(context).primaryColor),
                                                                                      ),
                                                                                    )
                                                                                  : Center(
                                                                                      child: ClipRRect(
                                                                                        borderRadius:  BorderRadius.circular(8).r,
                                                                                        child: Image.asset(
                                                                                          searchBankList[index].icon ?? "",
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                            ),
                                                                            12.horizontalSpace,
                                                                            Expanded(
                                                                              child:
                                                                                  Text(
                                                                                searchBankList[index].description ?? "",
                                                                                style: size16weight700.copyWith(
                                                                                  color: colors(context).blackColor,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            12.horizontalSpace,
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 8).w,
                                                                              child: UBRadio<
                                                                                  dynamic>(
                                                                                value:
                                                                                    searchBankList[index].key ?? "",
                                                                                groupValue:
                                                                                    bankCodeTemp,
                                                                                onChanged:
                                                                                    (value) {
                                                                                  bankCodeTemp = value;
                                                                                  bankNameTemp = searchBankList[index].description;
                                                                                  changeState(() {});
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      if ((searchBankList.length) -
                                                                              1 !=
                                                                          index)
                                                                        Divider(
                                                                          height:
                                                                              0,
                                                                          thickness:
                                                                              1,
                                                                          color: colors(context)
                                                                              .greyColor100,
                                                                        )
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      }));

                                        searchBankList = kBankList;
                                        setState(() {
                                          isBankSelected = true;
                                          updateSaveButtonState();
                                          selectedBranch = null;
                                          branchCodeTemp = null;
                                          branchNameTemp = null;
                                          branchCode = null;
                                          branchName = null;
                                          savedPayeeEntity.branchCode = null;
                                          savedPayeeEntity.branchName = null;
                                        });
                                        if (result == true) {
                                          bloc.add(GetPayeeBankBranchEvent(
                                              bankCode: savedPayeeEntity
                                                  .bankCode
                                                  .toString()));
                                        }
                                      },
                                      initialValue: bankName,
                                    ),
                                    24.verticalSpace,
                                    AppTextField(
                                      isInfoIconVisible: false,
                                      hint: AppLocalizations.of(context)
                                          .translate("enter_account_no"),
                                      title: AppLocalizations.of(context)
                                          .translate("Account_Number"),
                                      isLabel: false,
                                      inputType: TextInputType.number,
                                      maxLength: 18,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
                                      ],
                                      onTextChanged: (value) {
                                        setState(() {
                                          savedPayeeEntity.accountNumber =
                                              value.trim();
                                          isAccountNumberFilled =
                                              value.trim().isNotEmpty;
                                          updateSaveButtonState();
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value == '') {
                                          return AppLocalizations.of(context).translate("mandatory_field_msg");
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    24.verticalSpace,
                                    AppTextField(
                                      isInfoIconVisible: false,
                                      hint: AppLocalizations.of(context)
                                          .translate("enter_name"),
                                      isLabel: false,
                                      title: AppLocalizations.of(context)
                                          .translate("account_holders_name"),
                                      textCapitalization:
                                          TextCapitalization.words,
                                      inputFormatter: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[A-Z a-z ]")),
                                      ],
                                      onTextChanged: (value) {
                                        setState(() {
                                          savedPayeeEntity.accountHolderName =
                                              value.trim();
                                          isAccountHolderNameFilled =
                                              value.trim().isNotEmpty;
                                          updateSaveButtonState();
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value == '') {
                                          return AppLocalizations.of(context).translate("mandatory_field_msg");
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    Visibility(
                                      visible: isBankSelected == true &&
                                          bankCode !=
                                              AppConstants.ubBankCode
                                                  .toString(),
                                      child: Column(
                                        children: [
                                          24.verticalSpace,
                                          AppDropDown(
                                            label: AppLocalizations.of(context)
                                                .translate("branch"),
                                            labelText:
                                                AppLocalizations.of(context)
                                                    .translate("select_branch"),
                                            onTap: () async {
                                              final result =
                                                  await showModalBottomSheet<
                                                          bool>(
                                                      isScrollControlled: true,
                                                      useRootNavigator: true,
                                                      useSafeArea: true,
                                                      context: context,
                                                      barrierColor: colors(context).blackColor?.withOpacity(.85),
                                                      backgroundColor: Colors.transparent,
                                                      builder: (
                                                        context,
                                                      ) =>
                                                          StatefulBuilder(
                                                              builder: (context,
                                                                  changeState) {
                                                            return BottomSheetBuilder(
                                                              isSearch: true,
                                                              onSearch: (p0) {
                                                                changeState(() {
                                                                  if (p0.isEmpty ||
                                                                      p0 ==
                                                                          '') {
                                                                    searchBranchList =
                                                                        branchList;
                                                                  } else {
                                                                    searchBranchList = branchList
                                                                        ?.where((element) => element
                                                                            .description!
                                                                            .toLowerCase()
                                                                            .contains(p0.toLowerCase())).toSet()
                                                                        .toList();
                                                                  }
                                                                });
                                                              },
                                                              title: AppLocalizations
                                                                      .of(
                                                                          context)
                                                                  .translate(
                                                                      'select_branch'),
                                                              buttons: [
                                                                Expanded(
                                                                  child: AppButton(
                                                                      buttonType: ButtonType.PRIMARYENABLED,
                                                                      buttonText: AppLocalizations.of(context).translate("continue"),
                                                                      onTapButton: () {
                                                                        branchCode =
                                                                            branchCodeTemp;
                                                                        branchName =
                                                                            branchNameTemp;
                                                                        savedPayeeEntity.branchCode =
                                                                            branchCode;
                                                                        savedPayeeEntity.branchName =
                                                                            branchName;
                                                                        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                        Navigator.of(context)
                                                                            .pop(true);
                                                                        changeState(
                                                                            () {});
                                                                        setState(
                                                                            () {});
                                                                      }),
                                                                ),
                                                              ],
                                                              children: [
                                                                ListView
                                                                    .builder(
                                                                  itemCount:
                                                                      searchBranchList
                                                                          ?.length,
                                                                  shrinkWrap:
                                                                      true,
                                                                  padding: EdgeInsets.zero,
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        branchCodeTemp =
                                                                            searchBranchList![index].key;
                                                                        branchNameTemp =
                                                                            searchBranchList![index].description;
                                                                        changeState(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                             padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:20,0,20).h,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    searchBranchList![index].description ?? "",
                                                                                    style: size16weight700.copyWith(
                                                                                      color: colors(context).blackColor,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(right: 8).w,
                                                                                  child: UBRadio<dynamic>(
                                                                                    value: searchBranchList![index].key ?? "",
                                                                                    groupValue: branchCodeTemp,
                                                                                    onChanged: (value) {
                                                                                      branchCodeTemp = value;
                                                                                      branchNameTemp = searchBranchList![index].description;
                                                                                      changeState(() {});
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          if ((searchBranchList?.length ?? 0) - 1 !=
                                                                              index)
                                                                            Divider(
                                                                              height: 0,
                                                                              thickness: 1,
                                                                              color: colors(context).greyColor100,
                                                                            )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          }));

                                                searchBranchList = branchList;
                                                setState(() {});
                                              },
                                              initialValue: branchName,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              16.verticalSpace,
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8).r,
                                    color: colors(context).whiteColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(16).w,
                                  child: Column(
                                    children: [
                                      AppTextField(
                                        isInfoIconVisible: false,
                                        hint: AppLocalizations.of(context)
                                            .translate("enter_nickname"),
                                        isLabel: false,
                                        title: AppLocalizations.of(context)
                                            .translate("Nick_Name"),
                                        textCapitalization:
                                            TextCapitalization.none,
                                        inputType: TextInputType.text,
                                        inputFormatter: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[A-Z a-z ]")),
                                        ],
                                        onTextChanged: (value) {
                                          setState(() {
                                            // savedPayeeEntity.nickName = value;
                                            savedPayeeEntity.nickName =
                                                value.trim();
                                            isNickNameFilled =
                                                value.trim().isNotEmpty;
                                            updateSaveButtonState();
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null || value == '') {
                                            return AppLocalizations.of(context).translate("mandatory_field_msg");
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      24.verticalSpace,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate("add_favorite"),
                                            style: size16weight700.copyWith(
                                              color: colors(context).greyColor,
                                            ),
                                          ),
                                          CupertinoSwitch(
                                            value: savedPayeeEntity.isFavorite,
                                            trackColor: colors(context)
                                                .greyColor
                                                ?.withOpacity(.65),
                                            activeColor:
                                                colors(context).primaryColor,
                                            onChanged: (value) {
                                              setState(() {
                                                savedPayeeEntity.isFavorite =
                                                    value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        20.verticalSpace,
                        AppButton(
                          buttonText:
                              AppLocalizations.of(context).translate("save"),
                          buttonType: (isNickNameFilled &&
                                  isAccountHolderNameFilled &&
                                  isAccountNumberFilled &&
                                  isBankSelected)
                              ? ButtonType.PRIMARYENABLED
                              : ButtonType.PRIMARYDISABLED,
                          onTapButton: () async {
                            if (_formKey.currentState?.validate() == false) {
                              return;
                            }
                            await Navigator.of(context).pushNamed(
                                Routes.kAddPayDetailsConfirmView,
                                arguments: AddPayeeDetailsConfirmView(
                                    payeeDetails: savedPayeeEntity,
                                    isFromFromFundTransfer:
                                        widget.isFromFundTransfer));
                            setState(() {});
                          },
                        ),
                        16.verticalSpace,
                        AppButton(
                          buttonColor: Colors.transparent,
                          buttonType: ButtonType.OUTLINEENABLED,
                          buttonText:
                              AppLocalizations.of(context).translate("cancel"),
                          onTapButton: () async {
                            // Navigator.pushNamed(
                            //     context, Routes.kFundTransferView);

                            if (isNickNameFilled ||
                                isBankSelected ||
                                isAccountNumberFilled ||
                                isAccountHolderNameFilled == true) {
                              showAppDialog(
                                title: AppLocalizations.of(context)
                                    .translate("cancel_the_add_payee"),
                                alertType: AlertType.USER3,
                                message: AppLocalizations.of(context)
                                    .translate("cancel_the_edit_des"),
                                positiveButtonText: AppLocalizations.of(context)
                                    .translate("yes,_cancel"),
                                onPositiveCallback: () async {
                                  Navigator.of(context).pop();
                                },
                                negativeButtonText: AppLocalizations.of(context)
                                    .translate("no"),
                              );
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateSaveButtonState() {
    setState(() {
      if (isBankSelected == true &&
          savedPayeeEntity.bankCode == AppConstants.ubBankCode.toString()) {
        saveEnableButton = isNickNameFilled &&
            isBankSelected &&
            isAccountNumberFilled &&
            isAccountHolderNameFilled;
      } else if (isBankSelected == true &&
          savedPayeeEntity.bankCode != AppConstants.ubBankCode.toString()) {
        saveEnableButton = isNickNameFilled &&
            isBankSelected &&
            isAccountNumberFilled &&
            isAccountHolderNameFilled &&
            isBranchSelected;
      }
    });
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
