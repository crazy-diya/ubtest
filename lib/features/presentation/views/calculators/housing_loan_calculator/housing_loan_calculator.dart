import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/calculators/housing_loan_calculator/housing_loan_calculator_bloc.dart';

import '../../../../../core/service/app_permission.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/service/storage_service.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../../utils/text_editing_controllers.dart';

import '../../../../data/models/requests/calculator_share_pdf_request.dart';
import '../../../widgets/app_button.dart';

import '../../../widgets/app_radio_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/pop_scope/ub_pop_scope.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../request_money/request_money_view.dart';
import '../widgets/bank_tc_summary.dart';

class HousingLoanCalculator extends BaseView {
  final bool isFromPreLogin;


  HousingLoanCalculator({this.isFromPreLogin = false});
  @override
  _HousingLoanCalculatorState createState() => _HousingLoanCalculatorState();
}

class _HousingLoanCalculatorState extends BaseViewState<HousingLoanCalculator> {
  var bloc = injection<HousingLoanCalculatorBloc>();
  String? selectedMonth;
  String? loanAmount;
  String? _selectedRadioValue;
  String? selectedInterestedType;
  String? selectedPurposeLoan;
  bool? showBankTC = false;
  String? monthlyInstallment;
  String? interestRate;
  String? rate;
  String? amount;
  String? tenure;
  String? tenureHousing;
  late int val;

  double initialValue = 100000.0;
  double minValue = 100000.0;
  double maxValue = 100000000.0;

  late TextEditingController textEditingController;
  var thousandFormatter = ThousandsSeparatorInputFormatter();

  CurrencyTextEditingController amountController = CurrencyTextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  bool _isInputValid = false;
  bool isTenureValid = true;

