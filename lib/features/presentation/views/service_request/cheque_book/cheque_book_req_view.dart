import 'package:carousel_slider/carousel_slider.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/date_pickers/app_date_picker.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../../data/datasources/local_data_source.dart';
import '../../../../data/models/responses/city_response.dart';
import '../../../../domain/entities/response/account_entity.dart';
import '../../../bloc/account/account_bloc.dart';
import '../../../bloc/account/account_event.dart';
import '../../../bloc/account/account_state.dart';
import '../../../bloc/service_requests/service_requests_bloc.dart';
import '../../../bloc/service_requests/service_requests_event.dart';
import '../../../bloc/service_requests/service_requests_state.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_radio_button.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../../widgets/carousel_widget/app_carousel_widget.dart';
import '../../../widgets/drop_down_widgets/drop_down.dart';
import '../../../widgets/filtered_chip.dart';
import '../../../widgets/pop_scope/ub_pop_scope.dart';
import '../../../widgets/sliding_segmented_bar.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../../widgets/ub_radio_button.dart';
import '../../base_view.dart';
import '../../float_inquiry/data/fi_status.dart';
import '../../float_inquiry/widgets/fi_data_component.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';
import '../data/service_req_args.dart';
import '../data/service_req_entity.dart';
import '../widgets/service_req_component.dart';

class ChequeBookReqView extends BaseView {
  final ServiceReqArgs serviceReqArgs;


  ChequeBookReqView({required this.serviceReqArgs});

  @override
  _ChequeBookReqViewState createState() => _ChequeBookReqViewState();
}

class _ChequeBookReqViewState extends BaseViewState<ChequeBookReqView> {
  var acctBbloc = injection<AccountBloc>();
  var serviceReqBloc = injection<ServiceRequestsBloc>();
  List<AccountEntity> accountList = [];
  CarouselSliderController carouselController1 = CarouselSliderController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressControllerOptional = TextEditingController();
  List<bool> carauselValue = List.generate(30, (index) => false);
  int currentIndex = 0;
  final serviceReqEntity = ServiceReqEntity();
  bool isAmountAvailable = true;
  bool isEditField = false;
  DateTime? fromDateV;
  DateTime? fromDateVTemp;
  String? fromDate;
  String? fromDateTemp;
  DateTime? toDateV;
  DateTime? toDateVTemp;
  String? toDate;
  String? toDateTemp;
  final _formKey = GlobalKey<FormState>();
  LocalDataSource? localDataSource;
  List<CommonDropDownResponse>? branchList;
  List<CommonDropDownResponse>? searchBranchList;
  String? branchName;
  String? branchCode;
  String? branchNameTemp;
  String? branchCodeTemp;
  String? city;
  String? cityTemp;
  int current = 0;
  final _toolTipController = SuperTooltipController();
  final _toolTipController1 = SuperTooltipController();
  List<FIData> historyList = [];
  bool isHistoryAvailable = false;
  bool isFiltered = false;
  String? dropDownValue;
  String? dropDownValueTemp;
  String? collectionMethod;
  String? collectionMethodTemp;

