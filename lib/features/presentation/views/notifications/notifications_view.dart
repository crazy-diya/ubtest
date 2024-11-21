// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/notifications/notifications_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/notifications/widget/notification_widget.dart';
import 'package:union_bank_mobile/features/presentation/views/notifications/widget/offer_notification_preview.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/filtered_chip.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';

import '../../../data/datasources/local_data_source.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_sheet.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../fund_transfer/widgets/fund_transfer_data_component.dart';

class FilterListValue{
  String? description;
  String? value;

  FilterListValue({this.description, this.value});
}


class RequestMoneyValues{
  int? id;
  String? toAccount;
  String? toAccountName;
  num? requestedAmount;
  DateTime? requestedDate;
  String? route;
  String? toBankCode;

  RequestMoneyValues(
      {this.id,
      this.toAccount,
      this.toAccountName,
      this.requestedAmount,
      this.route,
      this.toBankCode,
      this.requestedDate});

  @override
  String toString() {
    return 'RequestMoneyValues{id: $id, toAccount: $toAccount, toAccountName: $toAccountName, requestedAmount: $requestedAmount, requestedDate: $requestedDate, route: $route}';
  }
}



class NotificationData {
  List<String>? imagePromo;
  String title;
  String? image;
  String? promoIcon;
  String time;
  String category;
  String? payFromName;
  String? payToNo;
  String? payFromNo;
  String? payToName;
  String? remarks;
  String? reference;
  String? body;
  DateTime? date;
  bool isSelected;
  bool isRead;
  int notificationId;
  String? requestID;
 String? reqMoneystatus;
 String? amount;
 String? txnType;
 String? channel;

  NotificationData({
    this.image,
    this.promoIcon,
    this.imagePromo,
    required this.title,
    required this.category,
    required this.time,
    required this.notificationId,
    this.date,
    this.payFromName,
    this.payToNo,
    this.payFromNo,
    this.payToName,
    this.remarks,
    this.reference,
    this.body,
    this.requestID,
    this.isSelected = false,
    this.isRead = false,
    this.reqMoneystatus,
    this.amount,
    this.txnType,
    this.channel,
  });

  @override
  String toString() {
    return 'NotificationData(imagePromo: $imagePromo, title: $title, image: $image, time: $time, category: $category, payFromName: $payFromName, payToNo: $payToNo, payFromNo: $payFromNo, payToName: $payToName, remarks: $remarks, reference: $reference, body: $body, date: $date, isSelected: $isSelected, isRead: $isRead, notificationId: $notificationId, requestID: $requestID, reqMoneystatus: $reqMoneystatus)';
  }
}

