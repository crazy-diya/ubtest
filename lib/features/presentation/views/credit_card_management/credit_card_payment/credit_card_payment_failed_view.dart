import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/credit_card_management/credit_card_management_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/pop_scope/ub_pop_scope.dart';

import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/common_status_icon.dart';
import '../../fund_transfer/widgets/fund_transfer_data_component.dart';
import 'data/credit_card_payment_args.dart';

class CreditCardPaymentFailedArgs{
  final CreditCardPaymentArgs creditCardPaymentArgs;
  final String refNo;
  final String? failReason;

  CreditCardPaymentFailedArgs({required this.creditCardPaymentArgs, required this.refNo , this.failReason});
}


class CreditCardPaymentFailedView extends BaseView {
  final CreditCardPaymentFailedArgs creditCardPaymentFailedArgs;


  CreditCardPaymentFailedView({required this.creditCardPaymentFailedArgs});

  @override
  State<CreditCardPaymentFailedView> createState() =>
      _CreditCardPaymentFailedViewState();
}

class _CreditCardPaymentFailedViewState
    extends BaseViewState<CreditCardPaymentFailedView> {
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
            padding: EdgeInsets.fromLTRB(20.w, 24.w, 20,
                20.w + AppSizer.getHomeIndicatorStatus(context)),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
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
                                  backGroundColor:
                                      colors(context).negativeColor!,
                                  icon: PhosphorIcons.warning(
                                      PhosphorIconsStyle.bold),
                                  iconColor: colors(context).whiteColor,
                                ),
                                16.verticalSpace,
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("payment_was_failed"),
                                  style: size18weight700.copyWith(
                                      color: colors(context).blackColor),
                                ),
                                4.verticalSpace,
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0 , right: 16),
                                  child: Text(
                                    widget.creditCardPaymentFailedArgs.failReason ?? "",
                                    textAlign: TextAlign.center,
                                    style: size14weight400.copyWith(
                                        color: colors(context).greyColor),
                                  ),
                                ),
                                16.verticalSpace,
                                Text(
                                  "${AppLocalizations.of(context).translate("lkr")} ${widget.creditCardPaymentFailedArgs.creditCardPaymentArgs.amount}",
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
                                  data: widget.creditCardPaymentFailedArgs.creditCardPaymentArgs.payFrom?.payFromName ?? "-",
                                  subData: widget.creditCardPaymentFailedArgs.creditCardPaymentArgs.payFrom?.payFromNum ?? "-",
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("Pay_To"),
                                  data: widget.creditCardPaymentFailedArgs.creditCardPaymentArgs.payTo?.nickName ?? "-",
                                  subData: widget.creditCardPaymentFailedArgs.creditCardPaymentArgs.payTo?.cardNumber ?? "-",
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("date_&_time"),
                                  data: DateFormat("dd-MMM-yyyy | hh:mm a").format(datetime ?? DateTime.now()),
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("remarks"),
                                  data: widget.creditCardPaymentFailedArgs.creditCardPaymentArgs.remark == null || widget.creditCardPaymentFailedArgs.creditCardPaymentArgs.remark == "" ? "-" :
                                  widget.creditCardPaymentFailedArgs.creditCardPaymentArgs.remark ?? "-",
                                ),
                                FTSummeryDataComponent(
                                  title: AppLocalizations.of(context)
                                      .translate("reference_number"),
                                  data: widget.creditCardPaymentFailedArgs.refNo,
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
        ));
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
