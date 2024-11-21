// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/app_permission.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/views/notifications/notifications_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/rounded_avatar.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/main_menu_and_prelogin_menu/main_menu/main_menu_item.dart';
import 'package:union_bank_mobile/features/presentation/views/payee_manegement/payee_management_save_payee_view.dart';
import 'package:union_bank_mobile/features/presentation/views/login_view/widgets/pre_login_menu_button.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../bloc/splash/splash_bloc.dart';
import '../../base_view.dart';

class MainMenuCarousel extends BaseView {
  MainMenuCarousel({Key? key}) : super(key: key);

  @override
  _MainMenuCarouselState createState() => _MainMenuCarouselState();
}

class _MainMenuCarouselState extends BaseViewState<MainMenuCarousel> {
  var bloc = injection<SplashBloc>();
  final localDataSource = injection<LocalDataSource>();
  int _current = 0;
  int pageGridLength = 0;
  List<QuickAccess> currentList = [];

  double pixelRatio = PlatformDispatcher.instance.views.first.devicePixelRatio;

  @override
  void initState() {
    super.initState();
    Size logicalScreenSize =
        PlatformDispatcher.instance.views.first.physicalSize / pixelRatio;
    pageGridLength = (logicalScreenSize.height) > 700 ? 12 : 9;
    currentList = quickAccessMenuItems();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Column(
            children: [
              Container(
                height: 155.h,
                width: double.infinity,
                color: colors(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 28.h, 30.w, 19.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RoundedAvatarView(
                            backgroundColor: colors(context).primaryColor50!,
                            forgroundColor: colors(context).primaryColor50!,
                            isOnline: false,
                            image: AppConstants.profileData.profileImage,
                           name: AppConstants.profileData.cName??AppConstants.profileData.fName,
                            size: 24.w,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.kSettingPasswordView,
                                  arguments: true);
                            },
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppConstants.profileData.name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: size16weight700.copyWith(
                                    color: colors(context).whiteColor,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("last_login"),
                                  style: size12weight400.copyWith(
                                    color: colors(context).whiteColor,
                                  ),
                                ),
                                Text(
                                  AppConstants.lastLoggingTime ?? "",
                                  style: size12weight400.copyWith(
                                    color: colors(context).whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          8.horizontalSpace,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                child: Container(
                                  height: 44.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: colors(context).primaryColor50!),
                                    borderRadius: BorderRadius.circular(8).r,
                                    color: colors(context).primaryColor,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 10)
                                              .w,
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate("log_out"),
                                        style: size16weight700.copyWith(
                                          color: colors(context).whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showAppDialog(
                                    alertType: AlertType.WARNING,
                                    title: AppLocalizations.of(context)
                                        .translate("log_out"),
                                    message: AppLocalizations.of(context)
                                        .translate("are_you_want_leave"),
                                    positiveButtonText: AppLocalizations.of(context)
                                        .translate("log_out"),
                                    negativeButtonText: AppLocalizations.of(context)
                                        .translate("cancel"),
                                    onPositiveCallback: () {
                                      logout();
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 4.h,
                color: colors(context).secondaryColor,
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.mainMenuBackgroundImage),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: CarouselSlider.builder(
                itemBuilder: (context, carouselIndex, realIndex) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 24, bottom: 5)
                        .w,
                    itemCount: getQuickAccessItem(carouselIndex).length,
                    itemBuilder: (context, gridIndex) {
                      return _buildMenuItem(context, gridIndex, carouselIndex);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 1),
                  );
                },
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0,
                    height: MediaQuery.of(context).size.height,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                itemCount: (currentList.length / pageGridLength).ceil(),
              ),
            ),
          ),
          Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List
                    .generate((currentList.length / pageGridLength).ceil(),
                        (index) => index).map((e) => e == _current
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4).w,
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors(context).secondaryColor),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4).w,
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors(context).blackColor100),
                        ),
                      ))
              ],
            ),
            16.verticalSpace,
            PreLoginMenuButton(
              width: 70,
              height: 42,
              isClose: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            20.verticalSpace,
            AppSizer.verticalSpacing(AppSizer.getHomeIndicatorStatus(context))
          ],
        )
        ],
      ),
    );
  }

  List<QuickAccess> quickAccessMenuItems() => [
        // QuickAccess(
        //   title: 'card_management',
        //   icon: AppAssets.icCardManagement,
        //   onTap: () => Navigator.pushNamed(context, Routes.kCardManagementView),
        // ),
        QuickAccess(
          title: 'biller_management',
          svg: AppAssets.quickBillerManagement,
          isSvg: true,
          onTap: () => Navigator.pushNamed(context, Routes.kBillersView,
              arguments: Routes.kQuickAccessCarousel),
        ),
        QuickAccess(
          title: 'payees_management',
          svg: AppAssets.quickPayeeManagement,
          isSvg: true,
          onTap: () => Navigator.pushNamed(
              context, Routes.kPayeeManagementSavedPayeeView,
              arguments:
                  PayeeManagementSavedPayeeViewArgs(isFromFundTransfer: false)),
        ),
        QuickAccess(
          title: 'Help_support',
          icon: PhosphorIcons.info(PhosphorIconsStyle.bold),
          onTap: () => Navigator.pushNamed(context, Routes.kFAQView),
        ),
        QuickAccess(
          title: 'manage_pay_options_n',
          icon: PhosphorIcons.handTap(PhosphorIconsStyle.bold),
          onTap: () => Navigator.pushNamed(
            context,
            Routes.kMainOtherBankView,
          ),
        ),
        QuickAccess(
          title: 'promotions',
          icon: PhosphorIcons.sealCheck(PhosphorIconsStyle.bold),
          onTap: () => Navigator.pushNamed(
              context, Routes.kPromotionsOffersView,
              arguments: false),
        ),
        QuickAccess(
          title: 'locations',
          icon: PhosphorIcons.mapPinLine(PhosphorIconsStyle.bold),
          onTap: () => Navigator.pushNamed(context, Routes.kMapLocatorView),
        ),
        // QuickAccess('share', AppImages.icShare),
        QuickAccess(
          title: 'contact_us',
          icon: PhosphorIcons.phone(PhosphorIconsStyle.bold),
          onTap: () => Navigator.pushNamed(context, Routes.kContactUsView),
        ),
        QuickAccess(
          title: 'rates',
          icon: PhosphorIcons.chartBar(PhosphorIconsStyle.bold),
          onTap: () => Navigator.pushNamed(context, Routes.kRatesView),
        ),
        QuickAccess(
          title: 'calculator',
          svg: AppAssets.quickCalculator,
          isSvg: true,
          onTap: () => Navigator.pushNamed(context, Routes.kCalculatorsView,
              arguments: false),
        ),
        QuickAccess(
          title: 'schedules',
          icon: PhosphorIcons.calendar(PhosphorIconsStyle.bold),
          onTap: () =>
              Navigator.pushNamed(context, Routes.kScheduleCategoryListView),
        ),
        QuickAccess(
          title: 'request_money2',
          icon: PhosphorIcons.handCoins(PhosphorIconsStyle.bold),
          onTap: () => Navigator.pushNamed(context, Routes.kRequestMoneyView),
        ),
        QuickAccess(
          title: 'bill_payments_n',
          icon: PhosphorIcons.fileText(PhosphorIconsStyle.bold),
          onTap: () => Navigator.pushNamed(context, Routes.kPayBillsMenuView,
              arguments: Routes.kQuickAccessCarousel),
        ),
        QuickAccess(
          title: 'demo_tour_n',
          icon: PhosphorIcons.video(PhosphorIconsStyle.bold),
          onTap: () => Navigator.pushNamed(context, Routes.kDemoTourView),
        ),
        QuickAccess(
          title: 'train_schedule_n',
          icon: PhosphorIcons.train(PhosphorIconsStyle.bold),
          onTap: () => Navigator.pushNamed(context, Routes.kTrainTicket),
        ),
        QuickAccess(
          title: 'news',
          icon: PhosphorIcons.newspaper(PhosphorIconsStyle.bold),
          onTap: () => Navigator.pushNamed(context, Routes.kNewsFeed),
        ),
        QuickAccess(
          title: 'qr_pay',
          icon: PhosphorIcons.qrCode(PhosphorIconsStyle.bold),
          onTap: () {
            AppPermissionManager.requestCameraPermission(context, () {
              Navigator.pushNamed(context, Routes.kScanQRCodeView,
                  arguments: Routes.kQuickAccessCarousel);
            });
          },
        ),
        QuickAccess(
          title: 'fund_transfer_n',
          icon: PhosphorIcons.arrowsLeftRight(PhosphorIconsStyle.bold),
          onTap: () {
            Navigator.pushNamed(context, Routes.kFundTransferNewView,
                arguments:
                    RequestMoneyValues(route: Routes.kQuickAccessCarousel));
          },
        ),
        // QuickAccess(
        //   title: 'mail_box',
        //   icon: PhosphorIcons.envelope(PhosphorIconsStyle.bold),
        //   onTap: () {
        //     Navigator.pushNamed(context, Routes.kMailBox, arguments: true);
        //   },
        // ),
        // QuickAccess(
        //   title: 'history',
        //   icon: PhosphorIcons.article(PhosphorIconsStyle.bold),
        //   onTap: () {
        //     Navigator.pushNamed(context, Routes.kTransactionHistoryFlowView,
        //         arguments: true);
        //   },
        // ),
        //TODO
        // if (AppConstants.IS_CURRENT_AVAILABLE == true)
        //   QuickAccess(
        //     title: 'cheque_status_inquiry',
        //     icon: PhosphorIcons.keyboard(),
        //     onTap: () => Navigator.pushNamed(context, Routes.kChequeStatusView),
        //   ),
        if (AppConstants.IS_CURRENT_AVAILABLE == true)
          QuickAccess(
            title: 'float_inquiry',
            icon: PhosphorIcons.file(),
            onTap: () => Navigator.pushNamed(context, Routes.kFloatInquiryView),
          ),

        // ///todo: remove false
        if (AppConstants.IS_CURRENT_AVAILABLE == true)
          QuickAccess(
            title: 'service_request_n',
            icon: PhosphorIcons.headset(PhosphorIconsStyle.bold),
            onTap: () =>
                Navigator.pushNamed(context, Routes.kSeviceReqCategoryView),
          ),
      QuickAccess(
          title: 'credit_card',
          icon: PhosphorIcons.creditCard(PhosphorIconsStyle.bold),
          onTap: () {
            Navigator.pushNamed(context, Routes.kCreditCardManagementView,
                arguments: Routes.kQuickAccessCarousel);
          },
        ),
        // if (AppConstants.IS_CURRENT_AVAILABLE == true)
        //   QuickAccess(
        //     title: 'request_callbak',
        //     icon: PhosphorIcons.handCoins(),
        //     onTap: () => Navigator.pushNamed(
        //         context, Routes.kRequestCallBackHistoryView,
        //         arguments: false),
        //   ),
      ];

  Widget _buildMenuItem(
      BuildContext context, int gridIndex, int carouselIndex) {
    return MainMenuCarouselItem(
      key: ValueKey(gridIndex),
      menuItem: getQuickAccessItem(carouselIndex)[gridIndex],
      index: gridIndex,
      //TODO Dont Remove this commented line this is for when future if we need remove or add quick buttons
      // onLongPress: () {
      // remove items
      // if (getGridLength(carouselIndex) == 1 && gridIndex == 0) {
      //   _current = _current - 1;
      // }

      // currentList.removeAt(gridIndex);
      // setState(() {});
      // },
    );
  }

  int getGridLength(int carouselIndex) {
    if ((currentList.length == null) || (currentList.isEmpty)) {
      return 0;
    } else {
      if (currentList.length <= pageGridLength) {
        return currentList.length;
      } else {
        final int minusValue =
            currentList.length - (pageGridLength * (carouselIndex + 1));
        final int value =
            (pageGridLength + (minusValue.isNegative ? minusValue : 0));

        return value;
      }
    }
  }

  List<QuickAccess> getQuickAccessItem(int carouselIndex) {
    int gridLength = getGridLength(carouselIndex);
    int firstIndex = carouselIndex * pageGridLength;
    int secondIndex = firstIndex + gridLength;

    return currentList.getRange(firstIndex, secondIndex).toList();
  }

  int getIndex(int gridIndex) {
    int gridLength = getGridLength(_current);
    int firstIndex = _current * pageGridLength;
    int secondIndex = firstIndex + gridLength;
    List<int> indexList = currentList.asMap().keys.toList();
    List<int> rangeIndexList =
        indexList.getRange(firstIndex, secondIndex).toList();

    return rangeIndexList.elementAt(gridIndex);
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

class QuickAccess {
  final String title;
  final IconData? icon;
  final bool? isSvg;
  final String? svg;
  final VoidCallback onTap;

  QuickAccess({
    required this.title,
    required this.onTap,
    this.icon,
    this.svg,
    this.isSvg = false,
  });
}