class NotificationsView extends BaseView {
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends BaseViewState<NotificationsView> {
  var bloc = injection<NotificationsBloc>();
  final requestMoneyValues = RequestMoneyValues();

  String? offerImage;
  String? title;
  String? description;
  String? validTime;
  bool isMarked = false;
  bool isMarkeClicked = false;
  // bool _isTransactionsAvaolable = true;
  // bool _isOffersAvaolable = true;
  // bool _isNoticesAvaolable = true;
  String? selectedTranOptionTemp = "all";
  String? selectedTranOption;
  String? selectedPromoOption;
  String? selectedPromoOptionTemp= "all";
  String? selectedNoticeOption ;
  String? selectedNoticeOptionTemp= "all";
  bool _selectAll = false;
  int pageNumberTran = 0;
  int pageNumberPromo = 0;
  int pageNumberNotice = 0;
  int? allNotificationCount;
  int? promoNotificationCount;
  int? tranNotificationCount;
  int? noticesNotificationCount;
  String? requestMoneyId;
  String? requestMoneyStatus;
  List<FilterListValue> filterList = [
    FilterListValue(
      value: "all",
      description: "all"
    ),
    FilterListValue(
      value: "read",
      description: "read"
    ),
    FilterListValue(
      value: "unread",
      description: "unread"
    ),
  ];
  late final _scrollControllerTran = ScrollController()
    ..addListener(_onScrollTran);
  late final _scrollControllerPromo = ScrollController()
    ..addListener(_onScrollPromo);
  late final _scrollControllerNotices = ScrollController()
    ..addListener(_onScrollNotices);
  int noticeCount = 0;
  int tranCount = 0;
  int promoCount = 0;

  List<String> tabs = [
    "transactions",
    "offers",
    "notices",
  ];
  int current = 0;
  List<NotificationData> transactionNotificationsList = [];
  List<NotificationData> offerNotificationsList = [];
  List<NotificationData> noticesNotificationsList = [];
  List<NotificationData> combinedList = [];
  List<int> selectedNotificationListForTran = [];
  List<int> selectedNotificationListForTranOnTap = [];
  List<int> selectedNotificationListForOffrer = [];
  List<int> selectedNotificationListForOffrerOnTap = [];
  List<int> selectedNotificationListForNotice = [];
  List<int> selectedNotificationListForNoticeOnTap = [];
  List<int> selectedNotificationTranListForDelete = [];
  List<int> selectedNotificationOfferListForDelete = [];
  List<int> selectedNotificationNoticeListForDelete = [];

  @override
  void initState() {
    super.initState();
    bloc.add(GetNotificationsEvent(
        page: pageNumberTran, size: 10, readStatus: selectedTranOption??"all"));
    bloc.add(GetPromotionEvent(
        page: pageNumberPromo, size: 10, readStatus: selectedPromoOption??"all"));
    bloc.add(GetNoticesEvent(
        page: pageNumberNotice,
        size: 10,
        epicUserId: epicUserId,
        readStatus: selectedNoticeOption??"all"));
    bloc.add(CountNotificationsEvent(
        readStatus: "all", notificationType: "ALL"));
    combinedList.addAll(transactionNotificationsList);
    combinedList.addAll(offerNotificationsList);
    combinedList.addAll(noticesNotificationsList);
  }

  _onScrollTran() {
    if(tranCount !=transactionNotificationsList.length ) {
      final maxScroll = _scrollControllerTran.position.maxScrollExtent;
      final currentScroll = _scrollControllerTran.position.pixels;
      if (maxScroll - currentScroll == 0) {
        bloc.add(GetNotificationsEvent(
            page: pageNumberTran, size: 10, readStatus: selectedTranOption??"all"));
      }  
    }
  }

  _onScrollPromo() {
    if(promoCount !=offerNotificationsList.length ) {
      final maxScroll = _scrollControllerPromo.position.maxScrollExtent;
      final currentScroll = _scrollControllerPromo.position.pixels;
      if (maxScroll - currentScroll == 0) {
        bloc.add(GetPromotionEvent(
            page: pageNumberPromo, size: 10, readStatus: selectedPromoOption??"all"));
      } 
    }
  }

  _onScrollNotices() {
    if(noticeCount !=noticesNotificationsList.length) {
      final maxScroll = _scrollControllerNotices.position.maxScrollExtent;
      final currentScroll = _scrollControllerNotices.position.pixels;
      if (maxScroll - currentScroll == 0) {
        bloc.add(GetNoticesEvent(
            page: pageNumberPromo,
            size: 10,
            epicUserId: epicUserId,
            readStatus: selectedNoticeOption??"all"));
      } 
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async{
        if (isMarked) {
          onBackPressed();
          deletedList();
        } else {
          Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
        }
        return false;
      },
      child: Scaffold(
        appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("notifications"),
          onBackPressed: () {
            if (isMarked) {
              onBackPressed();
            } else {
              Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
            }
            deletedList();
          },
          actions: [
            (transactionNotificationsList.any((notification) => notification.isSelected,) || offerNotificationsList.any((notification) => notification.isSelected || noticesNotificationsList.any((notification) => notification.isSelected))) ?
            Row(
              children: [
                InkWell(
                  child: PhosphorIcon(
                    PhosphorIcons.checks(PhosphorIconsStyle.bold),
                    color:  colors(context).whiteColor,
                  ),
                  onTap: () {
                     if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions")){
                            pageNumberTran = 0;
                            bloc.add(MarkNotificationAsReadEvent(
                                notifications: selectedNotificationTranListForDelete.toSet().toList(),
                                epicUserId: ''));
                          }
                
                          if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers")){
                            pageNumberPromo = 0;
                            bloc.add(MarkNotificationAsReadEvent(
                                notifications: selectedNotificationOfferListForDelete.toSet().toList(),
                                epicUserId: ''));
                          }
                
                          if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("notices")){
                            pageNumberNotice = 0;
                            bloc.add(MarkNotificationAsReadEvent(
                                notifications: selectedNotificationNoticeListForDelete.toSet().toList(),
                                epicUserId: ''));
                          }
                
                  },
                ),
                IconButton(
                  icon: PhosphorIcon(
                    PhosphorIcons.trash(PhosphorIconsStyle.bold),
                    color:  colors(context).whiteColor,
                  ),
                  onPressed: () {
                    showAppDialog(
                        alertType: AlertType.DELETE,
                        title:AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions") &&
                            selectedNotificationTranListForDelete.length >  1 ||
                            AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers") &&
                                          selectedNotificationOfferListForDelete.length > 1 ||
                            AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("notices") &&
                                          selectedNotificationNoticeListForDelete.length > 1
                                  ? AppLocalizations.of(context)
                                      .translate("delete_notifications")
                                  : AppLocalizations.of(context)
                                      .translate("delete_notification"),
                
                
                        message:"${AppLocalizations.of(context).translate("are_you_sure")} (${AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions") ?
                        selectedNotificationTranListForDelete.length :
                        AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers") ?
                        selectedNotificationOfferListForDelete.length:
                        selectedNotificationNoticeListForDelete.length})\n${AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions") &&
                            selectedNotificationTranListForDelete.length > 1 ||
                            AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers") &&
                                selectedNotificationOfferListForDelete.length > 1 ||
                            AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("notices") &&
                            selectedNotificationNoticeListForDelete.length > 1 ?
                        AppLocalizations.of(context).translate("are_you_sure_1"):
                        AppLocalizations.of(context).translate("are_you_sure_2")}",
                        positiveButtonText: AppLocalizations.of(context).translate("yes_delete"),
                        negativeButtonText: AppLocalizations.of(context).translate("no"),
                        onNegativeCallback: () {},
                        onPositiveCallback: () {
                          if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions")){
                            bloc.add(DeleteNotificationEvent(
                                page: pageNumberTran,
                                size: 10,
                                epicUserId: '',
                                notificationIds: selectedNotificationTranListForDelete.toSet().toList()));
                          }
                          if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers")){
                            bloc.add(DeleteNotificationEvent(
                                page: pageNumberPromo,
                                size: 10,
                                epicUserId: '',
                                notificationIds: selectedNotificationOfferListForDelete.toSet().toList()));
                          }
                
                          if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("notices")){
                            bloc.add(DeleteNotificationEvent(
                                page: pageNumberNotice,
                                size: 10,
                                epicUserId: '',
                                notificationIds: selectedNotificationNoticeListForDelete.toSet().toList()));
                          }
                
                
                        });
                  },
                ),
              ],
            ) :
            IconButton(
              icon: PhosphorIcon(
                PhosphorIcons.funnel(PhosphorIconsStyle.bold),
                color:  colors(context).whiteColor,),
              onPressed: () async {
                final result = await showModalBottomSheet<bool>(
                isScrollControlled: true,
                useRootNavigator: true,
                useSafeArea: true,
                context: context,
                barrierColor: colors(context).blackColor?.withOpacity(.85),
                backgroundColor: Colors.transparent,
                builder: (context,) => StatefulBuilder(
                    builder: (context,changeState) {
                      return BottomSheetBuilder(
                        title: AppLocalizations.of(context).translate("filter_notifications"),
                        // AppLocalizations.of(context).translate('filter_notifications'),
                        buttons: [
                          Expanded(
                            child: AppButton(
                                buttonType: ButtonType.PRIMARYENABLED,
                                buttonText: AppLocalizations.of(context) .translate("apply"),
                                onTapButton: () {
                                  if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions")){
                                    pageNumberTran = 0;
                                    selectedTranOption = selectedTranOptionTemp;
                                    bloc.add(GetNotificationsEvent(page: pageNumberTran, size: 10, readStatus: selectedTranOption??"all"));
                                  } else if (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers")) {
                                    pageNumberPromo = 0;
                                    selectedPromoOption = selectedPromoOptionTemp;
                                    bloc.add(GetPromotionEvent(page: pageNumberPromo, size: 10, readStatus: selectedPromoOption??"all"));
                                  } else {
                                    pageNumberNotice = 0;
                                    selectedNoticeOption = selectedNoticeOptionTemp;
                                    bloc.add(GetNoticesEvent(page: pageNumberNotice, size: 10, readStatus: selectedNoticeOption??"all", epicUserId: epicUserId));
                                  }
                                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                  Navigator.of(context).pop(true);
                                  changeState(() {});
                                  setState(() {});

                                }),
                          ),
                        ],
                        children: [
                          ListView.builder(
                            itemCount: filterList.length,
                            shrinkWrap: true,
                             padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions") ){
                                    selectedTranOptionTemp = filterList[index].value!;
                                  } else if (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers")){
                                    selectedPromoOptionTemp = filterList[index].value!;
                                  } else {
                                    selectedNoticeOptionTemp = filterList[index].value!;
                                  }
                                  changeState(() {});
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                       padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:24,0,24).h,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                           AppLocalizations.of(context).translate(filterList[index].description!) ,
                                            style: size16weight700.copyWith(color: colors(context).blackColor,),
                                          ),
                                         Padding(
                                           padding: const EdgeInsets.only(right: 8).w,
                                           child: UBRadio<dynamic>(
                                              value: filterList[index].value ?? "",
                                              groupValue: AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions") ?
                                              selectedTranOptionTemp :
                                              AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers") ?
                                              selectedPromoOptionTemp : selectedNoticeOptionTemp,
                                              onChanged: (value) {
                                                changeState(() {});
                                              },
                                            ),
                                         ),
                                        ],
                                      ),
                                    ),
                                  if(filterList.length - 1!=index) Divider(
                                      thickness: 1,
                                      height: 0,
                                      color: colors(context).greyColor100,
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      );
                    }
                ));
            setState(() {});
          },
        )
          ],
          goBackEnabled: true,
        ),
        body: BlocProvider(
          create: (context) => bloc,
          child: BlocListener<NotificationsBloc, BaseState<NotificationsState>>(
            bloc: bloc,
            listener: (_, state) {
              if(state is MoneyRequestNotificationSuccessState){
                requestMoneyValues.id = state.id;
                requestMoneyValues.toAccountName = state.toAccountName;
                requestMoneyValues.toAccount = state.toAccount;
                requestMoneyValues.requestedDate = state.requestedDate;
                requestMoneyValues.requestedAmount = state.requestedAmount;
                requestMoneyValues.toBankCode = state.toBankCode;
                requestMoneyValues.route = Routes.kNotificationsView;
                AppConstants.requestMoneyData.id = state.id;
                AppConstants.requestMoneyData.accountNumber = state.toAccount;
                setState(() {

                });
                Navigator.pushNamed(context, Routes.kFundTransferNewView , arguments: requestMoneyValues);

              }
              if(state is MoneyRequestNotificationFailedState){
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
              }
              if(state is CountNotificationSuccessState){
                setState(() {
                  allNotificationCount = state.allNotificationCount;
                  promoNotificationCount = state.promoNotificationCount;
                  tranNotificationCount = state.tranNotificationCount;
                  noticesNotificationCount = state.noticesNotificationCount;
                });
              }
              if (state is CountNotificationFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
              }
              if (state is NotificationSuccessState) {
                setState(() {
                  tranCount =state.count??0;
                  if (pageNumberTran == 0) {
                    transactionNotificationsList.clear();
                    state.notifications!.forEach((element) {
                      transactionNotificationsList.add(NotificationData(
                        notificationId: element.notificationId!,
                        title: element.title ?? AppLocalizations.of(context).translate("no_title"),
                        category:
                            getTranType(element.notificationType ?? AppLocalizations.of(context).translate("no_type")),
                        time:
                            "${timeago.format(element.date!, locale: 'en_short').replaceAll('~', '')} ${timeago.format(element.date!, locale: 'en_short').replaceAll('~', '').toUpperCase() != "NOW" ? AppLocalizations.of(context).translate("ago") : ""}",
                        image: element.billerImage ??
                            "https://firebasestorage.googleapis.com/v0/b/cdb-documents.appspot.com/o/e2c12c08-98b5-451d-ba84-195579818000.png?alt=media",
                        payFromName: element.fromAccountName,
                        payToName: element.toAccountName,
                        payFromNo: element.fromAccountNo,
                        payToNo: element.toAccountNo,
                        reference: element.referenceNumber,
                        remarks: element.remarks,
                        body: element.body,
                        date: element.date,
                        requestID: element.reqMoneyId,
                        isRead: element.readStatus == 0 ? false : true,
                        reqMoneystatus: element.reqMoneystatus,
                        amount: element.amount,
                        txnType: element.txnType
                      ));
                    });
                  } else {
                    state.notifications!.forEach((element) {
                      transactionNotificationsList.add(NotificationData(
                        notificationId: element.notificationId!,
                        title: element.title ?? AppLocalizations.of(context).translate("no_title"),
                        category:
                            getTranType(element.notificationType ?? AppLocalizations.of(context).translate("no_type")),
                        time:
                            "${timeago.format(element.date!, locale: 'en_short').replaceAll('~', '')} ${timeago.format(element.date!, locale: 'en_short').replaceAll('~', '').toUpperCase() != "NOW" ? AppLocalizations.of(context).translate("ago") : ""}",
                        image: element.billerImage ??
                            "https://firebasestorage.googleapis.com/v0/b/cdb-documents.appspot.com/o/e2c12c08-98b5-451d-ba84-195579818000.png?alt=media",
                        payFromName: element.fromAccountName,
                        payToNo: element.toAccountNo,
                        payToName: element.toAccountName,
                        payFromNo: element.fromAccountNo,
                        reference: element.referenceNumber,
                        remarks: element.remarks,
                        body: element.body,
                        date: element.date,
                        requestID: element.reqMoneyId,
                        isRead: element.readStatus == 0 ? false : true,
                        reqMoneystatus: element.reqMoneystatus,
                          amount: element.amount,
                          txnType: element.txnType
                      ));
                    });
                  }
                  pageNumberTran = pageNumberTran + 1;
                });
              }
              if (state is NotificationFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message?? AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
              }
              if (state is PromotionSuccessState) {
                setState(() {
                  promoCount =state.count??0;
                  if(pageNumberPromo == 0){
                    offerNotificationsList.clear();
                    state.notifications!.forEach((element) {
                      offerNotificationsList.add(
                        NotificationData(
                          notificationId: element.notificationId!,
                          title: element.promoHeader!,
                          body: element.promoBody,
                          category: element.offerValidTill!,
                          time:"${timeago.format(element.createdDate??DateTime.now(), locale: 'en_short').replaceAll('~', '')} ${timeago.format(element.createdDate!, locale: 'en_short').replaceAll('~', '').toUpperCase() != "NOW" ? AppLocalizations.of(context).translate("ago") : ""}",
                          imagePromo:element.promoImage ,
                          promoIcon: element.promoIcon,
                          isRead: element.readStatus == 0 ? false : true,
                          channel: element.channel
                        ),
                      );
                    });
                  }else{
                    state.notifications!.forEach((element) {
                      offerNotificationsList.add(
                        NotificationData(
                          notificationId: element.notificationId!,
                          title: element.promoHeader!,
                          body: element.promoBody,
                          category: element.offerValidTill!,
                          time: "${timeago.format(element.createdDate!, locale: 'en_short').replaceAll('~', '')} ${timeago.format(element.createdDate!, locale: 'en_short').replaceAll('~', '').toUpperCase() != "NOW" ? AppLocalizations.of(context).translate("ago") : ""}",
                          imagePromo: element.promoImage,
                          promoIcon: element.promoIcon,
                          isRead: element.readStatus == 0 ? false : true,
                          channel: element.channel
                        ),
                      );
                    });
                  }
                  offerNotificationsList = offerNotificationsList.where((e)=>e.channel?.toUpperCase() != "IB").toList();
                  pageNumberPromo = pageNumberPromo + 1;
                });
              }
              if (state is PromotionFailedState) {
                ToastUtils.showCustomToast(
                    context,state.message?? AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
              }
              if (state is NoticesSuccessState) {
                setState(() {
                  noticeCount =state.count??0;
                  if(pageNumberNotice == 0){
                    noticesNotificationsList.clear();
                    state.notifications!.forEach((element) {
                      noticesNotificationsList.add(
                        NotificationData(
                          notificationId: element.notificationId,
                          title: element.title,
                          category: element.code,
                          date: element.modifiedDate,
                          body: element.description,
                          time:
                              "${timeago.format(element.modifiedDate, locale: 'en_short').replaceAll('~', '')} ${timeago.format(element.modifiedDate!, locale: 'en_short').replaceAll('~', '').toUpperCase() != "NOW" ? AppLocalizations.of(context).translate("ago") : ""}",
                          image: "assets/png/icNotices.png",
                          isRead: element.readStatus == 0 ? false : true,
                        ),
                      );
                    });
                  }else{
                    state.notifications!.forEach((element) {
                      noticesNotificationsList.add(
                        NotificationData(
                          notificationId: element.notificationId,
                          title: element.title,
                          category: element.code,
                          date: element.modifiedDate,
                          body: element.description,
                          time:
                              "${timeago.format(element.modifiedDate, locale: 'en_short').replaceAll('~', '')} ${timeago.format(element.modifiedDate!, locale: 'en_short').replaceAll('~', '').toUpperCase() != "NOW" ? AppLocalizations.of(context).translate("ago") : ""}",
                          image: "assets/png/icNotices.png",
                          isRead: element.readStatus == 0 ? false : true,
                        ),
                      );
                    });
                  }
                  pageNumberNotice = pageNumberNotice + 1;
                });
              }
              if (state is NoticesFailedState) {
                ToastUtils.showCustomToast(
                    context,state.message?? AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
              }
              if (state is MarkAsReadNotificationSuccessState) {
                if (isMarkeClicked == true) {
                  ToastUtils.showCustomToast(
                      context, AppLocalizations.of(context).translate("mark_all_read"), ToastStatus.SUCCESS);
                  isMarkeClicked = false;
                }
                if (isMarked) {
                  for (var element in transactionNotificationsList) {
                    if (element.isSelected == true) {
                      element.isRead = true;
                    }
                    element.isSelected = false;
                  }
                  for (var element in offerNotificationsList) {
                    if (element.isSelected == true) {
                      element.isRead = true;
                    }
                    element.isSelected = false;
                  }
                  for (var element in noticesNotificationsList) {
                    if (element.isSelected == true) {
                      element.isRead = true;
                    }
                    element.isSelected = false;
                  }
                }


                isMarked = false;
                setState(() { });
                bloc.add(CountNotificationsEvent(
                    readStatus: "all", notificationType: "ALL"));
                if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions")){
                  bloc.add(GetNotificationsEvent(
                      page: pageNumberTran, size: 10, readStatus: selectedTranOption??"all"));
                }
                if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers")){
                  bloc.add(GetPromotionEvent(
                      page: pageNumberPromo, size: 10, readStatus: selectedPromoOption??"all"));
                }
                if(AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("notices")){
                  bloc.add(GetNoticesEvent(
                      page: pageNumberNotice,
                      size: 10,
                      epicUserId: epicUserId,
                      readStatus: selectedNoticeOption??"all"));
                }

              }
              if (state is ReqMoneyNotificationStatusSuccessState){
                transactionNotificationsList.where((element) => element.requestID == requestMoneyId,).first.reqMoneystatus = requestMoneyStatus;
                requestMoneyStatus = null;
                requestMoneyId = null;
                setState(() {});
                ToastUtils.showCustomToast(
                    context, state.description ?? AppLocalizations.of(context).translate("success"), ToastStatus.SUCCESS);
              }
              if (state is ReqMoneyNotificationStatusFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
              }
              if (state is DeleteNotificationSuccessState) {
                ToastUtils.showCustomToast(
                    context, AppLocalizations.of(context).translate("notifications_successfully_deleted"), ToastStatus.SUCCESS);
                bloc.add(CountNotificationsEvent(
                    readStatus: "all", notificationType: "ALL"));
                if (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions"))
                if (isMarked) {
                  for (var element in transactionNotificationsList) {
                    element.isSelected = false;
                  }
                  for (var element in offerNotificationsList) {
                    element.isSelected = false;
                  }
                  for (var element in noticesNotificationsList) {
                    element.isSelected = false;
                  }
                }
                isMarked = false;
                pageNumberTran = 0;
                bloc.add(GetNotificationsEvent(
                    page: pageNumberTran,
                    size: 10,
                    readStatus: selectedTranOption??"all"));
                if (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers")) if (isMarked) {
                  for (var element in transactionNotificationsList) {
                    element.isSelected = false;
                  }
                  for (var element in offerNotificationsList) {
                    element.isSelected = false;
                  }
                  for (var element in noticesNotificationsList) {
                    element.isSelected = false;
                  }
                }
                isMarked = false;
                pageNumberPromo = 0;
                bloc.add(GetPromotionEvent(
                    page: pageNumberPromo,
                    size: 10,
                    readStatus: selectedPromoOption??"all"));
                if (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("notices")) if (isMarked) {
                  for (var element in transactionNotificationsList) {
                    element.isSelected = false;
                  }
                  for (var element in offerNotificationsList) {
                    element.isSelected = false;
                  }
                  for (var element in noticesNotificationsList) {
                    element.isSelected = false;
                  }
                }
                isMarked = false;
                pageNumberNotice = 0;
                bloc.add(GetNoticesEvent(
                    page: pageNumberNotice,
                    size: 10,
                    epicUserId: epicUserId,
                    readStatus: selectedNoticeOption??"all"));
              }
              if (state is DeleteNotificationFailedState){
                ToastUtils.showCustomToast(
                    context, AppLocalizations.of(context).translate("something_went_wrong"), ToastStatus.FAIL);
              }
            },
            child: Stack(
              children: [
                    (transactionNotificationsList.isEmpty|| offerNotificationsList.isEmpty || noticesNotificationsList.isEmpty )
                        && ((AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions") &&
                        selectedTranOption != null )||
                        (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers")
                            && selectedPromoOption != null )||
                        (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("notices")
                            &&  selectedNoticeOption != null))?
                        Center(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
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
                                    PhosphorIcons.bell(
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
                                    'no_result_found'),
                                style: size18weight700.copyWith(
                                    color: colors(context)
                                        .blackColor),textAlign: TextAlign.center,
                              ),
                              4.verticalSpace,
                              Text(
                                AppLocalizations.of(context)
                                    .translate(
                                    'adjust_your_filters'),
                                style: size14weight400.copyWith(
                                    color: colors(context)
                                        .greyColor),textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ) :((AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions") &&
                        transactionNotificationsList.isEmpty)||
                        (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers")
                            && offerNotificationsList.isEmpty)||
                        (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("notices")
                            && noticesNotificationsList.isEmpty))?
                        Center(
                          child: Column(
                          mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
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
                                PhosphorIcons.bell(
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
                                'no_notifications'),
                            style: size18weight700.copyWith(
                                color: colors(context)
                                    .blackColor),textAlign: TextAlign.center,
                          ),
                          4.verticalSpace,
                          Text(
                            AppLocalizations.of(context)
                                .translate('when_you_get'),
                            style: size14weight400.copyWith(
                                color: colors(context)
                                    .greyColor),textAlign: TextAlign.center,
                          )
                                                ],
                                              ),
                        ):SizedBox.shrink(),
                Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                decoration: BoxDecoration(
                                border: Border.all(
                                    color: colors(context).primaryColor50!),
                                color: colors(context).whiteColor,
                                borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    /// todo: sliding segment bar is not same as in figma
                                    for (int index = 0; index < tabs.length; index++)
                                      GestureDetector(
                                        onTap: () {
                                          current = index;
                                          if (isMarked) {
                                            for (var element
                                            in transactionNotificationsList) {
                                              element.isSelected = false;
                                            }
                                            for (var element
                                            in offerNotificationsList) {
                                              element.isSelected = false;
                                            }
                                            for (var element
                                            in noticesNotificationsList) {
                                              element.isSelected = false;
                                            }
                                          }
                                          isMarked = false;
                                          _selectAll = false;
                                          deletedList();
                                          setState(() {});
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            color: index == current
                                                ? colors(context).primaryColor
                                                : Colors.transparent,
                                          ),
                                          child: Padding(
                                            padding:
                                            EdgeInsets.symmetric(
                                                horizontal:index==0? 10:index == 1?8:8,
                                                vertical: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context).translate(tabs[index])  ,
                                                    style: index == current ? size14weight700.copyWith(color: colors(context).whiteColor) : size14weight700.copyWith(color: colors(context).blackColor)
                                                ),
                                                AppSizer.horizontalSpacing(8),
                                                if (tabs[index] == tabs[0])
                                                  Container(
                                                      // width: 24,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: index == current ? colors(context).whiteColor : colors(context).primaryColor,
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                                        child: Center(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(3.2),
                                                              child: Text(
                                                                tranNotificationCount != null ? tranNotificationCount.toString() : "0",
                                                                style: index == current ? size14weight700.copyWith(color: colors(context).primaryColor) : size14weight700.copyWith(color: colors(context).whiteColor),
                                                              ),)),
                                                      ))
                                                else if (tabs[index] == tabs[1])
                                                  Container(
                                                      // width: 24,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: index == current ? colors(context).whiteColor
                                                            : colors(context).primaryColor,
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                                        child: Center(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(3.2),
                                                              child: Text(
                                                                promoNotificationCount !=null ? promoNotificationCount.toString()
                                                                    : "0",
                                                                style: index == current ? size14weight700.copyWith(color: colors(context).primaryColor) : size14weight700.copyWith(color: colors(context).whiteColor),
                                                              ),)),
                                                      ))
                                                else
                                                  Container(
                                                      // width: 24,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: index == current ? colors(context).whiteColor
                                                            : colors(context).primaryColor,
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                                        child: Center(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(3.2),
                                                              child: Text(
                                                                noticesNotificationCount != null ? noticesNotificationCount.toString()
                                                                    : "0",
                                                                style: index == current ? size14weight700.copyWith(color: colors(context).primaryColor) : size14weight700.copyWith(color: colors(context).whiteColor),
                                                              ),)),
                                                      ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (selectedTranOption !="all" &&
                                    selectedTranOption != null &&
                                    AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions"))
                              Padding(
                                padding:  EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                                child: FilteredChip(
                                  height: 0,
                                  onTap: () {
                                    if (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions")) {
                                      pageNumberTran = 0;
                                       selectedTranOptionTemp = "all";
                                      selectedTranOption = null;

                                          bloc.add(GetNotificationsEvent(
                                          page: pageNumberTran,
                                          size: 10,
                                          readStatus: selectedTranOption ?? "all"));
                                    }
                                    setState(() {});
                                  },
                                  children: [
                                    Text(
                                        selectedTranOption=="read"?AppLocalizations.of(context).translate("read"):AppLocalizations.of(context).translate("unread"),
                                      style: size14weight400.copyWith(
                                          color: colors(context).greyColor),
                                    ),
                                  ],
                                ),
                              ),
                
                                if ( selectedPromoOption !="all" && selectedPromoOption!=null && AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers"))
                                Padding(
                                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                                child: Wrap(children: [
                                  FilteredChip(
                                     height: 0,
                                    onTap: () {
                                      if (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("notices")) {
                                        pageNumberPromo = 0;
                                        selectedPromoOption = null;
                                            selectedPromoOptionTemp = "all";

                                            bloc.add(GetPromotionEvent(
                                            page: pageNumberPromo,
                                            size: 10,
                                            readStatus:
                                                selectedPromoOption ?? "all"));
                                      }
                                      setState(() {});
                                    },
                                    children: [
                                      Text(
                                        selectedPromoOption=="read"?AppLocalizations.of(context).translate("read") :AppLocalizations.of(context).translate("unread") ,
                                        style: size14weight400.copyWith(
                                            color: colors(context).greyColor),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                                if (selectedNoticeOption !="all" && selectedNoticeOption!=null &&
                                    AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("notices"))
                                Padding(
                                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                                child: FilteredChip(
                                   height: 0,
                                  onTap: () {
                                    if (AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("notices")) {
                                      pageNumberNotice = 0;
                                      selectedNoticeOption = null;
                                          selectedNoticeOptionTemp = "all";
                                          bloc.add(GetNoticesEvent(
                                          page: pageNumberNotice,
                                          size: 10,
                                          readStatus: selectedNoticeOption ?? "all",
                                          epicUserId: epicUserId));
                                    }
                                    setState(() {});
                                  },
                                  children: [
                                    Text(
                                      selectedNoticeOption=="read"? AppLocalizations.of(context)
                                .translate("read") :AppLocalizations.of(context)
                                .translate("unread"),
                                      style: size14weight400.copyWith(
                                          color: colors(context).greyColor),
                                    ),
                                  ],
                                ),)
                
                            ],),
                          ),
                          AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("transactions")
                              && transactionNotificationsList.isNotEmpty
                           ?
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    controller: _scrollControllerTran,
                                    key: Key("transactions"),
                                    child: Padding(
                                      padding: EdgeInsets.only( bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: transactionNotificationsList.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                hoverDuration: Duration.zero,
                                                splashColor: Colors.transparent,
                                                  onLongPress: () {
                                                    setState(() {
                                                      isMarked = true;
                                                      transactionNotificationsList[index].isSelected = true;
                                                    });
                                                    setState(() {
                                                      selectedNotificationTranListForDelete.clear();
                                                      if (transactionNotificationsList[index].isSelected == true) {
                                                        selectedNotificationTranListForDelete.add(transactionNotificationsList[index].notificationId);
                                                      } else {
                                                        selectedNotificationTranListForDelete.remove(transactionNotificationsList[index].notificationId);
                                                      }
                                                    });},
                                                  onTap: () {
                                                                    if (transactionNotificationsList[index].isSelected == false) {
                                                                      if (isMarked) {
                                                                        setState(() {
                                                                          transactionNotificationsList[index].isSelected = true;
                                                                        });
                                                                      } else {
                                                                        setState(() {
                                                                          selectedNotificationListForTran.add(transactionNotificationsList[index].notificationId);
                                                                        });
                                                                        if (transactionNotificationsList[index].isRead == false) {
                                                                          selectedNotificationListForTranOnTap.clear();
                                                                          selectedNotificationListForTranOnTap.add(transactionNotificationsList[index].notificationId);
                                                                          transactionNotificationsList[index].isRead = true;
                                                                          bloc.add(MarkNotificationAsReadEvent(
                                                                              notifications: selectedNotificationListForTranOnTap,
                                                                              epicUserId: ''));
                                                                          setState(() {});
                                                                        }
                
                
                
                                                                        if (transactionNotificationsList[index].requestID != null) {
                                                                        if(transactionNotificationsList[index].reqMoneystatus == "active")
                                                                          showAppDialog(
                                                                            bottomButtonText: AppLocalizations.of(context).translate("later"),
                                                                              title: AppLocalizations.of(context).translate("request_money"),
                                                                              // message: splitAndJoinAtBrTags(transactionNotificationsList[index].body ?? " "),
                                                                              dialogContentWidget: Column(
                                                                                children: [
                                                                                  Text.rich(
                                                                                      textAlign: TextAlign.center,
                                                                                      TextSpan(children: [
                                                                                        TextSpan(
                                                                                            // text: "${extractTextWithinTags(input:  splitAndJoinAtBrTags(transactionNotificationsList[index].body ?? " "))[0]} ",
                                                                                            text: "${extractTextWithinTags(input:  splitAndJoinAtBrTags(transactionNotificationsList[index].body.toString() ?? " "))[0]} ",
                                                                                            style:size14weight700.copyWith(color: colors(context).greyColor)
                                                                                        ),
                                                                                        TextSpan(
                                                                                            // recognizer: TapGestureRecognizer()
                                                                                            //   ..onTap = () async {
                                                                                            //     extractTextWithinTags(input:  splitAndJoinAtBrTags(transactionNotificationsList[index].body ?? ""))[1];
                                                                                            //   },
                                                                                            text: "${extractTextWithinTags(input:  splitAndJoinAtBrTags(transactionNotificationsList[index].body.toString() ?? " "))[1]} \n",
                                                                                            style:size14weight400.copyWith(color: colors(context).greyColor)
                                                                                        ),
                                                                                        TextSpan(
                                                                                            // recognizer: TapGestureRecognizer()
                                                                                            //   ..onTap = () async {
                                                                                            //     extractTextWithinTags(input:  splitAndJoinAtBrTags(transactionNotificationsList[index].body ?? ""))[1];
                                                                                            //   },
                                                                                            text: "${extractTextWithinTags(input:  splitAndJoinAtBrTags(transactionNotificationsList[index].body.toString() ?? " "))[2]} ",
                                                                                            style:size14weight400.copyWith(color: colors(context).greyColor)
                                                                                        ),
                                                                                        TextSpan(
                                                                                            // recognizer: TapGestureRecognizer()
                                                                                            //   ..onTap = () async {
                                                                                            //     extractTextWithinTags(input:  splitAndJoinAtBrTags(transactionNotificationsList[index].body ?? ""))[1];
                                                                                            //   },
                                                                                            text: "${extractTextWithinTags(input:  splitAndJoinAtBrTags(transactionNotificationsList[index].body.toString() ?? " "))[3]}",
                                                                                            style:size14weight700.copyWith(color: colors(context).greyColor)
                                                                                        ),
                                                                                      ])
                
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              alertType: AlertType.MONEY1,
                                                                              onPositiveCallback:
                                                                                  () {
                                                                                    bloc.add(MoneyRequestNotificationEvent(
                                                                                          requestMoneyId:  transactionNotificationsList[index].requestID,
                                                                                          messageType: "requestMoney"));
                                                                                setState(() {
                                                                                  transactionNotificationsList[index].isRead = true;
                                                                                });
                                                                              },
                                                                              positiveButtonText: AppLocalizations.of(context).translate("yes_accept"),
                                                                              negativeButtonText: AppLocalizations.of(context).translate("reject"),
                                                                              onBottomButtonCallback: (){
                                                                                extractTextWithinTags(input:  splitAndJoinAtBrTags(transactionNotificationsList[index].body ?? ""))[2];
                
                                                                              },
                                                                              onNegativeCallback: () {
                                                                                bloc.add(ReqMoneyNotificationStatusEvent(
                                                                                    requestMoneyId: transactionNotificationsList[index].requestID,
                                                                                    messageType: "requestMoney",
                                                                                    status: "rejected",
                                                                                    transactionStatus: "fail"));
                                                                                 requestMoneyId= transactionNotificationsList[index].requestID;
                                                                                 requestMoneyStatus = "rejected";
                                                                                setState(() {
                                                                                  transactionNotificationsList[index].isRead =
                                                                                      true;
                                                                                });
                                                                              });
                                                                        } else {
                                                                          final result = showModalBottomSheet<bool>(
                                                                              isScrollControlled: true,
                                                                              useRootNavigator: true,
                                                                              useSafeArea: true,
                                                                              context: context,
                                                                              barrierColor: colors(context).blackColor?.withOpacity(.85),
                                                                              backgroundColor: Colors.transparent,
                                                                              builder: (context,) => StatefulBuilder(
                                                                                  builder: (context,changeState) {
                                                                                    return BottomSheetBuilder(
                                                                                      title: "",
                                                                                      buttons: [
                                                                                      ],
                                                                                      children: [
                                                                                        Container(
                                                                                          decoration: BoxDecoration(
                                                                                            borderRadius: BorderRadius.circular(8).r,
                                                                                            color: colors(context).greyColor50,
                                                                                          ),
                                                                                        child: Column(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            20.verticalSpace,
                                                                                            Container(
                                                                                                decoration: BoxDecoration(
                                                                                                  color: colors(context).positiveColor,
                                                                                                  shape: BoxShape.circle,),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(10.0).w,
                                                                                                  child: PhosphorIcon(PhosphorIcons.check(PhosphorIconsStyle.bold),
                                                                                                  color: colors(context).whiteColor,
                                                                                                  ),
                                                                                                )),
                                                                                            12.verticalSpace,
                                                                                            Text(
                                                                                                transactionNotificationsList[index].txnType == "BILLPAY" ?AppLocalizations.of(context).translate("bill_payment_was_successful") :AppLocalizations.of(context).translate("fund_transfer_was_successful"),
                                                                                              style: size16weight700.copyWith(color: colors(context).blackColor),
                                                                                            ),
                                                                                            16.verticalSpace,
                                                                                            Center(
                                                                                              child: Row(
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Text(AppLocalizations.of(context).translate("lkr") , style: size20weight700.copyWith(color: colors(context).primaryColor),),
                                                                                                  8.horizontalSpace,
                                                                                                  Text('${transactionNotificationsList[index].amount!.withThousandSeparator()}' , style: size20weight700.copyWith(color: colors(context).primaryColor),),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            4.verticalSpace,
                                                                                            Text((transactionNotificationsList[index].txnType == "OWNUB" || transactionNotificationsList[index].txnType == "WITHINUB" )? AppLocalizations.of(context).translate("union_bank") : "" , style: size14weight700.copyWith(color: colors(context).primaryColor),),
                                                                                            20.verticalSpace,
                                                                                          ],
                                                                                        ),
                                                                                        ),
                                                                                        16.verticalSpace,
                                                                                        FTSummeryDataComponent(
                                                                                          title: AppLocalizations.of(context).translate("Pay_From"),
                                                                                          data: transactionNotificationsList[index].payFromName ?? "-",
                                                                                          subData: transactionNotificationsList[index].payFromNo ?? "-",
                                                                                        ),
                                                                                        FTSummeryDataComponent(
                                                                                          title: AppLocalizations.of(context).translate("Pay_To"),
                                                                                          data: transactionNotificationsList[index].payToName ?? "-",
                                                                                          subData: transactionNotificationsList[index].payToNo ?? "-",
                                                                                        ),
                                                                                        FTSummeryDataComponent(
                                                                                          title: AppLocalizations.of(context).translate("amount"),
                                                                                          isCurrency: true,
                                                                                          amount: double.parse(transactionNotificationsList[index].amount ?? "0") ,
                                                                                        ),
                                                                                        FTSummeryDataComponent(
                                                                                          title: AppLocalizations.of(context).translate("remarks"),
                                                                                          data: transactionNotificationsList[index].remarks ?? "" ,
                                                                                        ),
                                                                                        FTSummeryDataComponent(
                                                                                          title: AppLocalizations.of(context).translate("date_&_time"),
                                                                                          data: "${DateFormat('dd-MMMM-yyyy | HH:mm a').format(transactionNotificationsList[index].date!)}",
                                                                                        ),
                                                                                        FTSummeryDataComponent(
                                                                                          title: AppLocalizations.of(context).translate("reference_number"),
                                                                                          data: transactionNotificationsList[index].reference ?? "",
                                                                                          isLastItem: true,
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  }
                                                                              ));
                                                                        }
                                                                      }
                                                                    } else {
                                                                      setState(() {
                                                                        transactionNotificationsList[index].isSelected = false;
                                                                        if (transactionNotificationsList.where((element) => element.isSelected == true).length == 0) {
                                                                          isMarked = false;
                                                                          _selectAll = false;
                                                                        }
                                                                      });
                                                                    }
                                                                    setState(() {
                                                                      if (transactionNotificationsList[index].isSelected == true) {
                                                                        selectedNotificationTranListForDelete.add(transactionNotificationsList[index].notificationId);
                                                                      } else {
                                                                        selectedNotificationTranListForDelete.remove(transactionNotificationsList[index].notificationId);
                                                                      }
                                                                    });
                                                                  },
                                                  child: Container(
                                                   color: transactionNotificationsList[index].isRead
                                                    ? colors(context).whiteColor
                                                    : colors(context).secondaryColor50,
                                                    child: Row(
                                                      children: [
                                                         transactionNotificationsList.any((notification) => notification.isSelected,)?10.horizontalSpace:4.horizontalSpace,
                                                        if(transactionNotificationsList.any((notification) => notification.isSelected,))
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20),
                                                            child: SizedBox(
                                                              width: 20.w,
                                                              height: 20.w,
                                                              child: Checkbox(
                                                                splashRadius: 0,
                                                                shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(4).r),
                                                                    checkColor: colors(context).whiteColor,
                                                                    activeColor: colors(context).primaryColor,
                                                                value: transactionNotificationsList[index].isSelected,
                                                                onChanged: (value) {
                                                                  transactionNotificationsList[index].isSelected = !transactionNotificationsList[index].isSelected;
                                                                    setState(() {
                                                                          if (transactionNotificationsList[index].isSelected == true) {
                                                                            selectedNotificationTranListForDelete.add(transactionNotificationsList[index].notificationId);
                                                                          } else {
                                                                            selectedNotificationTranListForDelete.remove(transactionNotificationsList[index].notificationId);
                                                                          }
                                                                        });
                                                                  setState(() {});
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        Expanded(
                                                          child: NotificationComponent(
                                                            isNotices: false,
                                                            isOffer: false,
                                                            data: transactionNotificationsList[index],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                              if (transactionNotificationsList.length - 1 != index)
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                                  child: Divider(
                                                    thickness: 1,
                                                    height: 0,
                                                  ),)
                                            ],);
                                          },),
                                    ),
                                  )
                                ),
                                Visibility(
                                  visible: transactionNotificationsList.any((notification) => notification.isSelected,),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(16.w,20.h,16.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          AppButton(
                                              buttonText: AppLocalizations.of(context).translate("select_all"),
                                              onTapButton: (){
                                                setState(() {
                                                  _selectAll = !_selectAll;
                                                  for (var notification in transactionNotificationsList) {
                                                    notification.isSelected = _selectAll;
                                                  }
                                                  if (_selectAll == false) {
                                                    isMarked = false;
                                                  }
                                                  selectedNotificationTranListForDelete.addAll(
                                                      transactionNotificationsList.map((transaction) => transaction.notificationId)
                                                  );
                                                }
                                                );},
                                          ),
                                          16.verticalSpace,
                                          AppButton(
                                            buttonType: ButtonType.OUTLINEENABLED,
                                            buttonText: AppLocalizations.of(context).translate("cancel"),
                                            onTapButton: (){
                                              setState(() {
                                                isMarked = false;
                                                transactionNotificationsList.any((notification) => notification.isSelected = false,);
                                              });},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                          : AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("offers") &&
                              offerNotificationsList.isNotEmpty ?
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    controller: _scrollControllerPromo,
                                    key: Key("offers"),
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: offerNotificationsList.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                 hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                hoverDuration: Duration.zero,
                                                splashColor: Colors.transparent,
                                                onLongPress: () {
                                                                      setState(() {
                                                                        isMarked = true;
                                                                        offerNotificationsList[index].isSelected = true;
                                                                      });
                                                                      setState(() {
                                                                        selectedNotificationOfferListForDelete.clear();
                                                                        if (offerNotificationsList[index].isSelected == true) {
                                                                          selectedNotificationOfferListForDelete.add(offerNotificationsList[index].notificationId);
                                                                        } else {
                                                                          selectedNotificationOfferListForDelete.remove(
                                                                                  offerNotificationsList[index].notificationId);
                                                                        }
                                                                      });
                                                                    },
                                                onTap: () {
                                                                      if (offerNotificationsList[index].isRead == false) {
                                                                        selectedNotificationListForOffrerOnTap.clear();
                                                                        selectedNotificationListForOffrerOnTap.add(
                                                                            offerNotificationsList[index].notificationId);
                                                                        bloc.add(MarkNotificationAsReadEvent(
                                                                            notifications: selectedNotificationListForOffrerOnTap,
                                                                            epicUserId: ''));
                                                                        offerNotificationsList[index].isRead = true;
                                                                        bloc.add(CountNotificationsEvent(
                                                                            readStatus: "all",
                                                                            notificationType: "ALL"));
                                                                            if(offerNotificationsList[index].isRead){
                                                                               bloc.add(GetPromotionEvent(
                                                                                 page: pageNumberPromo, size: 10, readStatus: selectedPromoOption??"all"));
                                                                            }
                                      
                                                                        setState(() {});
                                                                      }
                                                                      if (offerNotificationsList[index].isSelected == false) {
                                                                        if (isMarked) {
                                                                          setState(() {
                                                                            offerNotificationsList[index].isSelected = true;
                                                                          });
                                                                        } else {
                                                                          setState(() {
                                                                            selectedNotificationListForOffrer.add(
                                                                                offerNotificationsList[index].notificationId);
                                                                          });
                                                                          Navigator.pushNamed(context,
                                                                              Routes.kOfferPreview,
                                                                              arguments: OfferArgs(
                                                                                  offerImage: offerNotificationsList[index].imagePromo!,
                                                                                  title: offerNotificationsList[index].title,
                                                                                  description: offerNotificationsList[index].body ?? "",
                                                                                  validTime: '${offerNotificationsList[index].category}'));
                                                                        }
                                                                      } else {
                                                                        setState(() {
                                                                          offerNotificationsList[index].isSelected = false;
                                                                          if (offerNotificationsList.where((element) => element.isSelected == true).length == 0) {
                                                                            isMarked = false;
                                                                            _selectAll = false;
                                                                          }
                                                                        });
                                                                      }
                                                                      setState(() {
                                                                        if (offerNotificationsList[index].isSelected == true) {
                                                                          selectedNotificationOfferListForDelete.add(offerNotificationsList[index].notificationId);
                                                                        } else {
                                                                          selectedNotificationOfferListForDelete.remove(offerNotificationsList[index].notificationId);
                                                                        }
                                                                      });
                                                                    },
                                                child: Container(
                                                   color: offerNotificationsList[index].isRead
                                                    ? colors(context).whiteColor
                                                    : colors(context).secondaryColor50,
                                                  child: Row(
                                                    children: [
                                                       offerNotificationsList.any((notification) => notification.isSelected,)?10.horizontalSpace:4.horizontalSpace,
                                                      if(offerNotificationsList.any((notification) => notification.isSelected))
                                                        Padding(
                                                            padding: const EdgeInsets.only(left: 20),
                                                          child: SizedBox(
                                                            width: 20.w,
                                                            height: 20.w,
                                                            child: Checkbox(
                                                              splashRadius: 0,
                                                              shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(4).r),
                                                                                                            checkColor: colors(context).whiteColor,
                                                                                                            activeColor: colors(context).primaryColor,
                                                              value: offerNotificationsList[index].isSelected,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  offerNotificationsList[index].isSelected = !offerNotificationsList[index].isSelected;
                                                                });
                                                                 setState(() {
                                                                    if (offerNotificationsList[index].isSelected == true) {
                                                                      selectedNotificationOfferListForDelete.add(offerNotificationsList[index].notificationId);
                                                                    } else {
                                                                      selectedNotificationOfferListForDelete.remove(offerNotificationsList[index].notificationId);
                                                                    }
                                                                  });
                                                                },
                                                            ),
                                                          ),
                                                        ),
                                                      Expanded(
                                                        child: NotificationComponent(
                                                          isNotices: false,
                                                          isOffer: true,
                                                          data: offerNotificationsList[index],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if (offerNotificationsList.length - 1 != index)
                                                const Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: 25),
                                                                      child: Divider(
                                                                        thickness: 1,
                                                                        height: 0,
                                                                      ),
                                                                    )
                                            ],
                                          );
                                          },
                                      ),
                                    ),
                                  )
                                ),
                                Visibility(
                                  visible: offerNotificationsList.any((notification) => notification.isSelected,),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(16.w,20.h,16.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          AppButton(
                                            buttonText: AppLocalizations.of(context).translate("select_all"),
                                            onTapButton: (){
                                              setState(() {
                                                _selectAll = !_selectAll;
                                                for (var notification in offerNotificationsList) {
                                                  notification.isSelected = _selectAll;
                                                }
                                                if (_selectAll == false) {
                                                  isMarked = false;}
                                                selectedNotificationOfferListForDelete.addAll(
                                                    offerNotificationsList.map((notification) => notification.notificationId)
                                                );
                                              }
                                              );},
                                          ),
                                          16.verticalSpace,
                                          AppButton(
                                            buttonType: ButtonType.OUTLINEENABLED,
                                            buttonText: AppLocalizations.of(context).translate("cancel"),
                                            onTapButton: (){
                                              setState(() {
                                                isMarked = false;
                                                offerNotificationsList.any((notification) => notification.isSelected = false,);
                                              });},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              
                              ],),)
                              :  noticesNotificationsList.isNotEmpty && AppLocalizations.of(context).translate(tabs[current]) == AppLocalizations.of(context).translate("notices")
                              ? 
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    controller: _scrollControllerNotices,
                                    key: Key("notices"),
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: noticesNotificationsList.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                 hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                hoverDuration: Duration.zero,
                                                splashColor: Colors.transparent,
                                                onLongPress: () {
                                                  setState(() {
                                                    isMarked = true;
                                                    noticesNotificationsList[index].isSelected = true;});
                                                  setState(() {
                                                    selectedNotificationNoticeListForDelete.clear();
                                                    if (noticesNotificationsList[index].isSelected == true) {
                                                      selectedNotificationNoticeListForDelete.add(noticesNotificationsList[index].notificationId);
                                                    } else {
                                                      selectedNotificationNoticeListForDelete.remove(noticesNotificationsList[index].notificationId);
                                                    }
                                                  });},
                                                onTap: () async {
                                                  if (noticesNotificationsList[index].isSelected == false) {
                                                    if (isMarked) {
                                                      setState(() {
                                                        noticesNotificationsList[index].isSelected = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        selectedNotificationListForNotice.add(noticesNotificationsList[index].notificationId);
                                                      });
                                                      if (noticesNotificationsList[index].isRead == false) {
                                                        selectedNotificationListForNoticeOnTap.clear();
                                                        selectedNotificationListForNoticeOnTap.add(noticesNotificationsList[index].notificationId);
                                                        bloc.add(MarkNotificationAsReadEvent(
                                                            notifications: selectedNotificationListForNoticeOnTap,
                                                            epicUserId: ''));
                                                        setState(() {});
                                                      }
                                                      if (noticesNotificationsList[index].requestID != null) {
                                                      } else {
                                                        if (noticesNotificationsList[index].isRead == false) {
                                                              bloc.add(CountNotificationsEvent(
                                                                  readStatus: "all",
                                                                  notificationType: "ALL"));
                                                              setState(() {
                                                                noticesNotificationsList[index].isRead = true;
                                                              });
                                                              if(noticesNotificationsList[index].isRead){
                                                                    bloc.add(GetNoticesEvent(
                                                                    page: pageNumberNotice,
                                                                    size: 10,
                                                                    epicUserId: epicUserId,
                                                                    readStatus: selectedNoticeOption??"all"));
                                                              }
                                                            }
                                                            await Navigator.pushNamed(context,
                                                                              Routes.kNoticePreview,
                                                                              arguments: noticesNotificationsList[index]);
                                                      }
                                                    }
                                                  } else {
                                                    setState(() {
                                                      noticesNotificationsList[index].isSelected = false;
                                                      if (noticesNotificationsList.where((element) => element.isSelected == true).length == 0) {
                                                        isMarked = false;
                                                        _selectAll = false;
                                                      }
                                                    });
                                                  }
                                                  setState(() {
                                                    if (noticesNotificationsList[index].isSelected == true) {
                                                      selectedNotificationNoticeListForDelete.add(
                                                          noticesNotificationsList[index].notificationId);
                                                    } else {
                                                      selectedNotificationNoticeListForDelete.remove(noticesNotificationsList[index].notificationId);
                                                    }
                                                  });},
                                                child:
                                                Container(
                                                   color: noticesNotificationsList[index].isRead
                                                    ? colors(context).whiteColor
                                                    : colors(context).secondaryColor50,
                                                  child: Row(
                                                    children: [
                                                      noticesNotificationsList.any((notification) => notification.isSelected,)?10.horizontalSpace:
                                                      4.horizontalSpace,
                                                      if(noticesNotificationsList.any((notification) => notification.isSelected))
                                                        Padding(
                                                            padding: const EdgeInsets.only(left: 20),
                                                          child: SizedBox(
                                                            width: 20.w,
                                                            height: 20.w,
                                                            child: Checkbox(
                                                              splashRadius: 0,
                                                              shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(4).r),
                                                                  checkColor: colors(context).whiteColor,
                                                                  activeColor: colors(context).primaryColor,
                                                              value: noticesNotificationsList[index].isSelected,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  noticesNotificationsList[index].isSelected = !noticesNotificationsList[index].isSelected;
                                                                });
                                                                 setState(() {
                                                                    if (noticesNotificationsList[index].isSelected == true) {
                                                                      selectedNotificationNoticeListForDelete.add(noticesNotificationsList[index].notificationId);
                                                                    } else {
                                                                      selectedNotificationNoticeListForDelete.remove(noticesNotificationsList[index].notificationId);
                                                                    }
                                                                  });
                                                                },
                                                            ),
                                                          ),
                                                        ),
                                                      Expanded(
                                                        child: NotificationComponent(
                                                          isNotices: true,
                                                          isOffer: false,
                                                          data: noticesNotificationsList[index],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if (noticesNotificationsList.length - 1 != index)
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                                  child: Divider(
                                                    thickness: 1,
                                                    height: 0,
                                                  ),
                                                )
                                            ],
                                          );},
                                      ),
                                    ),
                                  ),
                                ),
                                 Visibility(
                                  visible: noticesNotificationsList.any((notification) => notification.isSelected,),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(16.w,20.h,16.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          AppButton(
                                            buttonText: AppLocalizations.of(context).translate("select_all"),
                                            onTapButton: (){
                                              setState(() {
                                                _selectAll = !_selectAll;
                                                for (var notification in noticesNotificationsList) {
                                                  notification.isSelected = _selectAll;
                                                }
                                                if (_selectAll == false) {
                                                  isMarked = false;}
                                                selectedNotificationNoticeListForDelete.addAll(
                                                    noticesNotificationsList.map((notification) => notification.notificationId)
                                                );
                                              }
                                              );},
                                          ),
                                          16.verticalSpace,
                                          AppButton(
                                            buttonType: ButtonType.OUTLINEENABLED,
                                            buttonText: AppLocalizations.of(context).translate("cancel"),
                                            onTapButton: (){
                                              setState(() {
                                                isMarked = false;
                                                noticesNotificationsList.any((notification) => notification.isSelected = false,);
                                              });},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                // Visibility(
                                //   visible: noticesNotificationsList.any((notification) => notification.isSelected,),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(10),
                                //     child: SizedBox(
                                //       height: 30,
                                //       child: Row(
                                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //         children: [
                                //           Image.asset(
                                //             AppAssets.icSelectAll,
                                //             scale: 3,
                                //           ),
                                //           InkWell(
                                //             onTap: () {
                                //               setState(() {
                                //                 _selectAll = !_selectAll;
                                //                 for (var notification in noticesNotificationsList) {
                                //                   notification.isSelected = _selectAll;
                                //                 }
                                //                 if (_selectAll == false) {
                                //                   isMarked = false;
                                //                 }
                                //               });},
                                //             child: Text(
                                //               AppLocalizations.of(context).translate("select_all"),
                                //               style: TextStyle(
                                //                   fontWeight: FontWeight.w600,
                                //                   fontSize: 16,
                                //                   color: colors(context).secondaryColor300),
                                //             ),
                                //           ),
                                //           const VerticalDivider(
                                //             thickness: 1,
                                //           ),
                                //           Image.asset(
                                //             AppAssets.icMark,
                                //             scale: 3,
                                //           ),
                                //           InkWell(
                                //             onTap: () {
                                //               setState(() {
                                //                 isMarkeClicked = true;
                                //                 bloc.add(MarkNotificationAsReadEvent(
                                //                     notifications: selectedNotificationNoticeListForDelete.toSet().toList(),
                                //                     epicUserId: ''));
                                //               });
                                //               },
                                //             child: Text(
                                //               AppLocalizations.of(context).translate("mark_all_as_read"),
                                //               style: TextStyle(
                                //                   fontWeight: FontWeight.w600,
                                //                   fontSize: 16,
                                //                   color: colors(context).secondaryColor300),
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],),):SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  String formatDate(DateTime dateTime) {
    final formatter = DateFormat('dd-MMM-yyyy | hh:mm a');
    return formatter.format(dateTime);
  }

  String getTranType(String tranType) {
    switch (tranType) {
      case 'WITHINUB':
        return 'Transfers to Third Party within UB';
      case 'OWNUB':
        return 'Transfers to Own UB Accounts';
      case 'UTILPAY':
        return 'Utility Payments';
      case 'OTHERBANK':
        return 'Transfers to Other Banks';
      case 'BILLPAY':
        return 'Bill Payments';
      case 'FT':
        return 'Fund Transfer';
      default:
        return 'Txn';
    }
  }

  onBackPressed() {
    setState(() {
      noticesNotificationsList.forEach((element) {
        element.isSelected = false;
      });
      transactionNotificationsList.forEach((element) {
        element.isSelected = false;
      });
      offerNotificationsList.forEach((element) {
        element.isSelected = false;
      });
      isMarked = false;
      // Navigator.pop(context , Routes.kHomeBaseView);
      Navigator.pushNamedAndRemoveUntil(context,Routes.kHomeBaseView,(route) => false, );
    });
  }

  deletedList(){
    if(selectedNotificationTranListForDelete.length > 0){
      selectedNotificationTranListForDelete.clear();
    }
    if(selectedNotificationOfferListForDelete.length > 0){
      selectedNotificationOfferListForDelete.clear();
    }
    if(selectedNotificationNoticeListForDelete.length > 0){
      selectedNotificationNoticeListForDelete.clear();
    }
    if(selectedNotificationListForTran.length > 0){
      selectedNotificationListForTran.clear();
    }
    if(selectedNotificationListForOffrer.length > 0){
      selectedNotificationListForOffrer.clear();
    }
    if(selectedNotificationListForNotice.length > 0){
      selectedNotificationListForNotice.clear();
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
