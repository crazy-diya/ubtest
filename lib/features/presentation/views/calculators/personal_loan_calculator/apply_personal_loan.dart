import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/calculators/calculators.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/app_validator.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/text_editing_controllers.dart';

import '../../../bloc/calculators/apply_personal_loan/apply_personal_loan_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../home/home_base_view.dart';

class ApplyPersonalLoanCalculatorDataViewArgs {
   String? loanAmount;
   String? tenure;
   String? instalmentType;
   String? rate;
   bool isFromPreLogin;


  ApplyPersonalLoanCalculatorDataViewArgs(
      {
        this.loanAmount,
        this.tenure,
        this.instalmentType,
        this.rate,
        this.isFromPreLogin = false,
      });
}


class ApplyForPersonalLoan extends BaseView {
  final ApplyPersonalLoanCalculatorDataViewArgs applyPersonalLoanCalculatorDataViewArgs;

  ApplyForPersonalLoan({required this.applyPersonalLoanCalculatorDataViewArgs});
  @override
  _ApplyForPersonalLoanState createState() => _ApplyForPersonalLoanState();
}

class _ApplyForPersonalLoanState extends BaseViewState<ApplyForPersonalLoan> {
  var _bloc = injection<ApplyPersonalLoanBloc>();
  final AppValidator appValidator = AppValidator();

  String? getName;
  String? getNic;
  String? getEmail;
  String? getMobileNum;
  String? responseCode;
  String? responseDescription;
  String? amount;
  String? paymentPeriod;
  String? grossIncome;
  bool? emailValidated;
  bool _checkFieldValidation = false;

  final FocusNode _focusNodeNIC = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeMobile = FocusNode();
  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeReqAmount = FocusNode();
  final FocusNode _focusNodeReqPeriod = FocusNode();
  final FocusNode _focusNodeGrossIncome = FocusNode();

