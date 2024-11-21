import 'package:flutter/material.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/notifications/notifications_view.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../bloc/splash/splash_bloc.dart';

class NotificationView extends BaseView {
  NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends BaseViewState<NotificationView> {
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
      body: NotificationsView()


      // Center(
      //   child: Text('Notification'),
      // ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
