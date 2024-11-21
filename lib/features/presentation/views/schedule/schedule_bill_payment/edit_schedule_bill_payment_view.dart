import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/schedule/schedule_bill_payment/schedule_bill_payment_view.dart';
import 'package:union_bank_mobile/features/presentation/views/schedule/schedule_bill_payment/widgets/bill_payment_schedule_args.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/date_pickers/ft_date_picker.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../../utils/text_editing_controllers.dart';

import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_bloc.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_event.dart';
import '../../../bloc/fund_transfer_view_scheduling/ft_view_scheduling_state.dart';
import '../../../widgets/app_button.dart';

import '../../../widgets/pop_scope/ub_pop_scope.dart';
import '../../../widgets/text_fields/app_text_field.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';


class EditScheduleBillPaymentView extends BaseView {
  final ScheduleBillPaymentArgs scheduleBillPaymentArgs;


  EditScheduleBillPaymentView({required this.scheduleBillPaymentArgs});

  @override
  _EditScheduleBillPaymentViewState createState() => _EditScheduleBillPaymentViewState();
}

class _EditScheduleBillPaymentViewState extends BaseViewState<EditScheduleBillPaymentView> {


  var bloc = injection<FTViewSchedulingBloc>();
  int ownRecDays = 0;
  String? startDate;
  String? endDate;
  bool isEdited = false;
  bool? isStartDateAvailable;
  final _formKey = GlobalKey<FormState>();
  CurrencyTextEditingController? amountController;

