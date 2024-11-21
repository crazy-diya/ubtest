import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';

import '../../../../utils/app_sizer.dart';
import '../../../data/models/requests/add_justPay_instrument_request.dart';
import '../../../data/models/responses/city_response.dart';
import '../../../data/models/responses/mobile_login_response.dart';
import '../../../domain/entities/response/get_juspay_instrument_entity.dart';
import '../../bloc/payment_instrument/payment_instrument_bloc.dart';
import '../../bloc/payment_instrument/payment_instrument_event.dart';
import '../../bloc/payment_instrument/payment_instrument_state.dart';
import '../../widgets/app_radio_button.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/drop_down_widgets/drop_down.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../user_onboarding/data/just_pay_data.dart';
import 'manage_other_bank_terms.dart';
import 'otherBank_otp_view.dart';

class ManageOtherBankFormView extends BaseView {
  final JustPayInstruementsReques? addJustPayList;
  final MobileLoginResponse? mobileResNic;

  ManageOtherBankFormView({this.addJustPayList, this.mobileResNic});

  @override
  _ManageOtherBankFormViewState createState() =>
      _ManageOtherBankFormViewState();
}

class _ManageOtherBankFormViewState
    extends BaseViewState<ManageOtherBankFormView> {
  MobileLoginResponse? mobileResNic = MobileLoginResponse();
  var _bloc = injection<PaymentInstrumentBloc>();
  UserInstrumentsListEntity? userInstrumentsListEntity =
      UserInstrumentsListEntity();
  final _formKey = GlobalKey<FormState>();
  bool _checkbox = false;
  String? accountNu1,
      fullName1,
      BankName,
      BankCode,
      BankNameTemp,
      BankCodeTemp,
      nickName1,
      SA,
      CA,
      nic1,
      bankName1;
  String? selectedIdType;
  String? challengeReqId;
  int? age;
  bool termsAccepted = true;
  TextEditingController accountNumberController = TextEditingController();
  List<CommonDropDownResponse> searchBankList = [];

  @override
  void initState() {
    searchBankList = kBankList;
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("Add_New_Payment"),
      ),
      body: BlocProvider<PaymentInstrumentBloc>(
        create: (_) => _bloc,
        child: BlocListener<PaymentInstrumentBloc,
            BaseState<PaymentInstrumentState>>(
          listener: (context, state) {
            if (state is AddPaymentInstrumentSuccessState) {
              if(state.code == "853"){
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title:AppLocalizations.of(context).translate("already_added_nickname"),
                  message: splitAndJoinAtBrTags(state.responseDescription ?? ""),
                  positiveButtonText: AppLocalizations.of(context).translate("try_again"),
                  onPositiveCallback: (){
                  },
                );
              } else if(state.code == "842"){
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title:AppLocalizations.of(context).translate("account_already_exists"),
                  message: splitAndJoinAtBrTags(state.responseDescription ?? ""),
                  positiveButtonText: AppLocalizations.of(context).translate("close"),
                  onPositiveCallback: (){
                  },
                );
              } else {
                Navigator.pushNamed(
                  context,
                  Routes.kOtherBankOTPView,
                  arguments: OtherBankOTPViewArgs(
                    otpType: kManageOtherBank,
                    otherBankOtpResponseArgs: OtherBankOtpResponseArgs(
                      isOtpSend: true,
                    ),
                    requestOTP: true,
                    appBarTitle: AppLocalizations.of(context).translate("otp_verification"),
                    mobileNumber: '',
                  ),
                ).then((value) {
                  if (value != null) {
                    if(value!= false){

                   
                    challengeReqId = value.toString();
                    Navigator.pushNamed(context, Routes.kTnCManageOtherBankView,
                        arguments: OtherTermsArgs(
                            justPayData: JustPayData(bankCode: BankCode,accountNo: accountNu1),
                            termsType: ObType.justPay.name,
                            challengeReqId: challengeReqId
                        ));

                  }
                   }
                });
              }
            }
            if (state is AddPaymentInstrumentFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding:  EdgeInsets.fromLTRB(20.w,0.h,20.h,20.h + AppSizer.getHomeIndicatorStatus(context)),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 24.h),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).w,
                              color: colors(context).whiteColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16).w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context).translate("Enter_Other_Payment"),
                                  style: size16weight400.copyWith(color: colors(context).blackColor),
                                ),
                                24.verticalSpace,
                                CustomRadioButtonGroup(
                                  validator: (value) {
                                    if (selectedIdType == null || selectedIdType == "") {
                                      return AppLocalizations.of(context).translate("account_type_required");
                                    } else {
                                      return null;
                                    }
                                  },
                                  options: [
                                    RadioButtonModel(
                                        label: AppLocalizations.of(context)
                                            .translate("Savings_Account"),
                                        value: 'S'),
                                    RadioButtonModel(
                                        label: AppLocalizations.of(context)
                                            .translate("Current_Account"),
                                        value: 'D'),
                                  ],
                                  isDivider: false,
                                  value: selectedIdType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedIdType = value!;
                                    });
                                  },
                                  title: AppLocalizations.of(context)
                                      .translate("Account_Type"),
                                ),
                                24.verticalSpace,
                                AppTextField(
                                  isInfoIconVisible: false,
                                  inputType: TextInputType.text,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[A-Z a-z ]")),
                                  ],
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return AppLocalizations.of(context).translate("full_name_required");
                                    } else {
                                      return null;
                                    }
                                  },
                                  hint: AppLocalizations.of(context)
                                      .translate("enter_full_name"),
                                  title: AppLocalizations.of(context)
                                      .translate("Full_Name"),
                                  textCapitalization: TextCapitalization.none,
                                  onTextChanged: (value) {
                                    setState(() {
                                      fullName1 = value;
                                    });
                                  },
                                ),
                                24.verticalSpace,
                                AppDropDown(
                                  validator: (value){
                                    if(BankName ==null || BankName == ""){
                                      return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                    }else{
                                      return null;
                                    }
                                  },
                                  label: AppLocalizations.of(context).translate("Bank_Name"),
                                  labelText: AppLocalizations.of(context).translate("Select_Bank"),
                                  onTap:
                                      () async {
                                     await showModalBottomSheet<bool>(
                                        isScrollControlled: true,
                                        useRootNavigator: true,
                                        useSafeArea: true,
                                        context: context,
                                        barrierColor: colors(context).blackColor?.withOpacity(.85),
                                        backgroundColor: Colors.transparent,
                                        builder: (context,) => StatefulBuilder(
                                            builder: (context,changeState) {
                                              return BottomSheetBuilder(
                                                isSearch: true,
                                                onSearch: (p0) {
                                                  changeState(() {
                                                    if (p0.isEmpty || p0=='') {
                                                      searchBankList = kBankList;
                                                    } else {
                                                      searchBankList = kBankList
                                                          .where((element) => element
                                                          .description!
                                                          .toLowerCase()
                                                          .contains(p0.toLowerCase())).toSet().toList();
                                                    }
                                                  });
                                                },
                                                title: AppLocalizations.of(context).translate('Select_Bank'),
                                                buttons: [
                                                  Expanded(
                                                    child: AppButton(
                                                        buttonType: ButtonType.PRIMARYENABLED,
                                                        buttonText: AppLocalizations.of(context) .translate("continue"),
                                                        onTapButton: () {
                                                          BankCode = BankCodeTemp;
                                                          BankName = BankNameTemp;
                                                           WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                          Navigator.of(context).pop(true);
                                                          changeState(() {});
                                                          setState(() {});
                                                        }),
                                                  ),
                                                ],
                                                children: [
                                                  ListView.builder(
                                                    itemCount: searchBankList.length,
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemBuilder: (context, index) {
                                                      return InkWell(
                                                        onTap: (){
                                                          BankCodeTemp = searchBankList[index].key;
                                                          BankNameTemp = searchBankList[index].description;
                                                          changeState(() {});
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                                padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:12,0,12).w,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: 48.w,
                                                                    height: 48.w,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(8).r,
                                                                        border: Border.all(color: colors(context).greyColor300!)
                                                                    ),
                                                                    child: (searchBankList[ index] .icon==null)
                                                                        ? Center(
                                                                      child: Text(
                                                                        searchBankList[index].description
                                                                            ?.toString()
                                                                            .getNameInitial() ?? "",
                                                                        style: size20weight700.copyWith(
                                                                            color: colors(context).primaryColor),
                                                                      ),
                                                                    )
                                                                        : Center(
                                                                      child:ClipRRect(
                                                                        borderRadius: BorderRadius.circular(8).r,
                                                                        child: Image.asset(
                                                                          searchBankList[ index] .icon ?? "",
                                                                        ),
                                                                      ) ,
                                                                    ),
                                                                  ),
                                                                  12.horizontalSpace,
                                                                  Expanded(
                                                                    child: Text(
                                                                      searchBankList[index].description ?? "",
                                                                      style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(right: 8).w,
                                                                    child: UBRadio<dynamic>(
                                                                      value: searchBankList[index].key ?? "",
                                                                      groupValue: BankCodeTemp,
                                                                      onChanged: (value) {
                                                                        BankCodeTemp = value;
                                                                        BankNameTemp = searchBankList[index].description;
                                                                        changeState(() {});
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            if(searchBankList.length-1 != index)
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
                                            }
                                        ));
                                    // if (result == null) {
                                    //   BankName = null;
                                    //   BankNameTemp = null;
                                    //   BankCode = null;
                                    //   BankCodeTemp = null;
                                    //   setState(() {});
                                    // }
                                    searchBankList = kBankList;
                                    setState(() {});
                                  },

                                  //     () {
                                  //   Navigator.pushNamed(context, Routes.kDropDownView,
                                  //           arguments: DropDownViewScreenArgs(
                                  //               isSearchable: false,
                                  //               pageTitle: "Select Bank",
                                  //               dropDownEvent:
                                  //                   GetBankDropDownEvent()))
                                  //       .then((value) {
                                  //     if (value != null &&
                                  //         value is CommonDropDownResponse) {
                                  //       setState(() {
                                  //         bankName1 = value.description;
                                  //         BankCode1 = value.key;
                                  //       });
                                  //     }
                                  //   });
                                  // },
                                  initialValue: BankName,
                                ),
                                24.verticalSpace,
                                AppTextField(
                                  isInfoIconVisible: false,
                                  inputType: TextInputType.number,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9,]")),
                                  ],
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return AppLocalizations.of(context).translate("account_number_required");
                                    } else {
                                      return null;
                                    }
                                  },
                                  title: AppLocalizations.of(context)
                                      .translate("Account_Number"),
                                  hint: AppLocalizations.of(context)
                                      .translate("enter_account_number"),
                                  textCapitalization: TextCapitalization.none,
                                  onTextChanged: (value) {
                                    setState(() {
                                      accountNu1 = value;
                                    });
                                  },
                                ),
                                24.verticalSpace,
                                AppTextField(
                                  maxLength: 20,
                                  isInfoIconVisible: false,
                                  inputType: TextInputType.text,
                                  title: AppLocalizations.of(context)
                                      .translate("account_nickname"),
                                  hint: AppLocalizations.of(context)
                                      .translate("enter_account_nickname"),
                                  textCapitalization: TextCapitalization.none,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[A-Z a-z ]")),
                                  ],
                                  onTextChanged: (value) {
                                    setState(() {
                                      nickName1 = value;
                                    });
                                  },
                                ),
                                24.verticalSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Checkbox(
                                      shape: RoundedRectangleBorder(
                                           borderRadius:
                                                BorderRadius.circular(4).w),
                                        checkColor: colors(context).whiteColor,
                                        activeColor: colors(context).primaryColor,
                                      value: _checkbox,
                                      onChanged: (value) {
                                        setState(() {
                                          _checkbox = !_checkbox;
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate("sms_facility"),
                                        style: TextStyle(
                                            color: termsAccepted
                                                ? colors(context).blackColor
                                                : colors(context).negativeColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ), //Checkbox
                                  ], //<Widget>[]
                                ),
                                // 2.90.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      16.verticalSpace,
                      AppButton(
                          buttonText: AppLocalizations.of(context)
                              .translate("continue"),
                          onTapButton: () {
                            if (_formKey.currentState?.validate() == false) { return;}
                             
                            if(!_checkbox){
                              showAppDialog(
                              title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED),
                              alertType: AlertType.FAIL,
                              message: AppLocalizations.of(context)
                                        .translate("sms_facility_alert"),
                              positiveButtonText: AppLocalizations.of(context).translate("ok"),
                              onPositiveCallback: () {},
                              );
                              return;
                            }
                            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                        _bloc.add(
                                  AddInstrumentEvent(
                                    nickName: nickName1 == "" ? null :nickName1 ,
                                    bankCode: BankCode,
                                    accountNo: accountNu1,
                                    accountType: selectedIdType,
                                    fullName: fullName1,
                                    enableAlert: _checkbox,
                                    nic: mobileData!.nic,
                                  ),
                                );

                          }),
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

  alreadyRegisteredDialog() {
    showAppDialog(
        title: AppLocalizations.of(context).translate("Already_a_wallet_user"),
        alertType: AlertType.USER1,
        message: "${AppLocalizations.of(context)
            .translate("You_are_already_registered")} ${formatMobileNumber(AppConstants.CALL_CENTER_TEL_NO??"")}",
        positiveButtonText: AppLocalizations.of(context).translate("login"),
        onPositiveCallback: () {
          Navigator.of(context)
              .popUntil(ModalRoute.withName(Routes.kLoginView));
        });
  }

  inactiveAccountDialog() {
    showAppDialog(
      title: AppLocalizations.of(context).translate("inactive_account"),
      alertType: AlertType.USER1,
      message: "${AppLocalizations.of(context).translate("inactive_account_msg")} ${formatMobileNumber(AppConstants.CALL_CENTER_TEL_NO??"")}",
      positiveButtonText: AppLocalizations.of(context).translate("ok"),
      negativeButtonText: AppLocalizations.of(context).translate("cancel"),
    );
  }

  notAllowedAccountDialog() {
    showAppDialog(
      title: AppLocalizations.of(context).translate("not_allowed_account"),
      alertType: AlertType.USER1,
      message:
          "${AppLocalizations.of(context).translate("not_allowed_account_msg")} ${formatMobileNumber(AppConstants.CALL_CENTER_TEL_NO??"")}",
      positiveButtonText: AppLocalizations.of(context).translate("ok"),
      negativeButtonText: AppLocalizations.of(context).translate("cancel"),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
