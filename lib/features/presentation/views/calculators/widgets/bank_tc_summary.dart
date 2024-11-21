import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/calculators/fixed_deposit_calculator/apply_fixed_deposit.dart';
import 'package:union_bank_mobile/features/presentation/views/calculators/housing_loan_calculator/apply_housing_loan.dart';
import 'package:union_bank_mobile/features/presentation/views/calculators/leasing_calculator/apply_for_leasing.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../home/home_base_view.dart';
import '../personal_loan_calculator/apply_personal_loan.dart';
import 'custom_button.dart';

class BankTandCWidget extends StatefulWidget {
  final bool isShow;
  final bool isFromPreLogin;
  final String loanType;
  final String title;
  final String? amount;
  final String? installmentType;
  final String interestRate;
  final String? tenure;
  final String? tenurePersonal;
  final String? tenureHousing;
  final String? tenureLeasing;
  final CalculatorType calculatorType;
  final Function? navigateToPage;
  final Function? buttonTap;
  final String? advancePayment;
  final String? manufactYear;
  final String? price;
  final String? category;
  final String? type;
  final String? nominalRate;
  final String? annualRate;
  final String? housingInstallment;
  final String? leasingInstallment;
  final String? fixedInstallment;
  final String? personalInstallment;
  final String? monthlyValue;
  final String? fdMonthlyRate;
  final String? fdValue;
  final String? rate;
  final String? interestRecieved;
  final String? currencyCode;
  final String? currency;
  final Function(CalculatorType)? shareTap;


  //final String subTitle;
  BankTandCWidget({
    required this.isShow,
    required this.isFromPreLogin,
    required this.loanType,
    required this.title,
    this.amount,
    this.monthlyValue,
    this.fdMonthlyRate = "0",
    this.fdValue,
    this.installmentType,
    this.tenure,
    required this.calculatorType,
    required this.interestRate,
    this.navigateToPage,
    this.buttonTap,
    this.advancePayment,
    this.manufactYear,
    this.price,
    this.category,
    this.type,
    this.nominalRate,
    this.annualRate,
    this.housingInstallment,
    this.leasingInstallment,
    this.fixedInstallment = "0",
    this.personalInstallment,
    this.tenurePersonal,
    this.tenureHousing,
    this.shareTap,
    this.interestRecieved,
    this.currencyCode,
    this.currency,
    this.rate,
    this.tenureLeasing,
  });

  @override
  State<BankTandCWidget> createState() => _BankTandCWidgetState();
}

