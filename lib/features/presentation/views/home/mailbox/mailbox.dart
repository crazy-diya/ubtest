import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/mailbox_view.dart';

class Mailbox extends BaseView {
  Mailbox({Key? key}) : super(key: key);

  @override
  State<Mailbox> createState() => _MailboxState();
}

class _MailboxState extends BaseViewState<Mailbox> {
  var bloc = injection<SplashBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: MailBoxView()
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
