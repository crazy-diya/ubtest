import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/date_pickers/app_date_picker.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../bloc/service_requests/service_requests_bloc.dart';
import '../../../bloc/service_requests/service_requests_event.dart';
import '../../../bloc/service_requests/service_requests_state.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_radio_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../../widgets/drop_down_widgets/drop_down.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../../widgets/ub_radio_button.dart';
import '../../base_view.dart';
import '../../float_inquiry/widgets/fi_data_component.dart';
import '../cheque_book/cheque_book_req_details_view.dart';
import '../data/service_req_args.dart';
import '../widgets/service_req_component.dart';



class ServiceReqFilterView extends BaseView {
  final ServiceReqArgs serviceReqArgs;

  ServiceReqFilterView({required this.serviceReqArgs});

  @override
  _ServiceReqFilterViewState createState() => _ServiceReqFilterViewState();
}

class _ServiceReqFilterViewState extends BaseViewState<ServiceReqFilterView> {
  var bloc = injection<ServiceRequestsBloc>();
  final _formKey = GlobalKey<FormState>();
  DateTime? fromDateV;
  String? fromDate;
  DateTime? toDateV;
  String? toDate;
  String? dropDownValue;
  String? dropDownValueTemp;
  String? collectionMethod;
  bool isButtonClicked = false;
  bool isApiSuccess = false;
  bool isFilteredResultAvailable = false;
  List<FIData> filteredList = [];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE
            ? AppLocalizations.of(context).translate("cheque_book_filter")
            : AppLocalizations.of(context).translate("statement_filter"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child:
            BlocListener<ServiceRequestsBloc, BaseState<ServiceRequestsState>>(
          bloc: bloc,
          listener: (context, state) {
            if(state is FilterChequeBookSuccessState){
              isApiSuccess = true;
              filteredList.clear();
              filteredList.addAll(state.chequebookFilterList!
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
              filteredList.length == 0 ? isFilteredResultAvailable = false : isFilteredResultAvailable = true;
              setState(() {});
            }
            if(state is FilterStatementSuccessState){
              isApiSuccess = true;
              filteredList.clear();
              filteredList.addAll(state.statementFilterList!
                  .map((e) => FIData(
                status: e.status,
                chequeNumber: e.accountNo,
                dateRecieved: DateFormat('dd MMMM yyyy | HH:mm a').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(e.createdDate.toString())),
                collectionMethod: e.collectionMethod,
                branch: e.branch,
                fromDate: e.startDate,
                toDate: e.endDate,
                serviceCharge: e.serviceCharge.toString(),
                address: e.address,
                deliveryCharge: e.deliveryCharge.toString()
              )).toList());
              filteredList.length == 0 ? isFilteredResultAvailable = false : isFilteredResultAvailable = true;
              setState(() {});
            }
            if(state is FilterChequeBookFailState){
              filteredList.clear();
              filteredList.length == 0 ? isFilteredResultAvailable = false : isFilteredResultAvailable = true;
              ToastUtils.showCustomToast(
                  context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
            }
            if(state is FilterStatementFailState){
              filteredList.clear();
              filteredList.length == 0 ? isFilteredResultAvailable = false : isFilteredResultAvailable = true;
              ToastUtils.showCustomToast(
                  context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,0.h + AppSizer.getHomeIndicatorStatus(context)),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 24.h , bottom: 20.h),
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
                                  AppDatePicker(
                                    initialValue: ValueNotifier(fromDate!=null ?DateFormat('dd-MMM-yyyy').format(DateTime.parse(fromDate!)):null),
                                    isFromDateSelected: true,
                                    lastDate: DateTime.now(),
                                    labelText: AppLocalizations.of(context)
                                        .translate("from_date"),
                                    onChange: (value) {
                                      fromDate = value;
                                      fromDateV = DateTime.parse(fromDate!);
                                      isButtonClicked = false;
                                      setState(() {});
                                    },
                                    initialDate:  DateTime.parse(fromDate ??DateTime.now().toString()),
                                  ),
                              Column(
                                children: [
                                  5.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const SizedBox.shrink(),
                                      fromDate != null &&
                                          toDate != null &&
                                          toDateV!.isBefore(fromDateV!)
                                          ? Text(
                                        "${AppLocalizations.of(context).translate("date_cannot_greater_than")} $toDate",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: toDateV!.isBefore(fromDateV!)
                                                ? colors(context).negativeColor
                                                : colors(context).blackColor),
                                      )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ],
                              ),
                                  16.verticalSpace,
                                  AppDatePicker(
                                    initialValue: ValueNotifier(toDate!=null ?DateFormat('dd-MMM-yyyy').format(DateTime.parse(toDate!)):null),
                                    isFromDateSelected: true,
                                    firstDate: fromDateV,
                                    lastDate: DateTime.now(),
                                    initialDate:  DateTime.parse(toDate ??DateTime.now().toString()),
                                    labelText: AppLocalizations.of(context)
                                        .translate("to_date"),
                                    onChange: (value) {
                                      setState(() {
                                        toDate = value;
                                        toDateV = DateTime.parse(toDate!);
                                        isButtonClicked = false;
                                      });
                                    },
                                  ),
                                  16.verticalSpace,
                                  AppDropDown(
                                    label: AppLocalizations.of(context).translate("account"),
                                    labelText: AppLocalizations.of(context).translate("select_account"),
                                    onTap:
                                        () async {
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
                                                  title: AppLocalizations.of(context).translate('select_account'),
                                                  buttons: [
                                                    Expanded(
                                                      child: AppButton(
                                                          buttonType: ButtonType.PRIMARYENABLED,
                                                          buttonText: AppLocalizations.of(context) .translate("continue"),
                                                          onTapButton: () {
                                                            dropDownValue = dropDownValueTemp;
                                                            isButtonClicked = false;
                                                            _formKey.currentState?.validate();
                                                            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                            Navigator.of(context).pop(true);
                                                            changeState(() {});
                                                            setState(() {});
                                                          }),
                                                    ),
                                                  ],
                                                  children: [
                                                    ListView.builder(
                                                      itemCount: kActiveCurrentAccountList.length,
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.zero,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context, index) {
                                                        return InkWell(
                                                          onTap: (){
                                                            dropDownValueTemp = kActiveCurrentAccountList[index].description;
                                                            changeState(() {});
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:12,0,12).h,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                        kActiveCurrentAccountList[index].description ?? "",
                                                                        style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(right: 8).w,
                                                                      child: UBRadio<dynamic>(
                                                                        value: kActiveCurrentAccountList[index].key ?? "",
                                                                        groupValue: dropDownValueTemp,
                                                                        onChanged: ( value) {
                                                                          dropDownValueTemp = value;
                                                                          dropDownValueTemp = kActiveCurrentAccountList[index].key;
                                                                          changeState(() {});
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              if(kActiveCurrentAccountList.length-1 != index)
                                                                Divider(
                                                                    height: 0 ,
                                                                    thickness: 1,
                                                                    color: colors(context).greyColor100
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
                                      setState(() {});
                                    },
                                    initialValue: dropDownValue,
                                  ),
                                  // AppDropDown(
                                  //   isDisable: false,
                                  //   labelText: AppLocalizations.of(context)
                                  //       .translate("account"),
                                  //   label: AppLocalizations.of(context)
                                  //       .translate("account"),
                                  //   onTap:() {
                                  //     Navigator.pushNamed(
                                  //         context, Routes.kDropDownView,
                                  //         arguments: DropDownViewScreenArgs(
                                  //           isSearchable: true,
                                  //           pageTitle: AppLocalizations.of(context)
                                  //               .translate("select_account"),
                                  //           dropDownEvent: GetActiveCurrentAccountsDropDownEvent(),
                                  //         )).then((value) {
                                  //       if (value != null &&
                                  //           value is CommonDropDownResponse) {
                                  //         setState(() {
                                  //           dropDownValue = value.description;
                                  //           isButtonClicked = false;
                                  //         });
                                  //       }
                                  //     });
                                  //   },
                                  //   initialValue: dropDownValue,
                                  // ),
                                  16.verticalSpace,
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("collection_method"),
                                    style: size16weight400.copyWith(color: colors(context).blackColor),
                                  ),
                                  16.verticalSpace,
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomRadioButton(
                                        value: "BRANCH",
                                        groupValue: collectionMethod,
                                        onChanged: (value) {
                                          setState(() {
                                            collectionMethod = value;
                                            isButtonClicked = false;
                                          });
                                        },
                                        label: AppLocalizations.of(context)
                                            .translate("branch"),
                                        labelColor: colors(context).blackColor!,
                                      ),
                                      46.horizontalSpace,
                                      CustomRadioButton(
                                        value: "ADDRESS",
                                        groupValue: collectionMethod,
                                        onChanged: (value) {
                                          setState(() {
                                            collectionMethod = value;
                                            isButtonClicked = false;
                                          });
                                        },
                                        label: AppLocalizations.of(context)
                                            .translate("home_delivery"),
                                        labelColor: colors(context).blackColor!,
                                      ),
                                    ],
                                  ),
                                  16.verticalSpace,
                                  Divider(
                                    thickness: 1,
                                    color: colors(context)
                                        .greyColor400,
                                  ),
                                  16.verticalSpace,
                                  isApiSuccess
                                      ? Column(
                                          children: [
                                            isFilteredResultAvailable
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    physics: const BouncingScrollPhysics(),
                                                    itemCount: filteredList.length,
                                                    itemBuilder:
                                                        (context, int index) {
                                                      return InkWell(
                                                        onTap: (){
                                                          Navigator.pushNamed(context, Routes.kChequeBookRequestDetailsView, arguments: SrHistoryDetailsArgs(serviceReqArgs: widget.serviceReqArgs, historyDetails: FIData(
                                                            chequeNumber: filteredList[index].chequeNumber,
                                                            dateRecieved: filteredList[index].dateRecieved,
                                                            status: filteredList[index].status?.toUpperCase(),
                                                            collectionMethod: filteredList[index].collectionMethod,
                                                            branch: filteredList[index].branch,
                                                            noOfLeaves: filteredList[index].noOfLeaves,
                                                            serviceCharge: filteredList[index].serviceCharge,
                                                            fromDate: filteredList[index].fromDate,
                                                            toDate: filteredList[index].toDate,
                                                            address:  filteredList[index].address,
                                                            deliveryCharge: filteredList[index].deliveryCharge,
                                                          ), ));
                                                        },
                                                        child: ServiceReqComponent(
                                                          fiData: FIData(
                                                              chequeNumber:
                                                              filteredList[index].chequeNumber,
                                                              dateRecieved:
                                                              filteredList[index].dateRecieved,
                                                              status: filteredList[index].status,),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        ) : const SizedBox.shrink(),
                                  (isButtonClicked == true && isFilteredResultAvailable == false) ?
                                  Column(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate(
                                            "no_record_des"),
                                        style: size18weight700.copyWith(color: colors(context).blackColor),
                                        textAlign: TextAlign.justify,
                                      ),
                                      Center(
                                        child: Text(
                                            AppLocalizations.of(
                                                context)
                                                .translate(
                                                "csi_no_record_des1"),
                                            textAlign:
                                            TextAlign.center,
                                            style: size18weight400.copyWith(color: colors(context).greyColor200),),
                                      ),
                                      16.verticalSpace
                                    ],
                                  ): const SizedBox.shrink()
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !isButtonClicked,
                    child: Column(
                      children: [
                        20.verticalSpace,
                        AppButton(
                            buttonText: AppLocalizations.of(context)
                                .translate("filter_"),
                            onTapButton: () {
                             // if(_isDateRangeValid()) {
                             //  return;
                             // }
                              if(fromDate != null &&
                                  toDate != null &&
                                  toDateV!.isBefore(fromDateV!)){
                                showAppDialog(
                                  title: "${AppLocalizations.of(context).translate("adjust_date_picker")}",
                                  message: "${AppLocalizations.of(context).translate("date_cannot_greater_than")} $toDate",
                                  alertType: AlertType.INFO,
                                  onPositiveCallback: () {},
                                  positiveButtonText: AppLocalizations.of(context).translate("ok"),);
                              } else {
                                isButtonClicked = true;
                                widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                bloc.add(FilterCheckBookEvent(
                                  accountNo: dropDownValue,
                                  collectionMethod: collectionMethod,
                                  fromDate: fromDateV,
                                  toDate:toDateV == null ? null : DateTime(toDateV!.year , toDateV!.month , toDateV!.day , 23, 59 ,59),
                                )) :
                                bloc.add(FilterStatementEvent(
                                  accountNo: dropDownValue,
                                  collectionMethod: collectionMethod,
                                  fromDate: fromDateV,
                                  toDate:toDateV == null ? null : DateTime(toDateV!.year , toDateV!.month , toDateV!.day , 23, 59 ,59),
                                ));
                              }
                              setState(() {});
                            }),
                        16.verticalSpace,
                        AppButton(
                          buttonType: ButtonType.OUTLINEENABLED,
                          buttonColor: Colors.transparent,
                          buttonText: AppLocalizations.of(context).translate("reset_all"),
                          onTapButton: () {
                            fromDate = null;
                            fromDateV = null;
                            toDate = null;
                            toDateV = null;
                            dropDownValue = null;
                            collectionMethod = null;
                            filteredList.clear();
                            setState(() {

                            });
                          },
                        ),
                        16.verticalSpace,
                      ],
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

  //   bool _isDateRangeValid() {
  //   if (fromDateV != null && toDateV != null) {
  //     return toDateV!.isBefore(fromDateV!);
  //   }
  //   return true; // Return true if either fromDateV or toDateV is null.
  // }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
