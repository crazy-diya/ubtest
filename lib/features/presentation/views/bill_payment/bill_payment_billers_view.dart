import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/domain/entities/response/biller_entity.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import 'package:union_bank_mobile/features/presentation/views/bill_payment/widgets/bill_payees_component.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';

import '../../../../utils/app_sizer.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/biller_category_entity.dart';
import '../../../domain/entities/response/saved_biller_entity.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/text_fields/app_search_text_field.dart';
import '../base_view.dart';
import 'bill_payment_process_view.dart';

class BillPaymentBillersViewArgs {
  // final int serviceProviderId;
  final chargeAmount;
  final BillerCategoryEntity biller;
  final bool isSaved;
  final List<SavedBillerEntity>? savedBillers;
  final String route;

  // final String referenceSample;
  // final String referencePattern;

  BillPaymentBillersViewArgs({
    required this.biller,
    this.isSaved = false,
    this.savedBillers,
    required this.chargeAmount,
    required this.route,
    // required this.serviceProviderId,
    // required this.referenceSample,
    // required this.referencePattern,
  });
}

class BillPaymentBillersView extends BaseView {
  final BillPaymentBillersViewArgs? billPaymentBillersViewArgs;

  BillPaymentBillersView({this.billPaymentBillersViewArgs});

  @override
  _BillPaymentBillersViewState createState() => _BillPaymentBillersViewState();
}

class _BillPaymentBillersViewState
    extends BaseViewState<BillPaymentBillersView> {
  var _bloc = injection<BillerManagementBloc>();

  List<BillerEntity>? billers;
  List<BillerEntity>? searchBillers;

  @override
  void initState() {
    super.initState();
    billers = widget.billPaymentBillersViewArgs?.biller.billers;
    searchBillers = billers;
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
          title: widget.billPaymentBillersViewArgs!.biller.categoryName!),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {},
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0.h),
            child: Column(
              children: [
                SearchTextField(
                  isBorder: false,
                  hintText: AppLocalizations.of(context).translate("search"),
                  onChange: (p0) {
                    searchist(p0);
                  },
                ),
                24.verticalSpace,
                if (billers?.isNotEmpty == true)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: colors(context).whiteColor),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16).w,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: searchBillers?.length,
                                itemBuilder: (_, index) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    BillPayeesComponent(
                                      billerEntity: searchBillers?[index],
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.kBillPaymentProcessView,
                                          arguments: BillPaymentViewArgs(
                                            route: widget
                                                .billPaymentBillersViewArgs!
                                                .route,
                                            referencePattern:
                                                searchBillers![index]
                                                    .referencePattern!,
                                            referenceSample:
                                                searchBillers![index]
                                                    .referenceSample!,
                                            serviceProviderId:
                                                searchBillers![index].billerId!,
                                            billerEntity: searchBillers![index],
                                            isSaved: false,
                                            billerCategoryEntity: widget
                                                .billPaymentBillersViewArgs!
                                                .biller,
                                            chargeAmount: searchBillers![index]
                                                    .chargeCodeEntity
                                                    ?.chargeAmount ??
                                                0.0,
                                          ),
                                        );
                                      },
                                    ),
                                    if (searchBillers!.length - 1 != index)
                                      Divider(
                                        thickness: 1,
                                        height: 0,
                                        color: colors(context).greyColor100,
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          AppSizer.verticalSpacing(
                              AppSizer.getHomeIndicatorStatus(context)),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void searchist(String message) {
    if (message.trim().isEmpty) {
      searchBillers = billers;
    } else {
      searchBillers = billers
          ?.where((element) =>
              element.billerName!.toLowerCase().contains(message.toLowerCase())).toSet()
          .toList();
    }
    setState(() {});
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
