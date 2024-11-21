import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/features/data/models/responses/account_statements_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/credit_card_management/credit_card_management_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/pop_scope/ub_pop_scope.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/common_status_icon.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';
import 'credit_card_payment_failed_view.dart';

class CreditCardPaymentSuccessView extends BaseView {
  final CreditCardPaymentFailedArgs creditCardPaymentSuccessArgs;


  CreditCardPaymentSuccessView({required this.creditCardPaymentSuccessArgs});

  @override
  State<CreditCardPaymentSuccessView> createState() =>
      _CreditCardPaymentSuccessViewState();
}

class _CreditCardPaymentSuccessViewState
    extends BaseViewState<CreditCardPaymentSuccessView> {
  final bloc = injection<CreditCardManagementBloc>();
  late DateTime? datetime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datetime = DateTime.now();
  }


  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.kHomeBaseView,
          (Route<dynamic> route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          goBackEnabled: false,
          title: AppLocalizations.of(context).translate("payment_status"),
          onBackPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.kHomeBaseView,
              (Route<dynamic> route) => false,
            );
          },
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              20.w, 24.w, 20, 20.w + AppSizer.getHomeIndicatorStatus(context)),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).r,
                            color: colors(context).whiteColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24).w,
                          child: Column(
                            children: [
                              CommonStatusIcon(
                                backGroundColor: colors(context).positiveColor!,
                                icon: PhosphorIcons.check(
                                    PhosphorIconsStyle.bold),
                                iconColor: colors(context).whiteColor,
                              ),
                              16.verticalSpace,
                              Text(
                                AppLocalizations.of(context)
                                    .translate("payment_was_successful"),
                                style: size18weight700.copyWith(
                                    color: colors(context).blackColor),
                              ),
                              16.verticalSpace,
                              Text(
                                "${AppLocalizations.of(context).translate("lkr")} ${widget.creditCardPaymentSuccessArgs.creditCardPaymentArgs.amount?.replaceAll(',', '').withThousandSeparator()}",
                                // "${widget.creditCardPaymentFailedArgs?.amount.toString().withThousandSeparator()}",
                                style: size24weight700.copyWith(
                                    color: colors(context).primaryColor),
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
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0).w,
                          child: Column(
                            children: [
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("Pay_From"),
                                data: widget.creditCardPaymentSuccessArgs.creditCardPaymentArgs.payFrom?.payFromName ?? "-",
                                subData: widget.creditCardPaymentSuccessArgs.creditCardPaymentArgs.payFrom?.payFromNum ?? "-",
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("Pay_To"),
                                data: widget.creditCardPaymentSuccessArgs.creditCardPaymentArgs.payTo?.nickName ?? "-",
                                subData: widget.creditCardPaymentSuccessArgs.creditCardPaymentArgs.payTo?.cardNumber ?? "-",
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("date_&_time"),
                                data: DateFormat("dd-MMM-yyyy | hh:mm a").format(datetime ?? DateTime.now()),
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("remarks"),
                                data: widget.creditCardPaymentSuccessArgs.creditCardPaymentArgs.remark == "" || widget.creditCardPaymentSuccessArgs.creditCardPaymentArgs.remark == null ? "-" :
                                widget.creditCardPaymentSuccessArgs.creditCardPaymentArgs.remark ?? "-",
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("service_charge"),
                                amount: widget.creditCardPaymentSuccessArgs.creditCardPaymentArgs.payFrom?.serviceCharge == null ||
                                    widget.creditCardPaymentSuccessArgs.creditCardPaymentArgs.payFrom?.serviceCharge == 0.00 ? 0.00 :
                                widget.creditCardPaymentSuccessArgs.creditCardPaymentArgs.payFrom?.serviceCharge,
                                isCurrency: true,
                              ),
                              FTSummeryDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("reference_number"),
                                data: widget.creditCardPaymentSuccessArgs.refNo,
                                isLastItem: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppButton(
                  buttonText: AppLocalizations.of(context)
                      .translate("back_to_home"),
                  onTapButton: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.kHomeBaseView,
                          (Route<dynamic> route) => false,
                    );
                  })
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
