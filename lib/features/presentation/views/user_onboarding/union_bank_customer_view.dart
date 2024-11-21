import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';

import '../../bloc/splash/splash_bloc.dart';
import '../../widgets/app_button.dart';
import '../base_view.dart';

class UnionBankCustomerView extends BaseView {
  UnionBankCustomerView({Key? key});

  @override
  _UionBankCustomerViewState createState() => _UionBankCustomerViewState();
}

class _UionBankCustomerViewState extends BaseViewState<UnionBankCustomerView> {
  var bloc = injection<SplashBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: UBAppBar(
          goBackEnabled: true,
          isTransparent: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: 0.h + AppSizer.getHomeIndicatorStatus(context)),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                height: 227.h,
                width: double.infinity,
                color: colors(context).primaryColor,
                child: Column(
                  children: [
                     105.verticalSpace,
                    SvgPicture.asset(
                      AppAssets.ubGoLogo,width: 142.35.w,
                    ),
                  ],
                ),
              ),
                  Container(
                    width: double.infinity,
                    height: 12.h,
                    color: colors(context).secondaryColor,
                  ),
                  63.verticalSpace,
                  Center(
                      child: Text(
                    AppLocalizations.of(context).translate("ub_Customer"),
                    style: size24weight700.copyWith(color: colors(context).primaryColor),
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 23.5, right: 23.5).w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    8.verticalSpace,
                    Text(
                      AppLocalizations.of(context)
                          .translate("please_select_your_registration_method"),
                      style: size16weight400.copyWith(color: colors(context).greyColor),
                    ),
                    28.verticalSpace,
                    AppButton(
                        buttonType: ButtonType.OUTLINEENABLED,
                        buttonText: AppLocalizations.of(context)
                            .translate("union_bank_account"),
                        onTapButton: () {
                          Navigator.pushNamed(
                              context, Routes.kUbRegisterDetailsView);
                        }),
                    1.5.verticalSpace,
                    // AppButton(
                    //     buttonType: ButtonType.OUTLINEENABLED,
                    //     buttonText: AppLocalizations.of(context)
                    //         .translate("ub_debit_card"),
                    //     onTapButton: () {
                    //       Navigator.pushNamed(
                    //           context, Routes.kUbRegisterDebitCardDetailsView);
                    //     }),
                    // 1.5.verticalSpace,
                  ],
                ),
              )
            ],
          ),
        ));
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
