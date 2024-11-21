// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/domain/entities/response/fund_transfer_entity.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/bill_payment/bill_payment_fail.dart';
import 'package:union_bank_mobile/features/presentation/views/bill_payment/bill_payment_process_view.dart';
import 'package:union_bank_mobile/features/presentation/views/bill_payment/bill_payment_sucess.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/account_entity.dart';
import '../../../domain/entities/response/biller_category_entity.dart';
import '../../../domain/entities/response/biller_entity.dart';
import '../../../domain/entities/response/custom_field_entity.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_event.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';
import '../schedule/schedule_bill_payment/widgets/schedule_bill_payment_data_component.dart';
import '../transaction_history/data/transaction_history_args.dart';

class BillPaymentSummeryArgs {
  final bool isSaved;
  final BPRouteType bpRouteType;
  final BillerCategoryEntity? billerCategoryEntity;
  final BillerEntity? billerEntity;
  final double? amount;
  final double serviceCharge;
  final String? remark;
  final AccountEntity? accountEntity;
  final List<CustomFieldEntity>? customFields;
  final String? payFromAccName;
  final String? payFromAccNumber;
  final String? payToAccNumber;
  final String? payToAccName;
  final String? balanceBeforeTran;
  final String? balanceAfterTran;
  final String? tranCatagory;
  final int? serviceProviderId;
  final String instrumentId;
  final String route;

  final String? tranDate;
  final FundTransferEntity? fundTransferEntity;
  final String? accNumber;

  final String? toAccountNumber;
  final String? startDate;
  final String? endDate;
  final String? scheduleFrequency;
  final BillPaymentViewArgs? billPaymentViewArgs;

  BillPaymentSummeryArgs({
    required this.bpRouteType,
    this.billerCategoryEntity,
    this.billerEntity,
    this.amount,
    required this.serviceCharge,
    this.remark,
    this.accountEntity,
    this.customFields,
    this.payFromAccName,
    this.payFromAccNumber,
    this.payToAccNumber,
    this.payToAccName,
    this.balanceBeforeTran,
    this.balanceAfterTran,
    this.tranCatagory,
    this.tranDate,
    this.fundTransferEntity,
    this.accNumber,
    this.toAccountNumber,
    this.startDate,
    this.endDate,
    this.scheduleFrequency,
    this.serviceProviderId,
    required this.instrumentId,
    required this.route,
    required this.isSaved,
    this.billPaymentViewArgs,
  });
}

class BillPaymentSummaryView extends BaseView {
  final BillPaymentSummeryArgs? billPaymentSummeryArgs;

  BillPaymentSummaryView({this.billPaymentSummeryArgs});

  @override
  _BillPaymentSummaryViewState createState() => _BillPaymentSummaryViewState();
}

