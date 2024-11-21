import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/pre_login/contact_us/contact_us_state.dart';
import 'package:union_bank_mobile/features/presentation/views/contact_us/widget/contatct_details_row.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_extensions.dart';
import '../../../../utils/app_sizer.dart';
import '../../bloc/pre_login/contact_us/contact_us_bloc.dart';
import '../../bloc/pre_login/contact_us/contact_us_event.dart';
import '../../widgets/appbar.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class ContactUsView extends BaseView {
  @override
  _ContactUsViewState createState() => _ContactUsViewState();
}

class _ContactUsViewState extends BaseViewState<ContactUsView> {
  final ContactUsBloc _contactUsBloc = injection<ContactUsBloc>();
  String generalContact = "";
  String address = "";
  String companyName = "";
  String callCenterContact = "";
  String faxNumber = "";
  String webURL = "";
  String mailURL = "";
  String linkdinURL = '';
  String facebookURL = '';
  String twitterURL = '';
  String instagramURL = '';


  @override
  void initState() {
    _contactUsBloc.add(ContactUsEvent());
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        appBar:  UBAppBar(
          title:AppLocalizations.of(context).translate("contact_us"),
          goBackEnabled: true,
        ),
        body: BlocProvider(
          create: (_) => _contactUsBloc,
          child: BlocListener<ContactUsBloc, BaseState<ContactUsState>>(
            listener: (context, state) {
              if (state is ContactUsSuccessState) {
                setState(() {
                  callCenterContact = state.contactUsDetails!
                      .firstWhere((element) => element.code == 'CALL_CENTER_TEL_NO')
                      .value!;
                  facebookURL = state.contactUsDetails!
                      .firstWhere((element) => element.code == 'FACEBOOK')
                      .value!;
                  linkdinURL = state.contactUsDetails!
                      .firstWhere((element) => element.code == 'LINKEDIN')
                      .value!;

                  twitterURL = state.contactUsDetails!
                      .firstWhere((element) => element.code == 'TWITTER')
                      .value!;
                  instagramURL = state.contactUsDetails!
                      .firstWhere((element) => element.code == 'INSTAGRAM')
                      .value!;
                  faxNumber = state.contactUsDetails!
                      .firstWhere((element) => element.code == 'FAX')
                      .value!;
                  // address = state.contactUsDetails!
                  //     .firstWhere((element) => element.code == 'ADDRESS')
                  //     .value!;
                  generalContact = state.contactUsDetails!
                      .firstWhere((element) => element.code == 'GENERAL_TEL_NO')
                      .value!;
                   mailURL= state.contactUsDetails!
                      .firstWhere((element) => element.code == 'EMAIL')
                      .value!;
                   webURL= state.contactUsDetails!
                      .firstWhere((element) => element.code == 'WEB')
                      .value!;

                });
              } else if (state is ContactUsFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message?? AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
              }
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(35.w,50,35.w, (20.h + AppSizer.getHomeIndicatorStatus(context))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.unionBankLogo,
                            width: 243.w,
                          ),
                           26.verticalSpace,
                          SvgPicture.asset(
                            AppAssets.unionBankMotto,
                            width: 165.w,
                          ),
                        ],
                      ),
                    ),
                     45.56.verticalSpace,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate("connect_with_us"),
                          style: size18weight700.copyWith(
                            color: colors(context).blackColor,
                          ),
                        ),
                        8.verticalSpace,
                        ContatctDetailsRow(
                            onTap: () {
                              _launchCaller(int.parse(
                                  generalContact.replaceAll(' ', '')));
                            },
                            text: 'general_contact_number',
                            contact: formatMobileNumber(generalContact)),
                        16.verticalSpace,
                        ContatctDetailsRow(
                          onTap: () {
                          _launchCaller(
                              int.parse(callCenterContact.replaceAll(' ', '')));
                        },
                            text: 'call_center_contact_number',
                            contact: formatMobileNumber(callCenterContact)),
                          16.verticalSpace,
                        ContatctDetailsRow(
                            text: 'call_center_fax_number',
                            contact: formatMobileNumber(faxNumber)),
                         32.verticalSpace,
                         Text(
                          AppLocalizations.of(context)
                              .translate("web_and_email"),
                          style: size18weight700.copyWith(
                            color: colors(context).blackColor,
                          ),
                        ),
                        8.verticalSpace,
                        Row(
                          children: [
                            PhosphorIcon(PhosphorIcons.globe(PhosphorIconsStyle.regular),color: colors(context).primaryColor,),
                           8.horizontalSpace,
                            InkWell(
                              onTap: () {
                                _launchWebsiteUrl("https://$webURL");
                              },
                              child: Text(
                                webURL,
                                style: size16weight700.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 4,
                                  color: colors(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                         16.verticalSpace,
                        Row(
                          children: [
                            PhosphorIcon(PhosphorIcons.envelope(PhosphorIconsStyle.regular),color: colors(context).primaryColor,),
                           8.horizontalSpace,
                            InkWell(
                              onTap: () {
                                 _launchEmail(mailURL);
                              },
                              child: Text(
                                mailURL,
                                style: size16weight700.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 4,
                                  color: colors(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                         32.verticalSpace,
                        Text(
                          AppLocalizations.of(context)
                              .translate("engage_with_social_media"),
                          style: size18weight700.copyWith(
                            color: colors(context).blackColor,
                          ),
                        ),
                        8.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            
                            InkWell(
                              onTap: () {
                                _launchSocialUrl(facebookURL);
                              },
                              child: PhosphorIcon(PhosphorIcons.facebookLogo(PhosphorIconsStyle.regular),color: colors(context).primaryColor,size: 32.w,),
                            ),
                            27.horizontalSpace,
                            InkWell(
                              onTap: () {
                                _launchSocialUrl(linkdinURL);
                              },
                              child: PhosphorIcon(PhosphorIcons.linkedinLogo(PhosphorIconsStyle.regular),color: colors(context).primaryColor,size: 32.w,),
                            ),
                              27.horizontalSpace,
                            InkWell(
                              onTap: () {
                                _launchSocialUrl(instagramURL);
                              },
                              child: PhosphorIcon(PhosphorIcons.instagramLogo(PhosphorIconsStyle.regular),color: colors(context).primaryColor,size: 32.w,),
                            ),
                              27.horizontalSpace,
                            InkWell(
                                onTap: () {
                                  _launchSocialUrl(twitterURL);
                                },
                                child:  SvgPicture.asset(
                                  colorFilter: ColorFilter.mode(
                                      colors(context).primaryColor!,
                                      BlendMode.srcIn),
                                  AppAssets.xLogo,
                                  width: 32.w,
                                )
                             
                            //  PhosphorIcon(PhosphorIcons.xLogo(PhosphorIconsStyle.regular),color: colors(context).primaryColor,size: 8.w,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _contactUsBloc;
  }

  _launchWebsiteUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    } else {
      throw 'Cannot direct to $url';
    }
  }

  _launchSocialUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
    } else {
      throw 'Cannot direct to $url';
    }
  }

  _launchEmail(String emailId) async {
    var url = 'mailto:${emailId.toString()}';
    if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    } else {
      throw 'Cannot direct to $url';
    }
  }

  _launchCaller(int number) async {
    var url = 'tel:${number.toString()}';
    if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
    } else {
      throw 'Cannot direct to $url';
    }
  }
}


