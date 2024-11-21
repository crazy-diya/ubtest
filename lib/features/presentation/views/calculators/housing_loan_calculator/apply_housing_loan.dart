import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/app_validator.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/text_editing_controllers.dart';

import '../../../bloc/calculators/apply_housing_loan/apply_housing_loan_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../home/home_base_view.dart';
import '../calculators.dart';

class ApplyHousingLoanCalculatorDataViewArgs {
  String? loanAmount;
  String? tenure;
  String? instalmentType;
  String? rate;
  bool isFromPreLogin;

  ApplyHousingLoanCalculatorDataViewArgs(
      {
        this.loanAmount,
        this.tenure,
        this.instalmentType,
        this.rate,
        this.isFromPreLogin = false,
      });
}

class ApplyForHousingLoan extends BaseView {
  final ApplyHousingLoanCalculatorDataViewArgs applyHousingLoanCalculatorDataViewArgs;


  ApplyForHousingLoan({required this.applyHousingLoanCalculatorDataViewArgs});

  @override
  _ApplyForHousingLoanState createState() => _ApplyForHousingLoanState();
}

class _ApplyForHousingLoanState extends BaseViewState<ApplyForHousingLoan> {
  var _bloc = injection<ApplyHousingLoanBloc>();
  final AppValidator appValidator = AppValidator();
  String? getName;
  String? getNic;
  String? getEmail;
  String? getMobileNum;

  String? getAmount;
  String? getPaymentPeriod;
  String? getGrossIncome;
  String? getReqType;
  String? getMessageType;
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

