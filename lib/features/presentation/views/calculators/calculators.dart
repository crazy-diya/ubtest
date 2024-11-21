import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../bloc/portfolio/portfolio_bloc.dart';
import '../../widgets/appbar.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../base_view.dart';


class CalculatorsView extends BaseView {
  final bool isFromPreLogin;


  CalculatorsView({this.isFromPreLogin = false});

  @override
  State<CalculatorsView> createState() => _CalculatorsViewState();
}

class _CalculatorsViewState extends BaseViewState<CalculatorsView> {
  var bloc = injection<PortfolioBloc>();
  @override
  Widget build(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        widget.isFromPreLogin ?
        Navigator.pop(context, Routes.kPreLoginMenu) : Navigator.pop(context, Routes.kQuickAccessMenuView);
        return true;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          onBackPressed: () {
            widget.isFromPreLogin ?
            Navigator.pop(context, Routes.kPreLoginMenu) : Navigator.pop(context, Routes.kQuickAccessMenuView);
          },
          title: AppLocalizations.of(context).translate("calculators"),
        ),
        body:  Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h ,horizontal: 20.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8).w,
                color: colors(context).whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16).w,
                child: Column(
                  children: [
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).w,
                                  border: Border.all(
                                    color: colors(context).greyColor300 ?? Colors.black
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0).w,
                                  child: PhosphorIcon(PhosphorIcons.user(PhosphorIconsStyle.bold) ,
                                    size: 24.w,
                                    color: colors(context).primaryColor,),
                                ),
                              ),
                              12.horizontalSpace,
                              Text(
                                AppLocalizations.of(context)
                                    .translate("personal_loans"),
                                style: size16weight700.copyWith(color: colors(context).blackColor),
                              ),
                            ],
                          ),
                          PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold) ,
                            color: colors(context).primaryColor,size: 24.w,),
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, Routes.kPersonalLoanView , arguments: widget.isFromPreLogin ? true : false );
                      },
                    ),
                    16.verticalSpace,
                    Divider(
                      height: 0,
                      thickness: 1,
                      color: colors(context).greyColor100,
                    ),
                    16.verticalSpace,
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).w,
                                  border: Border.all(
                                      color: colors(context).greyColor300 ?? Colors.black
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20).w,
                                  child: PhosphorIcon(PhosphorIcons.houseLine(PhosphorIconsStyle.bold) ,
                                    color: colors(context).primaryColor, size: 24.w,),
                                ),
                              ),
                              12.horizontalSpace,
                              Text(
                                AppLocalizations.of(context)
                                    .translate("housing_loans"),
                                style: size16weight700.copyWith(color: colors(context).blackColor),
                              ),
                            ],
                          ),
                          PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold) ,
                            color: colors(context).primaryColor,),
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, Routes.kHousingLoanCalculatorView,arguments: widget.isFromPreLogin ? true : false);
                      },
                    ),
                    16.verticalSpace,
                    Divider(
                      height: 0,
                      thickness: 1,
                      color: colors(context).greyColor100,
                    ),
                    16.verticalSpace,
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).w,
                                  border: Border.all(
                                      color: colors(context).greyColor300 ?? Colors.black
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20).w,
                                  child: PhosphorIcon(PhosphorIcons.chartLineUp(PhosphorIconsStyle.bold) ,
                                    color: colors(context).primaryColor,size: 24,),
                                ),
                              ),
                              12.horizontalSpace,
                              Text(
                                AppLocalizations.of(context)
                                    .translate("fixed_deposits"),
                                style: size16weight700.copyWith(color: colors(context).blackColor),
                              ),
                            ],
                          ),
                          PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold) ,
                            color: colors(context).primaryColor,),
                        ],
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, Routes.kFixedDepositView,arguments: widget.isFromPreLogin ? true : false);
                      },
                    ),
                    // 1.9.verticalSpace,
                    // Divider(
                    //   thickness: 1,
                    //   color: colors(context).greyColor100,
                    // ),
                    // 1.9.verticalSpace,
                    // InkWell(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Container(
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(2).w,
                    //               border: Border.all(
                    //                   color: colors(context).greyColor300 ?? Colors.black
                    //               ),
                    //             ),
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(5.0).w,
                    //               child: PhosphorIcon(PhosphorIcons.carProfile(PhosphorIconsStyle.bold) ,
                    //                 color: colors(context).primaryColor,),
                    //             ),
                    //           ),
                    //           2.4.horizontalSpace,
                    //           Text(
                    //             AppLocalizations.of(context)
                    //                 .translate("leasing"),
                    //             style: size16weight700.copyWith(color: colors(context).blackColor),
                    //           ),
                    //         ],
                    //       ),
                    //       PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold) ,
                    //         color: colors(context).primaryColor,),
                    //     ],
                    //   ),
                    //   onTap: (){
                    //     Navigator.pushNamed(context, Routes.kLeasingCalculatorView, arguments: widget.isFromPreLogin ? true : false );
                    //   },
                    // ),
                  ],
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

  @override
  Widget buildView(BuildContext context) {
    // TODO: implement buildView
    throw UnimplementedError();
  }
}
