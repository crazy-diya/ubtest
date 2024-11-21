import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/float_inquiry/float_inquiry_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/float_inquiry/float_inquiry_state.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_sizer.dart';

import '../../../data/models/responses/float_inquiry_response.dart';
import '../../widgets/appbar.dart';
import '../../widgets/sliding_segmented_bar.dart';
import '../base_view.dart';
import '../fund_transfer/widgets/fund_transfer_data_component.dart';
import 'data/fi_status.dart';

class FloatInqArgs{
  final List<FloatInquiryCbsResponseList> todayInFloats;
  final List<FloatInquiryCbsResponseList> realizeByTodays;

  FloatInqArgs({required this.todayInFloats, required this.realizeByTodays});
}

class FloatInquiryDetailsView extends BaseView {
  final FloatInqArgs floatInqArgs;

  FloatInquiryDetailsView({required this.floatInqArgs});

  @override
  _FloatInquiryDetailsViewState createState() => _FloatInquiryDetailsViewState();
}

class _FloatInquiryDetailsViewState extends BaseViewState<FloatInquiryDetailsView> {
  var bloc = injection<FloatInquiryBloc>();
  final _formKey = GlobalKey<FormState>();
  int? current = 0;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("float_inquiry"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<FloatInquiryBloc, BaseState<FloatInquiryState>>(
          bloc: bloc,
          listener: (context, state) {},
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,0.h + AppSizer.getHomeIndicatorStatus(context)),
              child: Stack(
                children: [
                  if(current == 1 && widget.floatInqArgs.realizeByTodays.length == 0)
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
                              PhosphorIcon(
                                PhosphorIcons.subtitles(PhosphorIconsStyle.bold),
                                color: colors(context).whiteColor,
                                size: 28,
                              ),
                            ),
                          ),
                          16.verticalSpace,
                          Text(
                            AppLocalizations.of(context).translate('no_realize_today'),
                            textAlign: TextAlign.center,
                            style: size18weight700.copyWith(color: colors(context).blackColor),
                          ),
                          4.verticalSpace,
                          Text(
                            AppLocalizations.of(context).translate('no_inq_des'),
                            textAlign: TextAlign.center,
                            style: size14weight400.copyWith(color: colors(context).greyColor),
                          )
                        ],),
                    ),
                  if(current == 0 && widget.floatInqArgs.todayInFloats.length == 0)
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
                              PhosphorIcon(
                                PhosphorIcons.subtitles(PhosphorIconsStyle.bold),
                                color: colors(context).whiteColor,
                                size: 28,
                              ),
                            ),
                          ),
                          16.verticalSpace,
                          Text(
                            AppLocalizations.of(context).translate('no_today_infloat'),
                            textAlign: TextAlign.center,
                            style: size18weight700.copyWith(color: colors(context).blackColor),
                          ),
                          4.verticalSpace,
                          Text(
                            AppLocalizations.of(context).translate('no_inq_des'),
                            textAlign: TextAlign.center,
                            style: size14weight400.copyWith(color: colors(context).greyColor),
                          )
                        ],),
                    ),
                  Column(
                    children: [
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
                          selectedIndex: current ?? 0,
                          children: [
                            AppLocalizations.of(context).translate("today_float"),
                            AppLocalizations.of(context).translate("realize_today"),
                          ],
                        ),
                      ),
                      16.verticalSpace,
                      if(current == 0 && widget.floatInqArgs.todayInFloats.length != 0)
                           Expanded(
                             child:ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    top: 8,
                  ),
                  itemCount: widget.floatInqArgs.todayInFloats.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16 , right: 16),
                          child: Column(
                            children: [
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("cheque_number"),
                                data: (widget.floatInqArgs.todayInFloats[index].cicnum == "" ||
                                    widget.floatInqArgs.todayInFloats[index].cicnum == null)
                                    ? "-"
                                    : widget.floatInqArgs.todayInFloats[index].cicnum ?? "-",
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("date_received"),
                                data: (widget.floatInqArgs.todayInFloats[index].circv6 == "" ||
                                    widget.floatInqArgs.todayInFloats[index].circv6 == null)
                                    ? "-"
                                    : DateFormat('dd-MMM-yyyy').format(widget.floatInqArgs.todayInFloats[index].circv6!),
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("amount"),
                                amount: (widget.floatInqArgs.todayInFloats[index].ciamt == "" ||
                                    widget.floatInqArgs.todayInFloats[index].ciamt == null)
                                    ? 0.00
                                    : double.parse(widget.floatInqArgs.todayInFloats[index].ciamt ?? "0.00"),
                                isCurrency: true,
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context).translate("type"),
                                data: (widget.floatInqArgs.todayInFloats[index].citype == "" ||
                                    widget.floatInqArgs.todayInFloats[index].citype == null)
                                    ? "-"
                                    : widget.floatInqArgs.todayInFloats[index].citype ?? "-",
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
                                          color: colors(context).negativeColor
                                          // getStatus(widget.floatInqArgs.todayInFloats[index].cistat!.toUpperCase()).color!
                                      ),
                                      child: Center(
                                        child: Text(
                                          widget.floatInqArgs.todayInFloats[index].cistat ?? "-",
                                          // getStatus(widget.floatInqArgs.todayInFloats[index].cistat!.toUpperCase()).status!,
                                          style: size12weight700.copyWith(color: colors(context).whiteColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    //   FIDataComponent(
                    //   fiData: FIData(
                    //     chequeNumber: todayInFloat?.cicnum,
                    //     status: todayInFloat?.cistat,
                    //     type: todayInFloat?.citype,
                    //     dateRecieved: DateFormat('dd MMMM yyyy').format(todayInFloat!.circv6!),
                    //     amount: todayInFloat.ciamt,
                    //   ),
                    // );
                  })),
                      if(current == 1 && widget.floatInqArgs.realizeByTodays.length != 0)
                        Expanded(
                            child:ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  top: 8,
                                ),
                                itemCount: widget.floatInqArgs.realizeByTodays.length,
                                itemBuilder: (context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(8).r,
                                        color: colors(context).whiteColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16 , right: 16),
                                        child: Column(
                                          children: [
                                            FTSummeryDataComponent(
                                              title: AppLocalizations.of(context).translate("cheque_number"),
                                              data: (widget.floatInqArgs.realizeByTodays[index].cicnum == "" ||
                                                  widget.floatInqArgs.realizeByTodays[index].cicnum == null)
                                                  ? "-"
                                                  : widget.floatInqArgs.realizeByTodays[index].cicnum ?? "-",
                                            ),
                                            FTSummeryDataComponent(
                                              title: AppLocalizations.of(context).translate("date_received"),
                                              data: (widget.floatInqArgs.realizeByTodays[index].circv6 == "" ||
                                                  widget.floatInqArgs.realizeByTodays[index].circv6 == null)
                                                  ? "-"
                                                  : DateFormat('dd-MMM-yyyy').format(widget.floatInqArgs.realizeByTodays[index].circv6!),
                                            ),
                                            FTSummeryDataComponent(
                                              title: AppLocalizations.of(context).translate("amount"),
                                              amount: (widget.floatInqArgs.realizeByTodays[index].ciamt == "" ||
                                                  widget.floatInqArgs.realizeByTodays[index].ciamt == null)
                                                  ? 0.00
                                                  : double.parse(widget.floatInqArgs.realizeByTodays[index].ciamt ?? "0.00"),
                                              isCurrency: true,
                                            ),
                                            FTSummeryDataComponent(
                                              title: AppLocalizations.of(context).translate("type"),
                                              data: (widget.floatInqArgs.realizeByTodays[index].citype == "" ||
                                                  widget.floatInqArgs.realizeByTodays[index].citype == null)
                                                  ? "-"
                                                  : widget.floatInqArgs.realizeByTodays[index].citype ?? "-",
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
                                                        color: colors(context).negativeColor,
                                                        // getStatus(widget.floatInqArgs.realizeByTodays[index].cistat!.toUpperCase()).color!
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        // getStatus(widget.floatInqArgs.realizeByTodays[index].cistat!.toUpperCase()).status!,
                                                        widget.floatInqArgs.realizeByTodays[index].cistat ?? "-",
                                                        style: size12weight700.copyWith(color: colors(context).whiteColor),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                  //   FIDataComponent(
                                  //   fiData: FIData(
                                  //     chequeNumber: todayInFloat?.cicnum,
                                  //     status: todayInFloat?.cistat,
                                  //     type: todayInFloat?.citype,
                                  //     dateRecieved: DateFormat('dd MMMM yyyy').format(todayInFloat!.circv6!),
                                  //     amount: todayInFloat.ciamt,
                                  //   ),
                                  // );
                                })),
                    ],
                  ),
                ],
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

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}