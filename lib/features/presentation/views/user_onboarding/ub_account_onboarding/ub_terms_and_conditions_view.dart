import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_scroll_bar.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../bloc/on_boarding/tnc/tnc_bloc.dart';
import '../../../bloc/on_boarding/tnc/tnc_event.dart';
import '../../../bloc/on_boarding/tnc/tnc_state.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';

class TermsArgs {
  final String? termsType;
  final String? viewType;
  final String? appBarTitle;

  TermsArgs({this.termsType, this.viewType, this.appBarTitle});
}

class UBAccountTnCView extends BaseView {
  final TermsArgs termsArgs;

  UBAccountTnCView({required this.termsArgs});

  @override
  _UBAccountTnCViewState createState() => _UBAccountTnCViewState();
}

class _UBAccountTnCViewState extends BaseViewState<UBAccountTnCView> {
  final bloc = injection<TnCBloc>();
  final ScrollController scrollController = ScrollController();

  String _termsData = '';
  int _termID = 0;
  ButtonType _acceptButtonType = ButtonType.PRIMARYDISABLED;

  @override
  void initState() {
    bloc.add(GetTermsEvent(termType: widget.termsArgs.termsType));
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        _acceptButtonType = ButtonType.PRIMARYENABLED;
      });
    }
    final currentScroll = scrollController.position.pixels;
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context)
            .translate(widget.termsArgs.appBarTitle!),
        goBackEnabled: true,
      ),
      body: BlocProvider<TnCBloc>(
        create: (context) => bloc,
        child: BlocListener<TnCBloc, BaseState<TnCState>>(
          listener: (context, state) {
            if (state is TermsLoadedState) {
              showProgressBar();
              setState(() {
                _termsData = state.termsData!.termBody != null
                    ? state.termsData!.termBody!
                    : '';
                _termID = state.termsData!.termId!;
                termIdAll = state.termsData!.termId!;
                _acceptButtonType = ButtonType.PRIMARYENABLED;
              });
              hideProgressBar();
            }
            else if (state is TermsSubmittedState) {
              if (widget.termsArgs.termsType!.isNotEmpty) {
                Navigator.pop(context, true);
              } else {}
            }
            else if (state is TermsFailedState) {
              hideProgressBar();
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.w,0.h,10.w,20.h + AppSizer.getHomeIndicatorStatus(context) ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Html(
                        data: _termsData,
                        onLinkTap: (url, attributes, element) {
                          _launchUrl(url);
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0.w , right: 10.w),
                  child: Column(
                    children: [
                      20.verticalSpace,
                      AppButton(
                        buttonType:
                            _acceptButtonType == ButtonType.PRIMARYDISABLED
                                ? ButtonType.PRIMARYDISABLED
                                : ButtonType.PRIMARYENABLED,
                        buttonText:
                            AppLocalizations.of(context).translate("agree"),
                        onTapButton: () {
                          bloc.add(AcceptTermsEvent(
                            isMigrated:"",
                              termType: kGeneralTerms,
                              acceptedDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(DateTime.now()),
                              termId: _termID));
                        },
                      ),
                      16.verticalSpace,
                      AppButton(
                        buttonType: ButtonType.OUTLINEENABLED,
                        buttonText:
                            AppLocalizations.of(context).translate("Decline"),
                        onTapButton: () {
                          showAppDialog(
                            title: AppLocalizations.of(context)
                                .translate("Decline_Terms_&_Conditions"),
                            alertType: AlertType.DOCUMENT1,
                            message: AppLocalizations.of(context)
                                .translate("manage_instrument_terms_decline"),
                            positiveButtonText:
                                AppLocalizations.of(context).translate("yes_decline"),
                            negativeButtonText:
                                AppLocalizations.of(context).translate("no"),
                            onPositiveCallback: () {
                              Navigator.of(context).popUntil(ModalRoute.withName(
                                  Routes.kRegistrationMethodView));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
