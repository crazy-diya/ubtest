import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/views/fund_transfer/widgets/fund_transfer_data_component.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../bloc/fund_transfer/fund_transfer_bloc.dart';

import '../../base_view.dart';
import '../data/fund_transfer_args.dart';
import '../otp/ft_otp_view.dart';

class FundTransferNewReccurSummeryView extends BaseView {
  final FundTransferArgs fundTransferArgs;

  FundTransferNewReccurSummeryView({required this.fundTransferArgs});

  @override
  _FundTransferNewReccurSummeryViewState createState() =>
      _FundTransferNewReccurSummeryViewState();
}

class _FundTransferNewReccurSummeryViewState
    extends BaseViewState<FundTransferNewReccurSummeryView> {
  var _bloc = injection<FundTransferBloc>();
  int? balanceBeforeTransfer = 520000;
  int? balanceAfterTransfer;
  bool isCEFTenable = false;

  @override
  void initState() {
    if(widget.fundTransferArgs.fundTransferEntity.bankCode == AppConstants.ubBankCode){
      isCEFTenable = true;
      setState(() {
      });
    }
    super.initState();
  }


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(title: AppLocalizations.of(context).translate("Fund_Transfer_Summary"),
          // AppLocalizations.of(context).translate("Fund_Transfer_Summary"),
          ),
      body: BlocProvider(
        create: (_) => _bloc,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h+ AppSizer.getHomeIndicatorStatus(context)),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(top:24.h),
                          child: Column(
                            children: [
                            if(widget.fundTransferArgs.fundTransferEntity.bankCodePayFrom == 7302)  Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).whiteColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0).w,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8).r,
                                          color: colors(context).primaryColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16).w,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${AppLocalizations.of(context).translate("lkr")} ${widget.fundTransferArgs.fundTransferEntity.availableBalance.toString().withThousandSeparator()}",
                                                      style: size14weight700.copyWith(
                                                          color: colors(context).whiteColor),
                                                    ),
                                                    4.verticalSpace,
                                                    Text(
                                                      AppLocalizations.of(context).translate(
                                                          "balance_before_transfer"),
                                                      style: size12weight400.copyWith(
                                                          color: colors(context).whiteColor),
                                                    ),
                                  
                                                  ],
                                                ),
                                              ),
                                              Container(width: 1,height: 40.h,color: colors(context).primaryColor300,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${AppLocalizations.of(context).translate("lkr")} ${(widget.fundTransferArgs.fundTransferEntity.availableBalance! -
                                                          (widget.fundTransferArgs.fundTransferEntity.amount!+ widget.fundTransferArgs.fundTransferEntity.serviceCharge!)).toString().withThousandSeparator()}",
                                                      style: size14weight700.copyWith(
                                                          color: colors(context).whiteColor),
                                                    ),
                                                    4.verticalSpace,
                                                    Text(
                                                      AppLocalizations.of(context).translate(
                                                          "balance_after_transfer"),
                                                      style: size12weight400.copyWith(
                                                          color: colors(context).whiteColor),
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
                                  16.verticalSpace,
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(16,0,16,0).w,
                                  child: Column(
                                    children: [
                                      FTSummeryDataComponent(
                                        title: AppLocalizations.of(context).translate("Pay_From"),
                                        data: widget.fundTransferArgs.fundTransferEntity.payFromName ?? "-",
                                        subData: widget.fundTransferArgs.fundTransferEntity.payFromNum ?? "0",
                                      ),
                                      FTSummeryDataComponent(
                                        title: AppLocalizations.of(context).translate("Pay_To"),
                                        data: widget.fundTransferArgs.fundTransferEntity.bankCode == AppConstants.ubBankCode ?
                                        widget.fundTransferArgs.fundTransferEntity.payToacctname ?? "" :
                                        widget.fundTransferArgs.fundTransferEntity.payToacctname ?? "-",
                                        subData: widget.fundTransferArgs.fundTransferEntity.payToacctnmbr ?? "0",
                                      ),
                                      if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDNOW ||
                                          widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDRECURRING ||
                                          widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDLATER)
                                        FTSummeryDataComponent(
                                          title: AppLocalizations.of(context).translate("to_account_name"),
                                          data: widget.fundTransferArgs.fundTransferEntity.name ?? "-",
                                        ),
                                      if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDNOW ||
                                          widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDRECURRING ||
                                          widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDLATER ||
                                          widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWNOW ||
                                          widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWLATER ||
                                          widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWRECURRING
                                      )
                                        FTSummeryDataComponent(
                                          title: AppLocalizations.of(context).translate("bank"),
                                          data: widget.fundTransferArgs.fundTransferEntity.bankName ?? "-",
                                        ),
                                      FTSummeryDataComponent(
                                        title: AppLocalizations.of(context).translate("amount"),
                                        isCurrency: true,
                                        amount: widget.fundTransferArgs.fundTransferEntity.amount ?? 0,
                                      ),
                                      if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNRECUURING ||
                                          widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDRECURRING ||
                                          widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWRECURRING
                                      )
                                        Column(
                                          children: [
                                            FTSummeryDataComponent(
                                              title: AppLocalizations.of(context).translate("schedule_type"),
                                              data: "Repeat",
                                            ),
                                            FTSummeryDataComponent(
                                              title: AppLocalizations.of(context).translate("schedule_start_date"),
                                              data: widget.fundTransferArgs.fundTransferEntity.startDate ?? "-",
                                            ),
                                            FTSummeryDataComponent(
                                              title: AppLocalizations.of(context).translate("frequency"),
                                              data:AppLocalizations.of(context).translate (widget.fundTransferArgs.fundTransferEntity.scheduleFrequency??"daily"),
                                            ),
                                            FTSummeryDataComponent(
                                              title: AppLocalizations.of(context).translate("schedule_end_date"),
                                              data: widget.fundTransferArgs.fundTransferEntity.endDate ?? "-",
                                            ),
                                            FTSummeryDataComponent(
                                              title: AppLocalizations.of(context).translate("no_of_transfers"),
                                              data: getNumberOfTrans(),
                                            ),
                                          ],
                                        ),
                                      FTSummeryDataComponent(
                                        title: AppLocalizations.of(context).translate("remarks"),
                                        data: widget.fundTransferArgs.fundTransferEntity.remark == null || widget.fundTransferArgs.fundTransferEntity.remark == "" ? "-" :
                                        widget.fundTransferArgs.fundTransferEntity.remark ?? "-",
                                      ),
                                      FTSummeryDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("transaction_category"),
                                        data: widget.fundTransferArgs.fundTransferEntity.transactionCategory ?? "-",
                                      ),
                                      if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNLATER ||
                                          widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDLATER ||
                                          widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWLATER
                                      )
                                        FTSummeryDataComponent(
                                          title: AppLocalizations.of(context).translate("transaction_date"),
                                          data: widget.fundTransferArgs.fundTransferEntity.transactionDate ?? "-",
                                        ),
                                      FTSummeryDataComponent(
                                        title: AppLocalizations.of(context).translate("service_charge"),
                                        isCurrency: true,
                                        amount: widget.fundTransferArgs.fundTransferEntity.serviceCharge,
                                        isLastItem: true,
                                      ),

                                      // if(isCEFTenable)
                                      //   FTSummeryDataComponent(
                                      //     title: AppLocalizations.of(context).translate("branch"),
                                      //     data: widget.fundTransferArgs.fundTransferEntity.branch ?? "-",
                                      //   ),
                                      // FTSummeryDataComponent(
                                      //   title: AppLocalizations.of(context).translate("beneficiary_mobile_no"),
                                      //   data: widget.fundTransferArgs.fundTransferEntity.beneficiaryMobile ?? "-",
                                      // ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))),
                Column(
                  children: [
                    20.verticalSpace,
                    AppButton(
                      buttonText:
                          AppLocalizations.of(context).translate("confirm"),
                      onTapButton: () {
                        setState(() {
                          isIntraFT();
                          if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNRECUURING ||
                              widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDRECURRING ||
                              widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWRECURRING
                          ){
                            widget.fundTransferArgs.fundTransferEntity.noOfTransfers = getNumberOfTrans();
                          }
                        Navigator.pushNamed(context, Routes.kFTOtpView,
                            arguments: FtOtpArgs(
                                appBarTitle: AppLocalizations.of(context).translate("otp_verification"),
                                phoneNumber: AppConstants.profileData.mobileNo ?? "",
                                fundTransferArgs: widget.fundTransferArgs,
                                otpType: kFundTransOTPType,
                                requestOTP: true,
                                isIntraFT: isIntraFT(),
                                ftRouteType: widget.fundTransferArgs.fundTransferEntity.ftRouteType ?? FtRouteType.OWNNOW
                            ));
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
                            title: AppLocalizations.of(context).translate("cancel_fund_transfer"),
                            alertType: AlertType.WARNING,
                            message: AppLocalizations.of(context).translate("cancel_fund_transfer_des"),
                            positiveButtonText: AppLocalizations.of(context).translate("yes_cancel"),
                            onPositiveCallback: () {
                             Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
                            },
                            negativeButtonText: AppLocalizations.of(context).translate("no"),
                            onNegativeCallback: () {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),);
    //   ),
    // );
  }

  String getNumberOfTrans() {
    String trans;
    Duration difference = DateTime.parse(
      DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget.fundTransferArgs.fundTransferEntity.endDate!)),
    ).difference(DateTime.parse(
      DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget.fundTransferArgs.fundTransferEntity.startDate!)),
    ));
    if (widget.fundTransferArgs.fundTransferEntity.scheduleFrequency == "daily" || widget.fundTransferArgs.fundTransferEntity.scheduleFrequency ==null) {
      trans = (difference.inDays + 1).toString();
      return trans.toString();
    } else if (widget.fundTransferArgs.fundTransferEntity.scheduleFrequency == "weekly") {
      trans = ((difference.inDays / 7) .floor()+ 1).toString();
      return trans.toString();
    } else if (widget.fundTransferArgs.fundTransferEntity.scheduleFrequency == "monthly") {
      trans = ((DateTime.parse(
                DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(
                    widget.fundTransferArgs.fundTransferEntity.endDate!)),
              ).month -
              DateTime.parse(
                DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(
                    widget.fundTransferArgs.fundTransferEntity.startDate!)),
              ).month +
              (DateTime.parse(
                        DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(widget.fundTransferArgs.fundTransferEntity.endDate!)),
              ).year - DateTime.parse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y')
                            .parse(widget.fundTransferArgs.fundTransferEntity.startDate!)),).year) * 12)+1).toString();
      return trans.toString();
    } else {
      trans = (DateTime.parse(
                DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(
                    widget.fundTransferArgs.fundTransferEntity.endDate!)),
      ).year - DateTime.parse(
                DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(
                    widget.fundTransferArgs.fundTransferEntity.startDate!)),).year).toString();
      return trans.toString();
    }
  }

  String maskName(String input) {
    return input.replaceAllMapped(RegExp(r'[a-z]'), (match) => '*');
  }

  isIntraFT(){
    if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNNOW){
      return true;
    }
    if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNLATER){
      return false;
    }
    if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.OWNRECUURING){
      return false;
    }
    if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDNOW){
      return true;
    }
    if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDLATER){
      return false;
    }
    if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.SAVEDRECURRING){
      return false;
    }
    if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWNOW){
      return true;
    }
    if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWLATER){
      return false;
    }
    if(widget.fundTransferArgs.fundTransferEntity.ftRouteType == FtRouteType.NEWRECURRING){
      return false;
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
