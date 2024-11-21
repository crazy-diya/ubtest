import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../bloc/credit_card_management/credit_card_management_bloc.dart';
import '../../../widgets/appbar.dart';
import '../widgets/credit_card_details_card.dart';
import 'data/credit_card_payment_args.dart';


class CreditCardPaymentCategoryView extends BaseView {
  final List<CreditCardDetailsCard> itemList;


  CreditCardPaymentCategoryView({required this.itemList});

  @override
  State<CreditCardPaymentCategoryView> createState() => _CreditCardPaymentCategoryViewState();
}

class _CreditCardPaymentCategoryViewState extends BaseViewState<CreditCardPaymentCategoryView> {
  final bloc = injection<CreditCardManagementBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("credit_card_payment"),
        goBackEnabled: true,
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: colors(context).whiteColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0).w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.kCreditCardPaymentView, arguments: CreditCardPaymentArgs(creditCardPaymentType: CreditCardPaymentType.OWN , itemList: widget.itemList));
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 48.w,
                                  width: 48.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).whiteColor,
                                      border: Border.all(
                                          color: colors(context).greyColor300 ??
                                              Colors.black // Border width
                                      )),
                                  child: PhosphorIcon(
                                    PhosphorIcons.user(
                                        PhosphorIconsStyle.bold),
                                    color: colors(context).primaryColor,
                                  ),
                                ),
                                12.horizontalSpace,
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("pay_own_credit_card"),
                                  style: size16weight700.copyWith(
                                      color: colors(context).blackColor),
                                ),
                                const Spacer(),
                                PhosphorIcon(
                                  PhosphorIcons.caretRight(
                                      PhosphorIconsStyle.bold),
                                  color: colors(context).greyColor300,
                                )
                              ],
                            ),
                          ),
                          16.verticalSpace,
                          Divider(
                            thickness: 1,
                            color: colors(context).greyColor100,
                            height: 0,
                          ),
                          16.verticalSpace,
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.kCreditCardPaymentView, arguments: CreditCardPaymentArgs(creditCardPaymentType: CreditCardPaymentType.THIRDPARTY , itemList: widget.itemList));
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                 decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8).r,
                                            border: Border.all(
                                                color: colors(context)
                                                    .greyColor300!)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8).r,
                                    child: Image.asset(
                                      AppAssets.ubBank,
                                      width: 32,
                                      height: 32,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                12.horizontalSpace,
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("pay_third_party_ub"),
                                  style: size16weight700.copyWith(
                                      color: colors(context).blackColor),
                                ),
                                const Spacer(),
                                PhosphorIcon(
                                  PhosphorIcons.caretRight(
                                      PhosphorIconsStyle.bold),
                                  color: colors(context).greyColor300,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
