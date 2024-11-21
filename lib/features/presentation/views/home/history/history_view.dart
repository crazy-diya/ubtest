import 'package:flutter/material.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/transaction_history/transaction_history_view.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../bloc/splash/splash_bloc.dart';

class HistoryView extends BaseView {
  HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends BaseViewState<HistoryView> {
  var bloc = injection<SplashBloc>();

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {});
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: TransactionHistoryFlowView()


      // Center(
      //   child: Text('History'),
      // ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
