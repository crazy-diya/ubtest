import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import '../../../utils/app_sizer.dart';
import '../../../utils/navigation_routes.dart';
import '../views/login_view/widgets/pre_login_menu_button.dart';

class HomeBottomNavigationView extends StatefulWidget {
  final Function()? onHomeTab;
  final Function()? onHistoryTap;
  final Function()? onNavMenuTap;
  final Function()? onMailBoxTap;
  final Function()? onSettingsTap;
  final bool isCloseSelected;

  const HomeBottomNavigationView(
      {super.key,
      this.onHomeTab,
      this.onHistoryTap,
      this.onNavMenuTap,
      this.onMailBoxTap,
      this.onSettingsTap,
      required this.isCloseSelected});

  @override
  State<HomeBottomNavigationView> createState() =>
      _HomeBottomNavigationViewState();
}

class _HomeBottomNavigationViewState extends State<HomeBottomNavigationView> {
  @override
  int _selectedIndex = 0;

  void _toggleClickState(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      height: 68 +  AppSizer.getHomeIndicatorStatus(context), // Set the desired height for the Row
      decoration: BoxDecoration(
        color: colors(context).whiteColor,
        boxShadow: [
        BoxShadow(
              color: colors(context).blackColor!.withOpacity(0.12),
              blurRadius:44,
              spreadRadius: 0,
              offset: Offset(0, -6)
            ),
    
      ]
      
      ),
      child: Row(
        children: [
    
          Expanded(
            child: Stack(
              // alignment: Alignment.,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: _selectedIndex == 0
                              ? Container(
                              width: 60,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: colors(context).primaryColor),
                                                            )
                              : SizedBox.shrink(),
                ),
                Align(
                   alignment: Alignment.center,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.onHomeTab;
                          _toggleClickState(0);
                        });
                        widget.onHomeTab!();
                      },
                      //widget.onHomeTab,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _selectedIndex == 0
                              ? PhosphorIcon(
                                  PhosphorIcons.house(PhosphorIconsStyle.bold),
                                  color: colors(context).primaryColor,
                                  size: 24,
                                ) 
                              : PhosphorIcon(
                                  PhosphorIcons.house(PhosphorIconsStyle.bold),
                                  color: colors(context).greyColor,
                                  size: 24,
                                ),
                          AppSizer.verticalSpacing(4),
                           Text(AppLocalizations.of(context).translate("home"),
                           textAlign: TextAlign.center,
                              style:  size12weight400.copyWith(color:  _selectedIndex == 0?  colors(context).primaryColor:colors(context).greyColor) ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                 Align(
                  alignment: Alignment.topCenter,
                   child: _selectedIndex == 1
                                ? Container(
                                width: 60,
                                height: 4,
                                decoration: BoxDecoration(
                                    color: colors(context).primaryColor),
                                                              )
                                : SizedBox.shrink(),
                 ),
                 Align(
                   alignment: Alignment.center,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.onHistoryTap;
                          _toggleClickState(1);
                        });
                        widget.onHistoryTap!();
                      },
                      //widget.onHistoryTap,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _selectedIndex == 1
                              ? PhosphorIcon(
                                  PhosphorIcons.article(PhosphorIconsStyle.bold),
                                  color: colors(context).primaryColor,
                                  size: 24,
                                ) 
                              : PhosphorIcon(
                                  PhosphorIcons.article(PhosphorIconsStyle.bold),
                                  color: colors(context).greyColor,
                                  size: 24,
                                ),
                          AppSizer.verticalSpacing(4),
                           Text(AppLocalizations.of(context).translate("activity_log_"),
                            textAlign: TextAlign.center,
                              style:  size12weight400.copyWith(color:  _selectedIndex == 1?  colors(context).primaryColor:colors(context).greyColor) ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:  EdgeInsets.only(top: 6.5),
              child: PreLoginMenuButton(
                  onTap: (){
                    Navigator.pushNamed(context, Routes.kQuickAccessCarousel);
                    //QuickAccessMenuView();
                  }),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                   child: _selectedIndex == 2
                                ? Container(
                                 width: 60,
                              height: 4,
                                decoration: BoxDecoration(
                                    color: colors(context).primaryColor),
                                                              )
                                : SizedBox.shrink(),
                 ),
                Align(
                   alignment: Alignment.center,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.onMailBoxTap;
                          _toggleClickState(2);
                        });
                        widget.onMailBoxTap!();
                      },
                      //widget.onNotificationTap,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          StreamBuilder<int>(
                            stream: AppConstants.unreadMailCount.stream,
                            builder: (context, snapshot) {
                                return Stack(
                                  children: [
                                    _selectedIndex == 2
                                        ?  PhosphorIcon(
                                                PhosphorIcons.envelopeSimple(PhosphorIconsStyle.bold),
                                                color: colors(context).primaryColor,
                                                size: 24,
                                              )
                                            : PhosphorIcon(
                                                  PhosphorIcons.envelopeSimple(PhosphorIconsStyle.bold),
                                                  color: colors(context).greyColor,
                                                  size: 24,
                                                ),
                                   if ((snapshot.data??0) > 0)
                                      Positioned(
                                        right: 0,
                                        top: 1.5,
                                          child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(color: colors(context).secondaryColor,shape: BoxShape.circle),
                                      )),
                                  ],
                                );
                                
                                    
                              }),
                          AppSizer.verticalSpacing(4),
                           Text(AppLocalizations.of(context).translate("mail_box"),
                            textAlign: TextAlign.center,
                              style:  size12weight400.copyWith(color:  _selectedIndex == 2?  colors(context).primaryColor:colors(context).greyColor) ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
               Align(
                  alignment: Alignment.topCenter,
                   child: _selectedIndex == 3
                                ? Container(
                                 width: 60,
                              height: 4,
                                decoration: BoxDecoration(
                                    color: colors(context).primaryColor),
                                                              )
                                : SizedBox.shrink(),
                 ),
                Align(
                   alignment: Alignment.center,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.onSettingsTap;
                          _toggleClickState(3);
                        });
                        widget.onSettingsTap!();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        _selectedIndex == 3
                              ? PhosphorIcon(
                                  PhosphorIcons.gear(PhosphorIconsStyle.bold),
                                  color: colors(context).primaryColor,
                                  size: 24,
                                ) 
                              : PhosphorIcon(
                                  PhosphorIcons.gear(PhosphorIconsStyle.bold),
                                  color: colors(context).greyColor,
                                  size: 24,
                                ),
                          AppSizer.verticalSpacing(4),
                           Text(AppLocalizations.of(context).translate("settings"),
                            textAlign: TextAlign.center,
                              style: size12weight400.copyWith(color:  _selectedIndex == 3?  colors(context).primaryColor:colors(context).greyColor) ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
