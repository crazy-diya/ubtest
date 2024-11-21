import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import '../../../../../core/service/app_permission.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/service/storage_service.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../../utils/text_editing_controllers.dart';
import '../../../../data/models/requests/calculator_share_pdf_request.dart';
import '../../../../data/models/responses/city_response.dart';
import '../../../bloc/calculators/leasing_calculator/leasing_calculator_bloc.dart';
import '../../../bloc/drop_down/drop_down_bloc.dart';
import '../../../widgets/app_button.dart';

import '../../../widgets/appbar.dart';
import '../../../widgets/drop_down_widgets/drop_down.dart';
import '../../../widgets/drop_down_widgets/drop_down_view.dart';
import '../../../widgets/pop_scope/ub_pop_scope.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../widgets/bank_tc_summary.dart';

class LeasingCalculatorView extends BaseView {
  final bool isFromPreLogin;

  LeasingCalculatorView({this.isFromPreLogin = false});

  @override
  _LeasingCalculatorViewState createState() => _LeasingCalculatorViewState();
}

class _LeasingCalculatorViewState extends BaseViewState<LeasingCalculatorView> {
  // var bloc = injection<SplashBloc>();
  var bloc = injection<LeasingCalculatorBloc>();
  String? monthlyInstallment;
  String? interestRate;
  String? rate;

  String? messageType;
  String? vehicleCategory;
  String? displayedVehicleCategory;
  String? vehicleType;
  String? displayedVehicleType;
  String? manufactYear;
  String? price;
  String? advancedPayment;
  String? ghostId;
  String? amount;
  String? tenure;
  String? tenureForFront;
  int thisYear = DateTime.now().year;

  bool? showBankTC = false;

  double initialValue = 75000.0;
  late TextEditingController textEditingController;
  final TextEditingController _controller1 = TextEditingController();
  CurrencyTextEditingController priceController = CurrencyTextEditingController();
  CurrencyTextEditingController advanceController = CurrencyTextEditingController();
  CurrencyTextEditingController leaseController = CurrencyTextEditingController();
  final TextEditingController _controller5 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();

  bool yearValidate = false;
  bool prizeValidate = false;
  bool advancePaymentValidate = false;
  bool reqLeaseAmountValidate = false;
  bool categoryValidate = false;
  bool typeValidate = false;
  bool periodValidate = false;
  bool rateValidate = false;
  bool isButtonClicked = false;

