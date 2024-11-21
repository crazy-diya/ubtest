
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/bbc_cnn_NewsFeed/widget/news_compornent.dart';
import 'package:union_bank_mobile/features/presentation/widgets/sliding_segmented_bar.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:webfeed_plus/domain/rss_feed.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../core/service/rss_Feed.dart';
import '../../../../utils/app_localizations.dart';

import 'data/news_feed_response_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/splash/splash_bloc.dart';
import '../../widgets/appbar.dart';
import '../base_view.dart';

class NewsFeedView extends BaseView {
  @override
  State<NewsFeedView> createState() => _NewsFeedViewState();
}

class _NewsFeedViewState extends BaseViewState<NewsFeedView>  {
  var bloc = injection<SplashBloc>();
  int current = 0;
late Future<RssFeed> cnn;
  late Future<RssFeed> bbc;
 bool isShow =false;
  List<NewsFeedViewEntity> mapRssItemsToEntities(RssFeed rssFeed) {
    List<NewsFeedViewEntity> newsFeedList = [];
    var newsFeedEntity;

    for (var item in rssFeed.items!) {
      newsFeedEntity = NewsFeedViewEntity(
        title: item.title ?? '',
        subTitle: item.description ?? '',
        age: '',
        linkNews: item.link ?? '',
        details: item.pubDate ?? DateTime.now(),
        image: '',
      );
      newsFeedList.add(newsFeedEntity);
    }
    newsFeedList.removeWhere((element) => element.subTitle == '');
    newsFeedList.sort((a, b) => b.details!.compareTo(a.details!));
    return newsFeedList;
  }


  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {
      cnn = fetchAndParseRssFeed('http://rss.cnn.com/rss/edition_world.rss');
      bbc = fetchAndParseRssFeed('https://feeds.bbci.co.uk/news/world/rss.xml');

      setState(() {});
    });
  }
    @override
  void initState() {
    super.initState();
    cnn = fetchAndParseRssFeed('http://rss.cnn.com/rss/edition_world.rss');
    bbc = fetchAndParseRssFeed('https://feeds.bbci.co.uk/news/world/rss.xml');

  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50!,
      appBar: UBAppBar(
        goBackEnabled: true,
        title: AppLocalizations.of(context).translate("News_feed"),
      ),
      body: Padding(
        padding:  EdgeInsets.fromLTRB(20.w,20.h,20.w,0),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 44,
                  child: SlidingSegmentedBar(
                    selectedTextStyle: size14weight700.copyWith(color: colors(context).whiteColor),
                    textStyle: size14weight700.copyWith(color: colors(context).blackColor),
                    backgroundColor: colors(context).whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    onChanged: (int value) {
                      setState(() {
                        current = value;
                      });
                    },
                    selectedIndex: current,
                    children: [
                      "BBC",
                      "CNN",
                    ],
                  ),
                ),
                Expanded(
                  child:  LiquidPullToRefresh(
             backgroundColor: colors(context).primaryColor,
              color: Colors.transparent,
              onRefresh: _onRefresh,
              animSpeedFactor: 10,
              springAnimationDurationInMilliseconds: 1,
              showChildOpacityTransition: false,
                    child: Column(children: [
                      if(current == 0) Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24).h,
                        child: FutureBuilder<RssFeed>(
                          future: bbc, // Fetch and parse RSS feed
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final rssFeed = snapshot.data!;
                              final newsFeedList = mapRssItemsToEntities(rssFeed);
                                
                              return ListView.builder(
                                key: Key("1"),
                                itemCount: newsFeedList.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 4.h+AppSizer.getHomeIndicatorStatus(context)),
                                itemBuilder: (context, index) {
                                  final newsFeedEntity = newsFeedList[index];
                                  return NewsFeedComponent(
                                    isBBC: true,
                                    newsFeedViewEntity: newsFeedEntity, // Pass the entity to the component
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              if(isShow==false){
            
                              showError();
                              }
                              return SizedBox.shrink();
                            } else if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: SizedBox(
                                width: 200.w,
                                height: 200.h,
                                child: Lottie.asset(AppAssets.loadingAnimation,)));
                            } else {
                              return  Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: colors(context)
                                              .secondaryColor300,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.all(14).w,
                                        child: PhosphorIcon(
                                          size: 28.w,
                                          PhosphorIcons.newspaper(
                                              PhosphorIconsStyle.bold),
                                          color: colors(context)
                                              .whiteColor,
                                        ),
                                      ),
                                    ),
                                    16.verticalSpace,
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                              'no_updated_news'),
                                      style: size18weight700.copyWith(
                                          color: colors(context)
                                              .blackColor),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                              'when_news_are_updated_here'),
                                      style: size14weight400.copyWith(
                                          color: colors(context)
                                              .greyColor),
                                    )
                                  ],
                                ));
                            }
                          },
                        )
                      ),
                    ),
                    if(current == 1) Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24).h,
                        child: FutureBuilder<RssFeed>(
                          future: cnn, // Fetch and parse RSS feed
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                             final rssFeed = snapshot.data!;
                                final newsFeedList = mapRssItemsToEntities(rssFeed);
                        
                                return ListView.builder(
                                  key: Key("2"),
                                  itemCount: newsFeedList.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(bottom: 4.h+AppSizer.getHomeIndicatorStatus(context)),
                                  itemBuilder: (context, index) {
                                    final newsFeedEntity = newsFeedList[index];
                                    return NewsFeedComponent(
                                      isBBC: false,
                                      newsFeedViewEntity: newsFeedEntity, // Pass the entity to the component
                                    );
                                  },
                                );
                            } else if (snapshot.hasError) {
                              if(isShow==false){
            
                              showError();
                              }
                              return  SizedBox.shrink();
                            } else if (snapshot.connectionState == ConnectionState.waiting) {
                              return  Center(child: SizedBox(
                                  width: 200.w,
                                  height: 200.w,
                                child: Lottie.asset(AppAssets.loadingAnimation,)));
                            }else {
                              return  Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: colors(context)
                                              .secondaryColor300,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.all(14).w,
                                        child: PhosphorIcon(
                                          size: 28.w,
                                          PhosphorIcons.newspaper(
                                              PhosphorIconsStyle.bold),
                                          color: colors(context)
                                              .whiteColor,
                                        ),
                                      ),
                                    ),
                                    16.verticalSpace,
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                              'no_updated_news'),
                                      style: size18weight700.copyWith(
                                          color: colors(context)
                                              .blackColor),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate(
                                              'when_news_are_updated_here'),
                                      style: size14weight400.copyWith(
                                          color: colors(context)
                                              .greyColor),
                                    )
                                  ],
                                ));
                            }
                          },
                        )
                      ),
                    ),
                    ],),
                  ),
                ),
               
               
              ],
            ),
          ],
        ),
      ),
    );
  }

  showError() async {
    await Future.delayed(Duration(microseconds: 1));
    setState(() {
      isShow = true;
    });

    showAppDialog(
      alertType: AlertType.CONNECTION,
      title: AppLocalizations.of(context).translate("unable_connect_server"),
      message: AppLocalizations.of(context).translate("unable_connect_server_des"),
      onPositiveCallback: () {
        setState(() {
          isShow = true;
        });
      },
      positiveButtonText: AppLocalizations.of(context).translate("try_again"),
    );
  }




  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
