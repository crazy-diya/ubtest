
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_assets.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../bloc/base_event.dart';
import '../../bloc/splash/splash_bloc.dart';
import '../base_view.dart';

class IntroView extends BaseView {
  IntroView({Key? key}) : super(key: key);

  @override
  _IntroViewState createState() => _IntroViewState();
}

class _IntroViewState extends BaseViewState<IntroView> {
  var bloc = injection<SplashBloc>();
  final appSharedData = injection<LocalDataSource>();

  int _current = 0;
  String? firstMarketbanner;
  String? secondMarketbanner;
  String? thirdMarketbanner;
  String? bannerDescription;

  @override
  void initState() {
    super.initState();
    if (appSharedData.getMarketingBanners()?.isNotEmpty ?? false) {
      firstMarketbanner = appSharedData.getMarketingBanners()![0];
      secondMarketbanner = appSharedData.getMarketingBanners()![1];
      thirdMarketbanner = appSharedData.getMarketingBanners()![2];

      bannerDescription = appSharedData.getDescriptionBanners();


    }
  }

  @override
  Widget buildView(BuildContext context) {
    List<Widget> widgetList = [
      Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
            imageUrl: firstMarketbanner ?? "",
            imageBuilder: (context, imageProvider) => Container(
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8).r),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Center(
              child: SizedBox(
                height: 20.w,
                width: 20.w,
                child: CircularProgressIndicator(
                  color: colors(context).primaryColor400,
                  strokeWidth: 2,
                ),
              ),
            ),
            errorWidget: (context, url, error) => PhosphorIcon(
              PhosphorIcons.warningCircle(
                  PhosphorIconsStyle.bold),
            )),
          ),
          Container(width: double.infinity, height:  12, color: colors(context).secondaryColor),
          SizedBox(
             height: 232 +AppSizer.getHomeIndicatorStatus(context),
            child: Padding(
              padding: EdgeInsets.only( left: 20, right: 28, top: 40),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children:  [
                  Text(
                    AppLocalizations.of(context).translate("digital_wallet"),
                    style: size24weight700.copyWith (
                      color: colors(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    AppLocalizations.of(context).translate("digital_wallet_des"),
                    style: size16weight400.copyWith (
                      color: colors(context).greyColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CachedNetworkImage(
                imageUrl: secondMarketbanner ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  width: ScreenUtil().screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8).r),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    height: 20.w,
                    width: 20.w,
                    child: CircularProgressIndicator(
                      color: colors(context).primaryColor400,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => PhosphorIcon(
                  PhosphorIcons.warningCircle(
                      PhosphorIconsStyle.bold),
                )),
          ),
        Container(width: double.infinity, height:  12, color: colors(context).secondaryColor),
           SizedBox(
             height: 232 +AppSizer.getHomeIndicatorStatus(context),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 28, top: 40),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children:  [
                  Text(
                    AppLocalizations.of(context).translate("digital_wallet"),
                    style: size24weight700.copyWith (
                      color: colors(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    AppLocalizations.of(context).translate("digital_wallet_des"),
                    style: size16weight400.copyWith (
                      color: colors(context).greyColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CachedNetworkImage(
                imageUrl: thirdMarketbanner ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  width: ScreenUtil().screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8).r),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    height: 20.w,
                    width: 20.w,
                    child: CircularProgressIndicator(
                      color: colors(context).primaryColor400,
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => PhosphorIcon(
                  PhosphorIcons.warningCircle(
                      PhosphorIconsStyle.bold),
                )),
          ),
          Container(width: double.infinity, height:  12, color: colors(context).secondaryColor),
           SizedBox(
             height: 232 +AppSizer.getHomeIndicatorStatus(context),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 28, top: 40),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children:  [
                  Text(
                    AppLocalizations.of(context).translate("digital_wallet"),
                    style: size24weight700.copyWith (
                      color: colors(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    AppLocalizations.of(context).translate("digital_wallet_des"),
                    style: size16weight400.copyWith (
                      color: colors(context).greyColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      
    ];

    return Scaffold(
      
      body: Stack(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                items: widgetList,
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0,
                    scrollPhysics: ClampingScrollPhysics(),
                    height: MediaQuery.of(context).size.height,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 24.8+AppSizer.getHomeIndicatorStatus(context), right: 19.8),
                  child: InkWell(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            _current == 2 ?  AppLocalizations.of(context).translate("get_started") :  AppLocalizations.of(context).translate("skip"),
                            style: size16weight400.copyWith (
                              color: colors(context).greyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      appSharedData.setInitialLaunch();
                      Navigator.pushNamed(context, Routes.kLoginView,
                          arguments: kGeneralTerms);

                      // Navigator.pushNamed(context, Routes.kLoginView);
                    },
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(bottom: 32.8+AppSizer.getHomeIndicatorStatus(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widgetList.map((url) {
                    int index = widgetList.indexOf(url);
                    return _current == index
                        ? Container(
                            width: 20,
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 2.5),
                            decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(2),
                              //shape: BoxShape.circle,
                              color: _current == index
                                  ? colors(context).secondaryColor
                                  : colors(context).secondaryColor,
                            ),
                          )
                        : Container(
                            width: 10,
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 2.5),
                            decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(2),
                              //shape: BoxShape.circle,
                              color: _current == index
                                  ? colors(context).greyColor200
                                  : colors(context).greyColor200,
                            ),
                          );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