class _BankTandCWidgetState extends State<BankTandCWidget> {
  bool isYesButtonClicked = false;
  bool isNoButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return widget.isShow == true
        ? Padding(
          padding: const EdgeInsets.only(bottom: 16.0).w,
          child: Container(
            decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(8).w,
              color: colors(context).whiteColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(16).w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colors(context).secondaryColor300,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16,24,16,16).w,
                      child: Column(
                        children: [
                          Text(
                              "${AppLocalizations.of(context).translate("lkr")} " +
                                  (widget.calculatorType == CalculatorType.HOUSING
                                      ? widget.housingInstallment!.toString().withThousandSeparator()
                                      : widget.calculatorType == CalculatorType.LEASING
                                      ? widget.leasingInstallment!.toString().withThousandSeparator()
                                      : widget.calculatorType == CalculatorType.FIXED
                                      ?
                                  (widget.calculatorType == CalculatorType.FIXED && widget.interestRecieved == "maturity") ?
                                  widget.fixedInstallment!.toString().withThousandSeparator() : widget.fdMonthlyRate.toString().withThousandSeparator() ?? ""
                                      : widget.calculatorType == CalculatorType.PERSONAL
                                      ? widget.personalInstallment!.toString().withThousandSeparator()
                                      : "0"),
                              style: size18weight700.copyWith(color: colors(context).blackColor)
                          ),
                          1.verticalSpace,
                          Text(
                              widget.title,
                              style: size14weight400.copyWith(color: colors(context).greyColor)
                          ),
                          if(widget.calculatorType == CalculatorType.FIXED && widget.interestRecieved == "monthly")
                            Column(
                              children: [
                                0.96.verticalSpace,
                                Text(
                                    "${AppLocalizations.of(context).translate("lkr")} " +
                                    widget.monthlyValue!.toString().withThousandSeparator(),
                                    style: size18weight700.copyWith(color: colors(context).blackColor)
                                ),
                                0.24.verticalSpace,
                                Text(
                                    AppLocalizations.of(context)
                                        .translate("fixed_deposits_value"),
                                    style: size14weight400.copyWith(color: colors(context).greyColor)
                                ),
                              ],
                            ),
                          8.verticalSpace,
                          Divider(
                            thickness: 1,
                            height: 0,
                            color: colors(context).secondaryColor700,
                          ),
                          8.verticalSpace,
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25).w,
                            child: Text(
                                textAlign: TextAlign.center,
                                AppLocalizations.of(context).translate("bank_tc_widget_des"),
                                style: size12weight400.copyWith(color: colors(context).greyColor)
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  widget.calculatorType == CalculatorType.LEASING
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: colors(context).secondaryColor300,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16).w,
                                child: Column(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      widget.tenure ?? "",
                                      style: size18weight700.copyWith(color: colors(context).blackColor)
                                    ),
                                    0.24.verticalSpace,
                                    Text(
                                      textAlign: TextAlign.center,
                                      AppLocalizations.of(context).translate("lease_period_y"),
                                      style: size12weight400.copyWith(color: colors(context).greyColor)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: colors(context).secondaryColor300,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0).w,
                                child: Column(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      widget.interestRate + '%',
                                      style: size18weight700.copyWith(color: colors(context).blackColor)
                                    ),
                                    0.24.verticalSpace,
                                    Text(
                                      textAlign: TextAlign.center,
                                      AppLocalizations.of(context).translate("applied_interest_rate"),
                                      style: size12weight400.copyWith(color: colors(context).greyColor)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : widget.calculatorType == CalculatorType.HOUSING ||
                              widget.calculatorType == CalculatorType.PERSONAL
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colors(context).secondaryColor300,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0).w,
                                      child: Column(
                                        children: [
                                          Text(
                                            textAlign: TextAlign.center,
                                            widget.calculatorType ==
                                                    CalculatorType.PERSONAL
                                                ? widget.tenurePersonal!
                                                : widget.calculatorType ==
                                                        CalculatorType.HOUSING
                                                    ? widget.tenureHousing!
                                                    : "0",
                                            style: size18weight700.copyWith(color: colors(context).blackColor)
                                          ),
                                          0.24.verticalSpace,
                                          Text(
                                            textAlign: TextAlign.center,
                                            AppLocalizations.of(context).translate("tenure"),
                                            style: size12weight400.copyWith(color: colors(context).greyColor)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                8.horizontalSpace,
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colors(context).secondaryColor300,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0).w,
                                      child: Column(
                                        children: [
                                          Text(
                                            textAlign: TextAlign.center,
                                            widget.interestRate + "%",
                                            style: size18weight700.copyWith(color: colors(context).blackColor)
                                          ),
                                          1.verticalSpace,
                                          Text(
                                            AppLocalizations.of(context).translate("applied_interest_rate"),
                                            textAlign: TextAlign.justify,
                                            style: size12weight400.copyWith(color: colors(context).greyColor)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : widget.calculatorType == CalculatorType.FIXED
                              ? Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: colors(context).secondaryColor300,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0).w,
                                      child: Column(
                                        children: [
                                          Text(
                                            textAlign: TextAlign.center,
                                            widget.nominalRate!+ "%",
                                            style: size18weight700.copyWith(color: colors(context).blackColor)
                                          ),
                                          1.verticalSpace,
                                          Text(
                                              textAlign: TextAlign.center,
                                              AppLocalizations.of(context).translate("nominal_interest_rate"),
                                              style: size12weight400.copyWith(color: colors(context).greyColor)
                                          ),
                                        ],
                                      ),
                                    ),)
                                ],
                              )
                              : const SizedBox.shrink(),

                  16.verticalSpace,
                  Text(
                      textAlign: TextAlign.center,
                      AppLocalizations.of(context).translate("banks_terms_will_apply"),
                      style: size12weight400.copyWith(color: colors(context).blackColor)
                  ),
                  16.verticalSpace,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).w,
                      color: colors(context).primaryColor50,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0).w,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:  colors(context).primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(11.0).w,
                              child: PhosphorIcon(PhosphorIcons.bank(PhosphorIconsStyle.bold) ,
                                color: colors(context).whiteColor,
                              size: 22,
                              ),
                            ),
                          ),
                          12.verticalSpace,
                          Text(
                              textAlign: TextAlign.center,
                              AppLocalizations.of(context)
                                  .translate("like_to_contacted_by_bank"),
                              style: size14weight400.copyWith(color: colors(context).blackColor)
                          ),
                          18.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomButton(
                                  text: AppLocalizations.of(context).translate("no"),
                                  isSelected: false,
                                  onTap: () {
                                    widget.isFromPreLogin
                                        ? Navigator.pop(
                                      context, Routes.kCalculatorsView,
                                      // arguments:
                                      //     widget.isFromPreLogin ? true : false
                                    )
                                        : Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomeBaseView()),
                                          (Route<dynamic> route) => route.settings.name == 'kHomeBaseView',
                                    );
                                    setState(() {
                                      isYesButtonClicked = true;
                                      isNoButtonClicked = false;
                                    });
                                  },
                                ),
                              ),
                              16.horizontalSpace,
                              Expanded(
                                child: CustomButton(
                                  text: AppLocalizations.of(context).translate("yes"),
                                  isSelected: true,
                                  onTap: () {
                                    setState(() {
                                      isYesButtonClicked = false;
                                      isNoButtonClicked = true;
                                    });
                                    if (widget.calculatorType ==
                                        CalculatorType.PERSONAL) {
                                      Navigator.pushNamed(
                                          context, Routes.kApplyPersonalLoanView,
                                          arguments:
                                          ApplyPersonalLoanCalculatorDataViewArgs(
                                              tenure: widget.tenurePersonal,
                                              loanAmount: widget.amount,
                                              isFromPreLogin: widget.isFromPreLogin,
                                              instalmentType: widget.installmentType,
                                              rate: widget.interestRate
                                          ));
                                    }
                                    if (widget.calculatorType == CalculatorType.HOUSING) {
                                      Navigator.pushNamed(
                                          context, Routes.kApplyHousingLoanView,
                                          arguments:
                                          ApplyHousingLoanCalculatorDataViewArgs(
                                              loanAmount: widget.amount,
                                              tenure: widget.tenureHousing,
                                              instalmentType: widget.installmentType,
                                              rate: widget.interestRate,
                                              isFromPreLogin: widget.isFromPreLogin));
                                    }
                                    if (widget.calculatorType == CalculatorType.LEASING) {
                                      Navigator.pushNamed(
                                          context, Routes.kApplyLeasingView,
                                          arguments: ApplyLeasingArgs(
                                              isFromPreLogin: widget.isFromPreLogin,
                                              rate: widget.interestRate,
                                              vehicleCategory: widget.category,
                                              vehicleType: widget.type,
                                              manufactYear: widget.manufactYear,
                                              price: widget.price,
                                              advancePayment: widget.advancePayment,
                                              amount: widget.amount,
                                              tenure: widget.tenureLeasing
                                          ));
                                    }
                                    if (widget.calculatorType == CalculatorType.FIXED) {
                                      Navigator.pushNamed(
                                          context, Routes.kApplyFixedDepositLoan,
                                          arguments: ApplyFixedArgs(
                                              rate: widget.interestRate,
                                              interestPeriod: widget.tenure,
                                              interestRecieved: widget.interestRecieved,
                                              currencyCode: widget.currencyCode,
                                              isFromPreLogin: widget.isFromPreLogin,
                                              amount: widget.amount
                                          ));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ))
        : const SizedBox.shrink();
  }
}
