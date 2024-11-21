import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/request_call_back/widgets/request_call_component.dart';
import 'package:union_bank_mobile/features/presentation/widgets/date_pickers/app_date_picker.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../../utils/enums.dart';
import '../../../data/models/responses/city_response.dart';
import '../../../data/models/responses/request_callback_get_response.dart';
import '../../bloc/request_callback/request_callback_bloc.dart';
import '../../bloc/request_callback/request_callback_event.dart';
import '../../bloc/request_callback/request_callback_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../../widgets/drop_down_widgets/drop_down.dart';
import '../../widgets/drop_down_widgets/drop_down_view.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import 'data/request_call_back_data.dart';




class RequestCallBackFilterView extends BaseView {

  @override
  _RequestCallBackFilterViewState createState() => _RequestCallBackFilterViewState();
}

class _RequestCallBackFilterViewState extends BaseViewState<RequestCallBackFilterView> {
  var bloc = injection<RequestCallBackBloc>();
  final _formKey = GlobalKey<FormState>();
  DateTime? fromDateV;
  String? fromDate;
  DateTime? toDateV;
  String? toDate;
  String? dropDownValue;
  String? status;
  bool isButtonClicked = false;
  bool isApiSuccess = true;
  bool isFilteredResultAvailable = true;
  List<CommonDropDownResponse> statusList = [];
  List<CommonDropDownResponse> subjectList = [];
  CommonDropDownResponse? subject;
  CommonDropDownResponse? statusDD;

  int count = 0;

  int pageNumber = 0;

  List<Response>? requestCallBackGetFilteredDataList = [];

  ScrollController _scrollControllerRequestCall = ScrollController();

  @override
  void initState() {
    _scrollControllerRequestCall.addListener(_onScrollRequestCall);
    bloc.add(RequestCallBackGetDefaultDataEvent());
    super.initState();
  }