  @override
  void initState() {
    super.initState();
    widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
    serviceReqBloc.add(FilterCheckBookEvent()) : serviceReqBloc.add(FilterStatementEvent());
    widget.serviceReqArgs.serviceReqEntity = ServiceReqEntity();
    acctBbloc.add(GetPortfolioAccDetailsEvent());
    acctBbloc.add(GetBankBranchEvent(bankCode:"7302"));
    carauselValue[0] = true;
    widget.serviceReqArgs.serviceReqEntity?.collectionMethod = "BRANCH";
    setState(() {});
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async{
         widget.serviceReqArgs.serviceReqEntity = ServiceReqEntity();
         setState(() {});
       if(isEditField == true){
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
            onNegativeCallback: (){}
        );
      }else{
        Navigator.pop(context);
      }
       return true;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          goBackEnabled: true,
          title: widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ? AppLocalizations.of(context).translate("cheque_book") :
          AppLocalizations.of(context).translate("statement_request"),
          onBackPressed: (){
            widget.serviceReqArgs.serviceReqEntity = ServiceReqEntity();
            setState(() {});
            if(isEditField == true){
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
                  onNegativeCallback: (){}
              );
            }
            else{
              Navigator.pop(context);
            }
          },
          actions: [
            current == 1 ?
            IconButton(
              icon: PhosphorIcon(
                PhosphorIcons.funnel(PhosphorIconsStyle.bold),
                color:  colors(context).whiteColor,),
              onPressed: () async {
                tonull();
                setState(() {});
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
                            title: AppLocalizations.of(context).translate("filter_transactions"),
                            // AppLocalizations.of(context).translate('filter_notifications'),
                            buttons: [
                              Expanded(
                                child: AppButton(
                                    buttonType: ButtonType.PRIMARYENABLED,
                                    buttonText: AppLocalizations.of(context) .translate("apply"),
                                    onTapButton: () {
                                      fromDateV = fromDateVTemp;
                                      fromDate = fromDateTemp;
                                      toDate = toDateTemp;
                                      toDateV = toDateVTemp;
                                      collectionMethod = collectionMethodTemp;
                                      dropDownValue = dropDownValueTemp;
                                      historyList.clear();
                                      isFiltered = true;
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
                                        widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                        serviceReqBloc.add(FilterCheckBookEvent(
                                          accountNo: dropDownValue,
                                          collectionMethod: collectionMethod,
                                          fromDate: fromDateV,
                                          toDate:toDateV == null ? null : DateTime(toDateV!.year , toDateV!.month , toDateV!.day , 23, 59 ,59),
                                        )) :
                                        serviceReqBloc.add(FilterStatementEvent(
                                          accountNo: dropDownValue,
                                          collectionMethod: collectionMethod,
                                          fromDate: fromDateV,
                                          toDate:toDateV == null ? null : DateTime(toDateV!.year , toDateV!.month , toDateV!.day , 23, 59 ,59),
                                        ));
                                      }
                                      FocusScope.of(context).unfocus();
                                      Navigator.of(context).pop(true);
                                      changeState(() {});
                                      setState(() {});
                                    }),
                              ),
                            ],
                            children: [
                              AppDatePicker(
                                initialValue: ValueNotifier(fromDateTemp!=null ?DateFormat('dd-MMM-yyyy').format(DateTime.parse(fromDateTemp!)):null),
                                isFromDateSelected: true,
                                lastDate: DateTime.now(),
                                labelText: AppLocalizations.of(context)
                                    .translate("from_date"),
                                onChange: (value) {
                                  fromDateTemp = value;
                                  fromDateVTemp = DateTime.parse(fromDateTemp!);
                                  changeState(() {});
                                },
                                initialDate:  DateTime.parse(fromDateTemp ??DateTime.now().toString()),
                              ),
                              Column(
                                children: [
                                  5.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const SizedBox.shrink(),
                                      fromDateTemp != null &&
                                          toDateTemp != null &&
                                          toDateVTemp!.isBefore(fromDateVTemp!)
                                          ? Text(
                                        "${AppLocalizations.of(context).translate("date_cannot_greater_than")} $toDateTemp",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: toDateVTemp!.isBefore(fromDateVTemp!)
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
                                initialValue: ValueNotifier(toDateTemp!=null ?DateFormat('dd-MMM-yyyy').format(DateTime.parse(toDateTemp!)):null),
                                isFromDateSelected: true,
                                firstDate: fromDateVTemp,
                                lastDate: DateTime.now(),
                                initialDate:  DateTime.parse(toDateTemp ??DateTime.now().toString()),
                                labelText: AppLocalizations.of(context)
                                    .translate("to_date"),
                                onChange: (value) {
                                    toDateTemp = value;
                                    toDateVTemp = DateTime.parse(toDateTemp!);
                                    changeState(() {});
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
                                                        _formKey.currentState?.validate();
                                                        FocusScope.of(context).unfocus();
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
                                  changeState(() {});
                                  setState(() {});
                                },
                                initialValue: dropDownValueTemp,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("collection_method"),
                                    style: size14weight700.copyWith(
                                      color: colors(context).blackColor!,
                                    ),
                                  ),
                                  16.verticalSpace,
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          changeState(() {
                                            collectionMethodTemp = 'BRANCH';
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate("branch"),
                                              style: size16weight400.copyWith(
                                                  color: colors(context)
                                                      .blackColor),
                                            ),
                                            Spacer(),
                                            UBRadio<dynamic>(
                                              value: 'BRANCH',
                                              groupValue: collectionMethodTemp,
                                              onChanged: (dynamic value) {
                                                changeState(() {
                                                  collectionMethodTemp = value;
                                                });
                                              },
                                            ),
                                            8.horizontalSpace
                                          ],
                                        ),
                                      ),
                                      24.verticalSpace,
                                      InkWell(
                                        onTap: () {
                                          changeState(() {
                                            collectionMethodTemp = 'ADDRESS';
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context).translate("home_delivery"),
                                              style: size16weight400.copyWith(
                                                  color: colors(context)
                                                      .blackColor),
                                            ),
                                            Spacer(),
                                            UBRadio<dynamic>(
                                              value: 'ADDRESS',
                                              groupValue: collectionMethodTemp,
                                              onChanged: (dynamic value) {
                                                changeState(() {
                                                  collectionMethodTemp = value;
                                                });
                                              },
                                            ),
                                            8.horizontalSpace
                                          ],
                                        ),
                                      ),
                                      20.verticalSpace,
                                    ],
                                  ),
                                  // CustomRadioButton(
                                  //   value: "BRANCH",
                                  //   groupValue: collectionMethodTemp,
                                  //   onChanged: (value) {
                                  //       collectionMethodTemp = value;
                                  //       changeState(() {});
                                  //   },
                                  //   label: AppLocalizations.of(context)
                                  //       .translate("branch"),
                                  //   labelColor: colors(context).blackColor!,
                                  // ),
                                  // 46.horizontalSpace,
                                  // CustomRadioButton(
                                  //   value: "ADDRESS",
                                  //   groupValue: collectionMethodTemp,
                                  //   onChanged: (value) {
                                  //       collectionMethodTemp = value;
                                  //       changeState(() {});
                                  //   },
                                  //   label: AppLocalizations.of(context)
                                  //       .translate("home_delivery"),
                                  //   labelColor: colors(context).blackColor!,
                                  // ),
                                ],
                              ),
                            ],
                          );
                        }
                    ));
                setState(() {});
              },
            ) : SizedBox.shrink()
          ],
        ),
        body: BlocProvider<ServiceRequestsBloc>(
          create: (_) => serviceReqBloc,
          child: BlocProvider<AccountBloc>(
            create: (_) => acctBbloc,
            child: BlocListener<ServiceRequestsBloc, BaseState<ServiceRequestsState>>(
              bloc: serviceReqBloc,
              listener: (context, state){
                if(state is FilterChequeBookSuccessState){
                  historyList.clear();
                  historyList.addAll(state.chequebookFilterList!
                      .map((e) => FIData(
                      status: e.status,
                      chequeNumber: e.accountNo,
                      dateRecieved: DateFormat('dd-MMM-yyyy  HH:mm a').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(e.modifiedDate.toString())),
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
                      dateRecieved: DateFormat('dd-MMM-yyyy  HH:mm a').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(e.createdDate.toString())),
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
              child: BlocListener<AccountBloc, BaseState<AccountState>>(
                bloc: acctBbloc,
                listener: (_, state2) async {
                  if (state2 is PortfolioAccountDetailsSuccessState) {
                    setState(() {
                      accountList.clear();
                      accountList.addAll(state2.accDetails!.accountDetailsResponseDtos!
                          .map((e) => AccountEntity(
                        status: e.status,
                        instrumentId: e.instrumentId,
                        bankName: e.bankName,
                        bankCode: e.bankCode ?? AppConstants.ubBankCode.toString(),
                        accountNumber: e.accountNumber,
                        nickName: e.nickName ?? "",
                        availableBalance: double.parse(
                            e.availableBalance ?? "0.00"),
                        accountType: e.accountType,
                        isPrimary: true,
                        cfprcd: e.cfprcd
                      ))
                          .toList());
                      accountList = accountList
                          .where((element) =>
                          (element.accountType?.toUpperCase() == "D" && element.status?.toUpperCase()=="ACTIVE"))
                          .toList();
                      accountList = accountList.where((element) =>
                              (element.cfprcd?.toUpperCase().trim() != "SSHADOW")).toList();

                      if(accountList.isNotEmpty){

                        widget.serviceReqArgs.serviceReqEntity?.address = addressController.text + addressControllerOptional.text ;
                        widget.serviceReqArgs.serviceReqEntity?.availableBalance = accountList[0].availableBalance;
                        widget.serviceReqArgs.serviceReqEntity?.payFromNum = accountList[0].accountNumber;
                        widget.serviceReqArgs.serviceReqEntity?.payFromName = accountList[0].nickName;
                        widget.serviceReqArgs.serviceReqEntity?.instrumentId = accountList[0].instrumentId;
                        widget.serviceReqArgs.serviceReqEntity?.bankCodePayFrom = int.parse(accountList[0].bankCode!);

                        if(widget.serviceReqArgs.serviceReqEntity?.amount!=null){
                          if ((widget.serviceReqArgs.serviceReqEntity!.amount! > widget.serviceReqArgs.serviceReqEntity!.availableBalance!.toInt())&&(widget.serviceReqArgs.serviceReqEntity?.bankCodePayFrom==AppConstants.ubBankCode)) {
                            setState(() {
                              isAmountAvailable = false;
                            });
                          } else {
                            setState(() {
                              isAmountAvailable = true;
                            });
                          }
                        }
                      }

                      // accountList.addAll(accountListPortfolio);
                      // accountList = accountList.unique((x) => x.accountNumber);
                    });
                  }
                  if(state2 is AccountDetailFailState){
                    showAppDialog(
                              title: AppLocalizations.of(context).translate("there_was_some_error"),
                              alertType: AlertType.FAIL,
                              message: state2.errorMessage,
                              positiveButtonText:
                              AppLocalizations.of(context).translate("Try_Again"),
                              onPositiveCallback: () {
                                acctBbloc.add(GetPortfolioAccDetailsEvent());
                                acctBbloc.add(GetUserInstrumentEvent(
                                  requestType: RequestTypes.ACTIVE.name,
                                ));
                              },
                              negativeButtonText: AppLocalizations.of(context).translate("go_back"),
                              onNegativeCallback: () {
                                Navigator.pop(context);
                              });
                          setState(() {
                            accountList.clear();
                          });
                  }
                  if (state2 is GetbranchSuccessState) {
                    branchList = state2.data;
                    searchBranchList = branchList;
                  }
                  // if (state is GetUserInstrumentSuccessState) {
                  //   setState(() {
                  //     accountListInstrument.clear();
                  //     accountListInstrument.addAll(state.getUserInstList!
                  //         .map((e) => AccountEntity(
                  //       instrumentId: e.id,
                  //       bankName: e.bankName,
                  //       bankCode: e.bankCode,
                  //       accountNumber: e.accountNo,
                  //       nickName: e.nickName ?? "",
                  //       availableBalance:
                  //       double.parse(e.accountBalance ?? "0.00"),
                  //       accountType: e.accType,
                  //       isprimaryColor: e.isprimaryColor,
                  //     ))
                  //         .toList());
                  //     accountListInstrument = accountListInstrument
                  //         .where((element) =>
                  //     (element.accountType == "S") ||
                  //         (element.accountType == "D"))
                  //         .toList();
                  //     accountList.addAll(accountListInstrument);
                  //     accountList = accountList.unique((x) => x.accountNumber);
                  //     if (currentIndex == 0) {
                  //       serviceReqEntity.availableBalance = accountList[0].availableBalance;
                  //       serviceReqEntity.payFromNum = accountList[0].accountNumber;
                  //       serviceReqEntity.payFromName = accountList[0].nickName;
                  //       serviceReqEntity.bankCodePayFrom = int.parse(accountList[0].bankCode!);
                  //       serviceReqEntity.instrumentId = accountList[0].instrumentId;
                  //     }
                  //   });
                  //   // accountListForPayTo.removeAt(currentIndex);
                  // }
                  // else if (state is GetUserInstrumentFailedState) {
                  //   // showAppDialog(
                  //   //     title: "There was some error",
                  //   //     alertType: AlertType.FAIL,
                  //   //     message: state.message,
                  //   //     positiveButtonText:
                  //   //     AppLocalizations.of(context).translate("Try_Again"),
                  //   //     onPositiveCallback: () {
                  //   //       bloc.add(GetPortfolioAccDetailsEvent());
                  //   //       bloc.add(GetUserInstrumentEvent(
                  //   //         requestType: RequestTypes.ACTIVE.name,
                  //   //       ));
                  //   //     },
                  //   //     negativeButtonText: "Go Back",
                  //   //     onNegativeCallback: () {
                  //   //
                  //   //     });
                  //   // setState(() {
                  //   //   accountList.clear();
                  //   // });
                  // }
                },
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: GestureDetector(
                    onTap: () {
                      if (_toolTipController.isVisible) {
                        _toolTipController.hideTooltip();
                      }
                      if (_toolTipController1.isVisible) {
                        _toolTipController1.hideTooltip();
                      }
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 20,right: 20, bottom: 20+ AppSizer.getHomeIndicatorStatus(context)),
                      child: Stack(
                        children: [
                         if( current == 1 && isHistoryAvailable == false)
                            Center(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: colors(context).secondaryColor300,
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child:
                                    widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                    PhosphorIcon(
                                      PhosphorIcons.book(PhosphorIconsStyle.bold),
                                      color: colors(context).whiteColor,
                                      size: 28,
                                    ):
                                        PhosphorIcon(
                                      PhosphorIcons.notebook(PhosphorIconsStyle.bold),
                                      color: colors(context).whiteColor,
                                      size: 28,
                                    ),
                                  ),
                                ),
                                16.verticalSpace,
                                Text(
                                  isFiltered == false ?
                                    widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                    AppLocalizations.of(context).translate('no_check_book_req') :
                                  AppLocalizations.of(context).translate('no_statement_req')
                                  :AppLocalizations.of(context).translate('no_result_found'),
                                  textAlign: TextAlign.center,
                                  style: size18weight700.copyWith(color: colors(context).blackColor),
                                ),
                                4.verticalSpace,
                                Text(
                                  isFiltered == false ?
                                    widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                  AppLocalizations.of(context).translate('no_check_book_req_des') :
                                  AppLocalizations.of(context).translate('no_statement_req_des')
                                  :AppLocalizations.of(context).translate('adjust_your_filters'),
                                  textAlign: TextAlign.center,
                                  style: size14weight400.copyWith(color: colors(context).greyColor),
                                )
                              ],),
                            ),
                          Column(
                            children: [
                              24.verticalSpace,
                              SizedBox(
                                height: 44,
                                child: SlidingSegmentedBar(
                                  selectedTextStyle: size14weight700.copyWith(
                                      color: colors(context).whiteColor),
                                  textStyle: size14weight700.copyWith(
                                      color: colors(context).blackColor),
                                  backgroundColor: colors(context).whiteColor,
                                  onChanged: (int value) {
                                    current = value;
                                    setState(() {});

                                  },
                                  selectedIndex: current,
                                  children: [
                                    AppLocalizations.of(context).translate("new_request"),
                                    AppLocalizations.of(context).translate("history"),
                                  ],
                                ),
                              ),
                              if(current == 1 && isFiltered == true)
                                if(toDate != null || fromDate != null || collectionMethod != null || dropDownValue != null)
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      8.verticalSpace,
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Wrap(
                                            children: [
                                              if(toDate != null && fromDate != null)
                                                FilteredChip(
                                                  onTap: () {
                                                    setState(() {
                                                      fromDate = null;
                                                      toDate = null;
                                                      fromDateV = null;
                                                      toDateV = null;
                                                      // if (fromDate == null &&
                                                      //     toDate == null &&
                                                      //     collectionMethod == null &&
                                                      //     dropDownValue == null) {
                                                      //   isFiltered = false;
                                                      // }
                                                    });
                                                    _loadRequest();
                                                  },
                                                  children: [
                                                    Text("${DateFormat("dd-MMM-yyyy").format(DateTime.parse(fromDate!))} to ${DateFormat("dd-MMM-yyy").format(DateTime.parse(toDate!))}",
                                                      style: size14weight400.copyWith(color: colors(context).greyColor),
                                                    ),
                                                  ],
                                                ),
                                              if (fromDate == null &&
                                                  toDate != null)
                                                FilteredChip(
                                                  onTap: () {
                                                    setState(() {
                                                      toDate = null;
                                                      toDateV = null;
                                                      fromDateV = null;
                                                    });
                                                    _loadRequest();
                                                  },
                                                  children: [
                                                    Text(
                                                      "${AppLocalizations.of(context).translate("to_date")} - ${DateFormat("dd-MMM-yyyy").format(DateTime.parse(toDate!))}",
                                                      style:  size14weight400.copyWith(color: colors(context).greyColor),
                                                    ),
                                                  ],
                                                ),
                                              if (fromDate != null &&
                                                  toDate == null)
                                                FilteredChip(
                                                  onTap: () {
                                                    setState(() {
                                                      fromDate = null;
                                                      fromDateV = null;
                                                    });
                                                    _loadRequest();
                                                  },
                                                  children: [
                                                    Text(
                                                      "${AppLocalizations.of(context).translate("from_date")} - ${DateFormat("dd-MMM-yyyy").format(DateTime.parse(fromDate!))}",
                                                      style: size14weight400.copyWith(color: colors(context).greyColor),
                                                    ),
                                                  ],
                                                ),
                                              if (collectionMethod != null)
                                                FilteredChip(
                                                  onTap: () {
                                                    setState(() {
                                                      collectionMethod = null;
                                                    });
                                                    _loadRequest();
                                                  },
                                                  children: [
                                                    Text(
                                                      "${collectionMethod?.toTitleCase()}",
                                                      style: size14weight400.copyWith(color: colors(context).greyColor),
                                                    ),
                                                  ],
                                                ),
                                              if (dropDownValue != null)
                                                FilteredChip(
                                                  onTap: () {
                                                    setState(() {
                                                      dropDownValue = null;
                                                    });
                                                    _loadRequest();
                                                  },
                                                  children: [
                                                    Text(
                                                      "${dropDownValue}",
                                                      style: size14weight400.copyWith(color: colors(context).greyColor),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                              24.verticalSpace,
                              if(current == 0)
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
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context).translate("select_account"),
                                                  style: size16weight700.copyWith(color: colors(context).blackColor),
                                                ),
                                                // 16.verticalSpace,
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(8).r,
                                                    color: colors(context).whiteColor,
                                                  ),
                                                  child: AppCarouselWidget(
                                                      carouselController: carouselController1,
                                                      accountList: accountList,
                                                      onPageChanged: (index, reason) {
                                                        currentIndex = index;
                                                        widget.serviceReqArgs.serviceReqEntity?.availableBalance = accountList[index].availableBalance;
                                                        widget.serviceReqArgs.serviceReqEntity?.payFromNum = accountList[index].accountNumber;
                                                        widget.serviceReqArgs.serviceReqEntity?.payFromName = accountList[index].nickName;
                                                        widget.serviceReqArgs.serviceReqEntity?.instrumentId = accountList[index].instrumentId;
                                                        widget.serviceReqArgs.serviceReqEntity?.bankCodePayFrom = int.parse(accountList[index].bankCode!);
                                                        if(widget.serviceReqArgs.serviceReqEntity?.amount!=null){
                                                          if ((widget.serviceReqArgs.serviceReqEntity!.amount! > widget.serviceReqArgs.serviceReqEntity!.availableBalance!.toInt())&&(widget.serviceReqArgs.serviceReqEntity?.bankCodePayFrom==AppConstants.ubBankCode)) {
                                                            setState(() {
                                                              isAmountAvailable = false;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              isAmountAvailable = true;
                                                            });
                                                          }
                                                        }
                                                      }),
                                                ),
                                              ],
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
                                                CustomRadioButtonGroup(
                                                  validator: (value){
                                                    if(widget.serviceReqArgs.serviceReqEntity?.collectionMethod == null || widget.serviceReqArgs.serviceReqEntity?.collectionMethod ==""){
                                                      return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                    }else{
                                                      return null;
                                                    }
                                                  },
                                                  superToolTipController: _toolTipController,
                                                  isInfoIcon: true,
                                                  infoIconText: [
                                                    widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                                    "${AppLocalizations.of(context).translate("lkr")} ${widget.serviceReqArgs.serviceChargeEntity.deliveryCharge.toString().withThousandSeparator()} will be charged for the Delivery." :
                                                    "${AppLocalizations.of(context).translate("lkr")} ${widget.serviceReqArgs.serviceChargeEntity.deliveryChargeStatement.toString().withThousandSeparator()} will be charged for the Delivery."
                                                  ],
                                                  options: [
                                                    RadioButtonModel(
                                                        label: AppLocalizations.of(context).translate("branch"),
                                                        value: 'BRANCH'),
                                                    RadioButtonModel(
                                                        label: AppLocalizations.of(context).translate("home_delivery"),
                                                        value: 'ADDRESS'),
                                                  ],
                                                  value: widget.serviceReqArgs.serviceReqEntity?.collectionMethod,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      widget.serviceReqArgs.serviceReqEntity?.collectionMethod = value;
                                                      value = widget.serviceReqArgs.serviceReqEntity?.collectionMethod;
                                                      isEditField = true;
                                                    });
                                                  },
                                                  title: AppLocalizations.of(context).translate("collection_method"),
                                                ),
                                                16.verticalSpace,
                                                if(widget.serviceReqArgs.serviceReqEntity?.collectionMethod == "BRANCH")
                                                  AppDropDown(
                                                    validator: (value){
                                                      if(widget.serviceReqArgs.serviceReqEntity?.branchName == null|| widget.serviceReqArgs.serviceReqEntity?.branchName == "" ){
                                                        return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                      }else{
                                                        return null;
                                                      }
                                                    },
                                                    label: AppLocalizations.of(context).translate("branch"),
                                                    labelText: AppLocalizations.of(context).translate("select_branch"),
                                                    onTap: () async {
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
                                                                  isSearch: true,
                                                                  onSearch: (p0) {
                                                                    changeState(() {
                                                                      if (p0.isEmpty || p0=='') {
                                                                        searchBranchList = branchList;
                                                                      } else {
                                                                        searchBranchList = branchList
                                                                            ?.where((element) => element
                                                                            .description!
                                                                            .toLowerCase()
                                                                            .contains(p0.toLowerCase())).toSet().toList();
                                                                      }
                                                                    });
                                                                  },
                                                                  title: AppLocalizations.of(context).translate('select_branch'),
                                                                  buttons: [
                                                                    Expanded(
                                                                      child: AppButton(
                                                                          buttonType: ButtonType.PRIMARYENABLED,
                                                                          buttonText: AppLocalizations.of(context) .translate("continue"),
                                                                          onTapButton: () {
                                                                            branchCode = branchCodeTemp;
                                                                            branchName = branchNameTemp;
                                                                            widget.serviceReqArgs.serviceReqEntity?.branchName = branchName;
                                                                            widget.serviceReqArgs.serviceReqEntity?.branchCode = branchCode;
                                                                            isEditField = true;
                                                                            FocusScope.of(context).unfocus();
                                                                            Navigator.of(context).pop(true);
                                                                            changeState(() {});
                                                                            setState(() {});
                                                                          }),
                                                                    ),
                                                                  ],
                                                                  children: [
                                                                    ListView.builder(
                                                                      itemCount: searchBranchList?.length,
                                                                      shrinkWrap: true,
                                                                      padding: EdgeInsets.zero,
                                                                      physics: NeverScrollableScrollPhysics(),
                                                                      itemBuilder: (context, index) {
                                                                        return InkWell(
                                                                          onTap: (){
                                                                            branchCodeTemp = searchBranchList![index].code;
                                                                            branchNameTemp = searchBranchList![index].description;
                                                                            changeState(() {});
                                                                          },
                                                                          child: Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:20,0,20).w,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        searchBranchList![index].description ?? "",
                                                                                        style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(right: 8).w,
                                                                                      child: UBRadio<dynamic>(
                                                                                        value: searchBranchList![index].code ?? "",
                                                                                        groupValue: branchCodeTemp,
                                                                                        onChanged: (value) {
                                                                                          branchCodeTemp = value;
                                                                                          branchCodeTemp = searchBranchList![index].code;
                                                                                          changeState(() {});
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),

                                                                              if(searchBranchList!.length-1 != index)
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
                                                      searchBranchList = branchList;
                                                      setState(() {});
                                                    },
                                                    //     () {
                                                    //   Navigator.pushNamed(context, Routes.kDropDownView,
                                                    //           arguments: DropDownViewScreenArgs(
                                                    //               isSearchable: false,
                                                    //               pageTitle: "Select Bank",
                                                    //               dropDownEvent:
                                                    //                   GetBankDropDownEvent()))
                                                    //       .then((value) {
                                                    //     if (value != null &&
                                                    //         value is CommonDropDownResponse) {
                                                    //       setState(() {
                                                    //         bankName1 = value.description;
                                                    //         BankCode1 = value.key;
                                                    //       });
                                                    //     }
                                                    //   });
                                                    // },
                                                    initialValue: branchName,
                                                  ),
                                                // AppDropDown(
                                                //   validator: (value){
                                                //     if(widget.serviceReqArgs.serviceReqEntity?.branchName == null|| widget.serviceReqArgs.serviceReqEntity?.branchName == "" ){
                                                //       return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                //     }else{
                                                //       return null;
                                                //     }
                                                //   },
                                                //   onTap: () async {
                                                //     final result = await Navigator.pushNamed(
                                                //       context,
                                                //       Routes.kDropDownView,
                                                //       arguments: DropDownViewScreenArgs(
                                                //         isSearchable: false,
                                                //         pageTitle: AppLocalizations.of(context).translate("branch"),
                                                //         dropDownEvent: GetBankBranchDropDownEvent(bankCode: AppConstants.ubBankCode.toString()),
                                                //       ),
                                                //     ).then((value) {
                                                //       if (value != null && value is CommonDropDownResponse) {
                                                //         setState(() {
                                                //           widget.serviceReqArgs.serviceReqEntity?.branchName = value.description;
                                                //           widget.serviceReqArgs.serviceReqEntity?.branchCode = value.code;
                                                //           isEditField = true;
                                                //         });
                                                //       }
                                                //     });
                                                //   },
                                                //   isFirstItem: false,
                                                //   labelText: AppLocalizations.of(context).translate("branch"),
                                                //   label: AppLocalizations.of(context).translate("branch"),
                                                //   initialValue: widget.serviceReqArgs.serviceReqEntity?.branchName,
                                                // ),
                                                if(widget.serviceReqArgs.serviceReqEntity?.collectionMethod == "ADDRESS")
                                                  Column(
                                                    children: [
                                                      // if(widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE)
                                                      //   Row(
                                                      //     children: [
                                                      //       RichText(
                                                      //         text: TextSpan(
                                                      //           children: [
                                                      //             TextSpan(
                                                      //               text: '${AppLocalizations.of(context).translate("lkr")} ${widget.serviceReqArgs.serviceChargeEntity.deliveryCharge} ',
                                                      //               style: TextStyle(
                                                      //                 fontSize: 14,
                                                      //                 fontWeight: FontWeight.w400,
                                                      //                 color: colors(context).primaryColor,
                                                      //               ),
                                                      //             ),
                                                      //             WidgetSpan(
                                                      //               child: Text(
                                                      //                 AppLocalizations.of(context).translate("cheque_book_lkr_des_delivery"),
                                                      //                 style: const TextStyle(
                                                      //                     fontSize: 16,
                                                      //                     fontWeight: FontWeight.w400),
                                                      //                 textAlign: TextAlign.end,
                                                      //               ),
                                                      //             ),
                                                      //           ],
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // if(widget.serviceReqArgs.serviceReqType == ServiceReqType.STATEMENT)
                                                      //   Row(
                                                      //     children: [
                                                      //       // Image.asset(AppAssets.icSheduleInfo , scale: 3,),
                                                      //       SizedBox(width: 2.w,),
                                                      //       RichText(
                                                      //         text: TextSpan(
                                                      //           children: [
                                                      //             TextSpan(
                                                      //               text: '${AppLocalizations.of(context).translate("lkr")} ${widget.serviceReqArgs.serviceChargeEntity.deliveryChargeStatement} ',
                                                      //               style: TextStyle(
                                                      //                 fontSize: 14,
                                                      //                 fontWeight: FontWeight.w400,
                                                      //                 color: colors(context).primaryColor,
                                                      //               ),
                                                      //             ),
                                                      //             WidgetSpan(
                                                      //               child: Text(
                                                      //                 AppLocalizations.of(context).translate("cheque_book_lkr_des_delivery"),
                                                      //                 style: const TextStyle(
                                                      //                     fontSize: 16,
                                                      //                     fontWeight: FontWeight.w400),
                                                      //                 textAlign: TextAlign.end,
                                                      //               ),
                                                      //             ),
                                                      //           ],
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      16.verticalSpace,
                                                      AppTextField(
                                                        isInfoIconVisible: false,
                                                        hint: AppLocalizations.of(context).translate("address_line_1"),
                                                        title: AppLocalizations.of(context).translate("address_line_1"),
                                                        textCapitalization: TextCapitalization.none,
                                                        controller: addressController,
                                                        onTextChanged: (value){
                                                          isEditField = true;
                                                          setState(() {

                                                          });
                                                        },
                                                        validator: (a){
                                                          if(addressController.text.isEmpty && widget.serviceReqArgs.serviceReqEntity?.collectionMethod == "ADDRESS"){
                                                            return AppLocalizations.of(context)
                                                                .translate("mandatory_field_msg");
                                                          }else{
                                                            return null;
                                                          }
                                                        },
                                                        inputType: TextInputType.multiline,
                                                      ),
                                                      16.verticalSpace,
                                                      AppTextField(
                                                        isInfoIconVisible: false,
                                                        hint: AppLocalizations.of(context).translate("address_line_2"),
                                                        title: AppLocalizations.of(context).translate("address_line_2"),
                                                        textCapitalization: TextCapitalization.none,
                                                        controller: addressControllerOptional,
                                                        inputType: TextInputType.multiline,
                                                        onTextChanged: (value){
                                                          isEditField = true;
                                                          setState(() {});
                                                        },
                                                      ),
                                                      16.verticalSpace,
                                                      AppDropDown(
                                                        validator: (value){
                                                          if(widget.serviceReqArgs.serviceReqEntity?.city == null || widget.serviceReqArgs.serviceReqEntity?.city == ""){
                                                            return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                          }else{
                                                            return null;
                                                          }
                                                        },
                                                        label: AppLocalizations.of(context).translate("city"),
                                                        labelText: AppLocalizations.of(context).translate("city"),
                                                        onTap: () async {
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
                                                                      isSearch: false,
                                                                      title: AppLocalizations.of(context).translate('city'),
                                                                      buttons: [
                                                                        Expanded(
                                                                          child: AppButton(
                                                                              buttonType: ButtonType.PRIMARYENABLED,
                                                                              buttonText: AppLocalizations.of(context) .translate("continue"),
                                                                              onTapButton: () {
                                                                                city = cityTemp;
                                                                                widget.serviceReqArgs.serviceReqEntity?.city = city;
                                                                                isEditField = true;
                                                                                FocusScope.of(context).unfocus();
                                                                                Navigator.of(context).pop(true);
                                                                                changeState(() {});
                                                                                setState(() {});
                                                                              }),
                                                                        ),
                                                                      ],
                                                                      children: [
                                                                        ListView.builder(
                                                                          itemCount: branchList?.length,
                                                                          shrinkWrap: true,
                                                                          padding: EdgeInsets.zero,
                                                                          physics: NeverScrollableScrollPhysics(),
                                                                          itemBuilder: (context, index) {
                                                                            return InkWell(
                                                                              onTap: (){
                                                                                cityTemp = branchList![index].description;
                                                                                changeState(() {});
                                                                              },
                                                                              child: Column(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:20,0,20).w,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Text(
                                                                                            branchList![index].description ?? "",
                                                                                            style: size16weight700.copyWith(color: colors(context).blackColor,),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(right: 8).w,
                                                                                          child: UBRadio<dynamic>(
                                                                                            value: branchList![index].description ?? "",
                                                                                            groupValue: cityTemp,
                                                                                            onChanged: (value) {
                                                                                              cityTemp = value;
                                                                                              cityTemp = searchBranchList![index].description;
                                                                                              changeState(() {});
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),

                                                                                  if(searchBranchList!.length-1 != index)
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
                                                        initialValue: cityTemp,
                                                      ),
                                                      // AppDropDown(
                                                      //   validator: (value){
                                                      //     if(widget.serviceReqArgs.serviceReqEntity?.city == null || widget.serviceReqArgs.serviceReqEntity?.city == ""){
                                                      //       return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                      //     }else{
                                                      //       return null;
                                                      //     }
                                                      //   },
                                                      //   onTap: () async {
                                                      //     final result = await Navigator.pushNamed(
                                                      //       context,
                                                      //       Routes.kDropDownView,
                                                      //       arguments: DropDownViewScreenArgs(
                                                      //         isSearchable: false,
                                                      //         pageTitle: AppLocalizations.of(context).translate("city"),
                                                      //         dropDownEvent: GetBankBranchDropDownEvent(bankCode: AppConstants.ubBankCode.toString()),
                                                      //       ),
                                                      //     ).then((value) {
                                                      //       if (value != null && value is CommonDropDownResponse) {
                                                      //         setState(() {
                                                      //           widget.serviceReqArgs.serviceReqEntity?.city = value.description;
                                                      //           isEditField = true;
                                                      //         });
                                                      //       }
                                                      //     });
                                                      //   },
                                                      //   isFirstItem: false,
                                                      //   labelText: AppLocalizations.of(context).translate("city"),
                                                      //   label:  AppLocalizations.of(context).translate("city"),
                                                      //   initialValue: widget.serviceReqArgs.serviceReqEntity?.city,
                                                      // )
                                                    ],
                                                  ),
                                                if(widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE)
                                                  Column(
                                                    children: [
                                                      16.verticalSpace,
                                                      CustomRadioButtonGroup(
                                                        superToolTipController: _toolTipController1,
                                                        isInfoIcon: true,
                                                        infoIconText: [widget.serviceReqArgs.serviceReqEntity?.noOfLeaves == "10" ?
                                                        "${AppLocalizations.of(context).translate("lkr")} ${widget.serviceReqArgs.serviceChargeEntity.serviceChargeNumOfLeaves10.toString().withThousandSeparator()} ${AppLocalizations.of(context).translate("cheque_book_lkr_des")}" :
                                                        "${AppLocalizations.of(context).translate("lkr")} ${widget.serviceReqArgs.serviceChargeEntity.serviceChargeNumOfLeaves20.toString().withThousandSeparator()}  ${AppLocalizations.of(context).translate("cheque_book_lkr_des")}",],
                                                        validator: (value){
                                                          if(value ==null || value==""){
                                                            return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                          }else{
                                                            return null;
                                                          }
                                                        },
                                                        options: [
                                                          RadioButtonModel(
                                                              label: "10", value: '10'),
                                                          RadioButtonModel(
                                                              label: "20", value: '20'),
                                                        ],
                                                        value: widget.serviceReqArgs.serviceReqEntity?.noOfLeaves,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            widget.serviceReqArgs.serviceReqEntity?.noOfLeaves = value;
                                                            isEditField = true;
                                                          });
                                                        },
                                                        title: AppLocalizations.of(context).translate("number_of_leaves"),
                                                      ),
                                                      16.verticalSpace,
                                                      // Row(
                                                      //   children: [
                                                      //     Text(widget.serviceReqArgs.serviceReqEntity?.noOfLeaves == "10" ?
                                                      //     "${AppLocalizations.of(context).translate("lkr")} ${widget.serviceReqArgs.serviceChargeEntity.serviceChargeNumOfLeaves10} ${AppLocalizations.of(context).translate("cheque_book_lkr_des")}" :
                                                      //     "${AppLocalizations.of(context).translate("lkr")} ${widget.serviceReqArgs.serviceChargeEntity.serviceChargeNumOfLeaves20}  ${AppLocalizations.of(context).translate("cheque_book_lkr_des")}",
                                                      //       style: size14weight400.copyWith(color: colors(context).blackColor),
                                                      //     ),
                                                      //     // RichText(
                                                      //     //   text: TextSpan(
                                                      //     //     children: [
                                                      //     //       TextSpan(
                                                      //     //         text: 'LKR ',
                                                      //     //         style: size14weight400.copyWith(color: colors(context).blackColor)
                                                      //     //       ),
                                                      //     //       TextSpan(
                                                      //     //         text:  widget.serviceReqArgs.serviceReqEntity?.noOfLeaves == "10" ? "${widget.serviceReqArgs.serviceChargeEntity.serviceChargeNumOfLeaves10} " : "${widget.serviceReqArgs.serviceChargeEntity.serviceChargeNumOfLeaves20} ",
                                                      //     //         // text: serviceReqEntity.collectionMethod == "ADDRESS" ? "${AppConstants.CSI_DELIVERY_CHARGE} " : "${AppConstants.CSI_SERVICE_CHARGE} ",
                                                      //     //         style: size14weight400.copyWith(color: colors(context).blackColor),
                                                      //     //       ),
                                                      //     //       WidgetSpan(
                                                      //     //         child: Text(
                                                      //     //           AppLocalizations.of(context).translate("cheque_book_lkr_des"),
                                                      //     //           style: size16weight400.copyWith(color: colors(context).blackColor),
                                                      //     //           textAlign: TextAlign.end,
                                                      //     //         ),
                                                      //     //       ),
                                                      //     //     ],
                                                      //     //   ),
                                                      //     // ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                if(widget.serviceReqArgs.serviceReqType == ServiceReqType.STATEMENT)
                                                  Column(
                                                    children: [
                                                      16.verticalSpace,
                                                      AppDatePicker(
                                                        validator: (value){
                                                          if(value ==null){
                                                            return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                          }else{
                                                            return null;
                                                          }
                                                        },
                                                        initialValue: ValueNotifier(fromDate!=null ?DateFormat('dd-MMM-yyyy').format(DateTime.parse(fromDate!)):null),
                                                        isFromDateSelected: true,
                                                        lastDate: DateTime.now(),
                                                        labelText: AppLocalizations.of(context).translate("from_date"),
                                                        onChange: (value) {
                                                          fromDate = value;
                                                          fromDateV = DateTime.parse(fromDate!);
                                                          widget.serviceReqArgs.serviceReqEntity?.startDate = fromDateV;
                                                          isEditField = true;
                                                          setState(() {});
                                                        },
                                                        initialDate: DateTime.parse(fromDate ??DateTime.now().toString()),
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
                                                              : const SizedBox.shrink(),
                                                        ],
                                                      ),
                                                      16.verticalSpace,
                                                      AppDatePicker(
                                                        validator: (value){
                                                          if(value ==null){
                                                            return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                          }else{
                                                            return null;
                                                          }
                                                        },
                                                        initialValue: ValueNotifier(toDate!=null ?DateFormat('dd-MMM-yyyy').format(DateTime.parse(toDate!)):null),
                                                        isFromDateSelected: true,
                                                        firstDate: fromDateV,
                                                        lastDate: DateTime.now(),
                                                        initialDate:  DateTime.parse(toDate ??DateTime.now().toString()),
                                                        labelText: AppLocalizations.of(context).translate("to_date"),
                                                        onChange: (value) {
                                                          setState(() {
                                                            toDate = value;
                                                            widget.serviceReqArgs.serviceReqEntity?.toDate = value;
                                                            isEditField = true;
                                                            toDateV = DateTime.parse(toDate!);
                                                            widget.serviceReqArgs.serviceReqEntity?.endDate = toDateV;
                                                          });
                                                        },
                                                      ),
                                                      16.verticalSpace,
                                                    ],
                                                  ),
                                                if(widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE)
                                                  Column(
                                                    children: [
                                                      16.verticalSpace,
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(8),
                                                          border: Border.all(color: colors(context).secondaryColor200 ?? colors(context).whiteColor!),
                                                          color: colors(context).secondaryColor200,
                                                        ),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(top: 15.0 , bottom: 15 , right: 15 , left: 10),
                                                                child: Column(
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
                                                                      AppLocalizations.of(context).translate("cheque_book_req_info_des1"),
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
                                                        ),),
                                                    ],
                                                  ),
                                                if(widget.serviceReqArgs.serviceReqType == ServiceReqType.STATEMENT)
                                                  Column(
                                                    children: [
                                                      16.verticalSpace,
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(8),
                                                          border: Border.all(color: colors(context).secondaryColor200 ?? colors(context).whiteColor!),
                                                          color: colors(context).secondaryColor200,
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(16.0),
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
                                                              Padding(
                                                                padding: const EdgeInsets.only(top:0 , bottom: 5 , right: 15 , left: 5),
                                                                child: Text(
                                                                  AppLocalizations.of(context).translate("statement_req_des1"),
                                                                  style: size14weight400.copyWith(color: colors(context).greyColor),
                                                                  textAlign: TextAlign.justify,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 15.0 , bottom: 5 , right: 15 , left: 5),
                                                                child:
                                                                Text(
                                                                    "${AppLocalizations.of(context).translate("lkr")} ${widget.serviceReqArgs.serviceChargeEntity.serviceChargeStatement.toString().withThousandSeparator()} ${
                                                                          AppLocalizations.of(context).translate("statement_lkr_des")}",
                                                                          style: size14weight400.copyWith(color: colors(context).greyColor)),
                                                                      ),
                                                                // RichText(
                                                                //   text: TextSpan(
                                                                //     children: [
                                                                //       TextSpan(
                                                                //         text: 'LKR ',
                                                                //         style: TextStyle(
                                                                //           fontSize: 14,
                                                                //           fontWeight: FontWeight.w400,
                                                                //           color: colors(context).primaryColorColor,
                                                                //         ),
                                                                //       ),
                                                                //       WidgetSpan(
                                                                //         child: Text(
                                                                //           AppLocalizations.of(context).translate("statement_lkr_des"),
                                                                //           style: const TextStyle(
                                                                //               fontSize: 16,
                                                                //               fontWeight: FontWeight.w400),
                                                                //           textAlign: TextAlign.end,
                                                                //         ),
                                                                //       ),
                                                                //     ],
                                                                //   ),
                                                                // ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 15.0 , bottom: 5 , right: 15 , left: 5),
                                                                child: Text(
                                                                  AppLocalizations.of(context).translate("statement_req_des2"),
                                                                  style: size14weight400.copyWith(color: colors(context).greyColor),
                                                                  textAlign: TextAlign.justify,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                        )
                                        // CarouselSlider.builder(
                                        //   itemCount: accountList.length,
                                        //   carouselController: carouselController1,
                                        //   options: CarouselOptions(
                                        //       viewportFraction:
                                        //       accountList.length == 1 ? 1 : 0.90,
                                        //       height: 80,
                                        //       padEnds: accountList.isEmpty,
                                        //       initialPage: currentIndex,
                                        //       enableInfiniteScroll: false,
                                        //       autoPlay: false,
                                        //       scrollPhysics: const BouncingScrollPhysics(),
                                        //       onPageChanged: (index, reason) {
                                        //         currentIndex = index;
                                        //         widget.serviceReqArgs.serviceReqEntity?.availableBalance = accountList[index].availableBalance;
                                        //         widget.serviceReqArgs.serviceReqEntity?.payFromNum = accountList[index].accountNumber;
                                        //         widget.serviceReqArgs.serviceReqEntity?.payFromName = accountList[index].nickName;
                                        //         widget.serviceReqArgs.serviceReqEntity?.instrumentId = accountList[index].instrumentId;
                                        //         widget.serviceReqArgs.serviceReqEntity?.bankCodePayFrom = int.parse(accountList[index].bankCode!);
                                        //         if(widget.serviceReqArgs.serviceReqEntity?.amount!=null){
                                        //           if ((widget.serviceReqArgs.serviceReqEntity!.amount! > widget.serviceReqArgs.serviceReqEntity!.availableBalance!.toInt())&&(widget.serviceReqArgs.serviceReqEntity?.bankCodePayFrom==AppConstants.ubBankCode)) {
                                        //             setState(() {
                                        //               isAmountAvailable = false;
                                        //             });
                                        //           } else {
                                        //             setState(() {
                                        //               isAmountAvailable = true;
                                        //             });
                                        //           }
                                        //         }
                                        //       }),
                                        //   itemBuilder: (BuildContext context, int index, int realIndex) =>
                                        //   accountList.isNotEmpty ? Padding(
                                        //     padding: const EdgeInsets.only(right: 16.0),
                                        //     child: ServiceCarouselContainer(
                                        //       nickName: accountList[index].nickName,
                                        //       bankCode: accountList[index].bankCode,
                                        //       acctNmbr: accountList[index].accountNumber,
                                        //       carouselValue: carauselValue[index],
                                        //     ),
                                        //   ) : Center(
                                        //     child: Text(
                                        //       "No accounts are available",
                                        //       style: TextStyle(
                                        //         fontWeight: FontWeight.w700,
                                        //         fontSize: 14,
                                        //         color: colors(context).blackColor,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ]
                                    ),
                                  )),
                              if( current == 1 && isHistoryAvailable == true)
                                Expanded(
                                  child: SingleChildScrollView(
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
                                              "${historyList.length} ${AppLocalizations.of(context).translate("results")}",
                                              style: size16weight700.copyWith(color: colors(context).blackColor),
                                            ),
                                            // 16.verticalSpace,
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
                                                        onTap: () {
                                                          final result = showModalBottomSheet<
                                                              bool>(
                                                              isScrollControlled:
                                                              true,
                                                              useRootNavigator: true,
                                                              useSafeArea: true,
                                                              context: context,
                                                              barrierColor: colors(context).blackColor?.withOpacity(.85),
                                                              backgroundColor: Colors.transparent,
                                                              builder: (
                                                                  context,
                                                                  ) =>
                                                                  StatefulBuilder(builder: (context, changeState) {
                                                                    return BottomSheetBuilder(
                                                                      title:
                                                                      widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                                                      AppLocalizations.of(context).translate("check_book_req_summary") :
                                                                      AppLocalizations.of(context).translate("statement_req_summary"),
                                                                      buttons: [],
                                                                      children: [
                                                                        FTSummeryDataComponent(
                                                                          title: AppLocalizations.of(context)
                                                                              .translate("Account_Number"),
                                                                          data: historyList[index].chequeNumber ?? "-",
                                                                        ),
                                                                        FTSummeryDataComponent(
                                                                          title: AppLocalizations.of(context)
                                                                              .translate("collection_method"),
                                                                          data: historyList[index].collectionMethod ?? "-",
                                                                        ),
                                                                        FTSummeryDataComponent(
                                                                          title: AppLocalizations.of(context)
                                                                              .translate("branch"),
                                                                          data: historyList[index].branch ?? "-",
                                                                        ),
                                                                        if(widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE)
                                                                          FTSummeryDataComponent(
                                                                          title: AppLocalizations.of(context)
                                                                              .translate("number_of_leaves"),
                                                                          data: historyList[index].noOfLeaves ?? "-",
                                                                        ),
                                                                        if(widget.serviceReqArgs.serviceReqType == ServiceReqType.STATEMENT)
                                                                          FTSummeryDataComponent(
                                                                              title: AppLocalizations.of(context)
                                                                                  .translate("from_date"),
                                                                              data: historyList[index].fromDate == null ? "-" :
                                                                              DateFormat('dd-MMM-yyyy').format(historyList[index].fromDate!)
                                                                          ),
                                                                        if(widget.serviceReqArgs.serviceReqType == ServiceReqType.STATEMENT)
                                                                          FTSummeryDataComponent(
                                                                            title: AppLocalizations.of(context)
                                                                                .translate("to_date"),
                                                                            data: historyList[index].toDate == null ? "-" :
                                                                            DateFormat('dd-MMM-yyyy').format(historyList[index].toDate!),
                                                                          ),
                                                                        FTSummeryDataComponent(
                                                                          title: AppLocalizations.of(context)
                                                                              .translate("service_charge"),
                                                                          isCurrency: true,
                                                                          amount: double.parse(historyList[index].serviceCharge ?? "0.00"),
                                                                        ),
                                                                        FTSummeryDataComponent(
                                                                          title: AppLocalizations.of(context)
                                                                              .translate("date_&_time"),
                                                                          data: historyList[index].dateRecieved == null ? "-" :
                                                                          historyList[index].dateRecieved!,
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.fromLTRB(0.w,16.h,0.w,16.h),
                                                                          child: Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                AppLocalizations.of(context).translate("status"),
                                                                                style: size14weight700.copyWith(color: colors(context).blackColor),
                                                                              ),
                                                                              Container(
                                                                                width: 72,
                                                                                height: 24,
                                                                                decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                    border: Border.all(color:colors(context).greyColor200!),
                                                                                    color: getStatus(historyList[index].status!.toUpperCase()).color!
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    getStatus(historyList[index].status!.toUpperCase()).status!,
                                                                                    style: size12weight700.copyWith(color: colors(context).whiteColor),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                          thickness: 1,
                                                                          height: 0,
                                                                          color: colors(context).greyColor100,
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }));
                                                        },

                                                        //     (){
                                                        //   Navigator.pushNamed(context, Routes.kChequeBookRequestDetailsView,
                                                        //       arguments: SrHistoryDetailsArgs(
                                                        //         serviceReqArgs: widget.serviceReqArgs,
                                                        //         historyDetails: FIData(
                                                        //             chequeNumber: historyList[index].chequeNumber,
                                                        //             dateRecieved: historyList[index].dateRecieved,
                                                        //             status: historyList[index].status?.toUpperCase(),
                                                        //             collectionMethod: historyList[index].collectionMethod,
                                                        //             branch: historyList[index].branch,
                                                        //             noOfLeaves: historyList[index].noOfLeaves,
                                                        //             serviceCharge: historyList[index].serviceCharge,
                                                        //             fromDate: historyList[index].fromDate,
                                                        //             toDate: historyList[index].toDate,
                                                        //             address:  historyList[index].address,
                                                        //             deliveryCharge: historyList[index].deliveryCharge
                                                        //         ), ));
                                                        // },
                                                        child: Column(
                                                          children: [
                                                            ServiceReqComponent(
                                                              fiData: FIData(
                                                                  chequeNumber: historyList[index].chequeNumber,
                                                                  dateRecieved: historyList[index].dateRecieved,
                                                                  status: historyList[index].status,
                                                                icon: widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
                                                                PhosphorIcon(PhosphorIcons.book(PhosphorIconsStyle.bold),
                                                                    color: colors(context).primaryColor) :
                                                                PhosphorIcon(PhosphorIcons.notebook(PhosphorIconsStyle.bold),
                                                                    color: colors(context).primaryColor),
                                                              ),
                                                            ),
                                                            if(historyList.length-1 != index)
                                                              Divider(
                                                                thickness: 1,
                                                                height: 0,
                                                                color: colors(context).greyColor100,
                                                              )
                                                          ],
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
                              if(current == 0)
                                Column(
                                  children: [
                                    20.verticalSpace,
                                    AppButton(
                                        buttonText:
                                        AppLocalizations.of(context).translate("continue"),
                                        onTapButton: () {
                                          if(_formKey.currentState?.validate() == false){
                                            return;
                                          }
                                          if(fromDate != null &&
                                              toDate != null &&
                                              toDateV!.isBefore(fromDateV!) && widget.serviceReqArgs.serviceReqType == ServiceReqType.STATEMENT){
                                            showAppDialog(
                                              title: AppLocalizations.of(context).translate("adjust_date_picker"),
                                              message: "${AppLocalizations.of(context).translate("date_cannot_greater_than")} $toDate",
                                              alertType: AlertType.INFO,
                                              onPositiveCallback: () {},
                                              positiveButtonText: AppLocalizations.of(context).translate("ok"),);
                                            return;
                                          }
                                          if(widget.serviceReqArgs.serviceReqEntity?.collectionMethod! == "ADDRESS" ) {
                                            widget.serviceReqArgs.serviceReqEntity?.addressLine1 = addressController.text;
                                            widget.serviceReqArgs.serviceReqEntity?.addressLine2 = addressControllerOptional.text;
                                            widget.serviceReqArgs.serviceReqEntity?.address = "${addressController.text},${addressControllerOptional.text}";
                                          }
                                          // serviceReqEntity.collectionMethod == "ADDRESS" ?
                                          // serviceReqEntity.deliveryCharge = double.parse(AppConstants.CSI_DELIVERY_CHARGE ?? "0") :
                                          // serviceReqEntity.serviceCharge = double.parse(AppConstants.CSI_SERVICE_CHARGE ?? "0");
                                          // serviceReqEntity.collectionMethod == "ADDRESS" ?
                                          // serviceReqEntity.deliveryChargeStatement = double.parse(AppConstants.CSI_DELIVERY_CHARGE_STM ?? "0") :
                                          // serviceReqEntity.serviceChargeStatement = double.parse(AppConstants.CSI_SERVICE_CHARGE_STM ?? "0");
                                          widget.serviceReqArgs.serviceReqEntity?.toDate = toDateV == null ? null :DateTime(toDateV!.year , toDateV!.month , toDateV!.day , 23, 59 ,59).toString();
                                          setState(() {});
                                          Navigator.pushNamed(
                                              context,
                                              Routes.kChequeBookReqSummaryView,
                                              arguments: widget.serviceReqArgs
                                          );
                                        }),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  FIStatus getStatus(String status){
    switch(status) {
      case "PENDING": {
        return FIStatus(status: AppLocalizations.of(context).translate("pending"),color: colors(context).greyColor);
      }

      case "INPROGRESS": {
        return FIStatus(status: AppLocalizations.of(context).translate("in_progress"),color: colors(context).primaryColor);
      }

      case "CLEARED": {
        return FIStatus(status: AppLocalizations.of(context).translate("cleared"),color: colors(context).positiveColor);
      }



      default: {
        return FIStatus(status: AppLocalizations.of(context).translate("unrealized"),color: colors(context).negativeColor);
      }
    }

  }

  _loadRequest(){
    widget.serviceReqArgs.serviceReqType == ServiceReqType.CHEQUE ?
    serviceReqBloc.add(FilterCheckBookEvent(
      accountNo: dropDownValue,
      collectionMethod: collectionMethod,
      fromDate: fromDateV,
      toDate:toDateV == null ? null : DateTime(toDateV!.year , toDateV!.month , toDateV!.day , 23, 59 ,59),
    )) :
    serviceReqBloc.add(FilterStatementEvent(
      accountNo: dropDownValue,
      collectionMethod: collectionMethod,
      fromDate: fromDateV,
      toDate:toDateV == null ? null : DateTime(toDateV!.year , toDateV!.month , toDateV!.day , 23, 59 ,59),
    ));
  }

  tonull(){
    toDate = null;
    toDateTemp = null;
    fromDate = null;
    fromDateTemp = null;
    toDateV = null;
    toDateVTemp = null;
    collectionMethod = null;
    collectionMethodTemp = null;
    dropDownValue = null;
    dropDownValueTemp = null;
    isFiltered = false;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return serviceReqBloc;
  }
}