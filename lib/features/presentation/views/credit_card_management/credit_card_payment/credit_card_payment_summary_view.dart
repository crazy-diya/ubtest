import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';

import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../bloc/fund_transfer/fund_transfer_bloc.dart';
import '../../../bloc/fund_transfer/fund_transfer_event.dart';
import '../../../bloc/fund_transfer/fund_transfer_state.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';
import '../../otp/otp_view.dart';
import 'credit_card_payment_failed_view.dart';
import 'data/credit_card_payment_args.dart';

class CreditCardPaymentSummaryView extends BaseView {
  final CreditCardPaymentArgs creditCardPaymentArgs;

  CreditCardPaymentSummaryView({
    required this.creditCardPaymentArgs,
  });

  @override
  State<CreditCardPaymentSummaryView> createState() =>
      _CreditCardPaymentSummaryViewState();
}

class _CreditCardPaymentSummaryViewState
    extends BaseViewState<CreditCardPaymentSummaryView> {
  final bloc = injection<FundTransferBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  onRetryPressedEvent(){
    Navigator.pushNamed(context, Routes.kCreditCardPaymentFailedView , arguments: CreditCardPaymentFailedArgs(
        creditCardPaymentArgs: widget.creditCardPaymentArgs,
        refNo: "-",
        failReason: ""
    ));
  }


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("payment_summary"),
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<FundTransferBloc,
            BaseState<FundTransferState>>(
            bloc: bloc,
            listener: (context, state){
              if(state is IntraFundTransferSuccessState){
                Navigator.pushNamed(context, Routes.kCreditCardPaymentSuccessView , arguments: CreditCardPaymentFailedArgs(
                  creditCardPaymentArgs: widget.creditCardPaymentArgs,
                  refNo: state.intraFundTransferResponse?.referenceNumber ?? "-",
                ));
                setState(() {});
              }
              if(state is IntraFundTransferFailedState){
                Navigator.pushNamed(context, Routes.kCreditCardPaymentFailedView , arguments: CreditCardPaymentFailedArgs(
                    creditCardPaymentArgs: widget.creditCardPaymentArgs,
                    refNo: state.transactionReferenceNumber ?? "-",
                  failReason: state.message ?? ""
                ));
              }
            },
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20.w, 24.w, 20.w, 20.w + AppSizer.getHomeIndicatorStatus(context)),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0).w,
                          child: Column(
                            children: [
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("Pay_From"),
                                data: widget.creditCardPaymentArgs.payFrom?.payFromName ?? "-",
                                subData: widget.creditCardPaymentArgs.payFrom?.payFromNum ?? "-",
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("Pay_To"),
                                data: widget.creditCardPaymentArgs.payTo?.nickName ?? "-",
                                subData: widget.creditCardPaymentArgs.payTo?.cardNumber ?? "-",
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("amount"),
                                amount: double.parse(widget.creditCardPaymentArgs.amount?.replaceAll(",", "") ?? "0.00"),
                                isCurrency: true,
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("remarks"),
                                data: widget.creditCardPaymentArgs.remark == "" || widget.creditCardPaymentArgs.remark == null? "-" :
                                widget.creditCardPaymentArgs.remark ?? "-",
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("service_charge"),
                                amount: widget.creditCardPaymentArgs.payFrom?.serviceCharge,
                                isCurrency: true,
                                isLastItem: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    20.verticalSpace,
                    AppButton(
                      buttonText: AppLocalizations.of(context).translate("confirm"),
                      onTapButton: () {
                        Navigator.pushNamed(context, Routes.kOtpView,
                            arguments: OTPViewArgs(
                              phoneNumber: AppConstants.profileData.mobileNo.toString(),
                              appBarTitle: "otp_verification",
                              requestOTP: true,
                              otpType: kFundTransOTPType,
                            )).then((value) {
                          if (value is bool && value) {
                            if (value == true) {
                              // print(AppConstants.ubBankCode.toString());
                              // print(widget.creditCardPaymentArgs.payTo?.accountNumber);
                              // print(widget.creditCardPaymentArgs.payTo?.nickName?.contains("*"));
                              // print(widget.creditCardPaymentArgs.payTo?.nickName?.replaceAll("*", ""));
                              // print(widget.creditCardPaymentArgs.payTo?.nickName);
                              // print(widget.creditCardPaymentArgs.remark);
                              // print(widget.creditCardPaymentArgs.payFrom?.instrumentId);
                              // print(widget.creditCardPaymentArgs.amount);
                              // print(widget.creditCardPaymentArgs.amount?.replaceAll(",", ""));
                              // print("@@@@@@@@@@@@#############");
                              // print(getTranType());
                              bloc.add(
                                  AddIntraFundTransferEvent(
                                transactionCategory: "",
                                toBankCode: AppConstants.ubBankCode.toString(),
                                toAccountNo: widget.creditCardPaymentArgs.payTo?.accountNumber,
                                toAccountName: widget.creditCardPaymentArgs.payTo?.nickName?.contains("*") == true ?
                                widget.creditCardPaymentArgs.payTo?.nickName?.replaceAll("*", "") : widget.creditCardPaymentArgs.payTo?.nickName,
                                remarks: widget.creditCardPaymentArgs.remark??"",
                                // reference: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.reference,
                                instrumentId: widget.creditCardPaymentArgs.payFrom?.instrumentId,
                                isCreditCardPayment: true,
                                tranType: getTranType(),
                                // beneficiaryMobileNo: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.beneficiaryMobile,
                                // beneficiaryEmail: widget.ftOtpArgs.fundTransferArgs.fundTransferEntity.beneficiaryEmail,
                                amount: double.parse(widget.creditCardPaymentArgs.amount?.replaceAll(",", "") ?? "0.00"),
                              ));
                            }
                          }
                        });
                      },
                    ),
                    16.verticalSpace,
                    AppButton(
                      buttonType: ButtonType.OUTLINEENABLED,
                      buttonText: AppLocalizations.of(context).translate("cancel"),
                      buttonColor: Colors.transparent,
                      onTapButton: () {
                        showAppDialog(
                            title: AppLocalizations.of(context)
                                .translate("cancel_the_transaction"),
                            alertType: AlertType.TRANSFER,
                            message: AppLocalizations.of(context)
                                .translate("cancel_fund_transfer_des"),
                            positiveButtonText: AppLocalizations.of(context)
                                .translate("yes_cancel"),
                            onPositiveCallback: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.kHomeBaseView,
                                (route) => false,
                              );
                            },
                            negativeButtonText:
                                AppLocalizations.of(context).translate("no"),
                            onNegativeCallback: () {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getTranType(){
    if(widget.creditCardPaymentArgs.creditCardPaymentType == CreditCardPaymentType.OWN){
      if(widget.creditCardPaymentArgs.bankCode == AppConstants.ubBankCode.toString()){
        return "OWNUBCC";
      } else {
        return "JPCC";
      }
    } else {
      if(widget.creditCardPaymentArgs.bankCode == AppConstants.ubBankCode.toString()){
        return "WITHINUBCC";
      } else {
        return "JPCC";
      }
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
