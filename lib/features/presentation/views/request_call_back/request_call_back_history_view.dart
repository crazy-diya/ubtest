import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/request_callback_get_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/request_callback/request_callback_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/request_callback/request_callback_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/request_callback/request_callback_state.dart';
import 'package:union_bank_mobile/features/presentation/views/request_call_back/data/request_call_back_data.dart';
import 'package:union_bank_mobile/features/presentation/views/request_call_back/widgets/request_call_component.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../base_view.dart';

class RequestCallBackHistoryView extends BaseView {
  final bool isHome;
  const RequestCallBackHistoryView({super.key, required this.isHome});

  @override
  _RequestCallBackHistoryViewState createState() =>
      _RequestCallBackHistoryViewState();
}

class _RequestCallBackHistoryViewState
    extends BaseViewState<RequestCallBackHistoryView> {
  var bloc = injection<RequestCallBackBloc>();
  final _formKey = GlobalKey<FormState>();

  ScrollController _scrollControllerRequestCall = ScrollController();

  int count = 0;

  int pageNumber = 0;

  List<Response>? requestCallBackGetDataList = [];

  @override
  void initState() {
   _scrollControllerRequestCall.addListener(_onScrollRequestCall);
    bloc.add(RequestCallBackGetEvent(page: 0,size: 20));
    super.initState();
  }


   _onScrollRequestCall() {
    if(count !=requestCallBackGetDataList?.length ) {
      final maxScroll = _scrollControllerRequestCall.position.maxScrollExtent;
      final currentScroll = _scrollControllerRequestCall.position.pixels;
      if (maxScroll - currentScroll == 0) {
        bloc.add(RequestCallBackGetEvent(page: pageNumber,size: 20));
      }
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("request_callbak"),
        goBackEnabled: true,
        actions: [
          // IconButton(
          //   onPressed: (){
          //     Navigator.pushNamed(context, Routes.kRequestCallBackFilterView);
          //   },
          //   icon: Image.asset(
          //     AppAssets.icTransFilter,
          //     scale: 3,
          //   ),
          // )
        ],
      ),
      body: BlocProvider<RequestCallBackBloc>(
         create: (_) => bloc,
          child: BlocListener<RequestCallBackBloc, BaseState<RequestCallBackState>>(
          bloc: bloc,
          listener: (context, state) {
            if (state is RequestCallBackGetSuccessState) {
              setState(() {
                count = state.count ?? 0;
                if (pageNumber == 0) {
                  requestCallBackGetDataList?.clear();
                  requestCallBackGetDataList = state.requestCallBackGetResponse ?? [];
                } else {
                  requestCallBackGetDataList?.addAll(state.requestCallBackGetResponse ?? []);
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate("history"),
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollControllerRequestCall,
                        padding: EdgeInsets.zero,
                        itemCount: requestCallBackGetDataList?.length,
                        itemBuilder: (context, int index) {
                         final requestCall = requestCallBackGetDataList![index];
                          return InkWell(
                            onTap: (){
                              Navigator.pushNamed(
                                  context, Routes.kReqCallBackHistoryDetailsView , arguments:
                              ReqCallBackArgs(
                                callBackTime: CommonDropDownResponse(description: requestCall.callBackTime),
                                subject: CommonDropDownResponse(description: requestCall.subject),
                                comments: requestCall.comment,
                                language: CommonDropDownResponse(description: requestCall.language),
                                status: requestCall.status?.toUpperCase(),
                                id: requestCall.id
                              )
                              );
                            },
                            child: RequestCallComponent(
                              rcData: RCData(
                                prefTimeSlot: requestCall.callBackTime,
                                reqDate:DateFormat('dd-MMM-yyyy | hh:mm a').format(requestCall.createDate??DateTime.now()),
                                status: requestCall.status?.toUpperCase(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    AppButton(
                        buttonText: AppLocalizations.of(context)
                            .translate("initiate_new_request"),
                        onTapButton: () {
                          Navigator.pushNamed(
                              context, Routes.kRequestCallBackView , arguments: widget.isHome);
                        }),
                  ]),
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