  _onScrollRequestCall() {
    if(count !=requestCallBackGetFilteredDataList?.length ) {
      final maxScroll = _scrollControllerRequestCall.position.maxScrollExtent;
      final currentScroll = _scrollControllerRequestCall.position.pixels;
      if (maxScroll - currentScroll == 0) {
        bloc.add(
            RequestCallBackGetEvent(
                page: pageNumber, size: 20,
                fromDate: fromDateV,
                toDate: toDateV,
                subject: subject?.id,
                status: statusDD?.description?.toLowerCase()
            ));
      }
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("request_call_back_filter") ,
        goBackEnabled: true,
      ),
      body: BlocProvider<RequestCallBackBloc>(
        create: (context) => bloc,
        child: BlocListener<RequestCallBackBloc, BaseState<RequestCallBackState>>(
          bloc: bloc,
          listener: (context, state) {
            if(state is RequestCallBackGetDefaultDataSuccessState){
              if (state.requestCallBackGetDefaultDataResponse
                  ?.requestDetailDefaultDataTimeSlotResponseList !=
                  null) {
                statusList = state
                    .requestCallBackGetDefaultDataResponse!
                    .statusList!
                    .map((e) => CommonDropDownResponse(
                    code: e.status,
                    description: e.description,
                    // id: e.id,
                    // key: e.slotCode
                ))
                    .toList();
              }
              if (state.requestCallBackGetDefaultDataResponse
                  ?.requestDetailDefaultDataTimeSlotResponseList !=
                  null) {
                subjectList = state.requestCallBackGetDefaultDataResponse!
                    .requestDetailDefaultDataSubjectResponses!
                    .map((e) => CommonDropDownResponse(
                    code: e.subjectName,
                    description: e.subjectName,
                    id: e.id,
                    key: e.subjectCode))
                    .toList();
              }

            }
            else if(state is RequestCallBackGetDefaultDataFailState)
            {ToastUtils.showCustomToast(
                  context, state.message??"", ToastStatus.FAIL);}
            if (state is RequestCallBackGetSuccessState) {
              setState(() {
                count = state.count ?? 0;
                if (pageNumber == 0) {
                  requestCallBackGetFilteredDataList?.clear();
                  requestCallBackGetFilteredDataList = state.requestCallBackGetResponse ?? [];
                } else {
                  requestCallBackGetFilteredDataList?.addAll(state.requestCallBackGetResponse ?? []);
                }
                pageNumber = pageNumber + 1;
              });
            } else if (state is RequestCallBackGetFailState) {
              ToastUtils.showCustomToast(
                  context, state.message ?? "", ToastStatus.FAIL);
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
                      physics: BouncingScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppDatePicker(
                              initialValue: ValueNotifier(fromDate!=null ?DateFormat('dd-MMM-yyyy').format(DateTime.parse(fromDate!)):null),
                              isFromDateSelected: true,
                              lastDate: DateTime.now(),
                              labelText: AppLocalizations.of(context).translate("from_date"),
                              onChange: (value) {
                                fromDate = value;
                                fromDateV = DateTime.parse(fromDate!);
                                isButtonClicked = false;
                                setState(() {});
                              },
                              initialDate: DateTime.parse(fromDate ??DateTime.now().toString()),
                            ),
                            SizedBox(height: 1.h,),
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
                            SizedBox(
                              height: 3.h,
                            ),
                            AppDatePicker(
                              initialValue: ValueNotifier(toDate!=null ?DateFormat('dd-MMM-yyyy').format(DateTime.parse(toDate!)):null),
                              isFromDateSelected: true,
                             firstDate: fromDateV,
                              lastDate: DateTime.now(),
                              initialDate: DateTime.parse(toDate ??DateTime.now().toString()),
                              labelText: AppLocalizations.of(context) .translate("to_date"),
                              onChange: (value) {
                                setState(() {
                                  toDate = value;
                                  toDateV = DateTime.parse(toDate!);
                                  isButtonClicked = false;
                                });
                              },
                            ),
                            SizedBox(height: 4.h,),
                            AppDropDown(
                              isDisable: false,
                              labelText: AppLocalizations.of(context)
                                  .translate("subject_reason_for_allback"),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.kDropDownView,
                                    arguments: DropDownViewScreenArgs(
                                      itemList: subjectList,
                                      isAnEvent: false,
                                      isSearchable: true,
                                      pageTitle:
                                      AppLocalizations.of(context)
                                          .translate("subject_reason"),
                                    )).then((value) {
                                  if (value != null &&
                                      value is CommonDropDownResponse) {
                                    setState(() {
                                      subject = value;
                                      isButtonClicked = false;
                                    });
                                  }
                                });
                              },
                              initialValue: subject?.description,
                            ),
                            SizedBox(height: 3.h,),
                            AppDropDown(
                              isDisable: false,
                              labelText: AppLocalizations.of(context)
                                  .translate("status"),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.kDropDownView,
                                    arguments: DropDownViewScreenArgs(
                                      itemList: statusList,
                                      isAnEvent: false,
                                      isSearchable: true,
                                      pageTitle:
                                      AppLocalizations.of(context)
                                          .translate("status"),
                                    )).then((value) {
                                  if (value != null &&
                                      value is CommonDropDownResponse) {
                                    setState(() {
                                      statusDD = value;
                                      isButtonClicked = false;
                                    });
                                  }
                                });
                              },
                              initialValue: statusDD?.description,
                            ),
                            SizedBox(height: 2.h,),
                            isApiSuccess ?
                            Column(
                              children: [
                                SizedBox(height: 3.h,),
                                Divider(
                                  thickness: 1,
                                  color: colors(context).greyColor400,
                                ),
                                SizedBox(height: 3.h,),
                                isFilteredResultAvailable ?
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  controller: _scrollControllerRequestCall,
                                  itemCount: requestCallBackGetFilteredDataList?.length,
                                  itemBuilder: (context, int index){
                                    final filteredList = requestCallBackGetFilteredDataList![index];
                                    return InkWell(
                                      onTap: (){
                                        Navigator.pushNamed(
                                            context, Routes.kReqCallBackHistoryDetailsView , arguments:
                                        ReqCallBackArgs(
                                            callBackTime: CommonDropDownResponse(description: filteredList.callBackTime),
                                            subject: CommonDropDownResponse(description: filteredList.subject),
                                            comments: filteredList.comment,
                                            language: CommonDropDownResponse(description: filteredList.language),
                                            status: filteredList.status?.toUpperCase(),
                                            id: filteredList.id
                                        )
                                        );
                                      },
                                      child: RequestCallComponent(
                                        rcData: RCData(
                                          prefTimeSlot: filteredList.callBackTime,
                                          reqDate:DateFormat('dd-MMM-yyyy | hh:mm a').format(filteredList.createDate??DateTime.now()),
                                          status: filteredList.status?.toUpperCase(),
                                        ),
                                      ),
                                    );
                                  },
                                ):
                                Column(
                                  children: [
                                    // Image.asset(
                                    //   AppAssets.icCsiEmpty,
                                    //   scale: 3,
                                    //   width: 40.w,
                                    // ),
                                    Text(
                                      AppLocalizations.of(context).translate("no_record_des"),
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
                            ) : SizedBox.shrink()
                          ]
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !isButtonClicked,
                    child: Column(
                      children: [
                        SizedBox(height: 3.h,),
                        AppButton(
                            buttonText:
                            AppLocalizations.of(context).translate("filter_"),
                            onTapButton: () {
                              if(fromDate != null &&
                                  toDate != null &&
                                  toDateV!.isBefore(fromDateV!)){
                                showAppDialog(
                                  title: AppLocalizations.of(context).translate("adjust_date_picker"),
                                  message: "${AppLocalizations.of(context).translate("date_cannot_greater_than")} $toDate",
                                  alertType: AlertType.INFO,
                                  onPositiveCallback: () {},
                                  positiveButtonText: AppLocalizations.of(context).translate("ok"),);
                              } else {
                                isButtonClicked = true;
                                bloc.add(
                                    RequestCallBackGetEvent(
                                        page: 0, size: 20,
                                        fromDate: fromDateV,
                                        toDate: toDateV == null ? null :DateTime(toDateV!.year , toDateV!.month , toDateV!.day , 23, 59 ,59),
                                        subject: subject?.id,
                                        status: statusDD?.code?.toLowerCase()
                                    ));
                                pageNumber = 0;
                              }
                              setState(() {});
                            }),
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

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}