  bool _isInputValid = false;

  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    textEditingController =
        TextEditingController(text: initialValue.toStringAsFixed(2));
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void clearTextField() {
    _controller1.clear();
    priceController = CurrencyTextEditingController();
    advanceController = CurrencyTextEditingController();
    leaseController = CurrencyTextEditingController();
    _controller5.clear();
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async{
        if (showBankTC == true) {
          setState(() {
            showBankTC = false;
          });
        } else {
          Navigator.pop(
            context,
            Routes.kCalculatorsView,
          );
        }
        return false;
      },
      child: Scaffold(
        appBar: UBAppBar(
          onBackPressed: () {
            if (showBankTC == true) {
              setState(() {
                showBankTC = false;
              });
            } else {
              Navigator.pop(context, Routes.kCalculatorsView);
            }
          },
          title: AppLocalizations.of(context).translate("leasing_calculator"),
          goBackEnabled: true,
        ),
        body: BlocProvider<LeasingCalculatorBloc>(
          create: (context) => bloc,
          child: BlocListener<LeasingCalculatorBloc,
              BaseState<LeasingCalculatorState>>(
            listener: (context, state) {
              if (state is LeasingPDFSuccessState) {
                setState(() {});
                var data = base64.decode(state.document!);
                StorageService(directoryName: 'UB').storeFile(
                    fileName: "cal",
                    fileExtension: 'pdf',
                    fileData: data,
                    onComplete: (file) async {
                      if (state.shouldOpen!) {
                        await OpenFilex.open(file.path);
                      } else {
                        Share.shareXFiles(
                          [file],
                        );
                      }
                    },
                    onError: (error) {
                      ToastUtils.showCustomToast(
                          context, error, ToastStatus.FAIL);
                    });
              }
              if (state is LeasingFieldDataSuccessState) {
                setState(() {
                  monthlyInstallment = state.monthlyInstallment;
                  rate = state.rate;
                  showBankTC = true;
                });
                // Navigator.pushNamed(
                //     context, Routes.kApplyPersonalLoanView);
              }
              else if (state is LeasingFieldDataFailedState) {
                ToastUtils.showCustomToast(
                    context, "There was some error", ToastStatus.FAIL);
              }
            },
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: BankTandCWidget(
                              isFromPreLogin: widget.isFromPreLogin,
                              advancePayment: advancedPayment ?? "0",
                              manufactYear: manufactYear ?? "0",
                              price: price ?? "0",
                              amount: amount ?? "0",
                              category: vehicleCategory ?? "0",
                              type: vehicleType ?? "0",
                              tenure: tenureForFront ?? "0",
                              tenureLeasing: tenure ?? "0",
                              interestRate: rate ?? "0",
                              isShow: showBankTC!,
                              loanType: 'Apply for a Lease',
                              title: 'Monthly Rental',
                              leasingInstallment: monthlyInstallment ?? "0",
                              calculatorType: CalculatorType.LEASING,
                              navigateToPage: () {
                                Navigator.pushNamed(
                                    context, Routes.kApplyLeasingView);
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyLeasingView()));
                              },
                              //navigateToPage: ApplyLeasingView(),
                              buttonTap: () {
                                Navigator.pushNamed(
                                    context, Routes.kLeasingPersonalInfoView);
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyForHousingLoan()));
                              },
                              shareTap: (calType) {
                                if (calType == CalculatorType.LEASING) {
                                  bloc.add(LeasingPDFDataEvent(
                                    shouldOpen: true,
                                    title: "Personal Loan Calculator",
                                    docBody: <DocBody>[
                                      DocBody(
                                        fieldName: "Vehicle Category",
                                        fieldValue: vehicleCategory,
                                      ),
                                      DocBody(
                                          fieldName: "Vehicle Type",
                                          fieldValue: vehicleType),
                                      DocBody(
                                          fieldName: "Year of Manufacture",
                                          fieldValue: manufactYear),
                                      DocBody(
                                          fieldName: "Price of the Vehicle",
                                          fieldValue: price),
                                      DocBody(
                                          fieldName:
                                              "Advance Payment to the Seller",
                                          fieldValue: advancedPayment),
                                      DocBody(
                                          fieldName: "Required Lease Amount",
                                          fieldValue: amount),
                                      DocBody(
                                          fieldName: "Lease Period",
                                          fieldValue: tenure),
                                      DocBody(
                                          fieldName: "Interest Rate",
                                          fieldValue: rate! + "%"),
                                      DocBody(
                                          fieldName: "Monthly Rental",
                                          fieldValue: monthlyInstallment),
                                    ],
                                  ));
                                  AppPermissionManager
                                      .requestExternalStoragePermission(
                                          context, () {});
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: AppDropDown(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.kDropDownView,
                                    arguments: DropDownViewScreenArgs(
                                      isSearchable: true,
                                      pageTitle: AppLocalizations.of(context)
                                          .translate("vehicle_category"),
                                      dropDownEvent: GetVehicleOptionEvent(),
                                    )).then((value) {
                                  if (value != null &&
                                      value is CommonDropDownResponse) {
                                    setState(() {
                                      vehicleCategory = value.key;
                                      displayedVehicleCategory =
                                          value.description;
                                      _isInputValid = _isInputValidate();
                                      categoryValidate = true;
                                    });
                                  }
                                });
                              },
                              labelText: AppLocalizations.of(context)
                                  .translate("vehicle_category"),
                              initialValue: displayedVehicleCategory,
                              validator: (value){
                                if(displayedVehicleCategory ==null || displayedVehicleCategory==""){
                                  return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                }else{
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: AppDropDown(
                              validator: (value){
                                if(displayedVehicleType ==null || displayedVehicleType==""){
                                  return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                }else{
                                  return null;
                                }
                              },
                              onTap: () {
                                Navigator.pushNamed(context, Routes.kDropDownView,
                                    arguments: DropDownViewScreenArgs(
                                      isSearchable: true,
                                      pageTitle: 'Vehicle Type',
                                      dropDownEvent: GetVehicleTypeEvent(),
                                    )).then((value) {
                                  if (value != null &&
                                      value is CommonDropDownResponse) {
                                    setState(() {
                                      vehicleType = value.key;
                                      displayedVehicleType = value.description;
                                      _isInputValid = _isInputValidate();
                                      typeValidate = true;
                                    });
                                  }
                                });
                              },
                              labelText: 'Vehicle Type',
                              initialValue: displayedVehicleType,
                            ),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: AppTextField(
                              controller: _controller1,
                              validator: (a){
                                if(_controller1.text.isEmpty){
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                }else{
                                  return null;
                                }
                              },
                              isCurrency: false,
                              maxLength: 4,
                              inputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,],
                              // inputType: TextInputType.numberWithOptions(decimal: true),
                              // inputFormatter: [ThousandsSeparatorInputFormatter()],
                              hint: AppLocalizations.of(context)
                                  .translate("year_of_manufacture"),
                              isLabel: true,
                              focusNode: _focusNode1,
                              onTextChanged: (value) {
                                setState(() {
                                  manufactYear = value.replaceAll(',', '');
                                  _isInputValid = _isInputValidate();
                                  if (_controller1.text.isEmpty) {
                                    yearValidate = false;
                                    setState(() {});
                                  } else {
                                    yearValidate = true;
                                    setState(() {});
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: AppTextField(
                              controller: priceController,
                              validator: (a){
                                if(priceController.text.isEmpty || priceController.text == "0.00"){
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                }else{
                                  return null;
                                }
                              },
                              showCurrencySymbol: true,
                              focusNode: _focusNode2,
                              hint: AppLocalizations.of(context)
                                  .translate("price_of_the_vehicle"),
                              isLabel: true,
                              isCurrency: true,
                              inputType: const TextInputType.numberWithOptions(decimal: true),                         onTextChanged: (value) {
                                setState(() {
                                  price = value.replaceAll(',', '');
                                  _isInputValid = _isInputValidate();
                                  if (priceController.text.isEmpty ||
                                      _controller1.text == "0") {
                                    prizeValidate = false;
                                    setState(() {});
                                  } else {
                                    prizeValidate = true;
                                    setState(() {});
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: AppTextField(
                              controller: advanceController,
                              focusNode: _focusNode3,
                              validator: (a){
                                if(advanceController.text.isEmpty || advanceController.text == "0.00"){
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                }else{
                                  return null;
                                }
                              },
                              showCurrencySymbol: true,
                              hint: AppLocalizations.of(context)
                                  .translate("advance_payment"),
                              isLabel: true,
                              isCurrency: true,
                              inputType: const TextInputType.numberWithOptions(decimal: true),                          onTextChanged: (value) {
                                setState(() {
                                  advancedPayment = value.replaceAll(',', '');
                                  _isInputValid = _isInputValidate();
                                  if (advanceController.text.isEmpty ||
                                      _controller1.text == "0") {
                                    advancePaymentValidate = false;
                                    setState(() {});
                                  } else {
                                    advancePaymentValidate = true;
                                    setState(() {});
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: AppTextField(
                              controller: leaseController,
                              validator: (a){
                                if(leaseController.text.isEmpty || leaseController.text == "0.00"){
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                }else{
                                  return null;
                                }
                              },
                              focusNode: _focusNode4,
                              showCurrencySymbol: true,
                              hint: AppLocalizations.of(context)
                                  .translate("required_lease_amount"),
                              isLabel: true,
                              isCurrency: true,
                              inputType: const TextInputType.numberWithOptions(decimal: true),                             onTextChanged: (value) {
                                setState(() {
                                  amount = value.replaceAll(',', '');
                                  _isInputValid = _isInputValidate();
                                  if (leaseController.text.isEmpty ||
                                      _controller1.text == "0") {
                                    reqLeaseAmountValidate = false;
                                    setState(() {});
                                  } else {
                                    reqLeaseAmountValidate = true;
                                    setState(() {});
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: AppDropDown(
                              validator: (value){
                                if(tenureForFront ==null || tenureForFront == ""){
                                  return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                }else{
                                  return null;
                                }
                              },
                              onTap: () {
                                Navigator.pushNamed(context, Routes.kDropDownView,
                                    arguments: DropDownViewScreenArgs(
                                      isSearchable: true,
                                      pageTitle: AppLocalizations.of(context)
                                          .translate("lease_period"),
                                      dropDownEvent: GetLeaseYearEvent(),
                                    )).then((value) {
                                  if (value != null &&
                                      value is CommonDropDownResponse) {
                                    setState(() {
                                      tenure = value.key;
                                      tenureForFront = value.description;
                                      _isInputValid = _isInputValidate();
                                      periodValidate = true;
                                      if (showBankTC == true) {
                                        bloc.add(
                                          LeasingSaveDataEvent(
                                            tenure: tenure,
                                            amount: amount,
                                            advancedPayment: advancedPayment,
                                            manufactYear: manufactYear,
                                            price: price,
                                            rate: interestRate,
                                            vehicleCategory: vehicleCategory,
                                            vehicleType: vehicleType,
                                            messageType: "getLeasingCalculator",
                                          ),
                                        );
                                      }
                                    });
                                  } else {
                                    _isInputValid = true;
                                  }
                                });
                              },
                              labelText: AppLocalizations.of(context)
                                  .translate("lease_period"),
                              initialValue: tenureForFront,
                            ),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: AppTextField(
                              isInfoIconVisible: false,
                              isCurrency: false,
                              inputType: TextInputType.number,
                              controller: _controller5,
                              validator: (a){
                                if(_controller5.text.isEmpty){
                                  return AppLocalizations.of(context)
                                      .translate("mandatory_field_msg");
                                }else{
                                  return null;
                                }
                              },
                              focusNode: _focusNode5,
                              maxLength: 5,
                              hint: 'Interest Rate',
                              // AppLocalizations.of(context)
                              //     .translate("interest_rate"),
                              isLabel: true,
                              inputFormatter: [
                                // FilteringTextInputFormatter.allow(RegExp(r'^\d+%?$')),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9 .]")),
                              ],
                              onTextChanged: (value) {
                                _controller5.text = '$value%';
                                _controller5.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: _controller5.text.length - 1));
                                if (_controller5.text.endsWith('%%')) {
                                  _controller5.text = _controller5.text
                                      .substring(0, _controller5.text.length - 1);
                                  _controller5.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: _controller5.text.length - 1));
                                }
                                if (_controller5.text.startsWith('%')) {
                                  _controller5.text = _controller5.text
                                      .substring(0, _controller5.text.length - 1);
                                  _controller5.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: _controller5.text.length));
                                }
                                if (_controller5.text.length == 2) {
                                  _controller5.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: _controller5.text.length - 1));
                                }
                                setState(() {
                                  interestRate = value.replaceAll('%', '');
                                  _isInputValid = _isInputValidate();
                                  if (_controller5.text.isNotEmpty) {
                                    if (double.parse(_controller5.text
                                            .replaceAll('%', '')) >
                                        100) {
                                      _controller5.clear();
                                    }
                                  }
                                  if (_controller5.text.isEmpty) {
                                    rateValidate = false;
                                    setState(() {});
                                  } else {
                                    rateValidate = true;
                                    setState(() {});
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        AppButton(
                            buttonText: AppLocalizations.of(context)
                                .translate("calculate"),
                            onTapButton: () {
                              isButtonClicked = true;
                              if(_formKey.currentState?.validate() == false){
                                return;
                              }
                                _focusNode1.unfocus();
                                _focusNode2.unfocus();
                                _focusNode3.unfocus();
                                _focusNode4.unfocus();
                                _focusNode5.unfocus();
                                bloc.add(
                                  LeasingSaveDataEvent(
                                    tenure: tenure,
                                    amount: amount,
                                    advancedPayment: advancedPayment,
                                    manufactYear: manufactYear,
                                    price: price,
                                    rate: interestRate,
                                    vehicleCategory: vehicleCategory,
                                    vehicleType: vehicleType,
                                    messageType: "getLeasingCalculator",
                                  ),
                                );
                            }),
                        AppButton(
                                          buttonType: ButtonType.OUTLINEENABLED,
                          buttonText:
                              AppLocalizations.of(context).translate("reset"),
                         
                          onTapButton: () {
                            setState(() {
                              clearTextField();
                              vehicleType = null;
                              vehicleCategory = null;
                              manufactYear = null;
                              price = null;
                              advancedPayment = null;
                              amount = null;
                              displayedVehicleType = null;
                              displayedVehicleCategory = null;
                              interestRate = null;
                              tenure = null;
                              tenureForFront = null;
                              showBankTC = false;
                              _isInputValid = false;
                              _focusNode1.unfocus();
                              _focusNode2.unfocus();
                              _focusNode3.unfocus();
                              _focusNode4.unfocus();
                              _focusNode5.unfocus();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isInputValidate() {
    if (vehicleCategory == null) {
      return false;
    } else if (vehicleType == null) {
      return false;
    } else if (manufactYear == null || _controller1.text.isEmpty) {
      return false;
    } else if (price == null || priceController.text == "0") {
      return false;
    } else if (advancedPayment == null || advanceController.text == "0") {
      return false;
    } else if (amount == null || leaseController.text == "0") {
      return false;
    } else if (tenure == null) {
      return false;
    } else if (interestRate == null || _controller5.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool buttonRate() {
    if (_controller5.text.isEmpty) {
      return false;
    } else {
      if (double.parse(_controller5.text.replaceAll('%', '')) > 0) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool _fieldValidate() {
    if (_controller1.text.isEmpty) {
      return false;
    }
    if (priceController.text.isEmpty || priceController.text == "0") {
      return false;
    }
    if (advanceController.text.isEmpty || advanceController.text == "0") {
      return false;
    }
    if (leaseController.text.isEmpty || leaseController.text == "0") {
      return false;
    }
    if (_controller5.text.isEmpty || _controller5.text == "0") {
      return false;
    }
    if (displayedVehicleCategory == null) {
      return false;
    }
    if (displayedVehicleType == null) {
      return false;
    }
    if (tenureForFront == null) {
      return false;
    }else {
      return true;
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}

