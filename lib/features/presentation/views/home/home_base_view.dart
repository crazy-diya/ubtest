import 'dart:io';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import 'package:flutter/material.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/portfolio/portfolio_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/portfolio/portfolio_event.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/home/history/history_view.dart';
import 'package:union_bank_mobile/features/presentation/views/home/home/home_view.dart';
import 'package:union_bank_mobile/features/presentation/views/home/mailbox/mailbox.dart';

import 'package:union_bank_mobile/features/presentation/widgets/home_bottom_nav.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/enums.dart';
import 'settings_view/setting_password_view.dart';

class HomeBaseView extends BaseView {
  HomeBaseView({Key? key}) : super(key: key);

  @override
  State<HomeBaseView> createState() => _HomeBaseViewState();
}

enum Page { HOME, HISTORY, MENU, MAILBOX, SETTINGS }

class _HomeBaseViewState extends BaseViewState<HomeBaseView> {
  final bloc = injection<PortfolioBloc>();
  Page page = Page.HOME;
  int tapCount = 0;

  @override
  void initState() {
    bloc.add(GetMailCountEvent());
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {});
  }

  void onHomeClicked() {
    setState(() {
      page = Page.HOME;
    });
  }

  void onHistoryClicked() {
    setState(() {
      page = Page.HISTORY;
    });
  }

  // void onMenuClicked() {
  //   setState(() {
  //     page = Page.MENU;
  //   });
  //   //Navigator.pop(context);
  // }

  void onMailboxClicked() {
    setState(() {
      page = Page.MAILBOX;
    });
  }

  void onSettingsClicked() {
    setState(() {
      page = Page.SETTINGS;
    });
  }

  @override
  Widget buildView(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;
        if (tapCount == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(AppLocalizations.of(context).translate("tap_back_to_leave")),
            ),
          );
          tapCount++;
        } else {
          showAppDialog(
            title: AppLocalizations.of(context).translate("Exit"),
            alertType: AlertType.INFO,
            message: AppLocalizations.of(context).translate("log_out_app_message"),
            positiveButtonText:
                AppLocalizations.of(context).translate("Yes_Leave"),
            negativeButtonText: AppLocalizations.of(context).translate("no"),
            onPositiveCallback: () {
              exit(0);
            },
          );
        }
      },
      child: Scaffold(
        bottomNavigationBar: HomeBottomNavigationView(
                onHomeTab: onHomeClicked,
                onHistoryTap: onHistoryClicked,
                //onNavMenuTap: onMenuClicked,
                onMailBoxTap: onMailboxClicked,
                onSettingsTap: onSettingsClicked,
                isCloseSelected: page == Page.MENU,
              ),
        body: DoubleBackToCloseApp(
          snackBar:  SnackBar(
            content: Text(AppLocalizations.of(context).translate("tap_back_to_leave")),
          ),
          child: Column(
            children: [
              if (page == Page.HOME) ...[Expanded(child: HomeView())],
              if (page == Page.HISTORY) ...[Expanded(child: HistoryView())],
              if (page == Page.MAILBOX) ...[Expanded(child: Mailbox())],
              if (page == Page.SETTINGS) ...[Expanded(child: SettingPasswordView(isFromHome: false,))],
            ],
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