  bool nameValidate = false;
  bool nicValidate = false;
  bool mobileValidate = false;
  bool incomeValidate = false;
  bool reqAmountValidate = false;
  bool payentPeriodValidate = false;
  bool isButtonClicked = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    
    super.initState();
    _controllerTenure.text = widget.applyHousingLoanCalculatorDataViewArgs.tenure!;
    amountController.text =widget.applyHousingLoanCalculatorDataViewArgs.loanAmount!;
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        // onBackPressed: (){
        //   Navigator.pushNamed(context, Routes.kHousingLoanCalculatorView, arguments:widget.applyHousingLoanCalculatorDataViewArgs.isFromPreLogin ? true : false);
        // },
        title: AppLocalizations.of(context).translate("apply_housing_loan"),
        goBackEnabled: true,
      ),
      body: BlocProvider<ApplyHousingLoanBloc>(
        create: (context) => _bloc,
        child: BlocListener<ApplyHousingLoanBloc,
            BaseState<ApplyHousingLoanState>>(
          bloc: _bloc,
          listener:(context, state){
            if (state is ApplyHousingLoanFieldDataSuccessState) {

              getAmount = state.amount;
              getPaymentPeriod = state.paymentPeriod;
              getGrossIncome = state.grossIncome;
              getReqType = state.reqType;
              getMessageType = state.messageType;

              showAppDialog(
                  title: AppLocalizations.of(context).translate("details_submitted"),
                  alertType: AlertType.SUCCESS,
                  message: splitAndJoinAtBrTags(state.responseDes ?? ""),
                  positiveButtonText: AppLocalizations.of(context).translate("ok"),
                  onPositiveCallback: () {
                    if(widget.applyHousingLoanCalculatorDataViewArgs.isFromPreLogin == true){
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
            if(state is ApplyHousingLoanFieldDataFailedState){
              ToastUtils.showCustomToast(
                  context, AppLocalizations.of(context).translate("there_was_some_error"), ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding:  EdgeInsets.fromLTRB(20.w, 0.h, 20.w, (20.h + AppSizer.getHomeIndicatorStatus(context))),
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
                                // if(widget.applyHousingLoanCalculatorDataViewArgs.isFromPreLogin)
                                  AppTextField(isInfoIconVisible: false,
                                    title: AppLocalizations.of(context).translate("name"),
                                    hint: AppLocalizations.of(context).translate("enter_your_name"),
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[a-z A-Z .]")),
                                    ],
                                    maxLines: null,
                                    focusNode: _focusNodeName,
                                    controller: _controllerName,
                                    isEnable:  widget.applyHousingLoanCalculatorDataViewArgs.isFromPreLogin ? true : false,
                                    initialValue: widget.applyHousingLoanCalculatorDataViewArgs.isFromPreLogin ?
                                    "" : AppConstants.profileData.name,
                                    validator: (a){
                                      if(_controllerName.text.isEmpty){
                                        return AppLocalizations.of(context)
                                            .translate("mandatory_field_msg");
                                      }else{
                                        return null;
                                      }
                                    },
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
                                    title: AppLocalizations.of(context).translate("nic"),
                                    hint: AppLocalizations.of(context).translate("enter_nic"),
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
                                    isEnable:  widget.applyHousingLoanCalculatorDataViewArgs.isFromPreLogin ? true : false,
                                    initialValue: widget.applyHousingLoanCalculatorDataViewArgs.isFromPreLogin ?
                                    "" : AppConstants.profileData.nic,
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9 V v X x]")),
                                    ],
                                    textCapitalization: TextCapitalization.characters,
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
                                    controller: _controllerEmail,
                                    title: AppLocalizations.of(context).translate("email_optional"),
                                    hint: AppLocalizations.of(context).translate("enter_email_address"),
                                    isEnable:  widget.applyHousingLoanCalculatorDataViewArgs.isFromPreLogin ? true : false,
                                    initialValue: widget.applyHousingLoanCalculatorDataViewArgs.isFromPreLogin ?
                                    "" : AppConstants.profileData.email,
                                    focusNode: _focusNodeEmail,
                                    onTextChanged: (value) {
                                      setState(() {
                                        getEmail = value.replaceAll(',', '');
                                      });
                                    },
                                  ),
                                  24.verticalSpace,
                                  AppTextField(
                                    isInfoIconVisible: false,
                                    inputType: TextInputType.phone,
                                    title: AppLocalizations.of(context).translate("Mobile_Number"),
                                    hint: AppLocalizations.of(context).translate("enter_mobile_number"),
                                    isEnable:  widget.applyHousingLoanCalculatorDataViewArgs.isFromPreLogin ? true : false,
                                    initialValue: widget.applyHousingLoanCalculatorDataViewArgs.isFromPreLogin ?
                                    "" : AppConstants.profileData.mobileNo,
                                    focusNode: _focusNodeMobile,
                                    maxLength: 10,
                                    controller: _controllerMobile,
                                    validator: (a){
                                      if(_controllerMobile.text.isEmpty){
                                        return AppLocalizations.of(context)
                                            .translate("mandatory_field_msg");
                                      }else{
                                        return null;
                                      }
                                    },
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
                                  controller: incomeController,
                                  focusNode: _focusNodeGrossIncome,
                                  validator: (a){
                                    if(incomeController.text.isEmpty || incomeController.text == "0.00"){
                                      return AppLocalizations.of(context)
                                          .translate("mandatory_field_msg");
                                    }else{
                                      return null;
                                    }
                                  },
                                  isCurrency: true,
                                  inputType: const TextInputType.numberWithOptions(decimal: true),                          onTextChanged: (value) {
                                    setState(() {
                                      getGrossIncome = value.replaceAll(',', '');
                                      _checkFieldValidation = checkFieldValidation();
                                      if(value.isEmpty){
                                        setState(() {
                                          _checkFieldValidation = false;
                                        });
                                      }
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
                                  isCurrency: true,
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
                                  inputType: const TextInputType.numberWithOptions(decimal: true),                         initialValue: widget.applyHousingLoanCalculatorDataViewArgs.loanAmount,
                                  onTextChanged: (value) {
                                    setState(() {
                                      widget.applyHousingLoanCalculatorDataViewArgs.loanAmount = value;
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
                                  inputType: TextInputType.phone,
                                  title: AppLocalizations.of(context).translate("expected_loan_payment_period"),
                                  hint: AppLocalizations.of(context).translate("enter_expected_loan_payment_period"),
                                  focusNode: _focusNodeReqPeriod,
                                  controller: _controllerTenure,
                                  validator: (a){
                                    if(_controllerTenure.text.isEmpty){
                                      return AppLocalizations.of(context)
                                          .translate("mandatory_field_msg");
                                    }else{
                                      return null;
                                    }
                                  },
                                  initialValue: widget.applyHousingLoanCalculatorDataViewArgs.tenure,
                                  onTextChanged: (value) {
                                    setState(() {
                                      widget.applyHousingLoanCalculatorDataViewArgs.tenure = value;
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
                    ),),
                  20.verticalSpace,
                  AppButton(
                    buttonText:
                    AppLocalizations.of(context).translate("submit"),
                    onTapButton: (){
                      isButtonClicked = true;
                      if(_formKey.currentState?.validate() == false){
                        return;
                      }
                      // if(_fieldValidate() == true){
                      widget.applyHousingLoanCalculatorDataViewArgs.isFromPreLogin ?
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
    } else if (getGrossIncome == null || incomeController.text.isEmpty){
      return false;
    } else {
      return true;
    }
  }

  _onTapPostLogin() {
    _bloc.add(ApplyHousingLoanSaveDataEvent(
        mobileNumber: AppConstants.profileData.mobileNo,
        email: AppConstants.profileData.email,
        nic: AppConstants.profileData.nic,
        name: AppConstants.profileData.name,
        amount: widget.applyHousingLoanCalculatorDataViewArgs.loanAmount,
        grossIncome: getGrossIncome,
        paymentPeriod: widget.applyHousingLoanCalculatorDataViewArgs.tenure,
        reqType: "HOUSING_LOAN",
        messageType:"applyHousingLoan",
        rate: widget.applyHousingLoanCalculatorDataViewArgs.rate,
        installmentType: widget.applyHousingLoanCalculatorDataViewArgs.instalmentType
    ));
  }


  _onTap() {
    if(_controllerEmail.text.isEmpty){
      if (appValidator.validateMobileNumber(getMobileNum!)){
        if (appValidator.advancedNicValidation(getNic)) {
          _bloc.add(ApplyHousingLoanSaveDataEvent(
              mobileNumber: getMobileNum,
              email: getEmail,
              nic: getNic,
              name: getName,
              amount: widget.applyHousingLoanCalculatorDataViewArgs.loanAmount,
              grossIncome: getGrossIncome,
              paymentPeriod: widget.applyHousingLoanCalculatorDataViewArgs.tenure,
              reqType: "HOUSING_LOAN",
              messageType:"applyHousingLoan",
            rate: widget.applyHousingLoanCalculatorDataViewArgs.rate,
            installmentType: widget.applyHousingLoanCalculatorDataViewArgs.instalmentType
          ));
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
    } else{
      if (appValidator.validateMobileNumber(getMobileNum!)){
        if (appValidator.advancedNicValidation(getNic)) {
          if (appValidator.validateEmail(getEmail!)){
            _bloc.add(ApplyHousingLoanSaveDataEvent(
                mobileNumber: getMobileNum,
                email: getEmail,
                nic: getNic,
                name: getName,
                amount: widget.applyHousingLoanCalculatorDataViewArgs.loanAmount,
                grossIncome: getGrossIncome,
                paymentPeriod: widget.applyHousingLoanCalculatorDataViewArgs.tenure,
                reqType: "HOUSING_LOAN",
                messageType:"applyHousingLoan",
                rate: widget.applyHousingLoanCalculatorDataViewArgs.rate,
                installmentType: widget.applyHousingLoanCalculatorDataViewArgs.instalmentType
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
