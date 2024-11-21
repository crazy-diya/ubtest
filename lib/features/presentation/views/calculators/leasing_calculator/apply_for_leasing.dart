import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_validator.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../../data/models/responses/city_response.dart';
import '../../../bloc/calculators/apply_leasing_calculator/apply_leasing_calculator_bloc.dart';
import '../../../bloc/drop_down/drop_down_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/drop_down_widgets/drop_down.dart';
import '../../../widgets/drop_down_widgets/drop_down_view.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../home/home_base_view.dart';
import '../calculators.dart';

class ApplyLeasingArgs{
  String? rate;
  String? vehicleCategory;
  String? vehicleType;
  String? manufactYear;
  String? price;
  String? advancePayment;
  String? amount;
  String? tenure;
  bool isFromPreLogin;

  ApplyLeasingArgs(
      {this.rate,
      this.vehicleCategory,
      this.vehicleType,
      this.manufactYear,
      this.price,
      this.amount,
      this.tenure,
      this.advancePayment,
      this.isFromPreLogin = false
      });
}



class ApplyLeasingView extends BaseView {
final ApplyLeasingArgs applyLeasingArgs;


ApplyLeasingView({required this.applyLeasingArgs});

  @override
  _ApplyLeasingViewState createState() => _ApplyLeasingViewState();
}

class _ApplyLeasingViewState extends BaseViewState<ApplyLeasingView> {
  // var bloc = injection<SplashBloc>();

  var _bloc = injection<ApplyLeasingCalculatorBloc>();
  final AppValidator appValidator = AppValidator();
  String? messageType;
  String? responseCode;
  String? responseDescription;
  String? name;
  String? nic;
  String? email;
  String? mobileNumber;
  String? branch;
  String? branchName;
  String? reqType;
  bool _checkFieldValidation = false;

  final FocusNode _focusNodeNIC = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeMobile = FocusNode();

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerNIC = TextEditingController();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  bool nameValidate = false;
  bool nicValidate = false;
  bool mobileValidate = false;
  bool isButtonClicked = false;
  bool branchValidate = false;

