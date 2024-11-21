
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/models/responses/demo_tour_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/demo_tour/demo_tour_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_search_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/text_styles.dart';

class DemoTourView extends BaseView {
  DemoTourView({
    Key? key,
  }) : super(key: key);

  @override
  State<DemoTourView> createState() => _DemoTourViewState();
}

class _DemoTourViewState extends BaseViewState<DemoTourView> {
  var bloc = injection<DemoTourBloc>();

  List<DemoTourResponse> demoTourList = [];
  List<DemoTourResponse> demoTourSearchList = [];

  @override
  void initState() {
    super.initState();
    bloc.add(GetDemoTourEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          goBackEnabled: true,
          title: AppLocalizations.of(context).translate("demo_tour"),
        ),
        body: BlocProvider<DemoTourBloc>(
        create: (context) => bloc,
        child: BlocListener<DemoTourBloc, BaseState<DemoTourState>>(
          listener: (context, state) {
            if (state is DemoTourSuccessState) {
              demoTourList = state.demoTourList!.data!;
              demoTourSearchList = state.demoTourList!.data!;
              setState(() {});
              

              } 
            else if (state is DemoTourFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message??"", ToastStatus.FAIL);
              }
          },
            child: Padding(
              padding:  EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    if(demoTourSearchList.isNotEmpty)
                      Expanded(
                        child: Column(
                          children: [
                            SearchTextField(
                          hintText: AppLocalizations.of(context)
                              .translate("search"),
                          isBorder: false,
                          onChange: (p0) {
                            if (p0.isEmpty) {
                              demoTourSearchList = demoTourList;
                            } else {
                              demoTourSearchList = demoTourList
                                  .where((element) => element.title!
                                      .toLowerCase()
                                      .contains(p0.toLowerCase())).toSet()
                                  .toList();
                            }
                            setState(() {});
                          },
                        ),
                         24.verticalSpace,
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding:  EdgeInsets.only(bottom: 20 + AppSizer.getHomeIndicatorStatus(context)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).whiteColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16).w,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: demoTourSearchList.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                                      _launchUrl(demoTourSearchList[index].link);
                                                    },
                                            child: Column(
                                              children: [
                                                Row(children: [
                                                 Stack(
                                                   children: [
                                                     demoTourSearchList[index].iconUrl!.isNotEmpty?
                                                     Padding(
                                                       padding: EdgeInsets.only(left: 1.29),
                                                       child: Container(
                                                         width: 100,
                                                         height: 64,
                                                         decoration: BoxDecoration(
                                                           color: colors(context).secondaryColor50,
                                                           borderRadius: BorderRadius.circular(4).r,
                                                           border: Border.all(color: colors(context).greyColor200!),
                                                         ),
                                                         child: Stack(
                                                          alignment: Alignment.bottomCenter,
                                                           children: [
                                                             Container(
                                                               width: 60,
                                                               height: 50,
                                                               child: CachedNetworkImage(
                                                                   imageUrl: demoTourSearchList[index].iconUrl ?? "",
                                                                   imageBuilder: (context, imageProvider) => Container(
                                                                     width: ScreenUtil().screenWidth,
                                                                     decoration: BoxDecoration(
                                                                       borderRadius: BorderRadius.only(
                                                                         topLeft: Radius.circular(8),
                                                                         topRight: Radius.circular(8),
                                                                       ),
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
                                                               // alignment: Alignment.bottomCenter,decoration: BoxDecoration(
                                                               //   borderRadius: BorderRadius.only(topLeft: Radius.circular(3.65),topRight:Radius.circular(3.65) ), image: DecorationImage(fit: BoxFit.cover,
                                                               //   image: MemoryImage(
                                                               //     demoTourSearchList[index].icon!,
                                                               //   ))),
                                                             )
                                                           ],
                                                         ),
                                                       ),
                                                     ):
                                                       Container(
                                                         width: 100,
                                                         height: 64,
                                                         decoration: BoxDecoration(
                                                           color: colors(context).secondaryColor50,
                                                           borderRadius: BorderRadius.circular(4).r,
                                                           border: Border.all(color: colors(context).greyColor200!),
                                                         ),
                                                        child:Icon(PhosphorIcons.imageBroken(PhosphorIconsStyle.bold),size: 35,) ,
                                                      ),
                                                    Positioned(
                                                      top: 6,
                                                      left: 6,
                                                      child: SvgPicture.asset(
                                                        AppAssets.demoTourPlayIcon,
                                                      ),
                                                    ),
                                                   ],
                                                 ),
                                                  12.horizontalSpace,
                                                  Expanded(
                                                    child: Text(demoTourSearchList[index].title!,
                                                      style: size14weight700.copyWith(color:colors(context).primaryColor),
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //     _launchUrl(demoTourSearchList![index].link);
                                                  //   },
                                                  //   child: Image.asset(
                                                  //     AppImages.icDemoTourPlay,
                                                  //     scale: 2.5,
                                                  //   ),
                                                  // )
                                                ]),
                                                // 1.90.verticalSpace,
                                                   if((demoTourSearchList.length??0)-1 != index)
                                                                   Padding(
                                                                     padding:  EdgeInsets.only(top: 16.h,bottom: 16.w),
                                                                     child: Divider(
                                                                       thickness: 1,
                                                                       height: 0,
                                                                       color: colors(context).greyColor100,
                                                                     ),
                                                                   ),
                                              ],
                                            ),
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
                      )
                    ],
                  ),
                   if(demoTourSearchList.isEmpty)Center(
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
                              PhosphorIcons.video(
                                  PhosphorIconsStyle.bold),
                              color:
                                  colors(context).whiteColor,
                              size: 28,
                            ),
                          ),
                        ),
                        16.verticalSpace,
                        Text(
                          AppLocalizations.of(context).translate(
                              'no_result_found'),
                          style: size18weight700.copyWith(
                              color:
                                  colors(context).blackColor),
                        )
                      ],
                                       ),
                   ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _launchUrl(url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
