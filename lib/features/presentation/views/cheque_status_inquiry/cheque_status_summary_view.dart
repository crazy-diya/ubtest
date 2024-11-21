import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/calculators/housing_loan_calculator/housing_loan_calculator_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/cheque_status_inquiry/widgets/csi_data_component.dart';
import 'package:union_bank_mobile/features/presentation/views/cheque_status_inquiry/widgets/csi_summary_component.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';

import '../../widgets/appbar.dart';
import '../base_view.dart';
import '../fund_transfer/widgets/fund_transfer_data_component.dart';


class ChequeStatusSummaryView extends BaseView {
  final CSIData? csiData;

  ChequeStatusSummaryView({this.csiData});
  @override
  _ChequeStatusSummaryViewState createState() => _ChequeStatusSummaryViewState();
}

class _ChequeStatusSummaryViewState extends BaseViewState<ChequeStatusSummaryView> {
  var bloc = injection<HousingLoanCalculatorBloc>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate(
            "cheque_status_inquiry"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<HousingLoanCalculatorBloc,
            BaseState<HousingLoanCalculatorState>>(
          bloc: bloc,
          listener: (context, state) {},
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              onChanged: () {
                setState(() {

                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              color: colors(context).greyColor300,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25.0 , right: 25 , top: 25),
                              child: Column(
                                children: [
                                  CSISummeryDataComponent(
                                    title: AppLocalizations.of(context).translate("cheque_number"),
                                    data: widget.csiData?.chequeNumber ?? "-",
                                    isTitle: true,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          FTSummeryDataComponent(
                            title: AppLocalizations.of(context).translate("Account_Number"),
                            data: widget.csiData?.accountNumber ?? "-",
                          ),
                          FTSummeryDataComponent(
                            title: AppLocalizations.of(context).translate("collection_date"),
                            data: widget.csiData?.collectionDate ?? "-",
                          ),
                          FTSummeryDataComponent(
                            title: AppLocalizations.of(context).translate("amount"),
                            isCurrency: true,
                            amount: double.parse(widget.csiData?.amount ?? "0"),
                          ),
                          FTSummeryDataComponent(
                            title: AppLocalizations.of(context).translate("Account_Number"),
                            data: widget.csiData?.accountNumber ?? "-",
                          ),
                          FTSummeryDataComponent(
                            title: AppLocalizations.of(context).translate("branch"),
                            data: widget.csiData?.accountNumber ?? "-",
                          ),
                          FTSummeryDataComponent(
                            title: AppLocalizations.of(context).translate("ref_no"),
                            data: widget.csiData?.accountNumber ?? "-",
                          ),
                          FTSummeryDataComponent(
                            title: AppLocalizations.of(context).translate("category"),
                            data: widget.csiData?.accountNumber ?? "-",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
}