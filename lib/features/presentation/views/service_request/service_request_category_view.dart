import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';

import '../../../data/models/responses/sr_service_charge_response.dart';
import '../../bloc/service_requests/service_requests_bloc.dart';
import '../../bloc/service_requests/service_requests_event.dart';
import '../../bloc/service_requests/service_requests_state.dart';
import '../../widgets/appbar.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import 'data/service_charge_entity.dart';
import 'data/service_req_args.dart';
import 'data/service_req_entity.dart';


class SeviceReqCategoryView extends BaseView {

  @override
  _SeviceReqCategoryViewState createState() => _SeviceReqCategoryViewState();
}

class _SeviceReqCategoryViewState extends BaseViewState<SeviceReqCategoryView> {
  var bloc = injection<ServiceRequestsBloc>();
  final _formKey = GlobalKey<FormState>();
  List<ServiceCharge> serviceChargeList = [];
  final serviceReqEntity = ServiceReqEntity();
  final serviceChargeEntity = ServiceChargeEntity();


  @override
  void initState() {
    bloc.add(ServiceChargeEvent());
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("service_request"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<ServiceRequestsBloc,
            BaseState<ServiceRequestsState>>(
          bloc: bloc,
          listener: (context, state) {
            if(state is ServiceChargeSuccessState){
              serviceChargeList.clear();
              serviceChargeList.addAll(state.serviceChargeRequest!
                  .map((e) => ServiceCharge(
                  transactiontype: e.transactiontype,
                charge: e.charge
              )).toList());
              serviceChargeEntity.deliveryChargeStatement = serviceChargeList.where((e) => e.transactiontype == "STATDEL").first.charge;
              serviceChargeEntity.serviceChargeStatement = serviceChargeList.where((e) => e.transactiontype == "STATSER").first.charge;
              serviceChargeEntity.serviceChargeNumOfLeaves10 = serviceChargeList.where((e) => e.transactiontype == "CHEQSER10").first.charge;
              serviceChargeEntity.serviceChargeNumOfLeaves20 = serviceChargeList.where((e) => e.transactiontype == "CHEQSER20").first.charge;
              serviceChargeEntity.deliveryCharge = serviceChargeList.where((e) => e.transactiontype == "CHEQDEL").first.charge;
            }
            if(state is ServiceChargeFailState){
              ToastUtils.showCustomToast(
                  context, state.message ?? "", ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8).r,
                  color: colors(context).whiteColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16).w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        child: Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 48.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor,
                                  border: Border.all(
                                      color: colors(context).greyColor300 ?? Colors.black // Border width
                                  )
                              ),
                              child: PhosphorIcon(PhosphorIcons.book(PhosphorIconsStyle.bold), color: colors(context).primaryColor,),
                            ),
                            12.horizontalSpace,
                            Text(
                              AppLocalizations.of(context).translate("cheque_book"),
                              style: size16weight700.copyWith(color: colors(context).blackColor),
                            ),
                            const Spacer(),
                            PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                              color: colors(context).greyColor300,
                            )
                          ],
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, Routes.kChequeBookReqView , arguments: ServiceReqArgs(serviceReqEntity , ServiceReqType.CHEQUE , serviceChargeEntity));
                        },
                      ),
                      16.verticalSpace,
                      Divider(
                        thickness: 1,
                        color: colors(context).greyColor100,
                        height: 0,
                      ),
                      16.verticalSpace,
                      InkWell(
                        child: Row(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor,
                                  border: Border.all(
                                      color: colors(context).greyColor300 ?? Colors.black // Border width
                                  )
                              ),
                              child: PhosphorIcon(PhosphorIcons.notebook(PhosphorIconsStyle.bold),
                                color: colors(context).primaryColor,
                              ),
                            ),
                            12.horizontalSpace,
                            Text(
                              AppLocalizations.of(context).translate("statement"),
                              style: size16weight700.copyWith(color: colors(context).blackColor),
                            ),
                            const Spacer(),
                            PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                              color: colors(context).greyColor300,
                            )
                          ],
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, Routes.kChequeBookReqView , arguments: ServiceReqArgs(serviceReqEntity , ServiceReqType.STATEMENT , serviceChargeEntity));
                        },
                      ),
                    ]
                  ),
                ),
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