class _BillPaymentSummaryViewState
    extends BaseViewState<BillPaymentSummaryView> {
  var _bloc = injection<BillerManagementBloc>();
  final formatCurrency = NumberFormat.currency(symbol: '');


  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("bill_payment_summary"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {
            if (state is SchedulingBillPaymentSuccessState) {
              Navigator.pushReplacementNamed(
                context,
                Routes.kBillPaymentSucessView,
                arguments: SuccessBillStatusArgs(
                    billPaymentViewArgs:
                        widget.billPaymentSummeryArgs?.billPaymentViewArgs,
                    bpRouteType: widget.billPaymentSummeryArgs?.bpRouteType,
                    route: widget.billPaymentSummeryArgs!.route,
                    isSaved: widget.billPaymentSummeryArgs?.isSaved,
                    remark: widget.billPaymentSummeryArgs?.remark,
                    toAccName: widget.billPaymentSummeryArgs!.payToAccName,
                    toAccNumber: widget.billPaymentSummeryArgs!.payToAccNumber,
                    scheduleBillPaymentResponse:
                        state.scheduleBillPaymentResponse,
                    //billPaymentArgs: widget.billPaymentLaterSummeryArgs!.fundTransferEntity!,
                    paymentSuccess: true,
                    billPaymentSummeryArgs: widget.billPaymentSummeryArgs,
                    billReceiptArgs: TransactionHistoryArgs(
                      heading: "",
                      mobileNumber: "",
                      amount: widget.billPaymentSummeryArgs!.amount,
                      date: widget.billPaymentSummeryArgs!.tranDate,
                      remark: widget.billPaymentSummeryArgs?.remark,
                      refNumber: "",
                      crdr: "",
                      fromAccName:
                          widget.billPaymentSummeryArgs!.payFromAccName,
                      fromAccNumber:
                          widget.billPaymentSummeryArgs!.payFromAccNumber,
                      serviceFee: widget.billPaymentSummeryArgs!.serviceCharge,
                      refId: state.scheduleBillPaymentResponse?.reference,
                    )),
              );
            }
            else if (state is SchedulingBillPaymentFailedState) {
              Navigator.pushReplacementNamed(
                context,
                Routes.kBillPayemntFailView,
                arguments: BillStatusFailArgs(
                    message: state.message,
                    bpRouteType: widget.billPaymentSummeryArgs!.bpRouteType,
                    route: widget.billPaymentSummeryArgs!.route,
                    date: DateTime.now().toIso8601String(),
                    payFromName:
                        widget.billPaymentSummeryArgs!.payFromAccName ??
                            widget.billPaymentSummeryArgs!.accountEntity!
                                .accountType!,
                    payFromNumber:
                        widget.billPaymentSummeryArgs!.payFromAccNumber ??
                            widget.billPaymentSummeryArgs!.accountEntity!
                                .accountNumber,
                    payToName:
                        widget.billPaymentSummeryArgs!.payToAccName ?? "",
                    payToNumber: widget.billPaymentSummeryArgs?.payToAccNumber,
                    amount: widget.billPaymentSummeryArgs?.amount.toString()),
              );
            }
            if (state is BillPaymentSuccessState) {
              //ToastUtils.showCustomToast(context, state.message ?? "Success", ToastStatus.success);
              Navigator.pushNamed(
                context,
                Routes.kBillPaymentSucessView,
                arguments: SuccessBillStatusArgs(
                    billPaymentViewArgs:
                        widget.billPaymentSummeryArgs?.billPaymentViewArgs,
                    isSaved: widget.billPaymentSummeryArgs?.isSaved,
                    billPaymentResponse: state.billPaymentResponse,
                    bpRouteType: widget.billPaymentSummeryArgs?.bpRouteType,
                    route: widget.billPaymentSummeryArgs!.route,
                    remark: widget.billPaymentSummeryArgs?.remark,
                    toAccName: widget.billPaymentSummeryArgs!.payToAccName,
                    toAccNumber: widget.billPaymentSummeryArgs!.payToAccNumber,
                    //billPaymentArgs: widget.billPaymentLaterSummeryArgs!.fundTransferEntity!,
                    billPaymentSummeryArgs: widget.billPaymentSummeryArgs!,
                    paymentSuccess: true,
                    billReceiptArgs: TransactionHistoryArgs(
                      heading: "",
                      mobileNumber: "",
                      amount: widget.billPaymentSummeryArgs!.amount,
                      date: widget.billPaymentSummeryArgs!.tranDate,
                      remark: widget.billPaymentSummeryArgs?.remark,
                      refNumber: state.billPaymentResponse?.refId,
                      crdr: "",
                      fromAccName:
                          widget.billPaymentSummeryArgs!.payFromAccName,
                      fromAccNumber:
                          widget.billPaymentSummeryArgs!.payFromAccNumber,
                      serviceFee: widget.billPaymentSummeryArgs!.serviceCharge,
                      refId: state.billPaymentResponse?.refId,
                    )),
                //Routes.kBillPaymentPaswordAuthView,
                //arguments: state.billPaymentResponse,
              );
            }
            else if (state is BillPaymentFailedState) {
              Navigator.pushNamed(
                context,
                Routes.kBillPayemntFailView,
                arguments: BillStatusFailArgs(
                    bpRouteType: widget.billPaymentSummeryArgs!.bpRouteType,
                    route: widget.billPaymentSummeryArgs!.route,
                    date: DateTime.now().toIso8601String(),
                    refId: state.refId,
                    payFromName:
                        widget.billPaymentSummeryArgs!.payFromAccName ??
                            widget.billPaymentSummeryArgs!.accountEntity!
                                .accountType!,
                    payFromNumber:
                        widget.billPaymentSummeryArgs!.payFromAccNumber ??
                            widget.billPaymentSummeryArgs!.accountEntity!
                                .accountNumber,
                    payToName:
                        widget.billPaymentSummeryArgs!.payToAccName ?? "",
                    payToNumber: widget.billPaymentSummeryArgs?.payToAccNumber,
                    amount: widget.billPaymentSummeryArgs?.amount.toString(),
                    message: state.message),
                //Routes.kBillPaymentPaswordAuthView,
                //arguments: state.billPaymentResponse,
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20.w,
              24.h,
              20.w,
              20.h+ AppSizer.getHomeIndicatorStatus(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        if(widget.billPaymentSummeryArgs?.fundTransferEntity?.bankCodePayFrom == 7302)Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: colors(context).whiteColor,
                                  borderRadius: BorderRadius.circular(8).r),
                              child: Padding(
                                padding: const EdgeInsets.all(20).w,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: colors(context).primaryColor,
                                      borderRadius: BorderRadius.circular(8).r),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 24.h, horizontal: 16.w),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "LKR ${widget.billPaymentSummeryArgs!.balanceBeforeTran.toString().withThousandSeparator()}",
                                                style: size14weight700.copyWith(
                                                    color:
                                                        colors(context).whiteColor),
                                              ),
                                              4.verticalSpace,
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        "balance_before_transfer"),
                                                style: size12weight400.copyWith(
                                                    color:
                                                        colors(context).whiteColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          height: 44.h,
                                          color: colors(context).primaryColor300,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "LKR ${(double.parse(widget.billPaymentSummeryArgs!.balanceBeforeTran!) - (widget.billPaymentSummeryArgs!.serviceCharge + widget.billPaymentSummeryArgs!.amount!)).toString().withThousandSeparator()}",
                                                style: size14weight700.copyWith(
                                                    color:
                                                        colors(context).whiteColor),
                                              ),
                                              4.verticalSpace,
                                              Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        "balance_after_transfer"),
                                                style: size12weight400.copyWith(
                                                    color:
                                                        colors(context).whiteColor),
                                              ),
                                            ],
                                          ),
                                        )
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
                              color: colors(context).whiteColor,
                              borderRadius: BorderRadius.circular(8).r),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16,
                              0,
                              16,
                              16,
                            ).w,
                            child: Column(
                              children: [
                                BillPaymentDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("Pay_To"),
                                  //data: widget.billPaymentSummeryArgs!.billerEntity!.description ?? "",
                                  //subData: widget.billPaymentSummeryArgs!.billerEntity!.collectionAccount!,
                                  //subData: widget.billPaymentSummeryArgs!.toAccountNumber!,
                                  data: widget.billPaymentSummeryArgs
                                          ?.payToAccName ??
                                      "-",
                                  subData: widget.billPaymentSummeryArgs
                                          ?.payToAccNumber ??
                                      "-",
                                ),
                                BillPaymentDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("Pay_From"),
                                  //data: widget.billPaymentSummeryArgs!.accountEntity!.accountType!,
                                  data: widget.billPaymentSummeryArgs!
                                          .payFromAccName ??
                                      "-",
                                  //subData: widget.billPaymentSummeryArgs!.accountEntity!.accountNumber!,
                                  subData: widget.billPaymentSummeryArgs!
                                          .payFromAccNumber??
                                      "-",
                                ),
                                BillPaymentDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("amount"),
                                  isCurrency: true,
                                  amount: widget.billPaymentSummeryArgs?.amount
                                      .toString()
                                      .withThousandSeparator(),
                                ),
                                BillPaymentDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("remarks"),
                                  isCurrency: false,
                                  data: widget.billPaymentSummeryArgs?.remark !=
                                              null &&
                                          widget.billPaymentSummeryArgs
                                                  ?.remark !=
                                              ''
                                      ? widget.billPaymentSummeryArgs!.remark!
                                      : "-",
                                ),
                                if (BPRouteType.LATER ==
                                    widget.billPaymentSummeryArgs?.bpRouteType)
                                  BillPaymentDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("transaction_date"),
                                    data: DateFormat('dd-MMM-y').format(
                                            DateFormat('d MMMM y').parse(widget
                                                .billPaymentSummeryArgs!
                                                .tranDate
                                                .toString())) ??
                                        "-",
                                  ),
                                if (BPRouteType.RECUURING ==
                                    widget.billPaymentSummeryArgs?.bpRouteType)
                                  Column(
                                    children: [
                                      BillPaymentDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("start_date"),
                                        data: DateFormat('dd-MMM-y').format(
                                                DateFormat('d MMMM y').parse(
                                                    widget
                                                        .billPaymentSummeryArgs!
                                                        .startDate!
                                                        .toString())) ??
                                            "-",
                                      ),
                                      BillPaymentDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("end_date"),
                                        data: DateFormat('dd-MMM-y').format(
                                                DateFormat('d MMMM y').parse(
                                                    widget
                                                        .billPaymentSummeryArgs!
                                                        .endDate!
                                                        .toString())) ??
                                            "-",
                                      ),
                                      BillPaymentDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("frequency"),
                                        data: widget.billPaymentSummeryArgs
                                                ?.scheduleFrequency ??
                                            "-",
                                      ),
                                      BillPaymentDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("no_of_transfers"),
                                        data: getNumberOfTrans(),
                                      ),
                                    ],
                                  ),
                                BillPaymentDataComponent(
                                  isLastItem: true,
                                  title: AppLocalizations.of(context)
                                      .translate("service_charge"),
                                  isCurrency: true,
                                  amount: widget
                                      .billPaymentSummeryArgs?.serviceCharge
                                      .toString()
                                      .withThousandSeparator(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    20.verticalSpace,
                    AppButton(
                      buttonText:
                          AppLocalizations.of(context).translate("confirm"),
                      onTapButton: () {
                        if (widget.billPaymentSummeryArgs?.bpRouteType ==
                            BPRouteType.NOW) {
                          Navigator.pushNamed(context, Routes.kOtpView,
                              arguments: OTPViewArgs(
                                phoneNumber: AppConstants.profileData.mobileNo
                                    .toString(),
                                appBarTitle: "otp_verification",
                                requestOTP: true,
                                otpType: kBillPaymentOtp,
                              )).then((value) {
                            // if (value is bool && value) {
                            if (value != null) {
                              if (value != false) {
                                _bloc.add(
                                  BillPaymentEvent(
                                      serviceProviderId: widget
                                          .billPaymentSummeryArgs!
                                          .serviceProviderId
                                          .toString(),
                                      billerId: widget.billPaymentSummeryArgs!
                                          .billerEntity!.billerId
                                          .toString(),
                                      accountNumber: widget
                                          .billPaymentSummeryArgs!
                                          .payToAccNumber!,
                                          
                                      //accountNumber: widget.billPaymentSummeryArgs!.accountEntity!.accountNumber!,
                                      amount: widget
                                          .billPaymentSummeryArgs!.amount!,
                                      remarks:
                                          widget.billPaymentSummeryArgs!.remark,
                                      instrumentId: int.parse(widget
                                          .billPaymentSummeryArgs!
                                          .instrumentId),
                                      billPaymentCategory: widget
                                          .billPaymentSummeryArgs!
                                          .billerCategoryEntity!
                                          .categoryDescription),
                                );
                              }
                            }
                          });
                        } else if (widget.billPaymentSummeryArgs?.bpRouteType ==
                            BPRouteType.LATER) {
                          Navigator.pushNamed(context, Routes.kOtpView,
                              arguments: OTPViewArgs(
                                phoneNumber: AppConstants.profileData.mobileNo
                                    .toString(),
                                appBarTitle: "otp_verification",
                                requestOTP: true,
                                otpType: kBillPaymentOtp,
                              )).then((value) {
                            if (value != null) {
                              if (value != false) {
                                setState(() {});
                                _bloc.add(SchedulingBillPaymentEvent(
                                  billerId: widget.billPaymentSummeryArgs!
                                      .billerEntity!.billerId
                                      .toString(),
                                  beneficiaryEmail: "",
                                  remarks:
                                      widget.billPaymentSummeryArgs!.remark,
                                  toAccountNo: widget
                                      .billPaymentSummeryArgs!.payToAccNumber,
                                  toBankCode: "1234",
                                  toAccountName: widget
                                      .billPaymentSummeryArgs!.payToAccName,
                                  scheduleSource: "SCHEDULE",
                                  scheduleType: "OneTime",
                                  scheduleTitle: "",
                                  starDay: 0,
                                  failCount: 0,
                                  modifiedUser: pref.getEpicUserId(),
                                  status: "active",
                                  paymentInstrumentId: int.tryParse(widget
                                      .billPaymentSummeryArgs!.instrumentId),
                                  //paymentInstrumentId: widget.billPaymentLaterSummeryArgs!.accountEntity?.instrumentId,
                                  modifiedDate:
                                      "${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
                                  tranType: "BP",
                                  startDate: DateFormat('yyyy-MM-dd').format(
                                      DateFormat('d MMMM y').parse(widget
                                          .billPaymentSummeryArgs!.tranDate
                                          .toString())),
                                  createdUser: pref.getEpicUserId(),
                                  createdDate:
                                      "${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
                                  //reference: widget.fundTransferArgs.fundTransferEntity.reference,
                                  reference: "",
                                  endDate: DateFormat('yyyy-MM-dd').format(
                                      DateFormat('d MMMM y').parse(widget
                                          .billPaymentSummeryArgs!.tranDate
                                          .toString())),
                                  frequency: "Daily",
                                  transCategory: "Utility",
                                  // amount:  widget.billPaymentLaterSummeryArgs!.billPaymentArgs!.amount!,
                                  amount: widget.billPaymentSummeryArgs!.amount
                                      .toString(),
                                  beneficiaryMobile: "",
                                ));
                              }
                            }
                          });
                        } else if (widget.billPaymentSummeryArgs?.bpRouteType ==
                            BPRouteType.RECUURING) {
                          Navigator.pushNamed(context, Routes.kOtpView,
                              arguments: OTPViewArgs(
                                phoneNumber: AppConstants.profileData.mobileNo
                                    .toString(),
                                appBarTitle: "otp_verification",
                                requestOTP: true,

                                ///todo: change the OTP type
                                otpType: kBillPaymentOtp,
                              )).then((value) {
                            if (value != null) {
                              if (value != false) {
                                setState(() {});
                                _bloc.add(SchedulingBillPaymentEvent(
                                  toAccountNo: widget
                                      .billPaymentSummeryArgs?.toAccountNumber,
                                  billerId: widget.billPaymentSummeryArgs!
                                      .billerEntity!.billerId
                                      .toString(),
                                  beneficiaryEmail: "",
                                  remarks:
                                      widget.billPaymentSummeryArgs!.remark,
                                  toBankCode: "1234",
                                  toAccountName: widget.billPaymentSummeryArgs?.payToAccName??"",
                                  scheduleSource: "SCHEDULE",
                                  scheduleType: "Repeat",
                                  scheduleTitle: "",
                                  failCount: 0,
                                  modifiedUser: pref.getEpicUserId(),
                                  status: "active",
                                  //paymentInstrumentId: widget.scheduleRecurringArgs.accountEntity?.instrumentId,
                                  paymentInstrumentId: int.tryParse(widget
                                      .billPaymentSummeryArgs!.instrumentId),
                                  modifiedDate:
                                      "${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
                                  tranType: "BP",
                                  createdUser: pref.getEpicUserId(),
                                  createdDate:
                                      "${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
                                  reference: "",
                                  frequency: widget.billPaymentSummeryArgs!
                                      .scheduleFrequency,
                                  transCategory: "Utility",
                                  // amount:  widget.billPaymentLaterSummeryArgs!.billPaymentArgs!.amount!,
                                  amount: widget.billPaymentSummeryArgs!.amount
                                      .toString(),
                                  beneficiaryMobile: "",
                                  startDay: 0,
                                  startDate: DateFormat('yyyy-MM-dd').format(
                                      DateFormat('d MMMM y').parse(widget
                                          .billPaymentSummeryArgs!.startDate
                                          .toString())),
                                  endDate: DateFormat('yyyy-MM-dd').format(
                                      DateFormat('d MMMM y').parse(widget
                                          .billPaymentSummeryArgs!.endDate
                                          .toString())),
                                ));
                              }
                            }
                          });
                        }
                      },
                    ),
                    16.verticalSpace,
                    AppButton(
                      buttonColor: Colors.transparent,
                      buttonType: ButtonType.OUTLINEENABLED,
                      buttonText:
                          AppLocalizations.of(context).translate("cancel"),
                      onTapButton: () {
                        showAppDialog(
                            title: AppLocalizations.of(context)
                                .translate("cancel_the_bill_payment_title"),
                            message: AppLocalizations.of(context)
                                .translate("cancel_the_bill_payment_desk"),
                            alertType: AlertType.DOCUMENT1,
                            onPositiveCallback: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.kHomeBaseView,
                                (Route<dynamic> route) => false,
                              );
                            },
                            negativeButtonText:
                                AppLocalizations.of(context).translate("no"),
                            positiveButtonText: AppLocalizations.of(context)
                                .translate("yes,_cancel"));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          //  Column(
          //   children: [
          //     Expanded(
          //         child: SingleChildScrollView(
          //             physics: const BouncingScrollPhysics(),
          //             child: Column(
          //               children: [
          //                 Padding(
          //                   padding: const EdgeInsets.only(top: 25.0),
          //                   child: Container(
          //                     color: colors(context).secondaryColor,
          //                     height: 85,
          //                     child: Padding(
          //                       padding: const EdgeInsets.only(
          //                           left: 25, right: 25, top: 20, bottom: 20),
          //                       child: Row(
          //                         children: [
          //                           Expanded(
          //                             child:  SingleChildScrollView(
          //                             scrollDirection: Axis.horizontal,
          //                               child: Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Text(
          //                                     AppLocalizations.of(context)
          //                                         .translate(
          //                                             "balance_before_transfer"),
          //                                     style: const TextStyle(
          //                                         fontSize: 14,
          //                                         fontWeight: FontWeight.w400),
          //                                   ),
          //                                   const SizedBox(
          //                                     height: 10,
          //                                   ),
          //                                   Expanded(
          //                                     child: RichText(
          //                                       text: TextSpan(children: [
          //                                         TextSpan(
          //                                           text: "LKR ",
          //                                           style: TextStyle(
          //                                             fontSize: 16,
          //                                             fontWeight: FontWeight.w400,
          //                                             color: colors(context)
          //                                                 .blackColor,
          //                                           ),
          //                                         ),
          //                                         TextSpan(
          //                                           text: widget.billPaymentSummeryArgs!.balanceBeforeTran.toString()
          //                                             .withThousandSeparator(),
          //                                           style: TextStyle(
          //                                             fontSize: 18,
          //                                             fontWeight: FontWeight.w600,
          //                                             color: colors(context)
          //                                                 .blackColor,
          //                                           ),
          //                                         )
          //                                       ]),
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                           VerticalDivider(
          //                             color: colors(context).greyColor300,
          //                             thickness: 1,
          //                           ),
          //                           Expanded(
          //                             child:  SingleChildScrollView(
          //                   scrollDirection: Axis.horizontal,
          //                               child: Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 children: [
          //                                   Text(
          //                                     AppLocalizations.of(context)
          //                                         .translate(
          //                                             "balance_after_transfer"),
          //                                   ),
          //                                   const SizedBox(
          //                                     height: 10,
          //                                   ),
          //                                   Expanded(
          //                                     child: RichText(
          //                                       text: TextSpan(children: [
          //                                         TextSpan(
          //                                           text: "LKR ",
          //                                           style: TextStyle(
          //                                             fontSize: 16,
          //                                             fontWeight: FontWeight.w400,
          //                                             color: colors(context)
          //                                                 .blackColor,
          //                                           ),
          //                                         ),
          //                                         // TextSpan(
          //                                         //   text: (double.parse(widget.billPaymentSummeryArgs!.balanceBeforeTran!) + double.parse(widget.billPaymentSummeryArgs!.serviceCharge.toString()) - widget.billPaymentSummeryArgs!.amount!).clamp(0, double.infinity).toString(),
          //                                         //   style: TextStyle(
          //                                         //     fontSize: 18,
          //                                         //     fontWeight: FontWeight.w600,
          //                                         //     color: colors(context).blackColor,
          //                                         //   ),
          //                                         // )

          //                                         TextSpan(
          //                                           text: (double.parse(widget.billPaymentSummeryArgs!.balanceBeforeTran!) - (widget.billPaymentSummeryArgs!.serviceCharge+ widget.billPaymentSummeryArgs!.amount!)).toString()
          //                                             .withThousandSeparator(),
          //                                           style: TextStyle(
          //                                             fontSize: 18,
          //                                             fontWeight: FontWeight.w600,
          //                                             color: colors(context)
          //                                                 .blackColor,
          //                                           ),
          //                                         )
          //                                       ]),
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.all(24),
          //                   child: Column(
          //                     children: [
          //                       BillPaymentDataComponent(
          //                         title: AppLocalizations.of(context)
          //                             .translate("Pay_From"),
          //                         //data: widget.billPaymentSummeryArgs!.accountEntity!.accountType!,
          //                         data: widget.billPaymentSummeryArgs!.payFromAccName ?? "-",
          //                         //subData: widget.billPaymentSummeryArgs!.accountEntity!.accountNumber!,
          //                         subData: widget.billPaymentSummeryArgs!.payFromAccNumber ?? "-",
          //                       ),
          //                       BillPaymentDataComponent(
          //                         title: AppLocalizations.of(context)
          //                             .translate("Pay_To"),
          //                         //data: widget.billPaymentSummeryArgs!.billerEntity!.description ?? "",
          //                         //subData: widget.billPaymentSummeryArgs!.billerEntity!.collectionAccount!,
          //                         //subData: widget.billPaymentSummeryArgs!.toAccountNumber!,
          //                         data: widget.billPaymentSummeryArgs
          //                                 ?.billerEntity?.billerName ??
          //                             "-",
          //                         subData: widget.billPaymentSummeryArgs
          //                                 ?.payToAccNumber ??
          //                             "-",
          //                       ),
          //                       BillPaymentDataComponent(
          //                         title: AppLocalizations.of(context)
          //                             .translate("amount"),
          //                         isCurrency: true,
          //                         amount: widget.billPaymentSummeryArgs?.amount.toString().withThousandSeparator() ,
          //                       ),

          //                       BillPaymentDataComponent(
          //                         title: AppLocalizations.of(context)
          //                             .translate("service_charge"),
          //                         isCurrency: true,
          //                          amount:widget.billPaymentSummeryArgs?.serviceCharge.toString().withThousandSeparator(),
          //                       ),
          //                         Row(
          //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           Text(
          //                             AppLocalizations.of(context)
          //                                 .translate("remarks"),
          //                             style: TextStyle(
          //                               fontSize: 16,
          //                               fontWeight: FontWeight.w600,
          //                               color: colors(context).greyColor300,
          //                             ),
          //                           ),
          //                           Text(
          //                             widget.billPaymentSummeryArgs?.remark ?? "-",
          //                             style: TextStyle(
          //                               fontSize: 18,
          //                               fontWeight: FontWeight.w600,
          //                               color: colors(context).blackColor,
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ],
          //             ))),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 24,right: 24),
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Image.asset(
          //             AppAssets.icFAQ,
          //             width: 21,
          //             height: 21,
          //           ),
          //           const SizedBox(width: 6,),
          //           Expanded(
          //             child: Text(
          //               AppLocalizations.of(context).translate("your_mobile_reload_will_be"),
          //               textAlign: TextAlign.justify,
          //               style: TextStyle(
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.w600,
          //                 color: colors(context).blackColor,
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
          //       child: Column(
          //         children: [
          //           const SizedBox(
          //             height: 20,
          //           ),
          //           AppButton(
          //             buttonText:
          //                 AppLocalizations.of(context).translate("confirm"),
          //             onTapButton: () async {
          //               Navigator.pushNamed(context, Routes.kOtpView,
          //                   arguments: OTPViewArgs(
          //                     phoneNumber: AppConstants.profileData.mobileNo.toString(),
          //                     appBarTitle: 'bill_payment',
          //                     requestOTP: true,
          //                     otpType: kBillPaymentOtp,
          //                   )).then((value) {
          //                 // if (value is bool && value) {
          //                 if(value != null){
          //                   if(value != false){
          //                     _bloc.add(
          //                       BillPaymentEvent(
          //                         serviceProviderId: widget.billPaymentSummeryArgs!.serviceProviderId.toString(),
          //                           billerId: widget.billPaymentSummeryArgs!.billerEntity!.billerId.toString(),
          //                           accountNumber: widget.billPaymentSummeryArgs!.payToAccNumber!,
          //                           //accountNumber: widget.billPaymentSummeryArgs!.accountEntity!.accountNumber!,
          //                           amount: widget.billPaymentSummeryArgs!.amount!,
          //                           remarks: widget.billPaymentSummeryArgs!.remark,
          //                           instrumentId: int.parse(widget.billPaymentSummeryArgs!.instrumentId),
          //                           billPaymentCategory: widget.billPaymentSummeryArgs!.billerCategoryEntity!.categoryDescription

          //                       ),
          //                     );
          //                     date = date;
          //                     referenceNumber = referenceNumber;

          //                   }
          //                 }

          //               });

          //             },

          //           ),
          //           AppButton(
          //                                 buttonType: ButtonType.OUTLINEENABLED,
          //             buttonText:
          //                 AppLocalizations.of(context).translate("cancel"),

          //             onTapButton: () {
          //               // showAppDialog(
          //               //   title: AppLocalizations.of(context)
          //               //       .translate("cancel_the_schedule_bill_payment"),
          //               //   alertType: AlertType.WARNING,
          //               //   message: AppLocalizations.of(context).translate(
          //               //       "cancel_the_schedule_bill_payment_des"),
          //               //   positiveButtonText: AppLocalizations.of(context)
          //               //       .translate("yes,_cancel"),
          //               //   negativeButtonText:
          //               //       AppLocalizations.of(context).translate("no"),
          //               //   onPositiveCallback: () {},
          //               // );
          //                  Navigator.pushNamedAndRemoveUntil(
          //                   context,Routes.kHomeBaseView,
          //                       (Route<dynamic> route) => false,
          //                 );
          //             },
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  String getNumberOfTrans() {
    String trans;

    Duration difference = DateTime.parse(
      DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y')
          .parse(widget.billPaymentSummeryArgs!.endDate!)),
    ).difference(DateTime.parse(
      DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y')
          .parse(widget.billPaymentSummeryArgs!.startDate!)),
    ));
    if (widget.billPaymentSummeryArgs!.scheduleFrequency == "Daily") {
      trans = (difference.inDays + 1).toString();
      return trans.toString();
    } else if (widget.billPaymentSummeryArgs!.scheduleFrequency == "Weekly") {
      trans = ((difference.inDays / 7) + 1).floor().toString();
      return trans.toString();
    } else if (widget.billPaymentSummeryArgs!.scheduleFrequency == "Monthly") {
      trans = ((DateTime.parse(
                    DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y')
                        .parse(widget.billPaymentSummeryArgs!.endDate!)),
                  ).month -
                  DateTime.parse(
                    DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y')
                        .parse(widget.billPaymentSummeryArgs!.startDate!)),
                  ).month +
                  (DateTime.parse(
                            DateFormat('yyyy-MM-dd').format(
                                DateFormat('d MMMM y').parse(
                                    widget.billPaymentSummeryArgs!.endDate!)),
                          ).year -
                          DateTime.parse(
                            DateFormat('yyyy-MM-dd').format(
                                DateFormat('d MMMM y').parse(
                                    widget.billPaymentSummeryArgs!.startDate!)),
                          ).year) *
                      12) +
              1)
          .toString();
      return trans.toString();
    } else {
      trans = (DateTime.parse(
                DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y')
                    .parse(widget.billPaymentSummeryArgs!.endDate!)),
              ).year -
              DateTime.parse(
                DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y')
                    .parse(widget.billPaymentSummeryArgs!.startDate!)),
              ).year)
          .toString();
      return trans.toString();
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
// @override
// Base<BaseEvent, BaseState> getBloc() {
//   return bloc;
// }
}
