
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/cheque_status_inquiry/widgets/csi_data_component.dart';
import 'package:union_bank_mobile/features/presentation/widgets/date_pickers/app_date_picker.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../utils/navigation_routes.dart';

import '../../../data/models/responses/city_response.dart';
import '../../bloc/cheque_status_inquary/csi_bloc.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../../widgets/drop_down_widgets/drop_down.dart';
import '../../widgets/drop_down_widgets/drop_down_view.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';


class ChequeStatusView extends BaseView {

  @override
  _ChequeStatusViewState createState() => _ChequeStatusViewState();
}

class _ChequeStatusViewState extends BaseViewState<ChequeStatusView> {
  var bloc = injection<CSIBloc>();
  final _formKey = GlobalKey<FormState>();
  DateTime? fromDateV;
  String? fromDate;
  DateTime? toDateV;
  String? toDate;
  String? dropDownValue;
  bool isButtonClicked = false;
  bool isChequeStatusAvailable = false;
  List<CSIData> csiList = [];
  List<CommonDropDownResponse>? itemList; 
  @override
  void initState() {
    itemList = [
      CommonDropDownResponse(
          id: 00001234, code: "All", description: "All", key: "All"),
      ...kActiveCurrentAccountList
    ];
    if(kActiveCurrentAccountList.length == 1){
      dropDownValue = kActiveCurrentAccountList.first.key;
    }
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate(
            "cheque_status_inquiry"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<CSIBloc,
            BaseState<CSIState>>(
          bloc: bloc,
          listener: (context, state) {
            if(state is CSISuccessState){
              csiList.clear();
              csiList.addAll(state.csiDataList!
                  .map((e) => CSIData(
                  accountNumber: e.accountNumber,
                  chequeNumber: e.checkNumber,
                  amount: e.checkNumber,
                  collectionDate: DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(e.collectionDate.toString()))
              )).toList());
              csiList.isEmpty ? isChequeStatusAvailable == false: isChequeStatusAvailable == true;
              setState(() {});
            }
            if(state is CSIFailState){
              isButtonClicked = false;
              ToastUtils.showCustomToast(
                  context, state.responseDescription ?? "", ToastStatus.FAIL);
              setState(() {});
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(25),
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
                          Text(
                            AppLocalizations.of(context)
                                .translate(
                                "cheque_status_inquiry_des"),
                            style: TextStyle(
                                fontSize: 16,
                                color: colors(context).blackColor,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 4.h,),
                          AppDatePicker(
                            initialValue: ValueNotifier(fromDate!=null ?DateFormat('dd-MMM-yyyy').format(DateTime.parse(fromDate!)):null),
                            validator: (value){
                              if(value ==null){
                                return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                              }else{
                                return null;
                              }
                            },
                            isFromDateSelected: true,
                            lastDate: DateTime.now(),
                            labelText: AppLocalizations.of(context).translate("from_date"),
                            onChange: (value) {
                              fromDate = value;
                              fromDateV = DateTime.parse(fromDate!);
                              isButtonClicked = false; 
                              // if(toDateV != null){
                              //   if(toDateV!.add(const Duration(days: 31)).isAfter(fromDateV!) == true){
                              //     toDateV =  fromDateV!.add(const Duration(days: 31));
                              //     toDate = toDateV.toString();
                              //     log(toDate.toString());
                              //   }
                              //       // ? DateTime.parse(toDate ?? DateTime.now().toString())
                              //       // : fromDateV!.add(const Duration(days: 31));
                              // }
                              setState(() {});                            
                              },
                             initialDate: DateTime.parse(fromDate ??DateTime.now().toString()),
                          ),
                          const SizedBox(
                          height: 15,
                        ),
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
                                :  const SizedBox.shrink(),
                          ],
                        ),
                          SizedBox(height: 4.h,),
                          AppDatePicker(
                            initialValue: ValueNotifier(toDate!=null ?DateFormat('dd-MMM-yyyy').format(DateTime.parse(toDate!)):null),
                            validator: (value){
                              if(value ==null){
                                return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                              }else{
                                return null;
                              }
                            },
                            isFromDateSelected: true,
                            firstDate: fromDateV,
                            lastDate: fromDateV?.add(const Duration(days: 31)).isAfter(DateTime.now()) == true
                                ? DateTime.now()
                                : fromDateV?.add(const Duration(days: 31)) ?? DateTime.now(),
                            initialDate: fromDateV != null 
                                ? fromDateV!.add(const Duration(days: 31)).isAfter(DateTime.now()) == true
                                    ? DateTime.parse(toDate ?? DateTime.now().toString())
                                    : fromDateV!.add(const Duration(days: 31))
                                : DateTime.parse(toDate ?? DateTime.now().toString()),
                            labelText: AppLocalizations.of(context).translate("to_date"),
                            onChange: (value) {
                              setState(() {
                                toDate = value;
                                toDateV = DateTime.parse(toDate!);
                                isButtonClicked = false;
                              });
                            },
                          ),
                           const SizedBox(
                          height: 15,
                        ),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox.shrink(),
                            toDateV != null &&
                                toDate != null && fromDate  != null && fromDateV  != null &&
                                 !(fromDateV!.add(const Duration(days: 31)).isAfter(toDateV??DateTime.now()) == true)
                                ? Text(AppLocalizations.of(context)
                                .translate(
                                "cheque_status_inquiry_des"),
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: !(fromDateV!.add(const Duration(days: 31)).isAfter(toDateV??DateTime.now()) == true)
                                      ? colors(context).negativeColor
                                      : colors(context).blackColor),
                            ) 
                                :  const SizedBox.shrink(),
                          ],
                        ),
                          SizedBox(height: 4.h,),
                          AppDropDown(
                            // validator: (value){
                            //   if(dropDownValue == null || dropDownValue == ""){
                            //     return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                            //   }else{
                            //     return null;
                            //   }
                            // },
                            isDisable: false,
                            labelText: AppLocalizations.of(context)
                                .translate("account"),
                            onTap: () {
                              Navigator.pushNamed(context, Routes.kDropDownView,
                                  arguments: DropDownViewScreenArgs(
                                    itemList: itemList,
                                    isSearchable: true,
                                    isAnEvent: false,
                                    pageTitle: AppLocalizations.of(context)
                                        .translate("account"),
                                    // dropDownEvent: GetActiveCurrentAccountsDropDownEvent(),
                                  )).then((value) {
                                if (value != null &&
                                    value is CommonDropDownResponse) {
                                  setState(() {
                                    dropDownValue = value.code;
                                    isButtonClicked = false;
                                  });
                                }
                              });
                            },
                            initialValue: dropDownValue,
                          ),
                          SizedBox(height: 4.h,),
                          !isChequeStatusAvailable ?
                          ListView.builder(
                            shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(
                                bottom: 8,
                                top: 8,
                              ),
                              itemCount: csiList.length,
                              itemBuilder: (context, int index) {
                                return InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, Routes.kChequeStatusSummaryView , arguments:
                                    CSIData(
                                      chequeNumber: csiList[index].chequeNumber,
                                      accountNumber: csiList[index].accountNumber,
                                      collectionDate: csiList[index].collectionDate,
                                      amount: csiList[index].amount,
                                    ));
                                  },
                                  child: CSIDataComponent(
                                    csiData: CSIData(
                                      chequeNumber: csiList[index].chequeNumber,
                                      accountNumber: csiList[index].accountNumber,
                                      collectionDate: csiList[index].collectionDate,
                                      amount: csiList[index].amount,
                                    ),
                                  ),
                                );
                              })
                              : Column(
                            children: [
                              // Image.asset(
                              //   AppAssets.icCsiEmpty,
                              //   scale: 3,
                              //   width: 40.w,
                              // ),
                              Text(
                                  AppLocalizations.of(context).translate("csi_no_record_des"),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: colors(context).greyColor200,
                                  ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Center(
                                child: Text(
                                    AppLocalizations.of(context).translate("csi_no_record_des1"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: colors(context).greyColor,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !isButtonClicked,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: AppButton(
                          buttonText: AppLocalizations.of(context).translate("filter_"),
                          onTapButton: () {
                            //  if(_isDateRangeValid()) {
                            //   return;
                            //  }
                            if(_formKey.currentState?.validate() == false || fromDate != null &&
                                toDate != null &&
                                toDateV!.isBefore(fromDateV!) || !(fromDateV!.add(const Duration(days: 31)).isAfter(toDateV??DateTime.now()) == true)){
                              return;
                            } else {
                              isButtonClicked = true;
                              bloc.add(
                                  CSISuccessEvent(
                                      checkAllAccount: dropDownValue =="All"?true: false,
                                    accountNo: dropDownValue,
                                    accountType: "Current",
                                    fromDate: fromDateV,
                                    toDate: DateTime(toDateV!.year , toDateV!.month , toDateV!.day , 23, 59 ,59),
                                  ));
                              setState(() {

                              });
                            // }
                          }}
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