  final CurrencyTextEditingController amountController = CurrencyTextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerNIC = TextEditingController();
  final TextEditingController _controllerMobile = TextEditingController();
  final CurrencyTextEditingController incomeController = CurrencyTextEditingController();
  final TextEditingController _controllerTenure = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool nameValidate = false;
  bool nicValidate = false;
  bool mobileValidate = false;
  bool incomeValidate = false;
  bool reqAmountValidate = false;
  bool payentPeriodValidate = false;
  bool isButtonClicked = false;
  @override
  void initState() {
    
    super.initState();
    amountController.text = widget.applyPersonalLoanCalculatorDataViewArgs.loanAmount!;
    _controllerTenure.text = widget.applyPersonalLoanCalculatorDataViewArgs.tenure!;
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        // onBackPressed: (){
        //   Navigator.pushNamed(context, Routes.kPersonalLoanView, arguments:widget.applyPersonalLoanCalculatorDataViewArgs.isFromPreLogin ? true : false);
        // },
        title:
            AppLocalizations.of(context).translate("apply_personal_loan"),
        goBackEnabled: true,
      ),
      body: BlocProvider<ApplyPersonalLoanBloc>(
        create: (context) => _bloc,
        child: BlocListener<ApplyPersonalLoanBloc,
            BaseState<ApplyPersonalLoanState>>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is ApplyPersonalLoanFieldDataSuccessState) {
              responseCode = state.responseCode;
              responseDescription = state.responseDescription;
                showAppDialog(
                    title: AppLocalizations.of(context).translate("details_submitted"),
                    alertType: AlertType.SUCCESS,
                    message: splitAndJoinAtBrTags(state.responseDescription ?? ""),
                    positiveButtonText: AppLocalizations.of(context).translate("ok"),
                    onPositiveCallback: () {
                      if(widget.applyPersonalLoanCalculatorDataViewArgs.isFromPreLogin == true){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => CalculatorsView(isFromPreLogin: true)),
                              (Route<dynamic> route) => route.isFirst || route.settings.name == 'kPreLoginMenu', // This makes sure to remove all previous routes
                        );
                        // Navigator.pushNamed(context, Routes.kCalculatorsView, arguments: true);
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeBaseView()),
                              (route) => false, // This makes sure to remove all previous routes
                        );
                        // Navigator.pushNamed(context, Routes.kHomeBaseView);
                      }
                    });
            }
            if(state is ApplyPersonalLoanFieldDataFailedState){
              ToastUtils.showCustomToast(
                  context, AppLocalizations.of(context).translate("there_was_some_error"), ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding:
                 EdgeInsets.fromLTRB(20.w, 0.h, 20.w, (20.h + AppSizer.getHomeIndicatorStatus(context))),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: 24.h),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).w,
                            color: colors(context).whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0).w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // if(widget.applyPersonalLoanCalculatorDataViewArgs.isFromPreLogin)
                                  AppTextField(
                                    isInfoIconVisible: false,
                                    title: AppLocalizations.of(context).translate("name"),
                                    hint: AppLocalizations.of(context).translate("enter_your_name"),
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[a-z A-Z .]")),
                                    ],
                                    validator: (a){
                                      if(_controllerName.text.isEmpty){
                                        return AppLocalizations.of(context)
                                            .translate("mandatory_field_msg");
                                      }else{
                                        return null;
                                      }
                                    },
                                    maxLines: null,
                                    isEnable:  widget.applyPersonalLoanCalculatorDataViewArgs.isFromPreLogin ? true : false,
                                    initialValue: widget.applyPersonalLoanCalculatorDataViewArgs.isFromPreLogin ?
                                     "" : AppConstants.profileData.name,
                                    focusNode: _focusNodeName,
                                    controller: _controllerName,
                                    onTextChanged: (value) {
                                      setState(() {
                                        getName = value.replaceAll(',', '');
                                        _checkFieldValidation = checkFieldValidation();
                                        if(_controllerName.text.isEmpty){
                                          nameValidate = false;
                                          setState(() {

                                          });
                                        } else {
                                          nameValidate = true;
                                          setState(() {

                                          });
                                        }
                                      });
                                    },
                                  ),
                                  24.verticalSpace,
                                  AppTextField(
                                    isInfoIconVisible: false,
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9 V v X x]")),
                                    ],
                                    textCapitalization: TextCapitalization.characters,
                                    title: AppLocalizations.of(context).translate("nic"),
                                    hint: AppLocalizations.of(context).translate("enter_nic"),
                                    isEnable:  widget.applyPersonalLoanCalculatorDataViewArgs.isFromPreLogin ? true : false,
                                    initialValue: widget.applyPersonalLoanCalculatorDataViewArgs.isFromPreLogin ?
                                    "" : AppConstants.profileData.nic,
                                    focusNode: _focusNodeNIC,
                                    controller: _controllerNIC,
                                    validator: (a){
                                      if(_controllerNIC.text.isEmpty){
                                        return AppLocalizations.of(context)
                                            .translate("mandatory_field_msg");
                                      }else{
                                        return null;
                                      }
                                    },
                                    onTextChanged: (value) {
                                      setState(() {
                                        getNic = value.replaceAll(',', '');
                                        _checkFieldValidation = checkFieldValidation();
                                        if(_controllerNIC.text.isEmpty){
                                          nicValidate = false;
                                          setState(() {

                                          });
                                        } else {
                                          nicValidate = true;
                                          setState(() {

                                          });
                                        }
                                      });
                                    },
                                  ),
                                  24.verticalSpace,
                                  AppTextField(
                                    isInfoIconVisible: false,
                                    inputType: TextInputType.emailAddress,
                                    focusNode: _focusNodeEmail,
                                    controller: _controllerEmail,
                                    title: AppLocalizations.of(context).translate("email_optional"),
                                    hint: AppLocalizations.of(context).translate("enter_email_address"),
                                    isEnable:  widget.applyPersonalLoanCalculatorDataViewArgs.isFromPreLogin ? true : false,
                                    initialValue: widget.applyPersonalLoanCalculatorDataViewArgs.isFromPreLogin ?
                                    "" : AppConstants.profileData.email,
                                    onTextChanged: (value) {
                                      setState(() {
                                        getEmail = value;
                                      });
                                    },
                                  ),
                                  24.verticalSpace,
                                  AppTextField(
                                    isInfoIconVisible: false,
                                    inputType: TextInputType.phone,
                                    focusNode: _focusNodeMobile,
                                    controller: _controllerMobile,
                                    validator: (a){
                                      if(_controllerMobile.text.isEmpty){
                                        return AppLocalizations.of(context)
                                            .translate("mandatory_field_msg");
                                      }else{
                                        return null;
                                      }
                                    },
                                    title: AppLocalizations.of(context).translate("Mobile_Number"),
                                    hint: AppLocalizations.of(context).translate("enter_mobile_number"),
                                    isEnable:  widget.applyPersonalLoanCalculatorDataViewArgs.isFromPreLogin ? true : false,
                                    initialValue: widget.applyPersonalLoanCalculatorDataViewArgs.isFromPreLogin ?
                                    "" : AppConstants.profileData.mobileNo,
                                    maxLength: 10,
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]")),
                                    ],
                                    onTextChanged: (value) {
                                      setState(() {
                                        getMobileNum = value.replaceAll(',', '');
                                        _checkFieldValidation = checkFieldValidation();
                                        if(_controllerMobile.text.isEmpty){
                                          mobileValidate = false;
                                          setState(() {

                                          });
                                        }else{
                                          mobileValidate = true;
                                          setState(() {

                                          });
                                        }
                                      });
                                    },
                                  ),
                                  24.verticalSpace,
                                AppTextField(
                                  showCurrencySymbol: true,
                                  title: AppLocalizations.of(context).translate("gross_ncome"),
                                  hint: AppLocalizations.of(context).translate("enter_gross_income"),
                                  isCurrency: true,
                                  focusNode: _focusNodeGrossIncome,
                                  controller: incomeController,
                                  validator: (a){
                                    if(incomeController.text.isEmpty || incomeController.text == "0.00"){
                                      return AppLocalizations.of(context)
                                          .translate("mandatory_field_msg");
                                    }else{
                                      return null;
                                    }
                                  },
                                  inputType: const TextInputType.numberWithOptions(decimal: true),                   onTextChanged: (value) {
                                    setState(() {
                                      grossIncome = value.replaceAll(',', '');
                                      _checkFieldValidation = checkFieldValidation();
                                      // value.length == 1 ? _checkFieldValidation = false : _checkFieldValidation = true;
                                      if(incomeController.text.isEmpty || incomeController.text == "0"){
                                        incomeValidate = false;
                                        setState(() {

                                        });
                                      }else{
                                        incomeValidate = true;
                                        setState(() {

                                        });
                                      }
                                    });
                                  },
                                ),
                                24.verticalSpace,
                                AppTextField(
                                  title: AppLocalizations.of(context).translate("loan_amount_required"),
                                  hint: AppLocalizations.of(context).translate("enter_required_loan_amount"),
                                  controller: amountController,
                                  focusNode: _focusNodeReqAmount,
                                  validator: (a){
                                    if(amountController.text.isEmpty || amountController.text == "0.00"){
                                      return AppLocalizations.of(context)
                                          .translate("mandatory_field_msg");
                                    }else{
                                      return null;
                                    }
                                  },
                                  inputType: const TextInputType.numberWithOptions(decimal: true),
                                  isCurrency: true,
                                  initialValue: widget.applyPersonalLoanCalculatorDataViewArgs.loanAmount,
                                  onTextChanged: (value) {
                                    setState(() {
                                      widget.applyPersonalLoanCalculatorDataViewArgs.loanAmount = value.replaceAll(',', '');
                                      if(amountController.text == "0"){
                                        setState(() {
                                          _checkFieldValidation = false;
                                        });
                                      }else{
                                        setState(() {
                                          _checkFieldValidation = true;
                                        });
                                      }
                                      if(amountController.text.isEmpty || amountController.text == "0"){
                                        reqAmountValidate = false;
                                        setState(() {

                                        });
                                      }else{
                                        reqAmountValidate = true;
                                        setState(() {

                                        });
                                      }
                                    });
                                  },
                                ),
                                24.verticalSpace,
                                AppTextField(
                                  isInfoIconVisible: false,
                                  inputType: TextInputType.number,
                                  title: AppLocalizations.of(context).translate("expected_loan_payment_period"),
                                  hint: AppLocalizations.of(context).translate("enter_expected_loan_payment_period"),
                                  controller: _controllerTenure,
                                  focusNode: _focusNodeReqPeriod,
                                  validator: (a){
                                    if(_controllerTenure.text.isEmpty){
                                      return AppLocalizations.of(context)
                                          .translate("mandatory_field_msg");
                                    }else{
                                      return null;
                                    }
                                  },
                                  initialValue: widget.applyPersonalLoanCalculatorDataViewArgs.tenure,
                                  onTextChanged: (value) {
                                    setState(() {
                                      widget.applyPersonalLoanCalculatorDataViewArgs.tenure = value;
                                      if(_controllerTenure.text == ""){
                                        setState(() {
                                          _checkFieldValidation = false;
                                        });
                                      }else{
                                        setState(() {
                                          _checkFieldValidation = true;
                                        });
                                      }
                                      if(_controllerTenure.text.isEmpty){
                                        payentPeriodValidate = false;
                                        setState(() {

                                        });
                                      }else{
                                        payentPeriodValidate = true;
                                        setState(() {

                                        });
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  AppButton(
                    buttonText: AppLocalizations.of(context).translate("submit"),
                    onTapButton: (){
                      isButtonClicked = true;
                      if(_formKey.currentState?.validate() == false){
                        return;
                      }
                      // if(_fieldValidate() == true){
                      widget.applyPersonalLoanCalculatorDataViewArgs.isFromPreLogin ?
                        _onTap() : _onTapPostLogin();
                      // }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkFieldValidation(){
    if(getName == null || _controllerName.text.isEmpty){
      return false;
    } else if (getNic == null || _controllerNIC.text.isEmpty){
      return false;
    } else if (getMobileNum == null || _controllerMobile.text.isEmpty){
      return false;
    } else if (grossIncome == null || incomeController.text.isEmpty){
      return false;
    } else {
      return true;
    }
  }

  _onTapPostLogin(){
    _bloc.add(ApplyPersonalLoanSaveDataEvent(
        mobileNumber: AppConstants.profileData.mobileNo,
        email: AppConstants.profileData.email,
        nic: AppConstants.profileData.nic,
        name: AppConstants.profileData.name,
        // messageType: "savePersonalLoanReq",
        reqType: "PERSONAL_LOAN",
        amount: widget.applyPersonalLoanCalculatorDataViewArgs.loanAmount,
        grossIncome: grossIncome,
        paymentPeriod: widget.applyPersonalLoanCalculatorDataViewArgs.tenure,
        installmentType: widget.applyPersonalLoanCalculatorDataViewArgs.instalmentType,
        rate: widget.applyPersonalLoanCalculatorDataViewArgs.rate
    ));
  }

  _onTap() {
    if(_controllerEmail.text.isEmpty){
      if (appValidator.validateMobileNumber(getMobileNum!)){
        if (appValidator.advancedNicValidation(getNic)) {
          _bloc.add(ApplyPersonalLoanSaveDataEvent(
              mobileNumber: getMobileNum,
              email: getEmail,
              nic: getNic,
              name: getName,
              // messageType: "savePersonalLoanReq",
              reqType: "PERSONAL_LOAN",
              amount: widget.applyPersonalLoanCalculatorDataViewArgs.loanAmount,
              grossIncome: grossIncome,
              paymentPeriod: widget.applyPersonalLoanCalculatorDataViewArgs.tenure,
              installmentType: widget.applyPersonalLoanCalculatorDataViewArgs.instalmentType,
              rate: widget.applyPersonalLoanCalculatorDataViewArgs.rate
          ));
        } else {
          showAppDialog(
              title: AppLocalizations.of(context).translate("nic_incorrect"),
              message: AppLocalizations.of(context).translate("nic_incorrect_des"),
              onPositiveCallback: () {
                _focusNodeNIC.requestFocus();
              },
              positiveButtonText: AppLocalizations.of(context).translate("ok")
          );
        }
      } else {
        showAppDialog(
            title: AppLocalizations.of(context).translate("mobile_num_incorrect_des"),
            message: AppLocalizations.of(context).translate("mobile_num_incorrect"),
            alertType: AlertType.MOBILE,
            onPositiveCallback: () {
              _focusNodeMobile.requestFocus();
            },
            positiveButtonText: AppLocalizations.of(context).translate("ok"));
      }
    } else{
      if (appValidator.validateMobileNumber(getMobileNum!)){
        if (appValidator.advancedNicValidation(getNic)) {
          if (appValidator.validateEmail(getEmail!)){
            _bloc.add(ApplyPersonalLoanSaveDataEvent(
                mobileNumber: getMobileNum,
                email: getEmail,
                nic: getNic,
                name: getName,
                // messageType: "savePersonalLoanReq",
                reqType: "PERSONAL_LOAN",
                amount: widget.applyPersonalLoanCalculatorDataViewArgs.loanAmount,
                grossIncome: grossIncome,
                paymentPeriod: widget.applyPersonalLoanCalculatorDataViewArgs.tenure,
              installmentType: widget.applyPersonalLoanCalculatorDataViewArgs.instalmentType,
              rate: widget.applyPersonalLoanCalculatorDataViewArgs.rate
            ));
          } else {
            showAppDialog(
                title: AppLocalizations.of(context).translate("email_incorrect"),
                message: AppLocalizations.of(context).translate("email_incorrect_des"),
                alertType: AlertType.FAIL,
                onPositiveCallback: () {
                  _focusNodeEmail.requestFocus();
                },
                positiveButtonText: AppLocalizations.of(context).translate("ok"));
          }
        } else {
          showAppDialog(
              title: AppLocalizations.of(context).translate("nic_incorrect"),
              message: AppLocalizations.of(context).translate("nic_incorrect_des"),
              alertType: AlertType.FAIL,
              onPositiveCallback: () {
                _focusNodeNIC.requestFocus();
              },
              positiveButtonText: AppLocalizations.of(context).translate("ok")
          );
        }
      } else {
        showAppDialog(
            title: AppLocalizations.of(context).translate("mobile_num_incorrect_des"),
            message: AppLocalizations.of(context).translate("mobile_num_incorrect"),
            alertType: AlertType.MOBILE,
            onPositiveCallback: () {
              _focusNodeMobile.requestFocus();
            },
            positiveButtonText: AppLocalizations.of(context).translate("ok"));
      }
    }
  }

  bool _fieldValidate(){
    if(_controllerName.text.isEmpty){
      return false;
    }
    if(_controllerNIC.text.isEmpty){
      return false;
    }
    if(_controllerMobile.text.isEmpty){
      return false;
    }
    if(incomeController.text.isEmpty || incomeController.text == "0"){
      return false;
    }
    if(amountController.text.isEmpty || amountController.text == "0"){
      return false;
    }
    if(_controllerTenure.text.isEmpty){
      return false;
    } else {
      return true;
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }

}

// class ThousandsSeparatorInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     final numericValue = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');
//     final formattedValue = NumberFormat('#,###.##').format(double.tryParse(numericValue) ?? 0);
//     return TextEditingValue(
//       text: formattedValue,
//       selection: TextSelection.collapsed(offset: formattedValue.length),
//     );
//   }
// }
