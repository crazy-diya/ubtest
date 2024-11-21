import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/credit_card_management/credit_card_management_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../widgets/appbar.dart';
import '../widgets/credit_card_details_card.dart';

class SelfCareCategoryListView extends BaseView {
  final List<CreditCardDetailsCard> itemList;


  SelfCareCategoryListView({required this.itemList});

  @override
  State<SelfCareCategoryListView> createState() => _SelfCareCategoryListViewState();
}

class _SelfCareCategoryListViewState extends BaseViewState<SelfCareCategoryListView> {
  final bloc = injection<CreditCardManagementBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("self_care"),
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
                                  context, Routes.kEStatementView , arguments: widget.itemList);
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
                                    PhosphorIcons.fileText(
                                        PhosphorIconsStyle.bold),
                                    color: colors(context).primaryColor,
                                  ),
                                ),
                                12.horizontalSpace,
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("e_statement"),
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
                                  context, Routes.kNewPinRequestView , arguments: widget.itemList);
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
                                    PhosphorIcons.password(
                                        PhosphorIconsStyle.bold),
                                    color: colors(context).primaryColor,
                                  ),
                                ),
                                12.horizontalSpace,
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("new_pin_request"),
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
                                  context, Routes.kLoyaltyManagementView);
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
                                    PhosphorIcons.handCoins(
                                        PhosphorIconsStyle.bold),
                                    color: colors(context).primaryColor,
                                  ),
                                ),
                                12.horizontalSpace,
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("loyalty_management"),
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
                          )
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
