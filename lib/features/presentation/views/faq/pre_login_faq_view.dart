import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_search_text_field.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../domain/entities/faq_entity.dart';
import '../../bloc/pre_login/faq/faq_bloc.dart';
import '../../bloc/pre_login/faq/faq_event.dart';
import '../../bloc/pre_login/faq/faq_state.dart';
import '../../widgets/appbar.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class FAQView extends BaseView {
  @override
  _FAQViewState createState() => _FAQViewState();
}

class _FAQViewState extends BaseViewState<FAQView> {
  //var bloc = injection<SplashBloc>();

  final bloc = injection<FaqBloc>();

  String publicUrl = '';
  List<FAQEntity> faqList = [];
  List<FAQEntity> searchFaqList = [];

  @override
  void initState() {
    super.initState();
    setState(() {});
    bloc.add(GetFaqEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
       backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("Help_support"),
        goBackEnabled: true,
      ),
      body: BlocProvider<FaqBloc>(
        create: (_) => bloc,
        child: BlocListener<FaqBloc, BaseState<FaqState>>(
          bloc: bloc,
          listener: (_ , state) {
            if (state is FaqSuccessState) {
              setState(() {
                publicUrl = state.publicLink!;
                faqList.clear();
                faqList.addAll(state.faqData!
                    .map((e) => FAQEntity(isExpanded: false,
                    faqBody: e.answer!, faqHeader: e.question!, faqId: e.id!))
                    .toList());
                searchFaqList = faqList;
              });
            } else if (state is FaqFailState) {
              ToastUtils.showCustomToast(
                  context, state.errorMessage!, ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding:  EdgeInsets.fromLTRB(20.w,24.h,20.w,0),
            child: Column(
              children: [
                SearchTextField(
                  isBorder: false,
                  hintText: AppLocalizations.of(context).translate("search"),
                  onChange:  (value) {
                    // searchFaqList.clear();
                    
                     
                      if (value.isEmpty || value == '') {
                        searchFaqList = faqList.map((e) => FAQEntity(
                              faqBody: e.faqBody,
                              faqId: e.faqId,
                              faqHeader: e.faqHeader,
                              isExpanded: false))
                          .toList();;
                        log(searchFaqList.toString());
                      } else {
                        searchFaqList = faqList
                            .where((element) => element.faqHeader
                                .toLowerCase()
                                .contains(value.toLowerCase())).toSet()
                            .toList();

                           
                            
                          searchFaqList = searchFaqList .map((e) => FAQEntity(
                              faqBody: e.faqBody,
                              faqId: e.faqId,
                              faqHeader: e.faqHeader,
                              isExpanded: false))
                          .toList();
                          log(searchFaqList.toString());
                      }
                    setState(() {});
                  },
                ),
                24.verticalSpace,
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20 + AppSizer.getHomeIndicatorStatus(context)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8).w,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8).w,
                              color: colors(context).whiteColor,),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: searchFaqList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  if (index != 0)
                                    Padding(
                                      padding: const EdgeInsets.symmetric( horizontal: 16) .w,
                                      child: Divider(
                                        thickness: 1,
                                        color: colors(context).greyColor100,
                                      ),
                                    ),
                                  ExpansionTile(
                                    expandedAlignment: Alignment.bottomLeft,
                                    shape: Border(),
                                    onExpansionChanged: (value) {
                                      searchFaqList[index].isExpanded = value;
                      
                                      setState(() {});
                                    },
                                    trailing: PhosphorIcon(
                                       searchFaqList[index].isExpanded == false? PhosphorIcons.caretDown(PhosphorIconsStyle.bold):PhosphorIcons.caretUp(PhosphorIconsStyle.bold),
                                        size: 20.w,
                                        color: colors(context).greyColor300,
                                      ),
                                    title: Text(searchFaqList[index].faqHeader,
                                        style: size16weight700.copyWith(
                                            color: colors(context).blackColor)),
                                    children:[
                                     Padding(
                                        padding:  EdgeInsets.fromLTRB(16.w,8.h,16.w,8.w),
                                        child: Text(
                                          searchFaqList[index].faqBody,
                                          style: size14weight400.copyWith(
                                              color: colors(context).greyColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                             
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchWebsiteUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    } else {
      throw 'Cannot direct to $url';
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
