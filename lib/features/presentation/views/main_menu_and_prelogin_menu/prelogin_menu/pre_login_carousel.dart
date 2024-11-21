import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/main_menu_and_prelogin_menu/prelogin_menu/prelogin_menu_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/app_assets.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../login_view/widgets/pre_login_menu_button.dart';

class PreLogin {
  final String ?title;
  final IconData? icon;
   final bool? isSvg;
  final String? svg;

  PreLogin({this.title, this.icon, this.isSvg = false, this.svg});
}

List<PreLogin> preLoginMenuItems = [
  PreLogin(title: 'rates', icon:  PhosphorIcons.chartBar(PhosphorIconsStyle.bold)),
  PreLogin(title:'contact_us', icon: PhosphorIcons.phone(PhosphorIconsStyle.bold)),
  PreLogin(title:'promotions', icon: PhosphorIcons.sealCheck(PhosphorIconsStyle.bold)),
  PreLogin(title:'locations',icon:  PhosphorIcons.mapPinLine(PhosphorIconsStyle.bold)),
  PreLogin(title:'calculator', svg: AppAssets.quickCalculator ,isSvg: true),
  PreLogin(title:'Help_support',icon:  PhosphorIcons.info(PhosphorIconsStyle.bold)),
  PreLogin(title:'news', icon: PhosphorIcons.newspaper(PhosphorIconsStyle.bold)),
  PreLogin(title:'trainTickets',icon: PhosphorIcons.train(PhosphorIconsStyle.bold)),
  PreLogin(title:'demo_tour',icon: PhosphorIcons.video(PhosphorIconsStyle.bold)),
  // PreLogin('schedule', AppImages.icContactUs),
  // PreLogin('pay_to_mobile', AppImages.icContactUs),
  // PreLogin('request_money', AppImages.icFAQ),
  // PreLogin('portfolio', AppImages.icFAQ),
  // PreLogin('notifications', AppImages.icFAQ),
  // PreLogin('transaction_history', AppImages.icFAQ),
  // PreLogin('payee_management', AppImages.icFAQ),

];

class PreLoginCarousel extends StatelessWidget {
  final String _urlRates = '';

  final String _urlCalculators = '';

  const PreLoginCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      extendBodyBehindAppBar: true,
      body: PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
      if (didPop) return;
          Navigator.pushReplacementNamed(context, Routes.kLoginView);
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.mainMenuBackgroundImage),
              fit: BoxFit.fitWidth,
            ),),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 92.03.h),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.ubGoSplashLogo,
                    width: 102.47.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 68.00.h),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.only(left: 14, right:  14).w,
                  itemCount: preLoginMenuItems.length,
                  itemBuilder: _buildMenuItem,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,childAspectRatio: 1,
                    mainAxisSpacing: 20.h
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PreLoginMenuButton(
                    width: 70,
                    height: 42,
                    isClose: true,
                    onTap: () {
                      Navigator.pop(context, Routes.kLoginView);
                      // Navigator.pop(context);
                    },
                  ),
                ),
              ),
              20.verticalSpace,
              AppSizer.verticalSpacing(AppSizer.getHomeIndicatorStatus(context))
            ],
          ),
        ),
      )
    );
  }

  Widget _buildMenuItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, Routes.kRatesView);
            break;
          case 1:
            Navigator.pushNamed(context, Routes.kContactUsView);
            break;

          case 2:
            Navigator.pushNamed(context, Routes.kPromotionsOffersView, arguments: true,);
            break;
          case 3:
            Navigator.pushNamed(context, Routes.kMapLocatorView);

            break;
          case 4:
            // _launchUrl(_urlCalculators);
            Navigator.pushNamed(context, Routes.kCalculatorsView, arguments: true);
            break;
          case 5:
            Navigator.pushNamed(context, Routes.kFAQView);
            break;
          case 6:
            Navigator.pushNamed(context, Routes.kNewsFeed);
            break;
          case 7:
            Navigator.pushNamed(context, Routes.kTrainTicket);
            break;
          case 8:
            Navigator.pushNamed(context, Routes.kDemoTourView);
            break;

          //   case 8:
          //   Navigator.pushNamed(context, Routes.kPayToMobileView);
          //   break;
          //   case 9:
          //     Navigator.pushNamed(context, Routes.kRequestMoneyView);
          //   break;
          // case 10:
          //   Navigator.pushNamed(context, Routes.kPortfolioView);
          //   break;
          // case 11:
          //   Navigator.pushNamed(context, Routes.kNotificationsView);
          //   break;
          // case 12:
          //   Navigator.pushNamed(context, Routes.kTransactionHistoryFlowView);
          //   break;
          //   case 13:
          //   Navigator.pushNamed(context, Routes.kPayeeManagementSavedPayeeView);
          //   break;

          // case 7:
          //   Navigator.pushNamed(context, Routes.kScheduleCategoryListView);

        }
      },
      highlightColor: colors(context).whiteColor,
      hoverColor: colors(context).whiteColor,
      splashColor: colors(context).secondaryColor,
      borderRadius:  BorderRadius.all(
        Radius.circular(9.5).r,
      ),
      child: PreLoginCarouselItem(
        menuItem: preLoginMenuItems[index],
        index: index,
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
}
