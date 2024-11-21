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
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
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
import '../../../../data/models/responses/get_currency_list_response.dart';
import '../../../../data/models/responses/get_fd_period_response.dart';
import '../../../bloc/calculators/fd_calculator/fd_calculator_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_radio_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../../widgets/drop_down_widgets/drop_down.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../widgets/bank_tc_summary.dart';

class FdRateValues{
  String? code;
  String? description;
  String? currency;
  String? rate;
  String? type;
  String? count;

  @override
  String toString() {
    return 'FdRateValues{code: $code, description: $description, currency: $currency, rate: $rate, type: $type, count: $count}';
  }

  FdRateValues(
      {this.code,
      this.description,
      this.currency,
      this.rate,
      this.type,
      this.count});
}



class FixedepositCalculatorView extends BaseView {
  final bool isFromPreLogin;


  FixedepositCalculatorView({this.isFromPreLogin = false});
  @override
  _FixedepositCalculatorViewState createState() =>
      _FixedepositCalculatorViewState();
}

class _FixedepositCalculatorViewState
    extends BaseViewState<FixedepositCalculatorView> {

  var bloc = injection<FDCalculatorBloc>();
  CurrencyTextEditingController amountController = CurrencyTextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  List<FdRateValues> fdRateList = [];
  List<CurrencyResponse> currencyList = [];
  List<CurrencyResponse> searchCurrencyList = [];
  List<FDPeriodResponse> searchPeriodList = [];
  List<FDPeriodResponse> periodList = [];

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  String? currencyCode;
  String? currencyCodeTemp;
  String? currency;
  String? currencyTemp;
  String? monthlyValue;
  String? nominalRate;
  String? annualRate;
  String? messageType;
  String? interestPeriod;
  String? interestPeriodTemp;
  String? tenure;
  String? tenureTemp;
  String? interestReceived;
  String? monthlyRate;
  String? maturityValue;
  String? rate;
  String? fdRate;
  String? amount;
  int? enteredAmount;

  bool _isEnterAmountValid = true;
  bool? showBankTC = false;
  bool? isRateClicked = false;
  bool? isRecievedRate = false;
  bool? isChangeAmount= false;

  bool amountValidate = false;
  bool tenureValidate = false;
  bool rateValidate = false;
  bool insTypeValidate = true;
  bool currancyValidate = false;
  bool isButtonClicked = false;

  String _searchString = '';

  final _formKey = GlobalKey<FormState>();

  void clearTextField() {
    amountController = CurrencyTextEditingController();
    _controller2.clear();
  }

  @override
  void initState() {
    super.initState();
    bloc.add(GetFDRateEvent(
        messageType: "challengeReq",
        acceptedDate: DateTime.now()
    ));
  }

  @override
  Widget buildView(BuildContext context) {
    return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
          if (didPop) return;
        if (showBankTC == true) {
          setState(() {
            showBankTC = false;
          });
        } else {
          Navigator.pop(context, Routes.kCalculatorsView,);
        }
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
                  bloc.add(FDCalculatorPDFDataEvent(
                    shouldOpen: false,
                    title: AppLocalizations.of(context).translate("personal_loan_calculator"),
                    docBody: <DocBody>[
                      DocBody(
                        fieldName: "Currency",
                        fieldValue: currency,
                      ),
                      DocBody(
                          fieldName: "Amount",
                          fieldValue: amount),
                      DocBody(
                          fieldName: "Interest Period",
                          fieldValue: interestPeriod),
                      DocBody(
                          fieldName: "Interest Rate",
                          fieldValue: rate! + '%'),
                      DocBody(
                          fieldName: "Interest Received",
                          fieldValue: interestReceived),
                      interestReceived == "maturity" ?
                      DocBody(
                          fieldName: "Maturity Value",
                          fieldValue: maturityValue) :
                      DocBody(
                          fieldName: "Monthly Value",
                          fieldValue: monthlyValue)

                      ,
                    ],
                  ));
                  AppPermissionManager
                      .requestExternalStoragePermission(context,
                          () {

                      });
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
          title:
              AppLocalizations.of(context).translate("fixed_deposit_calculator"),
          goBackEnabled: true,
        ),
        body: BlocProvider(
          create: (context) => bloc,
          child: BlocListener<FDCalculatorBloc, BaseState<FDCalculatorState>>(
            bloc: bloc,
            listener: (context, state) {
              if(state is GetFDRateSuccessState){
                fdRateList.clear();
                fdRateList.addAll(state.fdRatesCbsResponseDtoList!
                    .map((e) => FdRateValues(
                  code: e.code,
                  description: e.description,
                  currency: e.currency,
                  rate: e.rate,
                  type: e.type,
                  count: e.count
                )).toList());
                bloc.add(GetFDCurrencyEvent());
                setState(() {});
              }
              if(state is GetFDRateFailedState){
                bloc.add(GetFDCurrencyEvent());
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("there_was_some_error"), ToastStatus.FAIL);
              }
              if (state is FDCalculatorPDFSuccessState){
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
              if (state is FDCalculatorFieldDataSuccessState) {
                setState(() {
                  currencyCode = state.currencyCode;
                  currency = state.currency;
                  monthlyValue = state.monthlyValue;
                  nominalRate = state.nominalRate;
                  // annualRate = state.annualRate;
                  monthlyRate = state.monthlyRate;
                  maturityValue = state.maturityValue;
                  showBankTC = true;
                });
              }
              if (state is FDCalculatorFieldDataFailedState){
                ToastUtils.showCustomToast(
                    context, AppLocalizations.of(context).translate("there_was_some_error"), ToastStatus.FAIL);
              }
              if (state is GetFDDataLoadedState){
                currencyList.clear();
                currencyList.addAll(state.data!
                    .map((e) => CurrencyResponse(
                  currencyCode: e.currencyCode,
                  currencyDescription: e.currencyDescription,
                  status: e.status
                )).toList());
                searchCurrencyList = currencyList;
                setState(() { });
                bloc.add(GetFDPeriodEvent());
              }
              if (state is GetFDDataFailedState){
                bloc.add(GetFDPeriodEvent());
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("there_was_some_error"), ToastStatus.FAIL);
              }
              if (state is GetFDPeriodLoadedState){
                periodList.clear();
                periodList.addAll(state.data!
                    .map((e) => FDPeriodResponse(
                  code: e.code,
                  timePeriod: e.timePeriod,
                  description: e.description,
                  status: e.status
                )).toList());
                searchPeriodList = periodList;
              }
              if (state is GetFDPeriodFailedState){
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("there_was_some_error"), ToastStatus.FAIL);
              }
            },
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding:  EdgeInsets.fromLTRB(20.w, 0.h, 20.w, (20.h+ AppSizer.getHomeIndicatorStatus(context))),
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
                                loanType: 'Open Fixed Deposits Account',
                                interestRate: rate ?? "0",
                                title: interestReceived == "maturity" ? 'Maturity Value' : 'Monthly Value',
                                fixedInstallment: maturityValue ?? "0",
                                calculatorType: CalculatorType.FIXED,
                                tenure: interestPeriod ?? "0",
                                annualRate: annualRate ?? "0",
                                nominalRate: nominalRate ?? "0",
                                isFromPreLogin: widget.isFromPreLogin,
                                fdMonthlyRate: monthlyRate,
                                monthlyValue: monthlyValue ?? "0",
                                interestRecieved: interestReceived,
                                currencyCode: currencyCode,
                                amount: amount ?? "0",
                                shareTap: (calType) {
                                  if(calType == CalculatorType.FIXED){}
                                },
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).w,
                                  color: colors(context).whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0).w,
                                  child: Column(
                                    children: [
                                      AppDropDown(
                                        validator: (value){
                                          if(currencyCode ==null || currencyCode == ""){
                                            return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                          }else{
                                            return null;
                                          }
                                        },
                                        onTap:() async {
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
                                                              searchCurrencyList = currencyList;
                                                            } else {
                                                              searchCurrencyList = currencyList
                                                                  .where((element) => element
                                                                      .currencyDescription!
                                                                      .toLowerCase()
                                                                      .contains(p0.toLowerCase())).toSet().toList();
                                                            }
                                                            });
                                                          },
                                                      title: AppLocalizations.of(context).translate('select_currency'),
                                                      buttons: [
                                                        Expanded(
                                                          child: AppButton(
                                                              buttonType: ButtonType.PRIMARYENABLED,
                                                              buttonText: AppLocalizations.of(context) .translate("continue"),
                                                              onTapButton: () {
                                                                currencyCode = currencyCodeTemp;
                                                                currency = currencyTemp;
                                                                fdRateReq();
                                                                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                Navigator.of(context).pop(true);
                                                                 changeState(() {});
                                                                 setState(() {});

                                                              }),
                                                        ),
                                                      ],
                                                      children: [
                                                        ListView.builder(
                                                          physics: NeverScrollableScrollPhysics(),
                                                          padding: EdgeInsets.zero,
                                                          itemCount: searchCurrencyList.length,
                                                            shrinkWrap: true,
                                                            itemBuilder: (context, index) {
                                                              return InkWell(
                                                                onTap: (){
                                                                  currencyCodeTemp = searchCurrencyList[index].currencyCode;
                                                                  currencyTemp = searchCurrencyList[index].currencyDescription;
                                                                  changeState(() {});
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:20,0,20).h,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            searchCurrencyList[index].currencyDescription!,
                                                                            style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(right: 8).w,
                                                                            child: UBRadio<dynamic>(
                                                                              value: searchCurrencyList[index].currencyCode ?? "",
                                                                              groupValue: currencyCodeTemp,
                                                                              onChanged: (value) {
                                                                                currencyCodeTemp = searchCurrencyList[index].currencyCode;
                                                                                currencyTemp = searchCurrencyList[index].currencyDescription;
                                                                                changeState(() {});
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    if(searchCurrencyList.length-1 != index)
                                                                      Divider(
                                                                        thickness: 1,
                                                                        height:0,
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
                                          //   currencyCodeTemp = null;
                                          //   currencyCode = null;
                                          //   currency = null;
                                          //   currencyTemp = null;
                                          //   setState(() {});
                                          // }

                                            searchCurrencyList = currencyList;
                                            setState(() {});

                                        },
                                        labelText: AppLocalizations.of(context)
                                            .translate("select_currency"),
                                        label: AppLocalizations.of(context)
                                            .translate("select_currency"),
                                        initialValue: currency,
                                      ),
                                      24.verticalSpace,
                                      AppTextField(
                                        currencySymbol: currency,
                                        controller: amountController,
                                        validator: (a){
                                          if(amountController.text.isEmpty || amountController.text == "0.00"){
                                            return AppLocalizations.of(context)
                                                .translate("mandatory_field_msg");
                                          }else{
                                            return null;
                                          }
                                        },
                                        showCurrencySymbol: true,
                                        hint: AppLocalizations.of(context)
                                            .translate("deposit_amount"),
                                        title: AppLocalizations.of(context)
                                            .translate("deposit_amount"),
                                        isCurrency: true,
                                        focusNode: _focusNode1,
                                        inputType: const TextInputType.numberWithOptions(decimal: true),
                                        onTextChanged: (value) {
                                          setState(() {
                                            amount = value.replaceAll(',', '');
                                            isChangeAmount = true;
                                            if(currency == "LKR"){
                                              if(double.parse(amount ?? "0.00") >= 50000){
                                                setState(() {
                                                  _isEnterAmountValid = true;
                                                });
                                              } else {
                                                setState(() {
                                                  _isEnterAmountValid = false;
                                                });
                                              }
                                            }
                                            if(isChangeAmount == true && isRecievedRate == true){
                                              interestPeriod = null;
                                              interestReceived = null;
                                              fdRate = null;
                                              isRateClicked = false;
                                              setState(() {

                                              });
                                            }
                                          });
                                          fdRateReq();
                                        },
                                      ),
                                      if(currency == "LKR")
                                        12.verticalSpace,
                                      if(currency == "LKR")
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const SizedBox.shrink(),
                                            Text( AppLocalizations.of(context).translate("minimum_deposit"),
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: _isEnterAmountValid ? colors(context).blackColor : colors(context).negativeColor),
                                            ),
                                          ],
                                        ),
                                      24.verticalSpace,
                                      AppDropDown(
                                        validator: (value){
                                          if(interestPeriod ==null || interestPeriod == ""){
                                            return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                          }else{
                                            return null;
                                          }
                                        },
                                        onTap: () async {
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
                                                      onSearch: (p0){
                                                        if (p0.isEmpty || p0=='') {
                                                          searchPeriodList = periodList;
                                                        } else {
                                                          searchPeriodList = periodList
                                                              .where((element) => element
                                                              .description!
                                                              .toLowerCase()
                                                              .contains(p0.toLowerCase())).toSet().toList();
                                                        }
                                                      },
                                                      title: AppLocalizations.of(context).translate('select_period'),
                                                      buttons: [
                                                        Expanded(
                                                          child: AppButton(
                                                              buttonType: ButtonType.PRIMARYENABLED,
                                                              buttonText: AppLocalizations.of(context) .translate("continue"),
                                                              onTapButton: () {
                                                                interestPeriod = interestPeriodTemp;
                                                                tenure = tenureTemp;
                                                                fdRateReq();
                                                                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                Navigator.of(context).pop(true);
                                                                changeState(() {});
                                                                setState(() {});
                                                              }),
                                                        ),
                                                      ],
                                                      children: [
                                                        ListView.builder(
                                                          itemCount: searchPeriodList.length,
                                                          shrinkWrap: true,
                                                          padding: EdgeInsets.zero,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context, index) {
                                                            return InkWell(
                                                              onTap: (){
                                                                interestPeriodTemp = searchPeriodList[index].timePeriod;
                                                                tenureTemp = searchPeriodList[index].description;
                                                                changeState(() {});
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:20,0,20).w,
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          searchPeriodList[index].description ?? "",
                                                                          style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(right: 8).w,
                                                                          child: UBRadio<dynamic>(
                                                                            value: searchPeriodList[index].timePeriod ?? "",
                                                                            groupValue: interestPeriodTemp,
                                                                            onChanged: (value) {
                                                                              interestPeriodTemp = value;
                                                                              interestPeriodTemp = searchPeriodList[index].timePeriod;
                                                                              changeState(() {});
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  if(searchPeriodList.length-1 != index)
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
                                          //   interestPeriodTemp = null;
                                          //   interestPeriod = null;
                                          //   tenure = null;
                                          //   tenureTemp = null;
                                          //   setState(() {});
                                          // }
                                          searchPeriodList = periodList;
                                          setState(() {});
                                        },

                                        //     () {
                                        //   Navigator.pushNamed(context, Routes.kDropDownView,
                                        //       arguments: DropDownViewScreenArgs(
                                        //         isSearchable: true,
                                        //         pageTitle: AppLocalizations.of(context)
                                        //             .translate("interest_period"),
                                        //         dropDownEvent: GetPeriodEvent(),
                                        //       )).then((value) {
                                        //     if (value != null &&
                                        //         value is CommonDropDownResponse) {
                                        //       setState(() {
                                        //         interestPeriod = value.code;
                                        //         tenureValidate = true;
                                        //         fdRateReq();
                                        //       });
                                        //     }
                                        //   });
                                        // },
                                        labelText: AppLocalizations.of(context)
                                            .translate("select_interest_period"),
                                        label: AppLocalizations.of(context)
                                            .translate("interest_period"),
                                        initialValue:tenure,
                                      ),
                                      // Visibility(
                                      //   visible: tenureValidate == false && isButtonClicked == true,
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
                                      24.verticalSpace,
                                      CustomRadioButtonGroup(
                                        validator: (value){
                                          if(interestReceived ==null || interestReceived==""){
                                            return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                          }else{
                                            return null;
                                          }
                                        },
                                        options: [
                                          RadioButtonModel(
                                              label: AppLocalizations.of(context)
                                                  .translate("monthly"),
                                              value: 'monthly'),
                                          RadioButtonModel(
                                              label: AppLocalizations.of(context)
                                                  .translate("maturity"),
                                              value: 'maturity'),
                                        ],
                                        value: interestReceived,
                                        onChanged: (value) {
                                          setState(() {
                                            interestReceived = value!;
                                            if(interestReceived != null){
                                              insTypeValidate = true;
                                            }
                                            if(value.isEmpty){

                                            }else{
                                            }
                                            fdRateReq();
                                          });
                                        },
                                        title: AppLocalizations.of(context)
                                            .translate("interest_received"),
                                      ),
                                      24.verticalSpace,
                                      AppTextField(
                                        isInfoIconVisible: false,
                                        initialValue:fdRate==null?null: "${fdRate} %",
                                        inputType: TextInputType.number,
                                        controller: _controller2,
                                        validator: (a){
                                          if(_controller2.text.isEmpty){
                                            return AppLocalizations.of(context)
                                                .translate("mandatory_field_msg");
                                          }else{
                                            return null;
                                          }
                                        },
                                        hint: AppLocalizations.of(context).translate("your_interest_rate"),
                                        focusNode: _focusNode2,
                                        title: AppLocalizations.of(context).translate("interest_rate"),
                                        maxLength: 5,
                                        inputFormatter: [
                                          // FilteringTextInputFormatter.allow(RegExp(r'^\d+%?$')),
                                          FilteringTextInputFormatter.allow(RegExp("[0-9 .]")),

                                        ],
                                        onTextChanged: (value) {
                                          _controller2.text = '$value%';
                                          _controller2.selection = TextSelection.fromPosition(
                                              TextPosition(offset: _controller2.text.length - 1));
                                          if (_controller2.text.endsWith('%%')) {
                                            _controller2.text = _controller2.text.substring(0, _controller2.text.length - 1);
                                            _controller2.selection = TextSelection.fromPosition(
                                                TextPosition(offset: _controller2.text.length - 1));
                                          }
                                          if (_controller2.text.startsWith('%')){
                                            _controller2.text = _controller2.text.substring(0, _controller2.text.length - 1);
                                            _controller2.selection = TextSelection.fromPosition(
                                                TextPosition(offset: _controller2.text.length));
                                          }
                                          if (_controller2.text.length == 2){
                                            _controller2.selection = TextSelection.fromPosition(
                                                TextPosition(offset: _controller2.text.length - 1));
                                          }
                                          setState(() {
                                            rate = value.replaceAll('%', '');
                                            if(_controller2.text.isNotEmpty){
                                            }
                                            if(isRateClicked == true && _controller2.text.isEmpty){
                                            }
                                            if(_controller2.text.isNotEmpty){
                                              if(double.parse(_controller2.text.replaceAll('%', '')) > 100){
                                                _controller2.clear();
                                              }
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              16.verticalSpace,
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).w,
                                  color: colors(context).whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16).w,
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.pushNamed(context, Routes.kFDInterestRateView , arguments: fdRateList);
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(3,0,3,0).w,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8).w,
                                                        border: Border.all(color: colors(context).blackColor ?? Colors.black),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(12.0).w,
                                                        child: PhosphorIcon(PhosphorIcons.chartBar(PhosphorIconsStyle.bold), color: colors(context).primaryColor, size: 24,),
                                                      )),
                                                  12.horizontalSpace,
                                                  Expanded(
                                                    child: Text(
                                                      AppLocalizations.of(context)
                                                          .translate("check_current_rates"),
                                                      style: size16weight700.copyWith(color: colors(context).blackColor),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold), color: colors(context).greyColor300,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0).h,
                      child: Column(
                        children: [
                          AppButton(
                              // buttonType: _isEnterAmountValid && _isInputValid && _controller2.text!="" &&  buttonRate()? ButtonType.ENABLED : ButtonType.DISABLED,
                              buttonText: AppLocalizations.of(context)
                                  .translate("calculate"),
                              onTapButton: () {
                                _focusNode1.unfocus();
                                _focusNode2.unfocus();
                                isButtonClicked = true;
                                if(_formKey.currentState?.validate() == false || !_isEnterAmountValid){
                                  return;
                                }
                                bloc.add(
                                  FDCalculatorSaveDataEvent(
                                      rate: rate,
                                      amount: amount,
                                      currencyCode: currencyCode,
                                      interestPeriod: interestPeriod,
                                      interestReceived: interestReceived,
                                      messageType: "getFDCalculator"),
                                );
                              }),
                          16.verticalSpace,
                          AppButton(
                                          buttonType: ButtonType.OUTLINEENABLED,
                            buttonText: AppLocalizations.of(context).translate("reset"),
                            buttonColor: Colors.transparent,
                            onTapButton: () {
                              setState(() {
                                clearTextField();
                                showBankTC = false;
                                currencyCode = null;
                                currency = null;
                                interestPeriod = null;
                                interestReceived = null;
                                amount = null;
                                rate = null;
                                interestPeriod = null;
                                _focusNode1.unfocus();
                                _focusNode2.unfocus();
                              });
                              // Navigator.pushNamed(
                              //     context, Routes.kFixedDepositView);
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
    } else if(currencyCode == null){
      return false;
    } else if(interestPeriod == null){
      return false;
    } else if(interestReceived == null){
      return false;
    } else if(rate == null){
      return false;
    } else {
      return true;
    }
  }

  bool buttonRate(){
    if(_controller2.text.isEmpty){
      return false;
    } else {
      if(double.parse(_controller2.text.replaceAll('%', ''))>0){
        return true;
      } else {
        return false;
      }
    }
  }

  fdRateReq(){
    if(currencyCode != null && amount != null && interestPeriod != null && interestReceived != null){
      List<FdRateValues> fdRateListTemp=[];
      fdRateListTemp.clear();
      _controller2.clear();
      fdRateListTemp = fdRateList.where(
              (element) => element.currency == currency && element.type == interestReceived!.toUpperCase() && element.count == interestPeriod
      ).toList();
      if(fdRateListTemp.isNotEmpty){
        _controller2.text = (double.parse(fdRateListTemp.first.rate!)*100).toString() + "%";
      }
      // _controller2.text = fdRateListTemp.first.rate! + "%";
      if(_controller2.text.isNotEmpty){
        rate = _controller2.text.replaceAll("%", "");
      }
      setState(() {

      });
    //   bloc.add(GetFDRateEvent(
    //       messageType: "challengeReq",
    //       acceptedDate: DateTime.now()
    //   ));
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
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
