import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/calculators/apply_fd_calculator/apply_fd_calculator_bloc.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/app_validator.dart';
import '../../../../../utils/enums.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../home/home_base_view.dart';
import '../calculators.dart';

class ApplyFixedArgs{
  String? rate;
  String? interestPeriod;
  String? currencyCode;
  String? interestRecieved;
  String? amount;
  bool isFromPreLogin;

  ApplyFixedArgs(
      {this.rate,
      this.interestPeriod,
      this.currencyCode,
      this.amount,
      this.isFromPreLogin = false,
      this.interestRecieved});
}



class ApplyFixedDepositLoan extends BaseView {
  final ApplyFixedArgs applyFixedArgs;


  ApplyFixedDepositLoan({required this.applyFixedArgs});

  @override
  _ApplyFixedDepositLoanState createState() => _ApplyFixedDepositLoanState();
}

class _ApplyFixedDepositLoanState extends BaseViewState<ApplyFixedDepositLoan> {
  // var bloc = injection<SplashBloc>();

  var _bloc = injection<ApplyFDCalculatorBloc>();
  final AppValidator appValidator = AppValidator();
  String? responseCode;
  String? responseDescription;
  String? messageType;
  String? nic;
  String? name;
  String? email;
  String? mobileNumber;
  String? branchName;
  String? reqType;
  bool _checkFieldValidation = false;

  final FocusNode _focusNodeNIC = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeMobile = FocusNode();
  final FocusNode _focusNodeBranch = FocusNode();

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerNIC = TextEditingController();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerBranch = TextEditingController();

