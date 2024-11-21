import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/calculators/housing_loan_calculator/housing_loan_calculator_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/cheque_status_inquiry/widgets/csi_summary_component.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';

import '../../../widgets/appbar.dart';
import '../../base_view.dart';
import '../../float_inquiry/widgets/fi_data_component.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';
import '../../request_call_back/data/request_status.dart';
import '../data/service_req_args.dart';

class SrHistoryDetailsArgs{
  final ServiceReqArgs serviceReqArgs;
  final FIData historyDetails;

  SrHistoryDetailsArgs({required this.serviceReqArgs, required this.historyDetails});


}


class ChequeBookRequestDetailsView extends BaseView {
  final SrHistoryDetailsArgs srHistoryDetailsArgs;

  ChequeBookRequestDetailsView({required this.srHistoryDetailsArgs});
  @override
  _ChequeStatusSummaryViewState createState() => _ChequeStatusSummaryViewState();
}

class _ChequeStatusSummaryViewState extends BaseViewState<ChequeBookRequestDetailsView> {
  var bloc = injection<HousingLoanCalculatorBloc>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: widget.srHistoryDetailsArgs.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ? AppLocalizations.of(context).translate("cheque_book_history") :
        AppLocalizations.of(context).translate("statement_history"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<HousingLoanCalculatorBloc,
            BaseState<HousingLoanCalculatorState>>(
          bloc: bloc,
          listener: (context, state) {},
          child: Padding(
            padding:  EdgeInsets.fromLTRB(20.w,24.h, 20.w, (20.h + AppSizer.getHomeIndicatorStatus(context))),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).whiteColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  color: colors(context).greyColor300,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      CSISummeryDataComponent(
                                        title: AppLocalizations.of(context).translate("Account_Number"),
                                        data: widget.srHistoryDetailsArgs.historyDetails.chequeNumber ?? "-",
                                        isTitle: true,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          16.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).r,
                              color: colors(context).whiteColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context).translate("collection_method"),
                                    data: collectionMethod(),
                                    // widget.srHistoryDetailsArgs.historyDetails.collectionMethod ?? "-",
                                  ),
                                  if(widget.srHistoryDetailsArgs.historyDetails.collectionMethod == "BRANCH")
                                    FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("branch"),
                                      data: widget.srHistoryDetailsArgs.historyDetails.branch ?? "-",
                                    ),
                                  if(widget.srHistoryDetailsArgs.historyDetails.collectionMethod == "ADDRESS")
                                    FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("address"),
                                      data: widget.srHistoryDetailsArgs.historyDetails.address ?? "-",
                                    ),
                                  if(widget.srHistoryDetailsArgs.serviceReqArgs.serviceReqType == ServiceReqType.STATEMENT)
                                    Column(
                                      children: [
                                        FTSummeryDataComponent(
                                          title: AppLocalizations.of(context).translate("from_date"),
                                          data: DateFormat('yyyy-MM-dd').format(widget.srHistoryDetailsArgs.historyDetails.fromDate ?? DateTime.now()),
                                        ),
                                        FTSummeryDataComponent(
                                          title: AppLocalizations.of(context).translate("to_date"),
                                          data: DateFormat('yyyy-MM-dd').format(widget.srHistoryDetailsArgs.historyDetails.toDate ?? DateTime.now()),
                                        ),
                                      ],
                                    ),
                                  if(widget.srHistoryDetailsArgs.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE)
                                    FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("number_of_leaves"),
                                      data: widget.srHistoryDetailsArgs.historyDetails.noOfLeaves ?? "-",
                                    ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context).translate("service_charge"),
                                    isCurrency: true,
                                    amount: double.parse(widget.srHistoryDetailsArgs.historyDetails.serviceCharge ?? "0"),
                                  ),
                                  if(widget.srHistoryDetailsArgs.historyDetails.collectionMethod == "ADDRESS")
                                    FTSummeryDataComponent(
                                      title: AppLocalizations.of(context).translate("delivery_charge"),
                                      isCurrency: true,
                                      amount: double.parse(widget.srHistoryDetailsArgs.historyDetails.deliveryCharge ?? "0"),
                                    ),
                                  FTSummeryDataComponent(
                                    title: AppLocalizations.of(context).translate("request_date"),
                                    data: widget.srHistoryDetailsArgs.historyDetails.dateRecieved ?? "-",
                                  ),
                                  16.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppLocalizations.of(context).translate("status") ,
                                        style: size14weight700.copyWith(color: colors(context).blackColor,),),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                                color: colors(context).greyColor200!),
                                            color: getStatus(widget.srHistoryDetailsArgs.historyDetails.status??"",context).color!),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 7.0, right: 7, top: 4, bottom: 4),
                                          child: Text(
                                            getStatus(widget.srHistoryDetailsArgs.historyDetails.status??"",context).status!,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: colors(context).whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
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

  String collectionMethod(){
    if(widget.srHistoryDetailsArgs.historyDetails.collectionMethod == "BRANCH"){
      return "Branch";
    }else{
      return "Home Delivery";
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}