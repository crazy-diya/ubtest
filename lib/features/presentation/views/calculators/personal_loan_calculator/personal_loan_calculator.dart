import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/models/requests/calculator_share_pdf_request.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import '../../../../../core/service/app_permission.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/service/storage_service.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../../utils/text_editing_controllers.dart';

import '../../../bloc/calculators/personal_loan_calculator/personal_loan_calculator_bloc.dart';
import '../../../widgets/app_button.dart';

import '../../../widgets/app_radio_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/pop_scope/ub_pop_scope.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../widgets/bank_tc_summary.dart';

class PersonalLoanCalculatorView extends BaseView {
  final bool isFromPreLogin;

  PersonalLoanCalculatorView({this.isFromPreLogin = false});

  @override
  _PersonalLoanCalculatorViewState createState() =>
      _PersonalLoanCalculatorViewState();
}

class _PersonalLoanCalculatorViewState
    extends BaseViewState<PersonalLoanCalculatorView> {
  var bloc = injection<PersonalLoanCalculatorBloc>();
  String? selectedMonth;
  String? selectedInterestedType;
  String? selectedPurposeLoan;
  bool? showBankTC = false;
  String? monthlyInstallment;
  String? interestRate;
  String? rate;
  String? loanAmount;
  String? messageType;
  String? installmentType;
  String? tenurePersonal;
  String? tenure;
  String? amount;
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  double initialValue = 75000.0;
  double minValue = 75000.0;
  double maxValue = 10000000.0;

  late TextEditingController textEditingController;

  final TextEditingController _controller1 = TextEditingController(text: "0.00");
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  CurrencyTextEditingController moneyController = CurrencyTextEditingController();

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
    amount = _controller1.text;
    _controller1.clear();
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
          Navigator.pop(
            context,
            Routes.kCalculatorsView,
          );
          // arguments: widget.isFromPreLogin ? true : false);
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
                    bloc.add(PersonalCalculatorPDFDataEvent(
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
                            fieldValue: interestRate! + '%'),
                        DocBody(
                            fieldName: "Installment Type",
                            fieldValue: installmentType),
                        DocBody(
                            fieldName: "Monthly Installment",
                            fieldValue: monthlyInstallment),
                      ],
                    ));
                    AppPermissionManager.requestExternalStoragePermission(context, () {});
                  },
                ),
            ],
            onBackPressed: () {
              if (showBankTC == true) {
                setState(() {
                  showBankTC = false;
                });
              } else {
                Navigator.pop(
                  context,
                  Routes.kCalculatorsView,
                );
                // arguments: widget.isFromPreLogin ? true : false);
              }
            },
            title: AppLocalizations.of(context)
                .translate("personal_loan_calculator"),
            goBackEnabled: true,
          ),
          body: BlocProvider<PersonalLoanCalculatorBloc>(
            create: (context) => bloc,
            child: BlocListener<PersonalLoanCalculatorBloc,
                BaseState<PersonalLoanCalculatorState>>(
              bloc: bloc,
              listener: (context, state) {
                if (state is PersonalLoanFieldDataSuccessState) {
                  setState(() {
                    monthlyInstallment = state.monthlyInstallment;
                    rate = state.rate;
                    installmentType = state.installmentType;
                    amount = state.amount;
                    tenure = state.tenure;
                    showBankTC = true;
                  });
                }
                if (state is PersonalLoanFieldDataFailedState) {
                  ToastUtils.showCustomToast(
                      context, AppLocalizations.of(context).translate("there_was_some_error"), ToastStatus.FAIL);
                }
                if (state is PersonalCalculatorPDFSuccessState) {
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
              },
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(20.w, 0.h, 20.w, (20.h + AppSizer.getHomeIndicatorStatus(context)) ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(top: 24.0.h),
                            child: Column(
                              children: [
                                BankTandCWidget(
                                  isFromPreLogin: widget.isFromPreLogin,
                                  tenurePersonal: tenure ?? '0',
                                  isShow: showBankTC!,
                                  loanType: 'Apply for a Personal Loan',
                                  title: 'Monthly Installment',
                                  personalInstallment: monthlyInstallment ?? "0",
                                  calculatorType: CalculatorType.PERSONAL,
                                  interestRate: rate ?? "0",
                                  amount: amount,
                                  installmentType: installmentType,
                                  // rate: interestRate,
                                  shareTap: (calType) {},
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8).w,
                                    color: colors(context).whiteColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0).w,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppTextField(
                                          controller: moneyController,
                                          showCurrencySymbol: true,
                                          focusNode: _focusNode1,
                                          validator: (a){
                                            if(moneyController.text.isEmpty || moneyController.text == "0.00"){
                                              return AppLocalizations.of(context)
                                                  .translate("mandatory_field_msg");
                                            }else{
                                              return null;
                                            }
                                          },
                                          inputType: const TextInputType.numberWithOptions(decimal: true),
                                          title: AppLocalizations.of(context).translate("loan_amount"),
                                          hint: AppLocalizations.of(context).translate("enter_loan_amount"),
                                          isCurrency: true,
                                          onTextChanged: (value) {
                                            setState(() {
                                              amount = value.replaceAll(',', '');
                                              if(_controller1.text.isEmpty || _controller1.text == "0"){
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
                                          focusNode: _focusNode2,
                                          inputType: TextInputType.number,
                                          title: AppLocalizations.of(context)
                                              .translate("tenure"),
                                          hint: AppLocalizations.of(context)
                                              .translate("enter_number_of_months"),
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
                                            FilteringTextInputFormatter.deny(
                                              RegExp(r'^0'),
                                            )
                                          ],
                                          onTextChanged: (value) {
                                            setState(() {
                                              tenurePersonal= value;
                                              _controller2.text.isEmpty ? tenurePersonal = "0" : tenurePersonal = _controller2.text;
                                                if (int.parse(tenurePersonal!) >= 241) {
                                                setState(() {
                                                  isTenureValid = false;
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
                                          },
                                          isInfoIconVisible: false,
                                        ),
                                        12.verticalSpace,
                                        Text(
                                          AppLocalizations.of(context).translate("minimum_months"),
                                          style: size14weight400.copyWith(color:colors(context).greyColor)
                                        ),
                                        24.verticalSpace,
                                        AppTextField(
                                          maxLength: 5,
                                          inputType: TextInputType.number,
                                          controller: _controller3,
                                          validator: (a){
                                            if(_controller3.text.isEmpty){
                                              return AppLocalizations.of(context)
                                                  .translate("mandatory_field_msg");
                                            }else{
                                              return null;
                                            }
                                          },
                                          hint: AppLocalizations.of(context)
                                              .translate("enter_interest_rate"),
                                          title: AppLocalizations.of(context)
                                              .translate("interest_rate"),
                                          focusNode: _focusNode3,
                                          inputFormatter: [
                                            // FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d+)?%?$'))
                                            FilteringTextInputFormatter.allow(RegExp("[0-9 .]")),
                                            // FilteringTextInputFormatter.allow(RegExp(r'^\d+%?$')),
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
                                            if(installmentType ==null || installmentType==""){
                                              return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                            }else{
                                              return null;
                                            }
                                          },
                                          options: [
                                            RadioButtonModel(
                                                label: AppLocalizations.of(context)
                                                    .translate("equal"),
                                                value: 'EQUAL'),
                                            RadioButtonModel(
                                                label: AppLocalizations.of(context)
                                                    .translate("equated"),
                                                value: 'EQUATED'),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              installmentType = value!;
                                              if(installmentType != null){
                                                insTypeValidate = true;
                                              }
                                            });
                                          },
                                          value: installmentType,
                                          title: AppLocalizations.of(context)
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
                        padding: EdgeInsets.only(top: 20.h),
                        child: Column(
                          children: [
                            AppButton(
                                buttonText: AppLocalizations.of(context)
                                    .translate("calculate"),
                                onTapButton: () {
                                  isButtonClicked = true;
                                  if(_formKey.currentState?.validate() == false || !isTenureValid){
                                    return;
                                  }
                                  _focusNode1.unfocus();
                                  _focusNode2.unfocus();
                                  _focusNode3.unfocus();
                                    bloc.add(
                                      PersonalLoanSaveDataEvent(
                                          tenure: tenurePersonal,
                                          installmentType: installmentType,
                                          interestRate: interestRate,
                                          loanAmount: amount,
                                          messageType: "getPersonalLoanDetails"),
                                    );
                                }),
                            18.verticalSpace,
                            AppButton(
                              buttonType: ButtonType.OUTLINEENABLED,
                              buttonColor: Colors.transparent,
                              buttonText: AppLocalizations.of(context).translate("reset"),
                              onTapButton: () {
                                clearTextField();
                                installmentType = null;
                                amount = null;
                                tenurePersonal = null;
                                interestRate = null;
                                showBankTC = false;
                                isTenureValid = true;
                                _focusNode1.unfocus();
                                _focusNode2.unfocus();
                                _focusNode3.unfocus();
                                moneyController = CurrencyTextEditingController();
                                setState(() {});
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
          )),
    );
  }

  bool _isInputValidate() {
    if (amount == null || _controller1.text == "0") {
      return false;
    } else if (tenurePersonal == null || _controller2.text.isEmpty) {
      return false;
    } else if (interestRate == null || _controller3.text.isEmpty) {
      return false;
    } else if (installmentType == null) {
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

  bool _fieldValidate(){
    if(_controller1.text.isEmpty || _controller1.text == "0"){
      return false;
    }
    if(_controller2.text.isEmpty){
      return false;
    }
    if(_controller3.text.isEmpty){
      return false;
    }
    if(insTypeValidate == false){
      return false;
    } else {
      return true;
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final cleanText = newValue.text.replaceAll(',', ''); // Remove any commas

    final regex = RegExp(r'^\d*\.?\d{0,2}$'); // Allow digits, an optional decimal point, and at most two digits after the decimal point

    // Check if the input matches the desired pattern
    if (!regex.hasMatch(cleanText)) {
      // Return the old value if the input doesn't match the pattern
      return oldValue;
    }

    // Apply the thousand separator formatter
    final numericRegex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final match = numericRegex.allMatches(cleanText);

    String formattedText = cleanText;
    if (match.isNotEmpty) {
      formattedText = cleanText.replaceAllMapped(
        numericRegex,
            (Match match) => '${match[1]},',
      );
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
