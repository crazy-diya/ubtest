import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/ub_account_onboarding/ub_terms_and_conditions_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../bloc/on_boarding/contact_information/contact_information_bloc.dart';
import '../../../bloc/on_boarding/contact_information/contact_information_state.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../otp/otp_view.dart';

class UbRegisterDebitCardDetailsView extends BaseView {
  UbRegisterDebitCardDetailsView({super.key});

  @override
  _UbRegisterDebitCardDetailsViewState createState() =>
      _UbRegisterDebitCardDetailsViewState();
}

class _UbRegisterDebitCardDetailsViewState
    extends BaseViewState<UbRegisterDebitCardDetailsView> {
  final ContactInformationBloc _bloc = injection<ContactInformationBloc>();
  final localDataSource = injection<LocalDataSource>();
  // String? debidCardNumber, atmPin;
  final _formkey = GlobalKey<FormState>();

  TextEditingController debidCardNumberController = TextEditingController();
  TextEditingController atmPinController = TextEditingController();

  MaskTextInputFormatter inputFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("ub_debit_card"),
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<ContactInformationBloc,
            BaseState<ContactInformationState>>(
          listener: (_, state) {
            if (state is CdbAccountVerificationSuccessState) {
              if (state.code == "00") {
                Navigator.pushNamed(context, Routes.kUBAccountTnCView,
                        arguments: TermsArgs(
                            termsType: kTermType, appBarTitle: "ub_debit_card"))
                    .then((value) {
                  if (value is bool && value) {
                    Navigator.pushNamed(
                      context,
                      Routes.kOtpView,
                      arguments: OTPViewArgs(
                        isSingleOTP: false,
                        otpResponseArgs: OtpResponseArgs(
                          isOtpSend: false,
                        ),
                        otpType: kOtpMessageTypeOnBoarding,
                        routeName: Routes.kUBSetupLoginDetailsView,
                        requestOTP: true,
                        appBarTitle: "otp_verification",
                      ),
                    );
                  }
                });
              } else if (state.code == "01") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("already_uBgo_user"),
                  dialogContentWidget: Column(
                    children: [
                      Text(
                        state.message ?? "",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${AppLocalizations.of(context).translate("already_uBgo_user_des")} ${formatMobileNumber(AppConstants.CALL_CENTER_TEL_NO??"")}",
                      ),
                    ],
                  ),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.kLoginView, (route) => false);
                  },
                  positiveButtonText: AppLocalizations.of(context).translate("login"),
                );
              } else if (state.code == "706") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("inactive_account"),
                  dialogContentWidget: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).translate("not_active_acct_des"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${AppLocalizations.of(context).translate("already_uBgo_user_des")} ${formatMobileNumber(AppConstants.CALL_CENTER_TEL_NO??"")}",
                      ),
                    ],
                  ),
                  positiveButtonText: AppLocalizations.of(context).translate("try_different_acct"),
                  negativeButtonText: AppLocalizations.of(context).translate("cancel"),
                );
              } else if (state.code == "707") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: AppLocalizations.of(context).translate("not_allowed_account"),
                  dialogContentWidget: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context).translate("not_allowed_account_msg_1"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Otherwise, you can continue registration using other bank account.",
                      ),
                    ],
                  ),
                  positiveButtonText: "Try Different UB Account",
                  negativeButtonText: "Cancel",
                );
              } else if (state.code == "711") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: "Invalid Account Type",
                  dialogContentWidget: Column(
                    children: const [
                      Text(
                        "This is invalid account. Please try with different UB account.",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Otherwise, you can continue registration using other bank account.",
                      ),
                    ],
                  ),
                  positiveButtonText: "Use My UB Account",
                  negativeButtonText: "Continue with Other Bank Account",
                );
              } else if (state.code == "510") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: "Customer Details not exist",
                  dialogContentWidget: Column(
                    children: const [
                      Text(
                        "You are already a UB customer. You can easily use your UB account to register with UBgo.",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Otherwise, you can continue registration using other bank account.",
                      ),
                    ],
                  ),
                  positiveButtonText: "Use My UB Account",
                  negativeButtonText: "Continue with Other Bank Account",
                );
              } else if (state.code == "500") {
                showAppDialog(
                  alertType: AlertType.FAIL,
                  title: "Incorrect Details",
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
                      // debidCardNumber = null;
                      // atmPin = null;
                      atmPinController.clear();
                      debidCardNumberController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                  positiveButtonText: "Retry",
                  // negativeButtonText: "Continue with Other Bank Account",
                );
              } else if (state.code == "501") {
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
                      // accountNu=null;
                      // identificatioNum=null;
                      // nickName=null;
                      // _isInputValid= false;
                      // nickNameController.clear();
                      // accountNumberController.clear();
                      // identificationNumController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                  positiveButtonText: "Ok",
                  // negativeButtonText: "Continue with Other Bank Account",
                );
              } else if (state.code == "511") {
                showAppDialog(
                  alertType: AlertType.USER1,
                  title: "Already a UBgo user",
                  dialogContentWidget: Column(
                    children: [
                      Text(
                        state.message ?? "",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "If you need further help or support please contact us on 011 2678765",
                      ),
                    ],
                  ),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.kLoginView, (route) => false);
                  },
                  positiveButtonText: "Login",
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
                      // accountNu=null;
                      // identificatioNum=null;
                      // nickName=null;
                      // _isInputValid= false;
                      // nickNameController.clear();
                      // accountNumberController.clear();
                      // identificationNumController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                  positiveButtonText: "Ok",
                  // negativeButtonText: "Continue with Other Bank Account",
                );
              }
            } else if (state is CdbAccountVerificationFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Center(
                          //   child: Image.asset(
                          //     AppAssets.icUbAccount,
                          //     width: 65.w,
                          //   ),
                          // ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .translate("Enter_Below_Details"),
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          AppTextField(
                            validator: (value) {
                              if (value == null || value == '') {
                                return "This is a required field.";
                              } else {
                                return null;
                              }
                            },
                            controller: debidCardNumberController,
                            isInfoIconVisible: false,
                            inputType: TextInputType.number,
                            hint: AppLocalizations.of(context)
                                .translate("debit_card_number"),
                            textCapitalization: TextCapitalization.none,
                            isLabel: true,
                            inputFormatter: [inputFormatter],
                            onTextChanged: (value) {
                              // setState(() {
                              //   debidCardNumber = value;
                              // });
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          AppTextField(
                            validator: (value) {
                              if (value == null || value == '') {
                                return "This is a required field.";
                              } else {
                                return null;
                              }
                            },
                            maxLength: 4,
                            controller: atmPinController,
                            isInfoIconVisible: false,
                            hint: AppLocalizations.of(context)
                                .translate("atm_pin"),
                            inputType: TextInputType.number,
                            isLabel: true,
                            obscureText: true,
                            letterSpacing: 4,
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            // onTextChanged: (value) {
                            //   setState(() {
                            //     atmPin = value;
                            //   });
                            // },
                          ),
                          SizedBox(
                            height: 4.sp,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 4.sp,
                                color: colors(context).greyColor,
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Expanded(
                                  child: Text(
                                AppLocalizations.of(context)
                                    .translate("debit_card_info"),
                                style: TextStyle(
                                    fontSize: 4.sp,
                                    fontWeight: FontWeight.w600,
                                    color: colors(context).greyColor),
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      AppButton(
                          buttonType: ButtonType.PRIMARYENABLED,
                          buttonText:
                              AppLocalizations.of(context).translate("Next"),
                          onTapButton: () {
                            if (_formkey.currentState?.validate() == false) {
                              return;
                            }
                            //UNMASKED TEXT

                            Navigator.pushNamed(
                                    context, Routes.kUBAccountTnCView,
                                    arguments: TermsArgs(
                                        termsType: kTermType,
                                        appBarTitle: "ub_debit_card"))
                                .then((value) {
                              if (value is bool && value) {
                                Navigator.pushNamed(
                                  context,
                                  Routes.kOtpView,
                                  arguments: OTPViewArgs(
                                    isSingleOTP: false,
                                    otpResponseArgs: OtpResponseArgs(
                                      isOtpSend: false,
                                    ),
                                    otpType: kOtpMessageTypeOnBoarding,
                                    routeName: Routes.kUBSetupLoginDetailsView,
                                    requestOTP: true,
                                    appBarTitle: "otp_verification",
                                  ),
                                );
                              }
                            });
                            // _bloc.add(
                            //   ValidateUBAccountEvent(
                            //     accountNumber: accountNu,
                            //     obType: ObType.CAO.name,
                            //     // referralCode: '',
                            //     nickName: nickName,
                            //     identificationType: selectedIdType,
                            //     identificationNo: identificatioNum,
                            //   ),
                            //   //ValidateAccountEvent(accountNumber: accNumber)
                            // );
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
      alertType: AlertType.WARNING,
      message:"${AppLocalizations.of(context).translate("inactive_account_msg")} ${formatMobileNumber(AppConstants.CALL_CENTER_TEL_NO??"")}",
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
