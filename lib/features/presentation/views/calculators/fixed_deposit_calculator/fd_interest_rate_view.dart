import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import '../../../../../core/service/dependency_injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/calculators/fd_calculator/fd_calculator_bloc.dart';
import '../../../widgets/app_radio_button.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import 'fixed_deposit_calculator.dart';
import 'dart:math' as math;

class FDInterestRateView extends BaseView {
  final List<FdRateValues> fdRateList;

  FDInterestRateView({required this.fdRateList});

  @override
  _FDInterestRateViewState createState() => _FDInterestRateViewState();
}

class _FDInterestRateViewState extends BaseViewState<FDInterestRateView> {
  var bloc = injection<FDCalculatorBloc>();
  late List<List<String>> cellData;
  List<FdRateValues> fdRateListMonthly = [];
  List<FdRateValues> fdRateListMaturity = [];
  String? fdRate;
  bool? isRecievedRate = false;
  bool? isChangeAmount = false;
  bool? isRateClicked = false;
  String? interestReceived = "monthly";
  String? rate;

  @override
  void initState() {
    // bloc.add(GetFDRateEvent(
    //     messageType: "challengeReq",
    //     acceptedDate: DateTime.now()
    // ));
    fdRateListMonthly = widget.fdRateList
        .where((element) => element.type == "MONTHLY")
        .toList();
    if (fdRateListMonthly.length > 2) {
      fdRateListMonthly
          .sort((a, b) => int.parse(a.count!).compareTo(int.parse(b.count!)));
    }
    fdRateListMaturity = widget.fdRateList
        .where((element) => element.type == "MATURITY")
        .toList();
    if (fdRateListMaturity.length > 2) {
      fdRateListMaturity
          .sort((a, b) => int.parse(a.count!).compareTo(int.parse(b.count!)));
    }
    log(fdRateListMaturity.toString());
    log(fdRateListMonthly.toString());
    super.initState();
    cellData = List.generate(
        interestReceived == "monthly"
            ? fdRateListMonthly.length
            : fdRateListMaturity.length,
        (i) => List.filled(4, ''));
    setData(0, 0, "Months");
    setData(0, 1, "Monthly%");
    // setData(0, 2, "AER%");
    getMonthlyData();
  }

  void getMonthlyData() {
    for (int i = 1; i < fdRateListMonthly.length; i++) {
      setData(i, 0, fdRateListMonthly[i].count ?? "");
      setData(i, 1,
          "${formatNumber(double.parse(fdRateListMonthly[i].rate!) * 100)}");
      // setData(i, 2, calculateAER(fdRateListMaturity[i].rate??"0",fdRateListMaturity[i].count??"0")??"");
    }
  }

  void getMaturityData() {
    for (int i = 1; i < fdRateListMaturity.length; i++) {
      setData(i, 0, fdRateListMaturity[i].count ?? "");
      setData(i, 1,
          "${formatNumber(double.parse(fdRateListMaturity[i].rate!) * 100)}");
      // setData(i, 2, calculateAER(fdRateListMaturity[i].rate??"0",fdRateListMaturity[i].count??"0")??"");
    }
  }

  String calculateAER(String nominalInterestRate, String timesCompounded) {
    double aer = math.pow(
            1 + double.parse(nominalInterestRate) / int.parse(timesCompounded),
            int.parse(timesCompounded)) -
        1;
    return "${aer.toStringAsFixed(3)}%";
  }

