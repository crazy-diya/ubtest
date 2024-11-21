import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/models/responses/common_check_box_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/just_pay_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/check_box_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/drop_down_widgets/drop_down.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../../data/models/responses/city_response.dart';
import '../../../bloc/on_boarding/contact_information/contact_information_bloc.dart';
import '../../../bloc/on_boarding/contact_information/contact_information_event.dart';
import '../../../bloc/on_boarding/contact_information/contact_information_state.dart';
import '../../../widgets/app_radio_button.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../base_view.dart';
import 'justpay_onboarding_otp.dart';

class JustPayUserScheduleForVerificationView extends BaseView {
  JustPayUserScheduleForVerificationView({super.key});

  @override
  _JustPayUserScheduleForVerificationViewState createState() =>
      _JustPayUserScheduleForVerificationViewState();
}

class _JustPayUserScheduleForVerificationViewState
    extends BaseViewState<JustPayUserScheduleForVerificationView> {
  var bloc = injection<ContactInformationBloc>();
  final localDataSource = injection<LocalDataSource>();


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accNumController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<CommonCheckBoxResponse> options = [
    CommonCheckBoxResponse(
      id: '1',
      description:
          'To register, SMS alert facility must be enabled for this account.',
    ),
  ];
  List<CommonCheckBoxResponse> selectedOptions = [];
  List<CommonDropDownResponse> searchBankList = [];

  // CommonDropDownResponse? selectedAccount;
  String? selectedAccount;
  bool _isSelected = false;

  // String? fullName;
  // String? accountNo;
  String? bankCode;
  String? bankName;
  String? bankNameTemp;
  String? bankCodeTemp;

  @override
  void initState() {
    searchBankList = kBankList;
    super.initState();
  }


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        appBar: UBAppBar(
          title: AppLocalizations.of(context)
              .translate("Other_bank_account_details"),
        ),
        body: BlocProvider<ContactInformationBloc>(
          create: (context) => bloc,
          child: BlocListener<ContactInformationBloc,
              BaseState<ContactInformationState>>(
            bloc: bloc,
            listener: (_, state) async {
              if (state is JustPayOnboardingSuccessState) {
                final fullName = _nameController.text.trim();
                final accountNo = _accNumController.text.trim();
                final nicName = _nickNameController.text.trim();
                final mobileNo = localDataSource.getSaveAndExist().mobilenumber ?? null;
                final email = localDataSource.getSaveAndExist().email ?? null;

                Navigator.pushNamed(context, Routes.kJustPayOTPView,
                    arguments: JustPayOTPViewArgs(
                      otpType: kOtpMessageTypeOnBoarding,
                      justPayOtpResponseArgs: JustPayOtpResponseArgs(
                        email: email,
                        mobile: mobileNo,
                        countdownTime: state.justPayAccountOnboardingDto!
                            .otpResult!.countdownTime,
                        otpTranId: state
                            .justPayAccountOnboardingDto!.otpResult!.otpTranId,
                        otpLength: state
                            .justPayAccountOnboardingDto!.otpResult!.otpLength,
                        resendAttempt: state.justPayAccountOnboardingDto!
                            .otpResult!.resendAttempt,
                        otpType: state
                            .justPayAccountOnboardingDto!.otpResult!.otpType
                            ?.toLowerCase(),
                        isOtpSend: false,
                      ),
                      justPayData: JustPayData(
                          fullName: fullName,
                          bankCode: bankCode,
                          accountType: selectedAccount,
                          accountNo: accountNo,
                          nickName: nicName,
                          isOnBoarding: true,
                          isSelected: _isSelected),
                      justPayAccountOnboardingDto:
                          state.justPayAccountOnboardingDto,
                      requestOTP: false,
                      appBarTitle: AppLocalizations.of(context)
                          .translate("otp_verification"),
                      mobileNumber: '',
                    ));
              }
              else if (state is JustPayOnboardingFailedState) {
                if (state.code == "06") {
                  showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("already_uBgo_user"),
                  dialogContentWidget: Column(
                    children: [
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          TextSpan(
                            text: splitAndJoinAtBrTags(extractTextWithinTags(input:  state.message ?? "")[0]),
                            style:size14weight400.copyWith(color: colors(context).greyColor) 
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                _launchCaller(splitAndJoinAtBrTags(extractTextWithinTags(input:  state.message ?? "")[1]));
                              },
                            text:" ${splitAndJoinAtBrTags(extractTextWithinTags(input:  state.message ?? "")[1])}" ,
                            style:size14weight700.copyWith(color: colors(context).primaryColor) 
                          ),
                        ])

                       )
                    ],
                  ),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.kLoginView, (route) => false);
                  },
                  positiveButtonText:
                      AppLocalizations.of(context).translate("login"),
                );
                } else {
                  showAppDialog(
                    alertType: AlertType.FAIL,
                    title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED),
                    dialogContentWidget: Column(
                      children: [
                        Text(
                          state.message ?? "",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    onPositiveCallback: () {
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                    },
                    positiveButtonText: AppLocalizations.of(context).translate("ok"),
                  );
                }
              }
            },
            child: Padding(
              padding:  EdgeInsets.fromLTRB(20.w,0.h,20.w,(20.h+ AppSizer.getHomeIndicatorStatus(context))),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.only(top: 40.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("Please_fill"),
                                  style: size16weight400.copyWith(
                                    color: colors(context).greyColor,
                                  ),
                                ),
                                24.verticalSpace,
                                CustomRadioButtonGroup(
                                  validator: (value){
                                    if(selectedAccount ==null || selectedAccount==""){
                                      return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                    }else{
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
                                  value: selectedAccount,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAccount = value!;
                                    });
                                  },
                                  title: AppLocalizations.of(context)
                                      .translate("Account_Type"),
                                ),
                                24.verticalSpace,
                                AppTextField(
                                  title: AppLocalizations.of(context)
                                      .translate("Full_Name"),
                                  controller: _nameController,
                                  isInfoIconVisible: false,
                                  icon: const Icon(
                                    Icons.access_time,
                                    size: 18,
                                  ),
                                  hint: AppLocalizations.of(context)
                                      .translate("Full_Name"),
                                  textCapitalization: TextCapitalization.words,
                                  isLabel: false,
                                  isEnable: true,

                                  isReadOnly: false,
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
                                  // onTextChanged: (value) {
                                  //   setState(() {
                                  //     fullName = value.trim();
                                  //   });
                                  // },
                                ),
                                24.verticalSpace,
                                AppDropDown(
                                  validator: (value){
                                    if(bankName ==null || bankName==""){
                                      return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                    }else{
                                      return null;
                                    }
                                  },
                                  onTap:
                                      () async {
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
                                                          bankCode = bankCodeTemp;
                                                          bankName = bankNameTemp;
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
                                                          bankCodeTemp = searchBankList[index].key;
                                                          bankNameTemp = searchBankList[index].description;
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
                                                                    padding: const EdgeInsets.only(right: 2).w,
                                                                    child: UBRadio<dynamic>(
                                                                      value: searchBankList[index].key ?? "",
                                                                      groupValue: bankCodeTemp,
                                                                      onChanged: (value) {
                                                                        bankCodeTemp = value;
                                                                        bankCodeTemp = searchBankList[index].key;
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
                                  //   Navigator.pushNamed(
                                  //       context, Routes.kDropDownView,
                                  //       arguments: DropDownViewScreenArgs(
                                  //         isSearchable: false,
                                  //         pageTitle: AppLocalizations.of(context)
                                  //             .translate("Select_Bank"),
                                  //         dropDownEvent: GetBankDropDownEvent(),
                                  //       )).then((value) {
                                  //     if (value != null &&
                                  //         value is CommonDropDownResponse) {
                                  //       setState(() {
                                  //         selectedBank = value;
                                  //         bankCode = value.key;
                                  //       });
                                  //     }
                                  //   });
                                  // },
                                  isFirstItem: false,
                                  label: AppLocalizations.of(context).translate("Bank_Name"),
                                  labelText: AppLocalizations.of(context).translate("Select_Bank"),
                                  initialValue: bankName,
                                ),
                                24.verticalSpace,
                                AppTextField(
                                  title: AppLocalizations.of(context)
                                      .translate("Account_Number"),
                                  controller: _accNumController,
                                  isInfoIconVisible: false,
                                  maxLength: 18,
                                  textCapitalization: TextCapitalization.words,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  // onTextChanged: (value) {
                                  //   setState(() {
                                  //     accountNo = value.trim();
                                  //   });
                                  // },
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return AppLocalizations.of(context).translate("account_number_required");
                                    } else {
                                      return null;
                                    }
                                  },
                                  hint: AppLocalizations.of(context)
                                      .translate("Account_Number"),
                                  inputType: TextInputType.number,
                                  isLabel: false,
                                  isEnable: true,
                                  isReadOnly: false,
                                ),
                                24.verticalSpace,
                                AppTextField(
                                  title: AppLocalizations.of(context)
                                      .translate("account_nickname"),
                                  controller: _nickNameController,
                                  isInfoIconVisible: false,
                                  inputType: TextInputType.text,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[A-Z a-z ]")),
                                  ],
                                  // onTextChanged: (value) {
                                  //   setState(() {
                                  //     nicName = value.trim();
                                  //   });
                                  // },
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return AppLocalizations.of(context).translate("nick_name_required");
                                    } else {
                                      return null;
                                    }
                                  },
                                  hint: AppLocalizations.of(context)
                                      .translate("Nick_Name_for_this_Account"),
                                  textCapitalization: TextCapitalization.none,
                                  isLabel: false,
                                  isEnable: true,
                                  isReadOnly: false,
                                ),
                                24.verticalSpace,
                                ReusableCheckboxList(
                                  options: options,
                                  selectedOptions: selectedOptions,
                                  onChanged: (selected) {
                                    setState(() {
                                      selectedOptions = selected;
                                      if (_isSelected) {
                                        _isSelected = false;
                                      } else {
                                        _isSelected = true;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          )),
                    ),
                    // 7.4.verticalSpace,
                    Column(
                      children: [
                        20.verticalSpace,
                        AppButton(
                          buttonText:
                              AppLocalizations.of(context).translate("submit"),
                          onTapButton: _onTap,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

    _launchCaller(String number) async {
    var url = 'tel:${number.toString()}';
    if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    } else {
      throw 'Cannot direct to $url';
    }
  }

  /// On tap
  void _onTap() {
    if (_formKey.currentState?.validate() == false) {
      return;
    }
    if(!_isSelected){
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
    bloc.add(JustPayAccountOnboardingEvent(
      fullName: _nameController.text.trim(),
      bankCode: bankCode,
      accountType: selectedAccount,
      accountNo: _accNumController.text.trim(),
      nickName: _nickNameController.text.trim(),
      enableAlert: _isSelected,
    ));
  }

  /// Validate Fields
  // bool _isValidated() {
  //   if (fullName == null ||
  //       fullName == "" ||
  //       selectedBank == null ||
  //       selectedAccount == null ||
  //       accountNo == null ||
  //       accountNo == "" ||
  //       nicName == null ||
  //       nicName == "" ||
  //       _isSelected == false) {
  //     return false;
  //   }
  //   return true;
  // }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
