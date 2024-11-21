
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/on_boarding/contact_information/contact_information_bloc.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_scroll_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../bloc/on_boarding/tnc/tnc_bloc.dart';
import '../../base_view.dart';



class HomeJustPayTnCView extends BaseView {
  final String termsData;

  HomeJustPayTnCView({required this.termsData});

  @override
  _HomeJustPayTnCViewState createState() => _HomeJustPayTnCViewState();
}

class _HomeJustPayTnCViewState extends BaseViewState<HomeJustPayTnCView> {
  final _bloc = injection<ContactInformationBloc>();
  final TnCBloc tncbloc = injection<TnCBloc>();
  final ScrollController scrollController = ScrollController();

  String _termsData = '';
 

  @override
  void initState() {
    super.initState();
    _termsData =  widget.termsData;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("other_bank_account"),
        goBackEnabled: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)
                  .translate("terms_and_conditions"),
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: AppScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Html(
                    onLinkTap: (url, attributes, element) {
                      _launchUrl(url);
                    },
                    data: _termsData,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
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
    return _bloc;
  }
}
