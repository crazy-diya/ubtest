import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../../data/datasources/local_data_source.dart';
import '../../../bloc/service_requests/service_requests_bloc.dart';
import '../../../bloc/service_requests/service_requests_event.dart';
import '../../../bloc/service_requests/service_requests_state.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../float_inquiry/widgets/fi_data_component.dart';
import '../data/service_req_args.dart';
import '../data/service_req_entity.dart';
import '../widgets/service_req_component.dart';
import 'cheque_book_req_details_view.dart';



class ChequeBookHistoryView extends BaseView {
  final ServiceReqArgs serviceReqArgs;


  ChequeBookHistoryView({required this.serviceReqArgs});

  @override
  _ChequeBookHistoryViewState createState() => _ChequeBookHistoryViewState();
}

class _ChequeBookHistoryViewState extends BaseViewState<ChequeBookHistoryView> {
  var bloc = injection<ServiceRequestsBloc>();
  final _formKey = GlobalKey<FormState>();
  List<FIData> historyList = [];
  bool isHistoryAvailable = false;
  LocalDataSource? localDataSource;


  @override
  void initState() {
    widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
    bloc.add(FilterCheckBookEvent()) : bloc.add(FilterStatementEvent());
    widget.serviceReqArgs.serviceReqEntity = ServiceReqEntity();
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ? AppLocalizations.of(context).translate("cheque_book") :
        AppLocalizations.of(context).translate("statement"),
        goBackEnabled: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, Routes.kServiceReqFilterView , arguments: widget.serviceReqArgs);
            },
            icon: PhosphorIcon(
              PhosphorIcons.funnel(PhosphorIconsStyle.bold),
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<ServiceRequestsBloc,
            BaseState<ServiceRequestsState>>(
          bloc: bloc,
          listener: (context, state) {
            if(state is FilterChequeBookSuccessState){
              historyList.clear();
              historyList.addAll(state.chequebookFilterList!
                  .map((e) => FIData(
                  status: e.status,
                  chequeNumber: e.accountNo,
                  dateRecieved: DateFormat('dd MMMM yyyy | HH:mm a').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(e.modifiedDate.toString())),
                collectionMethod: e.collectionMethod,
                branch: e.branch,
                noOfLeaves: e.numberOfLeaves.toString(),
                serviceCharge: e.serviceCharge.toString(),
                address: e.address,
                deliveryCharge: e.deliveryCharge.toString()
              )).toList());
              historyList.length == 0 ? isHistoryAvailable = false : isHistoryAvailable = true;
              setState(() {});
            }
            if(state is FilterStatementSuccessState){
              historyList.clear();
              historyList.addAll(state.statementFilterList!
                  .map((e) => FIData(
                  status: e.status,
                  chequeNumber: e.accountNo,
                  dateRecieved: DateFormat('dd MMMM yyyy | HH:mm a').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(e.createdDate.toString())),
                collectionMethod: e.collectionMethod,
                branch: e.branch,
                fromDate: e.startDate,
                toDate: e.endDate,
                serviceCharge: e.serviceCharge.toString(),
                deliveryCharge: e.deliveryCharge.toString(),
                address: e.address
              )).toList());
              historyList.length == 0 ? isHistoryAvailable = false : isHistoryAvailable = true;
              setState(() {});
            }
            if(state is FilterChequeBookFailState){
              historyList.clear();
              historyList.length == 0 ? isHistoryAvailable = false : isHistoryAvailable = true;
              ToastUtils.showCustomToast(
                  context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
            }
            if(state is FilterStatementFailState){
              historyList.clear();
              historyList.length == 0 ? isHistoryAvailable = false : isHistoryAvailable = true;
              ToastUtils.showCustomToast(
                  context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
            }
          },
          child: Stack(
            children: [
              if(isHistoryAvailable == false)
                Center(
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colors(context).secondaryColor300,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: PhosphorIcon(
                            PhosphorIcons.x(PhosphorIconsStyle.bold),
                            color: colors(context).whiteColor,
                            size: 28,
                          ),
                        ),
                      ),
                      16.verticalSpace,
                      Text(
                        AppLocalizations.of(context)
                            .translate("no_record_des"),
                        style: size18weight700.copyWith(
                            color: colors(context).blackColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if(isHistoryAvailable == true)
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 24.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).whiteColor,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(16.w,16.h,16.w,0.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context).translate("history"),
                                            style: size16weight700.copyWith(color: colors(context).blackColor),
                                          ),
                                          16.verticalSpace,
                                          Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                isHistoryAvailable == true ?
                                                ListView.builder(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  itemCount: historyList.length,
                                                  itemBuilder: (context, int index){
                                                    return InkWell(
                                                      onTap: (){
                                                        Navigator.pushNamed(context, Routes.kChequeBookRequestDetailsView,
                                                            arguments: SrHistoryDetailsArgs(
                                                              serviceReqArgs: widget.serviceReqArgs,
                                                              historyDetails: FIData(
                                                                  chequeNumber: historyList[index].chequeNumber,
                                                                  dateRecieved: historyList[index].dateRecieved,
                                                                  status: historyList[index].status?.toUpperCase(),
                                                                  collectionMethod: historyList[index].collectionMethod,
                                                                  branch: historyList[index].branch,
                                                                  noOfLeaves: historyList[index].noOfLeaves,
                                                                  serviceCharge: historyList[index].serviceCharge,
                                                                  fromDate: historyList[index].fromDate,
                                                                  toDate: historyList[index].toDate,
                                                                  address:  historyList[index].address,
                                                                  deliveryCharge: historyList[index].deliveryCharge
                                                              ), ));
                                                      },
                                                      child: ServiceReqComponent(
                                                        fiData: FIData(
                                                            chequeNumber: historyList[index].chequeNumber,
                                                            dateRecieved: historyList[index].dateRecieved,
                                                            status: historyList[index].status
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ): const SizedBox.shrink(),
                                              ]
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: AppButton(
                                buttonText: widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE?  AppLocalizations.of(context).translate( "request_new_cheque_book"):AppLocalizations.of(context).translate("request_new_statement"),
                                onTapButton: () {
                                  Navigator.pushNamed(context, Routes.kChequeBookReqView, arguments: widget.serviceReqArgs);
                                }),
                          ),
                        ],
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}