  @override
  void initState() {

    amountController=  CurrencyTextEditingController(initialValue: widget.scheduleBillPaymentArgs.billerEntity.amount!);

    super.initState();
    ownRecDays = DateTime.parse(
      DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM yyyy')
          .parse(widget.scheduleBillPaymentArgs.billerEntity.startDate!)),
    ).difference(DateTime.now()).inDays;
    startDate = widget.scheduleBillPaymentArgs.billerEntity.startDate;
    endDate = widget.scheduleBillPaymentArgs.billerEntity.endDate;
    isStartDateAvailable = widget.scheduleBillPaymentArgs.billerEntity.tabID == 0 ? false : true;
  }


  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async{
        _onBack();
        return true;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          onBackPressed: (){
            _onBack();
          },
          title: AppLocalizations.of(context).translate("schedule_bill_payments"),
        ),
        body: BlocProvider(
          create: (_) => bloc,
          child: BlocListener<FTViewSchedulingBloc, BaseState<FTViewSchedulingState>>(
            listener: (_, state) {
              if (state is EditSchedulingFTSuccessState){
                ToastUtils.showCustomToast(
                    context, state.responseDes!, ToastStatus.SUCCESS);
                Navigator.pushNamedAndRemoveUntil(
                  context,Routes.kScheduleBillPaymentView,
                      (Route<dynamic> route) => route.settings.name == Routes.kScheduleCategoryListView,
                );
              }
              if(state is EditSchedulingFTFailState){
                ToastUtils.showCustomToast(
                    context, state.errorMessage ?? AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
              }
            },
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                            // physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.only(top: 24.h),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8).r,
                                          color: colors(context).whiteColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 16.0 , right: 16).w,
                                          child: Column(
                                            children: [
                                              FTSummeryDataComponent(
                                                title: AppLocalizations.of(context).translate("paid_from"),
                                                data: widget.scheduleBillPaymentArgs.billerEntity.payFromName ?? "no name",
                                                subData: widget.scheduleBillPaymentArgs.billerEntity.payFromNum ?? "no acct",
                                              ),
                                              FTSummeryDataComponent(
                                                  title: AppLocalizations.of(context).translate("paid_to"),
                                                  data:  widget.scheduleBillPaymentArgs.billerEntity.billerName ?? "no name",
                                                  subData: widget.scheduleBillPaymentArgs.billerEntity.collectionAccount ?? "no acct"
                                              ),
                                              FTSummeryDataComponent(
                                                isLastItem: widget.scheduleBillPaymentArgs.billerEntity.scheduleType?.toUpperCase() != "REPEAT",
                                                title: AppLocalizations.of(context)
                                                    .translate("schedule_type"),
                                                data: widget.scheduleBillPaymentArgs.billerEntity.scheduleType?.toUpperCase() == "ONETIME" ?
                                                "One time" :
                                                widget.scheduleBillPaymentArgs.billerEntity.scheduleType??"-",
                                              ),
                                              if(widget.scheduleBillPaymentArgs.billerEntity.scheduleType?.toUpperCase() == "REPEAT")
                                                FTSummeryDataComponent(
                                                  isLastItem: widget.scheduleBillPaymentArgs.billerEntity.scheduleType?.toUpperCase() == "REPEAT",
                                                  title: AppLocalizations.of(context).translate("frequency"),
                                                  data:  widget.scheduleBillPaymentArgs.billerEntity.frequency ?? "no freq",
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
                                          padding: const EdgeInsets.all(16.0).w,
                                          child: Column(
                                            children: [
                                              AppTextField(
                                                hint: AppLocalizations.of(context).translate("amount"),
                                                title: AppLocalizations.of(context).translate("amount"),
                                                isCurrency: true,
                                                textCapitalization: TextCapitalization.none,
                                                controller: amountController,
                                                showCurrencySymbol: true,
                                                inputType: const TextInputType.numberWithOptions(decimal: true),
                                                // initialValue:  widget.scheduleBillPaymentArgs.billerEntity.amount.toString().withThousandSeparator(),
                                                onTextChanged: (value) {
                                                  setState(() {
                                                    double parsedValue = double.tryParse(value.replaceAll(',', '')) ?? 88;
                                                    widget.scheduleBillPaymentArgs.billerEntity.amount = parsedValue;
                                                    isEdited = true;
                                                  });
                                                },
                                                validator: (value){
                                                  if (amountController?.text == "" || amountController?.text == null ||amountController?.text == "0.00") {
                                                    return AppLocalizations.of(context)
                                                        .translate("mandatory_field_msg");
                                                  } else {
                                                    return null;
                                                  }
                                                },
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
                                          padding: const EdgeInsets.all(16.0).w,
                                          child: Column(
                                            children: [
                                              AppTextField(
                                                isInfoIconVisible: false,
                                                hint: AppLocalizations.of(context).translate("when"),
                                                title: AppLocalizations.of(context).translate("when"),
                                                isEnable: false,
                                                textCapitalization: TextCapitalization.none,
                                                initialValue: widget.scheduleBillPaymentArgs.billerEntity.scheduleType?.toUpperCase() == "REPEAT" ? "Recurring" : "Later",
                                                onTextChanged: (value) {},
                                              ),
                                              24.verticalSpace,
                                              if(widget.scheduleBillPaymentArgs.billerEntity.scheduleType!.toUpperCase() == "ONETIME")
                                                FTDatePicker(
                                                  labelText: AppLocalizations.of(context).translate("schedule_date"),
                                                  title: AppLocalizations.of(context).translate("schedule_date"),
                                                  firstDate: DateTime.parse(
                                                    DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM yyyy')
                                                        .parse(widget.scheduleBillPaymentArgs.billerEntity.startDate!)),
                                                  ),
                                                  // DateFormat('dd MMMM yyyy').parse(widget.fundTransferArgs.fundTransferEntity.startDate!),
                                                  text: startDate!=null ?DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse(startDate!)) :null ,
                                                  initialDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM yyyy').parse(widget.scheduleBillPaymentArgs.billerEntity.startDate!)),) ,
                                                  initialValue: DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse(widget.scheduleBillPaymentArgs.billerEntity.startDate!)) ,
                                                  isStartDateSelected: true,
                                                  onChange:
                                                      (value) {
                                                    if(widget.scheduleBillPaymentArgs.billerEntity.endDate != null){
                                                      setState(() {
                                                        widget.scheduleBillPaymentArgs.billerEntity.endDate = null;
                                                      });
                                                    }
                                                    startDate = value;
                                                    setState(() {
                                                      ownRecDays = DateTime.parse(
                                                        DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM yyyy')
                                                            .parse(widget.scheduleBillPaymentArgs.billerEntity.startDate!)),
                                                      ).difference(DateTime.now()).inDays;
                                                    });

                                                    setState(() {
                                                      isEdited = true;
                                                    });

                                                  },
                                                ),
                                              if(widget.scheduleBillPaymentArgs.billerEntity.scheduleType!.toUpperCase() == "REPEAT")
                                                Column(
                                                  children: [
                                                    FTDatePicker(
                                                      text: startDate!=null ?DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse(startDate!)) :null ,
                                                      labelText: AppLocalizations.of(context).translate("start_date"),
                                                      title: AppLocalizations.of(context).translate("start_date"),
                                                      isStartDateSelected: isStartDateAvailable ?? true,
                                                      firstDate:DateTime.parse(
                                                        DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM yyyy')
                                                            .parse(widget.scheduleBillPaymentArgs.billerEntity.startDate!)),
                                                      ) ,
                                                      initialDate:DateTime.parse(
                                                        DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM yyyy')
                                                            .parse(widget.scheduleBillPaymentArgs.billerEntity.startDate!)),
                                                      ),
                                                      initialValue:DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse(widget.scheduleBillPaymentArgs.billerEntity.startDate!)),
                                                      onChange:
                                                          (value) {
                                                        if(endDate != null){
                                                          setState(() {
                                                            endDate = null;
                                                          });
                                                        }
                                                        startDate = value;
                                                        setState(() {
                                                          ownRecDays = DateTime.parse(
                                                            DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM yyyy')
                                                                .parse(startDate!)),
                                                          ).difference(DateTime.now()).inDays;
                                                        });
                                                        setState(() {
                                                          isEdited = true;
                                                        });

                                                      },
                                                    ),
                                                    24.verticalSpace,
                                                    FTDatePicker(
                                                      validator: (value){
                                                        if(endDate == null){
                                                          return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                                        }
                                                        else{
                                                          return null;
                                                        }
                                                      },
                                                      labelText: AppLocalizations.of(context).translate("end_date"),
                                                      title: AppLocalizations.of(context).translate("end_date"),
                                                      isStartDateSelected: true,
                                                      firstDate: DateTime.now().add(Duration(days: ownRecDays + 2)),
                                                      initialDate: DateTime.now().add(Duration(days: ownRecDays + 2)),
                                                      text: endDate!=null ?DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse(endDate!)) :null ,
                                                      initialValue:widget.scheduleBillPaymentArgs.billerEntity.endDate!=null ? DateFormat('dd-MMM-yyyy').format(DateFormat('d MMMM yyyy').parse(widget.scheduleBillPaymentArgs.billerEntity.endDate!)):null,
                                                      // DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').parse(widget.fundTransferArgs.fundTransferEntity.endDate!)),
                                                      onChange:
                                                          (value) {
                                                        endDate = value;
                                                        setState(() {
                                                          isEdited = true;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      16.verticalSpace,
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8).r,
                                          color: colors(context).secondaryColor200,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0).w,
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  PhosphorIcon(PhosphorIcons.info(PhosphorIconsStyle.bold)),
                                                  8.horizontalSpace,
                                                  Text(
                                                      AppLocalizations.of(context).translate("please_note"),
                                                      textAlign: TextAlign.justify,
                                                      style: size14weight700.copyWith(color: colors(context).blackColor)
                                                  ),
                                                ],
                                              ),
                                              12.verticalSpace,
                                              Text(
                                                  AppLocalizations.of(context).translate("edit_scedule_des_complete"),
                                                  textAlign: TextAlign.justify,
                                                  style: size14weight400.copyWith(color: colors(context).greyColor)
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ))),
                    Column(
                      children: [
                        20.verticalSpace,
                        AppButton(
                            buttonText:
                            AppLocalizations.of(context).translate("save"),
                            onTapButton: () {
                              if(_formKey.currentState?.validate() == false){
                                return;
                              }
                              bloc.add(UpdateScheduleFTEvent(
                                messageType: "scheduleFtReq",
                                scheduleId: widget.scheduleBillPaymentArgs.billerEntity.scheduleID,
                                endDate:widget.scheduleBillPaymentArgs.billerEntity.scheduleType!.toUpperCase() == "ONETIME" ? DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM yyyy').parse(startDate!)):
                                DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM yyyy').parse(endDate!)),
                                amount: widget.scheduleBillPaymentArgs.billerEntity.amount,
                                startDate: DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM yyyy').parse(startDate!)),
                                // beneficiaryMobile: widget.fundTransferArgs.fundTransferEntity.beneficiaryMobile,
                                // beneficiaryEmail: widget.fundTransferArgs.fundTransferEntity.beneficiaryEmail,
                              ));
                            }),
                        16.verticalSpace,
                        AppButton(
                          buttonType: ButtonType.OUTLINEENABLED,
                          buttonColor: Colors.transparent,
                          buttonText: AppLocalizations.of(context).translate("cancel"),
                          onTapButton: () {
                            _onBack();
                          },
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
    );
  }


  _onBack(){
    if(isEdited == true){
      showAppDialog(
          alertType: AlertType.WARNING,
          title: AppLocalizations.of(context).translate("are_you_sure?"),
          message: AppLocalizations.of(context).translate("schedule_edit_back_des"),
          negativeButtonText: AppLocalizations.of(context).translate("no"),
          positiveButtonText: AppLocalizations.of(context).translate("yes"),
          onNegativeCallback: (){

          },
          onPositiveCallback: () {
            widget.scheduleBillPaymentArgs.billerEntity.startDate = startDate;
            widget.scheduleBillPaymentArgs.billerEntity.endDate = endDate;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ScheduleBillPaymentView()),
                  (Route<dynamic> route) =>
              route.settings.name == 'kScheduleCategoryListView',
            );
            setState(() {
            });
          });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
