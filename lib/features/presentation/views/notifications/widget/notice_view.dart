import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/notifications/notifications_view.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_localizations.dart';

import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/splash/splash_bloc.dart';
import '../../../widgets/appbar.dart';


class NoticePreview extends BaseView {
  final NotificationData notificationData;

  NoticePreview({required this.notificationData});
  @override
  State<NoticePreview> createState() => _NoticePreviewState();
}

class _NoticePreviewState extends BaseViewState<NoticePreview> {
  var bloc = injection<SplashBloc>();
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("notices"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8).r,
                  color: colors(context).whiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.verticalSpace,
                          Text(widget.notificationData.title,style: size16weight700.copyWith(color: colors(context).primaryColor),),
                          20.verticalSpace,
                          Text(widget.notificationData.body??"",style: size14weight400.copyWith(color: colors(context).greyColor),),
                          20.verticalSpace,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${AppLocalizations.of(context).translate("date_&_time")} : " , style: size14weight400.copyWith(color: colors(context).primaryColor),),
                              Text("${DateFormat('dd MMM yyyy').format(
                                        DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ')
                                            .parse(
                                      widget.notificationData.date.toString()
                                          .toString(),
                                    ))} "  ,style: size14weight700.copyWith(color: colors(context).primaryColor),),
                              Text( widget.notificationData.time,style: size14weight700.copyWith(color: colors(context).primaryColor),),
                              // Text( "${timeago.format(widget.notificationData.date!, locale: 'en_short').replaceAll('~', '')} ${timeago.format(widget.notificationData.date!, locale: 'en_short').replaceAll('~', '').toUpperCase() != "NOW" ? AppLocalizations.of(context).translate("ago") : ""}",style: size14weight700.copyWith(color: colors(context).primaryColor),),

                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