  final _formKey = GlobalKey<FormState>();


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("leasing_calculator"),
        goBackEnabled: true,
      ),
      body: BlocProvider<ApplyLeasingCalculatorBloc>(
        create: (context) => _bloc,
        child: BlocListener<ApplyLeasingCalculatorBloc,
            BaseState<ApplyLeasingCalculatorState>>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is ApplyLeasingCalculatorFieldDataSuccessState) {
              responseCode = state.responseCode;
              responseDescription = state.responseDescription;

              showAppDialog(
                  title: AppLocalizations.of(context).translate("details_submitted"),
                  alertType: AlertType.SUCCESS,
                  message: AppLocalizations.of(context)
                      .translate("your_loan_quotation_request"),
                  positiveButtonText: AppLocalizations.of(context).translate("ok"),
                  onPositiveCallback: () {
                    if(widget.applyLeasingArgs.isFromPreLogin == true){
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => CalculatorsView(isFromPreLogin: true,)),
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

              // Navigator.pushNamed(
              //     context, Routes.kApplyPersonalLoanView);
            }
            else if(state is ApplyLeasingCalculatorFieldDataFailedState){
              ToastUtils.showCustomToast(
                  context, "There was some error", ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 24,right: 24,top: 30,bottom: 24),
            child: Form(
              key: _formKey,
              onChanged: (){
                setState(() {

                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            AppLocalizations.of(context).translate("apply_for_leasing"),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: colors(context).blackColor,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            AppLocalizations.of(context).translate("please_fill_all_information"),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: colors(context).blackColor,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AppTextField(isInfoIconVisible: false,

                            hint: AppLocalizations.of(context).translate("name"),
                            maxLines: null,
                            isLabel: true,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-z A-Z .]")),
                            ],
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
                          const SizedBox(
                            height: 30,
                          ),
                          AppTextField(isInfoIconVisible: false,
                            hint: AppLocalizations.of(context).translate("nic"),
                            isLabel: true,
                            focusNode: _focusNodeNIC,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9 V v X x]")),
                            ],
                            validator: (a){
                              if(_controllerNIC.text.isEmpty){
                                return AppLocalizations.of(context)
                                    .translate("mandatory_field_msg");
                              }else{
                                return null;
                              }
                            },
                            textCapitalization: TextCapitalization.characters,
                            controller: _controllerNIC,
                            onTextChanged: (value) {
                              setState(() {
                                nic = value.replaceAll(',', '');
                                _checkFieldValidation = checkFieldValidation();
                                if(_controllerNIC.text.isEmpty){
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
                          const SizedBox(
                            height: 30,
                          ),
                          AppTextField(isInfoIconVisible: false,
                            inputType: TextInputType.emailAddress,
                            controller: _controllerEmail,
                            hint: AppLocalizations.of(context).translate("email_optional"),
                            focusNode: _focusNodeEmail,
                            isLabel: true,
                            onTextChanged: (value) {
                              setState(() {
                                email = value.replaceAll(',', '');
                              });
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AppTextField(isInfoIconVisible: false,
                            inputType: TextInputType.phone,
                            hint: AppLocalizations.of(context).translate("Mobile_Number"),
                            isLabel: true,
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
                                mobileNumber = value.replaceAll(',', '');
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
                          const SizedBox(
                            height: 30,
                          ),
                          AppDropDown(
                            validator: (value){
                              if(branchName ==null || branchName == ""){
                                return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                              }else{
                                return null;
                              }
                            },
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  isSearchable: false,
                                  pageTitle: AppLocalizations.of(context).translate("branch"),
                                  dropDownEvent: GetBankBranchDropDownEvent(bankCode: AppConstants.ubBankCode.toString()),
                                ),
                              ).then((value) {
                                if (value != null && value is CommonDropDownResponse) {
                                  setState(() {
                                    branchName=value.description;
                                    branch = value.code;
                                    _checkFieldValidation = checkFieldValidation();
                                    branchValidate = true;
                                  });
                                }
                              });
                            },
                            isFirstItem: false,
                            labelText: AppLocalizations.of(context).translate("branch"),
                            initialValue: branchName,
                          ),
                          Visibility(
                            visible: branchValidate == false && isButtonClicked == true,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "This is a required field, please make a selection.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: colors(context).negativeColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  AppButton(
                    buttonText:
                    AppLocalizations.of(context).translate("submit"),
                    // buttonType: _checkFieldValidation==true ? ButtonType.ENABLED : ButtonType.DISABLED,
                    onTapButton:(){
                      isButtonClicked = true;
                      if(_formKey.currentState?.validate() == false){
                        return;
                      }
                      // if(_controllerName.text.isEmpty){
                      //   nameValidate = false;
                      //   // _focusNodeName.requestFocus();
                      //   setState(() {
                      //
                      //   });
                      // }
                      // if(_controllerNIC.text.isEmpty){
                      //   nicValidate = false;
                      //   // _focusNodeNIC.requestFocus();
                      //   setState(() {
                      //
                      //   });
                      // }
                      // if(_controllerMobile.text.isEmpty){
                      //   mobileValidate = false;
                      //   // _focusNodeMobile.requestFocus();
                      //   setState(() {
                      //
                      //   });
                      // }
                      _onTap();
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
    if(name == null || _controllerName.text.isEmpty){
      return false;
    } else if (nic == null || _controllerNIC.text.isEmpty){
      return false;
    } else if (mobileNumber == null || _controllerMobile.text.isEmpty){
      return false;
    } else if (branch == null || branch==""){
      return false;
    } else {
      return true;
    }
  }

  _onTap() {
    if(_controllerEmail.text.isEmpty){
      if (appValidator.validateMobileNumber(mobileNumber!)){
        if (appValidator.advancedNicValidation(nic)) {
          _bloc.add(ApplyLeasingCalculatorSaveDataEvent(
            mobileNumber: mobileNumber,
            email: email,
            nic: nic,
            name: name,
            branch: branch,
            messageType:"applyLeasingCalculator",
            reqType: "LEASING",
            rate: widget.applyLeasingArgs.rate,
            // installmentType: "EQUAL",
            vehicleType: widget.applyLeasingArgs.vehicleType,
            vehicleCategory: widget.applyLeasingArgs.vehicleCategory,
            manufactYear: int.parse(widget.applyLeasingArgs.manufactYear!),
            price: int.parse(widget.applyLeasingArgs.price!),
            advancedPayment: int.parse(widget.applyLeasingArgs.advancePayment!),
            amount: int.parse(widget.applyLeasingArgs.amount!),
            interestPeriod: widget.applyLeasingArgs.tenure
          ));
        } else {
          showAppDialog(
              title: "NIC seems incorrect, please try gain",
              message:
              "NIC seems incorrect",
              alertType: AlertType.FAIL,
              onPositiveCallback: () {
                _focusNodeNIC.requestFocus();
              },
              positiveButtonText: "Ok"
          );
        }
      } else {
        showAppDialog(
            title: "Mobile Number seems incorrect, please try gain",
            message:
            "Mobile Number seems incorrect",
            alertType: AlertType.MOBILE,
            onPositiveCallback: () {
              _focusNodeMobile.requestFocus();
            },
            positiveButtonText: "Ok");
      }
    } else{
      if (appValidator.validateMobileNumber(mobileNumber!)){
        if (appValidator.advancedNicValidation(nic)) {
          if (appValidator.validateEmail(email!)){
            _bloc.add(ApplyLeasingCalculatorSaveDataEvent(
                mobileNumber: mobileNumber,
                email: email,
                nic: nic,
                name: name,
                branch: branch,
                messageType:"applyLeasingCalculator",
                reqType: "LEASING",
                rate: widget.applyLeasingArgs.rate,
                // installmentType: "EQUAL",
                vehicleType: widget.applyLeasingArgs.vehicleType,
                vehicleCategory: widget.applyLeasingArgs.vehicleCategory,
                manufactYear: int.parse(widget.applyLeasingArgs.manufactYear!),
                price: int.parse(widget.applyLeasingArgs.price!),
                advancedPayment: int.parse(widget.applyLeasingArgs.advancePayment!),
                amount: int.parse(widget.applyLeasingArgs.amount!),
                interestPeriod: widget.applyLeasingArgs.tenure
            ));
          } else {
            showAppDialog(
                title: "Email seems incorrect, please try gain",
                message:
                "Email seems incorrect",
                alertType: AlertType.FAIL,
                onPositiveCallback: () {
                  _focusNodeEmail.requestFocus();
                },
                positiveButtonText: "Ok");
          }
        } else {
          showAppDialog(
              title: "NIC seems incorrect, please try gain",
              message:
              "NIC seems incorrect",
              alertType: AlertType.FAIL,
              onPositiveCallback: () {
                _focusNodeNIC.requestFocus();
              },
              positiveButtonText: "Ok"
          );
        }
      } else {
        showAppDialog(
            title: "Mobile Number seems incorrect, please try gain",
            message:
            "Mobile Number seems incorrect",
            alertType: AlertType.MOBILE,
            onPositiveCallback: () {
              _focusNodeMobile.requestFocus();
            },
            positiveButtonText: "Ok");
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