  bool nameValidate = false;
  bool nicValidate = false;
  bool mobileValidate = false;
  bool isButtonClicked = false;
  bool branchValidate = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("apply_for_fixed_deposit_account"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<ApplyFDCalculatorBloc,
            BaseState<ApplyFDCalculatorState>>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is ApplyFDCalculatorFieldDataSuccessState) {
              responseCode = state.responseCode;
              responseDescription = state.responseDescription;

              showAppDialog(
                  title: AppLocalizations.of(context).translate("details_submitted"),
                  alertType: AlertType.SUCCESS,
                  message: splitAndJoinAtBrTags(state.responseDescription ?? ""),
                  positiveButtonText: AppLocalizations.of(context).translate("ok"),
                  onPositiveCallback: () {
                    if(widget.applyFixedArgs.isFromPreLogin == true){
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
            if(state is ApplyFDCalculatorFieldDataFailedState){
              ToastUtils.showCustomToast(
                  context, "There was some error", ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding:  EdgeInsets.fromLTRB(20.w, 0.h, 20.w, (20.h+AppSizer.getHomeIndicatorStatus(context))),
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
                                // if(widget.applyFixedArgs.isFromPreLogin)
                                  AppTextField(
                                    maxLines: null,
                                    isInfoIconVisible: false,
                                    title: AppLocalizations.of(context).translate("name"),
                                    hint: AppLocalizations.of(context).translate("enter_your_name"),
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[a-z A-Z .]")),
                                    ],
                                    isEnable:  widget.applyFixedArgs.isFromPreLogin ? true : false,
                                    initialValue: widget.applyFixedArgs.isFromPreLogin ?
                                    "" : AppConstants.profileData.name,
                                    controller: _controllerName,
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
                                        name = value.replaceAll(',', '');
                                        _checkFieldValidation = checkFieldValidation();
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
                                    isEnable:  widget.applyFixedArgs.isFromPreLogin ? true : false,
                                    initialValue: widget.applyFixedArgs.isFromPreLogin ?
                                    "" : AppConstants.profileData.nic,
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9 V v X x]")),
                                    ],
                                    textCapitalization: TextCapitalization.characters,
                                    onTextChanged: (value) {
                                      setState(() {
                                        nic = value.replaceAll(',', '');
                                        _checkFieldValidation = checkFieldValidation();
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
                                    isEnable:  widget.applyFixedArgs.isFromPreLogin ? true : false,
                                    initialValue: widget.applyFixedArgs.isFromPreLogin ?
                                    "" : AppConstants.profileData.email,
                                    focusNode: _focusNodeEmail,
                                    onTextChanged: (value) {
                                      setState(() {
                                        email = value.replaceAll(',', '');
                                      });
                                    },
                                  ),
                                  24.verticalSpace,
                                  AppTextField(
                                    isInfoIconVisible: false,
                                    inputType: TextInputType.phone,
                                    title: AppLocalizations.of(context).translate("Mobile_Number"),
                                    hint: AppLocalizations.of(context).translate("enter_mobile_number"),
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
                                    isEnable:  widget.applyFixedArgs.isFromPreLogin ? true : false,
                                    initialValue: widget.applyFixedArgs.isFromPreLogin ?
                                    "" : AppConstants.profileData.mobileNo,
                                    maxLength: 10,
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]")),
                                    ],
                                    onTextChanged: (value) {
                                      setState(() {
                                        mobileNumber = value.replaceAll(',', '');
                                        _checkFieldValidation = checkFieldValidation();
                                      });
                                    },
                                  ),
                                  24.verticalSpace,
                                AppTextField(
                                  isInfoIconVisible: false,
                                  inputType: TextInputType.text,
                                  title: AppLocalizations.of(context).translate("preferred_branch"),
                                  hint: AppLocalizations.of(context).translate("enter_preferred_branch"),
                                  focusNode: _focusNodeBranch,
                                  controller: _controllerBranch,
                                  validator: (a){
                                    if(branchName ==null || branchName==""){
                                      return AppLocalizations.of(context)
                                          .translate("mandatory_field_msg");
                                    }else{
                                      return null;
                                    }
                                  },
                                  onTextChanged: (value) {
                                    setState(() {
                                      branchName = value.replaceAll(',', '');
                                    });
                                  },
                                ),
                                // AppDropDown(
                                //   validator: (value){
                                //     if(branchName ==null || branchName==""){
                                //       return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                //     }else{
                                //       return null;
                                //     }
                                //   },
                                //   onTap: () async {
                                //     await Navigator.pushNamed(
                                //       context,
                                //       Routes.kDropDownView,
                                //       arguments: DropDownViewScreenArgs(
                                //         isSearchable: false,
                                //         pageTitle: AppLocalizations.of(context).translate("branch"),
                                //         dropDownEvent: GetBankBranchDropDownEvent(bankCode: AppConstants.ubBankCode.toString()),
                                //       ),
                                //     ).then((value) {
                                //       if (value != null && value is CommonDropDownResponse) {
                                //         setState(() {
                                //           branchName=value.description;
                                //           branch = value.code;
                                //           _checkFieldValidation = checkFieldValidation();
                                //           branchValidate = true;
                                //         });
                                //       }
                                //     });
                                //   },
                                //   isFirstItem: false,
                                //   labelText: AppLocalizations.of(context).translate("branch"),
                                //   initialValue: branchName,
                                // ),
                                // Visibility(
                                //   visible: branchValidate == false && isButtonClicked == true,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(top: 10.0),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.start,
                                //       children: [
                                //         Text(
                                //           "This is a required field, please make a selection.",
                                //           style: TextStyle(
                                //             fontSize: 14,
                                //             fontWeight: FontWeight.w400,
                                //             color: colors(context).negativeColor,
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),),

                  Column(
                    children: [
                      20.verticalSpace,
                      AppButton(
                        buttonText:
                        AppLocalizations.of(context).translate("submit"),
                        // buttonType: _checkFieldValidation==true ? ButtonType.ENABLED : ButtonType.DISABLED,
                        onTapButton: (){
                          isButtonClicked = true;
                          if(_formKey.currentState?.validate() == false){
                            return;
                          }
                          widget.applyFixedArgs.isFromPreLogin ?
                            _onTap() : _onTapPostLogin();
                          // _onTap
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
    );
  }

  bool checkFieldValidation(){
    if(name == null || _controllerName.text.isEmpty){
      return false;
    } else if (nic == null || _controllerNIC.text.isEmpty){
      return false;
    } else if (mobileNumber == null || _controllerMobile.text.isEmpty){
      return false;
    } else if (branchName == null || branchName==""){
      return false;
    } else {
      return true;
    }
  }


  _onTapPostLogin() {
    _bloc.add(ApplyFDCalculatorSaveDataEvent(
        mobileNumber: AppConstants.profileData.mobileNo,
        email: AppConstants.profileData.email,
        nic: AppConstants.profileData.nic,
        name: AppConstants.profileData.name,
        branch: branchName,
        messageType: "applyFD",
        reqType: "SAVE_FIXED_DEPOSITE",
        rate: widget.applyFixedArgs.rate,
        // installmentType: "EQUAL",
        interestPeriod: widget.applyFixedArgs.interestPeriod,
        currencyCode: widget.applyFixedArgs.currencyCode,
        interestRecieved: widget.applyFixedArgs.interestRecieved,
        amount: widget.applyFixedArgs.amount
    ));
  }

  _onTap() {
    if(_controllerEmail.text.isEmpty){
      if (appValidator.validateMobileNumber(mobileNumber!)){
        if (appValidator.advancedNicValidation(nic)) {
          _bloc.add(ApplyFDCalculatorSaveDataEvent(
            email: email,
            name: name,
            branch: branchName,
            messageType: "applyFD",
            mobileNumber: mobileNumber,
            nic: nic,
            reqType: "SAVE_FIXED_DEPOSITE",
              rate: widget.applyFixedArgs.rate,
              // installmentType: "EQUAL",
              interestPeriod: widget.applyFixedArgs.interestPeriod,
              currencyCode: widget.applyFixedArgs.currencyCode,
              interestRecieved: widget.applyFixedArgs.interestRecieved,
            amount: widget.applyFixedArgs.amount
          ));
        } else {
          showAppDialog(
              title: AppLocalizations.of(context).translate("nic_incorrect"),
              message: AppLocalizations.of(context).translate("nic_incorrect_des"),
              alertType: AlertType.FAIL,
              onPositiveCallback: () {
                _focusNodeNIC.requestFocus();
              },
              positiveButtonText:  AppLocalizations.of(context).translate("ok")
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
      if (appValidator.validateMobileNumber(mobileNumber!)){
        if (appValidator.advancedNicValidation(nic)) {
          if (appValidator.validateEmail(email!)){
            _bloc.add(ApplyFDCalculatorSaveDataEvent(
              email: email,
              name: name,
              branch: branchName,
              messageType: "applyFD",
              mobileNumber: mobileNumber,
              nic: nic,
              reqType: "SAVE_FIXED_DEPOSITE",
              rate: widget.applyFixedArgs.rate,
              // installmentType: "EQUAL",
              interestPeriod: widget.applyFixedArgs.interestPeriod,
              currencyCode: widget.applyFixedArgs.currencyCode,
              interestRecieved: widget.applyFixedArgs.interestRecieved,
                amount: widget.applyFixedArgs.amount

            ));
          } else {
            showAppDialog(
                title: AppLocalizations.of(context).translate("email_incorrect"),
                message: AppLocalizations.of(context).translate("email_incorrect_des"),
                alertType: AlertType.FAIL,
                onPositiveCallback: () {
                  _focusNodeEmail.requestFocus();
                },
                positiveButtonText:  AppLocalizations.of(context).translate("ok"));
          }
        } else {
          showAppDialog(
              title: AppLocalizations.of(context).translate("nic_incorrect"),
              message: AppLocalizations.of(context).translate("nic_incorrect_des"),
              alertType: AlertType.FAIL,
              onPositiveCallback: () {
                _focusNodeNIC.requestFocus();
              },
              positiveButtonText:  AppLocalizations.of(context).translate("ok")
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
            positiveButtonText:  AppLocalizations.of(context).translate("ok"));
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
    if(branchName == null){
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
