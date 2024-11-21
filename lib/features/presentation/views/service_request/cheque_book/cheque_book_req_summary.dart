import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../bloc/service_requests/service_requests_bloc.dart';
import '../../../bloc/service_requests/service_requests_state.dart';
import '../../../widgets/app_button.dart';
import '../../base_view.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';
import '../data/service_req_args.dart';
import '../data/service_req_entity.dart';

class ChequeBookReqSummaryView extends BaseView {
  final ServiceReqArgs serviceReqArgs;


  ChequeBookReqSummaryView({required this.serviceReqArgs});

  @override
  _ChequeBookReqSummaryViewState createState() =>
      _ChequeBookReqSummaryViewState();
}

class _ChequeBookReqSummaryViewState
    extends BaseViewState<ChequeBookReqSummaryView> {
  var bloc = injection<ServiceRequestsBloc>();
  String? chequeBookId;
  final serviceReqEntity = ServiceReqEntity();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        goBackEnabled: true,
        title: widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE
            ? AppLocalizations.of(context).translate("check_book_req_summary")
            : AppLocalizations.of(context).translate("statement_req_summary"),
        // onBackPressed: () {
        //   showAppDialog(
        //       title: AppLocalizations.of(context)
        //           .translate("cancel_the_confirmation"),
        //       message: AppLocalizations.of(context)
        //           .translate("cancel_the_confirmation_des"),
        //       alertType: AlertType.INFO,
        //       onPositiveCallback: () {
        //         Navigator.pushAndRemoveUntil(
        //           context,
        //           MaterialPageRoute(builder: (context) => HomeBaseView()),
        //           (Route<dynamic> route) =>
        //               route.settings.name == 'kHomeBaseView',
        //         );
        //       },
        //       positiveButtonText:
        //           AppLocalizations.of(context).translate("yes,_cancel"),
        //       negativeButtonText:
        //           AppLocalizations.of(context).translate("no"),
        //       onNegativeCallback: () {});
        // meka comment kre bug ekk nisa UBDB-697
        // },
      ),
      body: BlocProvider<ServiceRequestsBloc>(
        create: (_) => bloc,
        child: BlocListener<ServiceRequestsBloc,
            BaseState<ServiceRequestsState>>(
          listener: (_, state) {
            if (state is CheckBookRequestSuccessState) {
              // chequeBookId == state.chequeBookId.toString();
              // Navigator.pushNamed(context, Routes.kOtpView,
              //     arguments: OTPViewArgs(
              //       phoneNumber: AppConstants.profileData.mobileNo.toString(),
              //       appBarTitle: 'cheque_book_request',
              //       requestOTP: true,
              //       otpType: kChequeBookOtpType,
              //     )).then((value) {
              //   final result = value as bool;
              //   if (result == true) {
              //     showAppDialog(
              //       title:
              //       AppLocalizations.of(context).translate("request_success"),
              //       message: widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
              //       AppLocalizations.of(context).translate("request_success_des") :
              //       AppLocalizations.of(context).translate("request_success_des_statement"),
              //       alertType: AlertType.SUCCESS,
              //       onPositiveCallback: () {
              //
              //       },
              //       positiveButtonText: AppLocalizations.of(context).translate("ok"),
              //     );
              //     Navigator.of(context)
              //       ..pop()
              //       ..pop(true);
              //     ToastUtils.showCustomToast(
              //         context,
              //         AppLocalizations.of(context)
              //             .translate("add_payee_success_message"),
              //         ToastStatus.success);
              //   }
              // });
            }
          },
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 16,right: 16).w,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("Account_Number"),
                                  data: (widget.serviceReqArgs.serviceReqEntity
                                                  ?.payFromNum ==
                                              "" ||
                                          widget.serviceReqArgs.serviceReqEntity
                                                  ?.payFromNum ==
                                              null)
                                      ? "-"
                                      : widget.serviceReqArgs.serviceReqEntity
                                          ?.payFromNum ?? "-",
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("collection_method"),
                                  data: (widget.serviceReqArgs.serviceReqEntity
                                                  ?.collectionMethod ==
                                              "" || widget.serviceReqArgs.serviceReqEntity?.collectionMethod == null)
                                      ? "-"
                                      : (widget.serviceReqArgs.serviceReqEntity
                                          ?.collectionMethod! == "ADDRESS") ? "Home Delivery" : "Branch",
                                ),
                                if (widget.serviceReqArgs.serviceReqEntity?.collectionMethod! == "ADDRESS")
                                  Column(
                                    children: [
                                      FTSummeryDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("address_line_1"),
                                        data: (widget.serviceReqArgs.serviceReqEntity?.addressLine1 == "" ||
                                            widget.serviceReqArgs.serviceReqEntity?.addressLine1 == null)
                                            ? "-"
                                            : widget.serviceReqArgs.serviceReqEntity
                                            ?.addressLine1 ?? "-",
                                      ),
                                      FTSummeryDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("address_line_2"),
                                        data: (widget.serviceReqArgs.serviceReqEntity?.addressLine2 == "" ||
                                            widget.serviceReqArgs.serviceReqEntity?.addressLine2 == null)
                                            ? "-"
                                            : widget.serviceReqArgs.serviceReqEntity
                                            ?.addressLine2 ?? "-",
                                      ),
                                      FTSummeryDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("city"),
                                        data: (widget.serviceReqArgs.serviceReqEntity?.city == "" ||
                                            widget.serviceReqArgs.serviceReqEntity?.city == null)
                                            ? "-"
                                            : widget.serviceReqArgs.serviceReqEntity
                                            ?.city ?? "-",
                                      ),
                                    ],
                                  ),
                                if (widget.serviceReqArgs.serviceReqEntity?.collectionMethod! == "BRANCH")
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context)
                                        .translate("selected_branch"),
                                    data: (widget.serviceReqArgs.serviceReqEntity
                                                    ?.branchName ==
                                                "" ||
                                            widget.serviceReqArgs.serviceReqEntity
                                                    ?.branchName ==
                                                null)
                                        ? "-"
                                        : widget.serviceReqArgs.serviceReqEntity
                                            ?.branchName ?? "-",
                                  ),
                                if (widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE)
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context).translate("number_of_leaves"),
                                    data: (widget.serviceReqArgs.serviceReqEntity?.noOfLeaves == "" ||
                                            widget.serviceReqArgs.serviceReqEntity?.noOfLeaves == null) ? "-"
                                        : widget.serviceReqArgs.serviceReqEntity?.noOfLeaves ?? "-",
                                  ),
                                if (widget.serviceReqArgs.serviceReqType == ServiceReqType.STATEMENT)
                                  Column(
                                    children: [
                                      FTSummeryDataComponent(
                                        title: AppLocalizations.of(context).translate("from_date"),
                                        data: (widget.serviceReqArgs.serviceReqEntity?.startDate == "" ||
                                                widget.serviceReqArgs.serviceReqEntity?.startDate == null)
                                            ? "-"
                                            :  DateFormat('dd-MMM-yyyy').format(
                                            DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(widget.serviceReqArgs.serviceReqEntity!.startDate.toString())),
                                      ),
                                      FTSummeryDataComponent(
                                        title: AppLocalizations.of(context)
                                            .translate("to_date"),
                                        data: (widget.serviceReqArgs.serviceReqEntity?.endDate == "" ||
                                                widget.serviceReqArgs.serviceReqEntity?.endDate == null)
                                            ? "-"
                                            : DateFormat('dd-MMM-yyyy').format(
                                            DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(widget.serviceReqArgs.serviceReqEntity!.endDate.toString())),
                                      ),
                                    ],
                                  ),
                                if(widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE)
                                  FTSummeryDataComponent(
                                      title: AppLocalizations.of(context)
                                          .translate("service_charge"),
                                      isCurrency: true,
                                      isLastItem: (widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE && widget.serviceReqArgs.serviceReqEntity?.collectionMethod != "ADDRESS")?true:false,
                                      amount: widget.serviceReqArgs.serviceReqEntity?.noOfLeaves == "10" ?
                                          widget.serviceReqArgs.serviceChargeEntity.serviceChargeNumOfLeaves10?.toDouble() ?? 0.00:
                                      widget.serviceReqArgs.serviceChargeEntity.serviceChargeNumOfLeaves20?.toDouble()?? 0.00),
                                      // (widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE && widget.serviceReqArgs.serviceReqEntity?.noOfLeaves == "10") ?
                                      // double.parse(widget.serviceReqArgs.serviceChargeEntity.serviceChargeNumOfLeaves10.toString()) : double.parse(widget.serviceReqArgs.serviceChargeEntity.serviceChargeNumOfLeaves20.toString())),
                                if(widget.serviceReqArgs.serviceReqType == ServiceReqType.STATEMENT)
                                  FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("service_charge"),
                                      isCurrency: true,
                                      isLastItem: (widget.serviceReqArgs.serviceReqType == ServiceReqType.STATEMENT && widget.serviceReqArgs.serviceReqEntity?.collectionMethod != "ADDRESS")?true:false,
                                      amount: widget.serviceReqArgs.serviceChargeEntity.serviceChargeStatement?.toDouble() ?? 0.00
                                      // double.parse(widget.serviceReqArgs.serviceChargeEntity.serviceChargeStatement.toString())
                                  ),
                                if (widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE && widget.serviceReqArgs.serviceReqEntity?.collectionMethod == "ADDRESS")
                                  FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("delivery_charge"),
                                      isCurrency: true,
                                      isLastItem: widget.serviceReqArgs.serviceReqEntity?.collectionMethod == "ADDRESS"?true:false,
                                      amount: widget.serviceReqArgs.serviceChargeEntity.deliveryCharge?.toDouble()?? 0.00,),
                                if (widget.serviceReqArgs.serviceReqType == ServiceReqType.STATEMENT && widget.serviceReqArgs.serviceReqEntity?.collectionMethod == "ADDRESS")
                                  FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("delivery_charge"),
                                      isCurrency: true,
                                      isLastItem: widget.serviceReqArgs.serviceReqEntity?.collectionMethod == "ADDRESS"?true:false,
                                      amount: widget.serviceReqArgs.serviceChargeEntity.deliveryChargeStatement?.toDouble()?? 0.00,)
                                      // widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                      // double.parse(widget.serviceReqArgs.serviceChargeEntity.deliveryCharge.toString()) : double.parse(widget.serviceReqArgs.serviceChargeEntity.deliveryChargeStatement.toString())),
                              ]),
                        ),
                      ),
                    )),
                    Column(
                      children: [
                        if (widget.serviceReqArgs.serviceReqEntity?.collectionMethod == "ADDRESS")
                          Column(
                            children: [
                              20.verticalSpace,
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color:
                                          colors(context).secondaryColor200 ??
                                              colors(context).whiteColor!),
                                  color: colors(context).secondaryColor200,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       top: 15.0, left: 5),
                                    //   child: Image.asset(
                                    //     AppAssets.icSheduleInfo,
                                    //     scale: 3,
                                    //   ),
                                    // ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                PhosphorIcon(PhosphorIcons.info(PhosphorIconsStyle.bold), size: 16, color: colors(context).blackColor,),
                                                5.horizontalSpace,
                                                Text(
                                                  AppLocalizations.of(context).translate("please_note"),
                                                  style: size14weight700.copyWith(color: colors(context).blackColor),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ],
                                            ),
                                            8.verticalSpace,
                                            Text(
                                              widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE
                                                  ? AppLocalizations.of(context)
                                                      .translate(
                                                          "cheque_book_req_summary_des")
                                                  : AppLocalizations.of(context)
                                                      .translate(
                                                          "statement_req_summary_des"),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        20.verticalSpace,
                        AppButton(
                            buttonText: AppLocalizations.of(context).translate("confirm"),
                            onTapButton: () {
                              if (_formKey.currentState?.validate() == false) {
                                return;
                              }
                              showAppDialog(
                                  title: widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                  AppLocalizations.of(context).translate("confirm_check_book_req") : AppLocalizations.of(context).translate("confirm_statement"),
                                  message: AppLocalizations.of(context).translate("confirmation_request_des"),
                                  alertType: widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                  AlertType.CHECKBOOK :
                                  AlertType.STATEMENT,
                                  onPositiveCallback: () {
                                    Navigator.pushNamed(context,
                                        Routes.kChequeBookRequestView,
                                        arguments: widget.serviceReqArgs
                                    );
                                  },
                                  positiveButtonText: AppLocalizations.of(context).translate("continue"),
                                  negativeButtonText: AppLocalizations.of(context).translate("cancel"),
                                  onNegativeCallback: () {});
                            }),
                        16.verticalSpace,
                        AppButton(
                          buttonType: ButtonType.OUTLINEENABLED,
                          buttonColor: Colors.transparent,
                          buttonText: AppLocalizations.of(context).translate("cancel"),
                          onTapButton: () {
                            showAppDialog(
                                title: widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                AppLocalizations.of(context).translate("cancel_the_check_book"):
                                AppLocalizations.of(context).translate("cancel_the_statement"),
                                message: AppLocalizations.of(context).translate("cancel_the_request_des"),
                                alertType: widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                AlertType.CHECKBOOK :
                                AlertType.STATEMENT,
                                onPositiveCallback: () {
                                  Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
                                },
                                positiveButtonText: AppLocalizations.of(context).translate("yes,_cancel"),
                                negativeButtonText: AppLocalizations.of(context).translate("no"),
                                onNegativeCallback: () {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
