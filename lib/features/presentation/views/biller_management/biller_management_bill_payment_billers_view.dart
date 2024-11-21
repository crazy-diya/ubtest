import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/biller_category_entity.dart';
import '../../../domain/entities/response/biller_entity.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/appbar.dart';
import '../../widgets/text_fields/app_search_text_field.dart';
import 'add_biller_view.dart';
import '../bill_payment/widgets/bill_payees_component.dart';

class BillerManagementViewArgs {
  final BillerCategoryEntity biller;
  final bool isSaved;
  String routeType;
  BillerManagementViewArgs({required this.biller, this.isSaved = false,required this.routeType});

}
class BillerMnagementBillPaymentBillerView extends BaseView {
  final BillerManagementViewArgs? billerViewArgs;

  BillerMnagementBillPaymentBillerView({this.billerViewArgs});

  @override
  _BillerMnagementBillPaymentBillerViewState createState() => _BillerMnagementBillPaymentBillerViewState();
}

class _BillerMnagementBillPaymentBillerViewState extends BaseViewState<BillerMnagementBillPaymentBillerView> {
  var _bloc = injection<BillerManagementBloc>();
  List<BillerEntity> filteredBillers = [];
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    filteredBillers = widget.billerViewArgs!.biller.billers!;
  }


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(title: widget.billerViewArgs!.biller.categoryName!),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc, BaseState<BillerManagementState>>(
          listener: (context, state) {},
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
            child: Column(
              children: [
                24.verticalSpace,
                SearchTextField(
                  textEditingController: searchController,
                  hintText: AppLocalizations.of(context).translate("search"),
                  isBorder: false,
                  onChange: _onSearchTextChanged,
                ),
                24.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8).r,
                    color: colors(context).whiteColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16,0,16,0).w,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: filteredBillers.length,
                      itemBuilder: (_, index) => Column(
                        children: [
                          BillPayeesComponent(
                            billerEntity: filteredBillers[index],
                            onTap: () {
                              Navigator.pushNamed(context,
                                Routes.kAddBillerView,
                                //arguments: BillPaymentViewArgs(billerEntity: widget.biller.billers[index],isSaved: true),
                                arguments: AddBillerViewArgs(
                                    billerCategoryEntity: widget.billerViewArgs!.biller,
                                    isSaved: true,
                                    billerEntity: widget.billerViewArgs!.biller.billers![index],
                                    routeType: widget.billerViewArgs!.routeType),
                              );
                            },
                          ),
                          if(filteredBillers.length-1 != index)
                            Divider(
                              height: 0,
                              thickness: 1,
                              color: colors(context).greyColor100,
                            )
                        ],
                      ),
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




  void _onSearchTextChanged(String searchText) {
    setState(() {
      filteredBillers = widget.billerViewArgs!.biller.billers!
          .where((biller) => biller.billerName!.toLowerCase().contains(searchText.toLowerCase())).toSet()
          .toList();
    });
  }


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}