  @override
  Widget buildView(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is GetFDRateSuccessState) {
          } else if (state is GetFDRateFailedState) {
            ToastUtils.showCustomToast(
                context, AppLocalizations.of(context).translate("there_was_some_error"), ToastStatus.FAIL);
          }
        },
        child: Scaffold(
            backgroundColor: colors(context).primaryColor50,
            appBar: UBAppBar(
              goBackEnabled: true,
              title: AppLocalizations.of(context).translate("current_rates"),
            ),
            body: cellData.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
                    child: Column(
                      children: [
                        Expanded(
                            child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 24.0.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8).w,
                                            color: colors(context).whiteColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16).w,
                                          child: CustomRadioButtonGroup(
                                            options: [
                                              RadioButtonModel(
                                                  label:
                                                      AppLocalizations.of(context)
                                                          .translate("monthly"),
                                                  value: 'monthly'),
                                              RadioButtonModel(
                                                  label:
                                                      AppLocalizations.of(context)
                                                          .translate("maturity"),
                                                  value: 'maturity'),
                                            ],
                                            value: interestReceived,
                                            onChanged: (value) {
                                              interestReceived = value;
                                              cellData = List.generate(
                                                  interestReceived == "monthly"
                                                      ? fdRateListMonthly.length
                                                      : fdRateListMaturity.length,
                                                  (i) => List.filled(4, ''));
                                              setData(0, 0, "Months");
                                              setData(0, 1, interestReceived == "monthly" ? "Monthly%" : "Maturity%");
                                              // setData(0, 2, "AER%");
                                              if (interestReceived == "monthly") {
                                                getMonthlyData();
                                              } else {
                                                getMaturityData();
                                              }
                                              setState(() {});
                                            },
                                            title: AppLocalizations.of(context)
                                                .translate("interest_received"),
                                          ),
                                        ),
                                      ),
                                      16.verticalSpace,
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8).w,
                                            color: colors(context).whiteColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16).w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Table(
                                                border: TableBorder.all(
                                                    color: colors(context)
                                                        .greyColor!),
                                                columnWidths: const {
                                                  0: FixedColumnWidth(100.0),
                                                },
                                                children: List.generate(
                                                    interestReceived == "monthly"
                                                        ? fdRateListMonthly.length
                                                        : fdRateListMaturity
                                                            .length, (i) {
                                                  return TableRow(
                                                    decoration: i == 0
                                                        ? BoxDecoration(
                                                            color: colors(context)
                                                                .greyColor50)
                                                        : null,
                                                    children:
                                                        List.generate(2, (j) {
                                                      return TableCell(
                                                        child: SizedBox(
                                                          height: 40,
                                                          child: Center(
                                                              child: Text(
                                                                  cellData[i]
                                                                      [j])),
                                                        ),
                                                      );
                                                    }),
                                                  );
                                                }),
                                              ),
                                              // SizedBox(height: 3.h,),
                                              // RichText(
                                              //     text: TextSpan(children: [
                                              //       TextSpan(
                                              //         text: 'Premature withdrawals (penal rate): ',
                                              //         style: TextStyle(
                                              //           fontSize: 16,
                                              //           fontWeight:
                                              //           FontWeight.w400,
                                              //           color: colors(context)
                                              //               .greyColor,
                                              //         ),
                                              //       ),
                                              //       TextSpan(
                                              //         text: "1.00%",
                                              //         style: TextStyle(
                                              //           fontSize: 16,
                                              //           fontWeight:
                                              //           FontWeight.w400,
                                              //           color: colors(context)
                                              //               .greyColor,
                                              //         ),
                                              //       )
                                              //     ])),
                                              // SizedBox(height: 3.h,),
                                              // RichText(
                                              //     text: TextSpan(children: [
                                              //       TextSpan(
                                              //         text: 'Minimum Deposit LKR: ',
                                              //         style: TextStyle(
                                              //           fontSize: 16,
                                              //           fontWeight:
                                              //           FontWeight.w400,
                                              //           color: colors(context)
                                              //               .greyColor,
                                              //         ),
                                              //       ),
                                              //       TextSpan(
                                              //         text: "10,000",
                                              //         style: TextStyle(
                                              //           fontSize: 16,
                                              //           fontWeight:
                                              //           FontWeight.w400,
                                              //           color: colors(context)
                                              //               .greyColor,
                                              //         ),
                                              //       )
                                              //     ])),
                                              // SizedBox(height: 3.h,),
                                              // RichText(
                                              //     text: TextSpan(children: [
                                              //       TextSpan(
                                              //         text: 'Last updated: ',
                                              //         style: TextStyle(
                                              //           fontSize: 16,
                                              //           fontWeight:
                                              //           FontWeight.w400,
                                              //           color: colors(context)
                                              //               .greyColor,
                                              //         ),
                                              //       ),
                                              //       TextSpan(
                                              //         text: "10/10/2023",
                                              //         style: TextStyle(
                                              //           fontSize: 16,
                                              //           fontWeight:
                                              //           FontWeight.w400,
                                              //           color: colors(context)
                                              //               .greyColor,
                                              //         ),
                                              //       )
                                              //     ])),
                                            ],
                                          ),
                                        ),
                                      ),
                                      20.verticalSpace,
                                    ],
                                  ),
                                ))),
                      ],
                    ))
                : SizedBox.shrink()),
      ),
    );
  }

  void setData(int row, int col, String data) {
    setState(() {
      // cellData[row][col] = data;
      if (cellData.isNotEmpty) {
        cellData[row][col] = data;
      }
    });
  }

  String formatNumber(double number) {
    String formattedNumber = number.toStringAsFixed(2);
    if (number < 10) {
      formattedNumber = '0' + formattedNumber;
    }

    return formattedNumber;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