  bool amountValidate = false;
  bool tenureValidate = false;
  bool rateValidate = false;
  bool insTypeValidate = true;
  bool isButtonClicked = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textEditingController =
        TextEditingController(text: initialValue.toStringAsFixed(2));
  }

  void clearTextField() {
    amountController = CurrencyTextEditingController();
    _controller2.clear();
    _controller3.clear();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
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
          Navigator.pop(context, Routes.kCalculatorsView,
              // arguments: widget.isFromPreLogin ? true : false
          );
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          actions: [
            if(showBankTC! == true)
              IconButton(
                icon: PhosphorIcon(PhosphorIcons.shareNetwork(PhosphorIconsStyle.bold) ,
                  color: colors(context).whiteColor,),
                onPressed: (){
                  bloc.add(HousingLoanPDFDataEvent(
                    shouldOpen: false,
                    title: "Personal Loan Calculator",
                    docBody: <DocBody>[
                      DocBody(
                        fieldName: "Loan Amount",
                        fieldValue: amount,
                      ),
                      DocBody(
                          fieldName: "Tenure",
                          fieldValue: tenure),
                      DocBody(
                          fieldName: "Interest Rate",
                          fieldValue: rate! + '%'),
                      DocBody(
                          fieldName: "Installment Type",
                          fieldValue: _selectedRadioValue),
                      DocBody(
                          fieldName: "Monthly Installment",
                          fieldValue: monthlyInstallment),
                    ],
                  ));
                  AppPermissionManager
                      .requestExternalStoragePermission(context, () {});
                },
              )
          ],
          onBackPressed: () {
            if(showBankTC == true){
              setState(() {
                showBankTC = false;
              });
            }else{
              Navigator.pop(context, Routes.kCalculatorsView ,
                  // arguments:widget.isFromPreLogin ? true : false
              );
            }
          },
          title: AppLocalizations.of(context).translate(
              "housing_loan_calculator"),
          goBackEnabled: true,
        ),
        body: BlocProvider(
          create: (context) => bloc,
          child: BlocListener<HousingLoanCalculatorBloc,
              BaseState<HousingLoanCalculatorState>>(
            bloc: bloc,
            listener: (context, state) {
              if (state is HousingLoanPDFSuccessState){
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
              if (state is HousingLoanFieldDataSuccessState) {
                setState(() {
                  monthlyInstallment = state.monthlyInstallment;
                  rate = state.rate;
                  amount = state.amount;
                  tenure = state.tenure;
                  showBankTC = true;
                });
              }
              else if(state is HousingLoanFieldDataFailedState){
                ToastUtils.showCustomToast(
                    context, AppLocalizations.of(context).translate("there_was_some_error"), ToastStatus.FAIL);
              }
            },
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding:  EdgeInsets.fromLTRB(20.w, 0.h, 20.w, (20.h + AppSizer.getHomeIndicatorStatus(context))),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: Column(
                            children: [
                              BankTandCWidget(
                                isShow: showBankTC!,
                                loanType: 'Apply for a Housing Loan',
                                title: 'Monthly Installment',
                                housingInstallment: monthlyInstallment ?? "0",
                                calculatorType: CalculatorType.HOUSING,
                                interestRate: rate ?? "0",
                                tenureHousing: tenure ?? '0',
                                amount: amount,
                                isFromPreLogin: widget.isFromPreLogin,
                                installmentType: _selectedRadioValue,
                                // rate: interestRate,
                                shareTap: (calType) {
                                  if(calType == CalculatorType.HOUSING){

                                  }
                                },
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0).w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppTextField(
                                        controller: amountController,
                                        focusNode: _focusNode1,
                                        validator: (a){
                                          if(amountController.text.isEmpty || amountController.text == "0.00"){
                                            return AppLocalizations.of(context)
                                                .translate("mandatory_field_msg");
                                          }else{
                                            return null;
                                          }
                                        },
                                        showCurrencySymbol: true,
                                        inputType: const TextInputType.numberWithOptions(decimal: true),
                                        title: AppLocalizations.of(context).translate("loan_amount"),
                                        hint: AppLocalizations.of(context).translate("enter_loan_amount"),
                                        isCurrency: true,
                                        onTextChanged: (value) {
                                          setState(() {
                                            amount = value.replaceAll(',', '');
                                            _isInputValid = _isInputValidate();
                                            if(amountController.text.isEmpty || amountController.text == "0"){
                                              amountValidate = false;
                                              setState(() {

                                              });
                                            }else{
                                              amountValidate = true;
                                              setState(() {

                                              });
                                            }
                                          });
                                        },
                                      ),
                                      24.verticalSpace,
                                      AppTextField(
                                        maxLength: 3,

                                        controller: _controller2,
                                        inputType: TextInputType.number,
                                        title: AppLocalizations.of(context)
                                            .translate("tenure"),
                                        hint: AppLocalizations.of(context)
                                            .translate("enter_number_of_months"),
                                        focusNode: _focusNode2,
                                        validator: (a){
                                          if(_controller2.text.isEmpty){
                                            return AppLocalizations.of(context)
                                                .translate("mandatory_field_msg");
                                          }else{
                                            return null;
                                          }
                                        },
                                        inputFormatter: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          FilteringTextInputFormatter.deny(RegExp(r'^0'))],
                                        onTextChanged: (value) {
                                          setState(() {
                                            tenureHousing = value;
                                            _isInputValid = _isInputValidate();
                                            _controller2.text.isEmpty ? tenureHousing = "0" : tenureHousing = _controller2.text;
                                            if(int.parse(tenureHousing!) >= 241 ){
                                              setState(() {
                                                isTenureValid = false;
                                                _isInputValid = false;
                                              });
                                            } else {
                                              setState(() {
                                                isTenureValid = true;
                                              });
                                            }
                                            if(_controller2.text.isEmpty){
                                              tenureValidate = false;
                                              setState(() {

                                              });
                                            }else{
                                              tenureValidate = true;
                                              setState(() {

                                              });
                                            }
                                          });
                                        }, isInfoIconVisible: false,
                                      ),
                                      12.verticalSpace,
                                      Text(
                                          AppLocalizations.of(context).translate("minimum_months"),
                                          style: size14weight400.copyWith(color:colors(context).greyColor)
                                      ),
                                      24.verticalSpace,
                                      AppTextField(
                                        isInfoIconVisible: false,
                                        controller: _controller3,
                                        maxLength: 5,
                                        inputType: TextInputType.number,
                                        validator: (a){
                                          if(_controller3.text.isEmpty){
                                            return AppLocalizations.of(context)
                                                .translate("mandatory_field_msg");
                                          }else{
                                            return null;
                                          }
                                        },
                                        focusNode: _focusNode3,
                                        hint: AppLocalizations.of(context)
                                            .translate("enter_interest_rate"),
                                        title: AppLocalizations.of(context)
                                            .translate("interest_rate"),
                                        inputFormatter: [
                                          FilteringTextInputFormatter.allow(RegExp("[0-9 .]")),
                                        ],
                                        onTextChanged: (value) {
                                          _controller3.text = '$value%';
                                          _controller3.selection = TextSelection.fromPosition(
                                              TextPosition(offset: _controller3.text.length - 1));
                                          if (_controller3.text.endsWith('%%')) {
                                            _controller3.text = _controller3.text.substring(0, _controller3.text.length - 1);
                                            _controller3.selection = TextSelection.fromPosition(
                                                TextPosition(offset: _controller3.text.length - 1));
                                          }
                                          if (_controller3.text.startsWith('%')){
                                            _controller3.text = _controller3.text.substring(0, _controller3.text.length - 1);
                                            _controller3.selection = TextSelection.fromPosition(
                                                TextPosition(offset: _controller3.text.length));
                                          }
                                          if (_controller3.text.length == 2){
                                            _controller3.selection = TextSelection.fromPosition(
                                                TextPosition(offset: _controller3.text.length - 1));
                                          }
                                          setState(() {
                                            interestRate = value.replaceAll('%', '');
                                            _isInputValid = _isInputValidate();
                                            if(_controller3.text.isNotEmpty){
                                              if(double.parse(_controller3.text.replaceAll('%', '')) > 100){
                                                _controller3.clear();
                                              }
                                            }
                                            if(_controller3.text.isEmpty){
                                              rateValidate = false;
                                              setState(() {

                                              });
                                            }else{
                                              rateValidate = true;
                                              setState(() {

                                              });
                                            }
                                          });
                                        },
                                      ),
                                      24.verticalSpace,
                                      CustomRadioButtonGroup(
                                        validator: (value){
                                          if(_selectedRadioValue ==null || _selectedRadioValue==""){
                                            return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                          }else{
                                            return null;
                                          }
                                        },
                                        options: [
                                          RadioButtonModel(
                                              label: AppLocalizations.of(context).translate("equal"),
                                              value: 'EQUAL'),
                                          RadioButtonModel(
                                              label: AppLocalizations.of(context).translate("equated"),
                                              value: 'EQUATED'),
                                        ],
                                        value: _selectedRadioValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedRadioValue = value!;
                                            _isInputValid = _isInputValidate();
                                            if(_selectedRadioValue != null){
                                              insTypeValidate = true;
                                            }
                                            // if(value.isEmpty){
                                            //   setState(() {
                                            //     _isInputValid = false;
                                            //   });
                                            // }else {
                                            //   _isInputValid = true;
                                            // }
                                          });
                                        },
                                        title:
                                        AppLocalizations.of(context)
                                            .translate("installment_type"),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0).w,
                      child: Column(
                        children: [
                          AppButton(
                              buttonText:
                              AppLocalizations.of(context).translate("calculate"),
                              onTapButton:
                                  () {
                                    _focusNode1.unfocus();
                                    _focusNode2.unfocus();
                                    _focusNode3.unfocus();
                                    isButtonClicked = true;
                                    if(_formKey.currentState?.validate() == false || !isTenureValid){
                                      return;
                                    }
                                bloc.add(
                                  HousingLoanSaveDataEvent(
                                      tenure: tenureHousing,
                                      installmentType: _selectedRadioValue,
                                      interestRate: interestRate,
                                      loanAmount: amount,
                                      messageType: "getHousingLoanCalculator",
                                  ),
                                );
                              }
                          ),
                          16.verticalSpace,
                          AppButton(
                                          buttonType: ButtonType.OUTLINEENABLED,
                            buttonText: AppLocalizations.of(context).translate("reset"),
                            buttonColor: Colors.transparent,
                            onTapButton: () {
                              setState(() {
                                clearTextField();
                                _selectedRadioValue = null;
                                amount = null;
                                tenureHousing = null;
                                interestRate = null;
                                _isInputValid = false;
                                showBankTC = false;
                                isTenureValid = true;
                                _focusNode1.unfocus();
                                _focusNode2.unfocus();
                                _focusNode3.unfocus();
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
      ),
    );
  }


  bool _isInputValidate(){
    if(amount == null || amountController.text == "0"){
      return false;
    } else if(tenureHousing == null || _controller2.text.isEmpty){
      return false;
    } else if(interestRate == null || _controller3.text.isEmpty){
      return false;
    } else if(_selectedRadioValue == null){
      return false;
    } else {
      return true;
    }
  }

  bool buttonRate(){
    if(_controller3.text.isEmpty){
      return false;
    } else {
      if(double.parse(_controller3.text.replaceAll('%', ''))>0){
        return true;
      } else {
        return false;
      }
    }
  }


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }

  onFailDialog() {
    showAppDialog(
        title: AppLocalizations.of(context).translate("net_salary"),
        alertType: AlertType.INFO,
        message: AppLocalizations.of(context)
            .translate("net_income_is_your_take_home"),
        positiveButtonText: AppLocalizations.of(context).translate("ok"),
        onPositiveCallback: () {
          Navigator.pop(context);
        });
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
