// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/view_mail_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/mailbox/mailbox_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/mailbox/mailbox_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/mailbox/mailbox_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/compose_mail_result.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/mail_data.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/mail_filter.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/widgets/mailbox_component.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/bottom_sheet.dart';
import 'package:union_bank_mobile/features/presentation/widgets/date_pickers/app_date_picker.dart';
import 'package:union_bank_mobile/features/presentation/widgets/drop_down_widgets/drop_down.dart';
import 'package:union_bank_mobile/features/presentation/widgets/filtered_chip.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

class MailBoxView extends BaseView {
  final bool isFromHome;

  MailBoxView({super.key, this.isFromHome = false});

  @override
  State<MailBoxView> createState() => _MailBoxViewState();
}

class _MailBoxViewState extends BaseViewState<MailBoxView> {
  var bloc = injection<MailBoxBloc>();

  int currentTab = 0;
  // String mailFilter.readStatus = "all";

  List<int> tabs = [0, 1, 2];

  List<ViewMailData> inboxData = [];
  List<int> inboxSelectedMail = [];

  List<ViewMailData> sentData = [];

  List<ViewMailData> draftData = [];

  MailFilter mailFilter = MailFilter();

  final _scrollControllerInbox = ScrollController();
  final _scrollControllerSent = ScrollController();
  final _scrollControllerDraft = ScrollController();

  int inboxCount = 0;
  int sentCount = 0;
  int draftCount = 0;

  int pageNumberInbox = 1;
  int pageNumberSent = 1;
  int pageNumberDraft = 1;

  String? toDate;
  DateTime? fromDateV;
  DateTime? toDateV;
  String? fromDate;
  String? status;
  bool hasAttachment = false;

  CommonDropDownResponse? initialRecipientType;
  CommonDropDownResponse? initialRecipientCategory;
  late TextEditingController _subjectController;

  List<CommonDropDownResponse> recipientCategory = [];
  CommonDropDownResponse? tempRecipientCategory = CommonDropDownResponse();
  List<CommonDropDownResponse> searchRecipientCategory = [];

  List<CommonDropDownResponse> recipientType = [];
  CommonDropDownResponse? tempRecipientType = CommonDropDownResponse();

  @override
  void initState() {
    bloc.add(GetViewMailEvent(
        page: 1,
        size: 20,
        recipientCategoryCode: mailFilter.recipientCategoryCode?.code,
        recipientTypeCode: mailFilter.recipientTypeCode?.code,
        fromDate: mailFilter.fromDate,
        toDate: mailFilter.toDate,
        readStatus: mailFilter.readStatus,
        hasAttachment: mailFilter.hasAttachment,
        subject: mailFilter.subject));

    bloc.add(MailboxRecipientCategoryEvent());
    _scrollControllerInbox.addListener(_onScrollInbox);
    _scrollControllerSent.addListener(_onScrollSent);
    _scrollControllerDraft.addListener(_onScrollDraft);

    _subjectController = TextEditingController();
    super.initState();
  }

  _onScrollInbox() {
    if (inboxCount != inboxData.length) {
      final maxScroll = _scrollControllerInbox.position.maxScrollExtent;
      final currentScroll = _scrollControllerInbox.position.pixels;
      if (maxScroll - currentScroll == 0) {
        bloc.add(GetViewMailEvent(
            page: pageNumberInbox,
            size: 20,
            recipientCategoryCode: mailFilter.recipientCategoryCode?.code,
            recipientTypeCode: mailFilter.recipientTypeCode?.code,
            fromDate: mailFilter.fromDate,
            toDate: mailFilter.toDate,
            readStatus: mailFilter.readStatus,
            hasAttachment: mailFilter.hasAttachment,
            subject: mailFilter.subject));
      }
    }
  }

  _onScrollSent() {
    if (sentCount != sentData.length) {
      final maxScroll = _scrollControllerSent.position.maxScrollExtent;
      final currentScroll = _scrollControllerSent.position.pixels;
      if (maxScroll - currentScroll == 0) {
        bloc.add(GetViewMailEvent(
            page: pageNumberSent,
            size: 20,
            recipientCategoryCode: mailFilter.recipientCategoryCode?.code,
            recipientTypeCode: mailFilter.recipientTypeCode?.code,
            fromDate: mailFilter.fromDate,
            toDate: mailFilter.toDate,
            readStatus: mailFilter.readStatus,
            hasAttachment: mailFilter.hasAttachment,
            subject: mailFilter.subject));
      }
    }
  }

  _onScrollDraft() {
    if (draftCount != draftData.length) {
      final maxScroll = _scrollControllerDraft.position.maxScrollExtent;
      final currentScroll = _scrollControllerDraft.position.pixels;
      if (maxScroll - currentScroll == 0) {
        bloc.add(GetViewMailEvent(
            page: pageNumberDraft,
            size: 20,
            recipientCategoryCode: mailFilter.recipientCategoryCode?.code,
            recipientTypeCode: mailFilter.recipientTypeCode?.code,
            fromDate: mailFilter.fromDate,
            toDate: mailFilter.toDate,
            readStatus: mailFilter.readStatus,
            hasAttachment: mailFilter.hasAttachment,
            subject: mailFilter.subject));
      }
    }
  }

  String tabsTitleLang(BuildContext context, int tab) {
    switch (tab) {
      case 0:
        return AppLocalizations.of(context).translate("inbox");
      case 1:
        return AppLocalizations.of(context).translate("sent");
      case 2:
        return AppLocalizations.of(context).translate("drafts");
      default:
        return AppLocalizations.of(context).translate("inbox");
    }
  }

  WHERE  where = WHERE.NONE;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: (currentTab == 0 && inboxData.isNotEmpty)
          ? colors(context).whiteColor
          : (currentTab == 1 && sentData.isNotEmpty)
              ? colors(context).whiteColor
              : (currentTab == 2 && draftData.isNotEmpty)
                  ? colors(context).whiteColor
                  : colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("mail_box"),
        goBackEnabled: widget.isFromHome ? true : false,
        actions: [
          IconButton(
              onPressed: () async {
                final result = await showModalBottomSheet<bool>(
                    isScrollControlled: true,
                    useRootNavigator: true,
                    useSafeArea: true,
                    context: context,
                    barrierColor: colors(context).blackColor?.withOpacity(.85),
                    backgroundColor: Colors.transparent,
                    builder: (
                      context,
                    ) =>
                        StatefulBuilder(builder: (context, changeState) {
                          return BottomSheetBuilder(
                            title: AppLocalizations.of(context)
                                .translate('filter_by'),
                                isTwoButton: true,
                            buttons: [
                              Expanded(
                                child: AppButton(
                                    buttonType: ButtonType.OUTLINEENABLED,
                                    buttonText: AppLocalizations.of(context)
                                        .translate("reset"),
                                    onTapButton: () {
                                      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                      if (mailFilter.isFiltered == true) {
                                        changeState(() {
                                          inboxData.clear();
                                          draftData.clear();
                                          sentData.clear();
                                          mailFilter = MailFilter();
                                          pageNumberInbox = 1;
                                          pageNumberSent = 1;
                                          pageNumberDraft = 1;
                                        });

                                        bloc.add(GetViewMailEvent(
                                            page: 1,
                                            size: 20,
                                            recipientCategoryCode: mailFilter
                                                .recipientCategoryCode?.code,
                                            recipientTypeCode: mailFilter
                                                .recipientTypeCode?.code,
                                            fromDate: mailFilter.fromDate,
                                            toDate: mailFilter.toDate,
                                            readStatus: mailFilter.readStatus,
                                            hasAttachment:
                                                mailFilter.hasAttachment,
                                            subject: mailFilter.subject));
                                      }
                                      changeState(() {
                                        initialRecipientCategory = null;
                                        initialRecipientType = null;
                                        tempRecipientCategory = null;
                                        tempRecipientType = null;
                                        _subjectController.clear();
                                        toDate = null;
                                        toDateV = null;
                                        fromDateV = null;
                                        fromDate = null;
                                        status = null;
                                        hasAttachment = false;
                                      });
                                    }),
                              ),
                              16.horizontalSpace,
                              Expanded(
                                child: AppButton(
                                  buttonType: _isDateRangeValid() || validate()
                                      ? ButtonType.PRIMARYDISABLED
                                      : ButtonType.PRIMARYENABLED,
                                  buttonText: AppLocalizations.of(context)
                                      .translate("apply"),
                                  onTapButton: () {
                                    changeState(() {
                                      pageNumberInbox = 1;
                                      pageNumberSent = 1;
                                      pageNumberDraft = 1;

                                      mailFilter = MailFilter(
                                          isFiltered: true,
                                          subject:
                                              _subjectController.text.isEmpty
                                                  ? null
                                                  : _subjectController.text,
                                          recipientCategoryCode:
                                              initialRecipientCategory,
                                          recipientTypeCode:
                                              initialRecipientType,
                                          fromDate: fromDateV,
                                          toDate: toDateV,
                                          hasAttachment:
                                              hasAttachment == true ? 1 : null,
                                          readStatus: status);
                                    });

                                    bloc.add(GetViewMailEvent(
                                        page: 1,
                                        size: 20,
                                        recipientCategoryCode: mailFilter
                                            .recipientCategoryCode?.code,
                                        recipientTypeCode:
                                            mailFilter.recipientTypeCode?.code,
                                        fromDate: mailFilter.fromDate,
                                        toDate: mailFilter.toDate,
                                        readStatus: mailFilter.readStatus,
                                        hasAttachment: mailFilter.hasAttachment,
                                        subject: mailFilter.subject));

                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ),
                            ],
                            children: [
                              AppDropDown(
                                labelText: AppLocalizations.of(context)
                                    .translate("select_category"),
                                label: AppLocalizations.of(context)
                                    .translate("recipient_category"),
                                onTap: () async {
                                  final result = await showModalBottomSheet<
                                          bool>(
                                      isScrollControlled: true,
                                      useRootNavigator: true,
                                      useSafeArea: true,
                                      context: context,
                                      barrierColor: colors(context).blackColor?.withOpacity(.85),
                                      backgroundColor: Colors.transparent,
                                      builder: (
                                        context,
                                      ) =>
                                          StatefulBuilder(
                                              builder: (context, changeState) {
                                            return BottomSheetBuilder(
                                              isSearch: true,
                                              onSearch: (p0) {
                                                changeState(() {
                                                  if (p0.isEmpty || p0 == '') {
                                                    searchRecipientCategory =
                                                        recipientCategory;
                                                  } else {
                                                    searchRecipientCategory =
                                                        recipientCategory
                                                            .where((element) => element
                                                                .description!
                                                                .toLowerCase()
                                                                .contains(p0
                                                                    .toLowerCase())).toSet()
                                                            .toList();
                                                  }
                                                });
                                              },
                                              title: AppLocalizations.of(
                                                      context)
                                                  .translate("select_recipient_category"),
                                              buttons: [
                                                Expanded(
                                                  child: AppButton(
                                                      buttonType: ButtonType
                                                          .PRIMARYENABLED,
                                                      buttonText:
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  "continue"),
                                                      onTapButton: () {
                                                        initialRecipientCategory =
                                                            tempRecipientCategory;
                                                        initialRecipientType =
                                                            null;
                                                        tempRecipientType =
                                                            null;

                                                       WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                        Navigator.of(context)
                                                            .pop(true);
                                                        changeState(() {});
                                                        setState(() {});
                                                      }),
                                                ),
                                              ],
                                              children: [
                                                ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      searchRecipientCategory
                                                          .length,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        tempRecipientCategory =
                                                            searchRecipientCategory[
                                                                index];
                                                        changeState(() {});
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:  EdgeInsets.only(top:  index == 0 ?0:20,bottom:  20).h,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  searchRecipientCategory[
                                                                          index]
                                                                      .description!,
                                                                  style: size16weight700
                                                                      .copyWith(
                                                                    color: colors(
                                                                            context)
                                                                        .blackColor,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right: 8).w,
                                                                  child: UBRadio<
                                                                          dynamic>(
                                                                    value: searchRecipientCategory[index]
                                                                            .code ??
                                                                        "",
                                                                    groupValue:
                                                                        tempRecipientCategory
                                                                            ?.code,
                                                                  
                                                                    onChanged:
                                                                        (dynamic
                                                                            value) {
                                                                      tempRecipientCategory =
                                                                          searchRecipientCategory[
                                                                              index];
                                                                      changeState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          if (searchRecipientCategory
                                                                      .length -
                                                                  1 !=
                                                              index)
                                                            Divider(
                                                              height: 0,
                                                              thickness: 1.w,
                                                              color: colors(
                                                                      context)
                                                                  .greyColor100,
                                                            )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                              ],
                                            );
                                          }));
                                  changeState(() {});
                                  if (result == true) {
                                    bloc.add(MailboxRecipientTypesEvent(
                                        recipientCode:
                                            initialRecipientCategory?.code));
                                  }
                                },
                                initialValue:
                                    initialRecipientCategory?.description,
                              ),
                              24.verticalSpace,
                              AppDropDown(
                                isDisable:
                                    initialRecipientCategory?.code != null
                                        ? false
                                        : true,
                                labelText: AppLocalizations.of(context)
                                    .translate("select_recipient_type"),
                                label: AppLocalizations.of(context)
                                    .translate("recipient_type"),
                                onTap: () async {
                                  await showModalBottomSheet<bool>(
                                      isScrollControlled: true,
                                      useRootNavigator: true,
                                      useSafeArea: true,
                                      context: context,
                                      barrierColor: colors(context).blackColor?.withOpacity(.85),
                                      backgroundColor: Colors.transparent,
                                      builder: (
                                        context,
                                      ) =>
                                          StatefulBuilder(
                                              builder: (context, changeState) {
                                            return BottomSheetBuilder(
                                              isSearch: false,
                                              // onSearch: (p0) {
                                              //   changeState(() {
                                              //     if (p0.isEmpty || p0 == '') {
                                              //       searchRecipientCategory = recipientCategory;
                                              //     } else {
                                              //       searchRecipientCategory = recipientCategory
                                              //           .where((element) => element
                                              //               .description!
                                              //               .toLowerCase()
                                              //               .contains(p0
                                              //                   .toLowerCase()))
                                              //           .toList();
                                              //     }
                                              //   });
                                              // },
                                              title: AppLocalizations.of(
                                                      context)
                                                  .translate(
                                                      "select_recipient_type"),
                                              buttons: [
                                                Expanded(
                                                  child: AppButton(
                                                      buttonType: ButtonType
                                                          .PRIMARYENABLED,
                                                      buttonText:
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  "continue"),
                                                      onTapButton: () {
                                                        initialRecipientType =
                                                            tempRecipientType;

                                                       WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                        Navigator.of(context)
                                                            .pop(true);
                                                        changeState(() {});
                                                        setState(() {});
                                                      }),
                                                ),
                                              ],
                                              children: [
                                                ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      recipientType.length,
                                                  shrinkWrap: true,
                                                   padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        tempRecipientType =
                                                            recipientType[
                                                                index];
                                                        changeState(() {});
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                             padding:  EdgeInsets.fromLTRB(0,index == 0 ?0:24,0,24).h,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  recipientType[
                                                                          index]
                                                                      .description!,
                                                                  style: size16weight700
                                                                      .copyWith(
                                                                    color: colors(
                                                                            context)
                                                                        .blackColor,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right: 8).w,
                                                                  child: UBRadio<
                                                                            dynamic>(
                                                                    value: recipientType[index]
                                                                            .code ??
                                                                        "",
                                                                    groupValue:
                                                                        tempRecipientType
                                                                            ?.code,
                                                                    
                                                                    onChanged:
                                                                        (dynamic
                                                                            value) {
                                                                      tempRecipientType =
                                                                          recipientType[
                                                                              index];
                                                                      changeState(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          if (recipientType
                                                                      .length -
                                                                  1 !=
                                                              index)
                                                            Divider(
                                                              height: 0,
                                                              thickness: 1.w,
                                                              color: colors(
                                                                      context)
                                                                  .greyColor100,
                                                            )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                              ],
                                            );
                                          }));
                                  changeState(() {});
                                },
                                initialValue: initialRecipientType?.description,
                              ),
                              24.verticalSpace,
                              AppTextField(
                                controller: _subjectController,
                                hint: AppLocalizations.of(context)
                                    .translate("enter_subject"),
                                title: AppLocalizations.of(context)
                                    .translate("subject"),
                                inputType: TextInputType.text,
                                onTextChanged: (value) {
                                  changeState(() {});
                                },
                              ),
                             24.verticalSpace,
                              AppDatePicker(
                                initialValue: ValueNotifier(fromDate != null
                                    ? DateFormat('dd-MMM-yyyy')
                                        .format(DateTime.parse(fromDate!))
                                    : null),
                                isFromDateSelected: true,
                                firstDate:
                                // DateTime.now().subtract(const Duration(days: 365)),
                                 Jiffy.parse(Jiffy.now().format(pattern: 'yyyy-MM-dd'), pattern: 'yyyy-MM-dd').subtract(years: 1).dateTime,
                                lastDate: DateTime.now(),
                                labelText: AppLocalizations.of(context)
                                    .translate("from_date"),
                                onChange: (value) {
                                  changeState(() {
                                    fromDate = value;
                                    fromDateV = DateTime.parse(fromDate!);
                                  });
                                },
                                initialDate: DateTime.parse(
                                    fromDate ?? DateTime.now().toString()),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox.shrink(),
                                  fromDate != null &&
                                          toDate != null &&
                                          toDateV!.isBefore(fromDateV!)
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12).h,
                                          child: Text(
                                            "From date cannot be greater than $toDate",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: toDateV!
                                                        .isBefore(fromDateV!)
                                                    ? colors(context)
                                                        .negativeColor
                                                    : colors(context)
                                                        .blackColor),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                             24.verticalSpace,
                              AppDatePicker(
                                initialValue: ValueNotifier(toDate != null
                                    ? DateFormat('dd-MMM-yyyy')
                                        .format(DateTime.parse(toDate!))
                                    : null),
                                isFromDateSelected: true,
                                firstDate: fromDateV,
                                lastDate: DateTime.now(),
                                labelText: AppLocalizations.of(context)
                                    .translate("to_date"),
                                onChange: (value) {
                                  changeState(() {
                                    toDate = value;
                                    toDateV = DateTime.parse(toDate!);
                                  });
                                },
                                initialDate: DateTime.parse(
                                    toDate ?? DateTime.now().toString()),
                              ),
                              24.verticalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("status"),
                                    style: size14weight700.copyWith(
                                      color: colors(context).blackColor!,
                                    ),
                                  ),
                                   18.verticalSpace,
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          changeState(() {
                                            status = 'read';
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                             AppLocalizations.of(context).translate("read") ,
                                              style: size16weight400.copyWith(
                                                  color: colors(context)
                                                      .blackColor),
                                            ),
                                            Spacer(),
                                            UBRadio<dynamic>(
                                              value: 'read',
                                              groupValue: status,
                                              onChanged: (dynamic value) {
                                                changeState(() {
                                                  status = value;
                                                });
                                              },
                                            ),
                                            8.horizontalSpace
                                          ],
                                        ),
                                      ),
                                      20.verticalSpace,
                                      InkWell(
                                        onTap: () {
                                          changeState(() {
                                            status = 'unread';
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context).translate("unread") ,
                                              style: size16weight400.copyWith(
                                                  color: colors(context)
                                                      .blackColor),
                                            ),
                                            Spacer(),
                                            UBRadio<dynamic>(
                                              value: 'unread',
                                              groupValue: status,
                                              onChanged: (dynamic value) {
                                                changeState(() {
                                                  status = value;
                                                });
                                              },
                                            ),
                                            8.horizontalSpace
                                          ],
                                        ),
                                      ),
                                     
                                    ],
                                  ),
                                  30.verticalSpace,
                                   Padding(
                                padding:  EdgeInsets.only(left: 8.w),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                      height: 20.w,
                                      child: Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4).r),
                                        checkColor: colors(context).whiteColor,
                                        activeColor: colors(context).primaryColor,
                                        value: hasAttachment,
                                        onChanged: (value) {
                                          changeState(() {
                                            hasAttachment = !hasAttachment;
                                          });
                                        },
                                      ),
                                    ),
                                    12.horizontalSpace,
                                    Text(
                                      "Attachments",
                                      style: size16weight400.copyWith(
                                        color: colors(context).blackColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                                  
                                 20.verticalSpace,
                                ],
                              ),
                            ],
                          );
                        }));
              },
              icon: PhosphorIcon(
                PhosphorIcons.funnel(PhosphorIconsStyle.bold),size: 24.w
              ))
        ],
      ),
      body: BlocProvider<MailBoxBloc>(
        create: (context) => bloc,
        child: BlocListener<MailBoxBloc, BaseState<MailBoxState>>(
          listener: (context, state) {
            if (state is GetViewMailLoadedState) {
              setState(() {
                if (mailFilter.fromDate != null ||
                    mailFilter.toDate != null ||
                    mailFilter.recipientCategoryCode != null ||
                    mailFilter.recipientTypeCode != null ||
                    mailFilter.readStatus != null ||
                    mailFilter.subject != null ||
                    mailFilter.hasAttachment != null) {
                  mailFilter.isFiltered = true;
                } else {
                  mailFilter.isFiltered = false;
                }

                inboxCount = state.viewMails?.inboxCount ?? 0;
                sentCount = state.viewMails?.sentCount ?? 0;
                draftCount = state.viewMails?.draftCount ?? 0;
                if (pageNumberInbox == 1 ||
                    pageNumberSent == 1 ||
                    pageNumberDraft == 1) {
                  inboxData.clear();
                  inboxData = state.viewMails?.viewInboxResponseDtos ?? [];
                  inboxData.removeWhere(
                      (element) => element.mailResponseDtoList!.isEmpty);
                  sentData.clear();
                  sentData = state.viewMails?.viewSentResponseDtos ?? [];
                  sentData.removeWhere(
                      (element) => element.mailResponseDtoList!.isEmpty);
                  draftData.clear();
                  draftData = state.viewMails?.viewDraftResponseDtos ?? [];
                  draftData.removeWhere(
                      (element) => element.mailResponseDtoList!.isEmpty);
                } else {
                  inboxData
                      .addAll(state.viewMails?.viewInboxResponseDtos ?? []);
                  inboxData.removeWhere(
                      (element) => element.mailResponseDtoList!.isEmpty);

                  sentData.addAll(state.viewMails?.viewSentResponseDtos ?? []);
                  sentData.removeWhere(
                      (element) => element.mailResponseDtoList!.isEmpty);

                  draftData
                      .addAll(state.viewMails?.viewDraftResponseDtos ?? []);
                  draftData.removeWhere(
                      (element) => element.mailResponseDtoList!.isEmpty);
                }
                pageNumberInbox = pageNumberInbox + 1;
                pageNumberSent = pageNumberSent + 1;
                pageNumberDraft = pageNumberDraft + 1;
              });
            } else if (state is GetViewMailFailedState) {
              showAppDialog(
                  alertType: AlertType.FAIL,
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                  message: state.message,
                  onPositiveCallback: () {});
              // Navigator.of(context).pop();
            } else if (state is MarkAsReadMailSuccessState) {
              showAppDialog(
                  alertType: AlertType.SUCCESS,
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_SUCCESS),
                  message: state.message,
                  onPositiveCallback: () {
                    inboxSelectedMail.clear();
                    pageNumberInbox = 1;
                    pageNumberSent = 1;
                    pageNumberDraft = 1;
                    setState(() {});
                    bloc.add(GetViewMailEvent(
                        page: 1,
                        size: 20,
                        recipientCategoryCode:
                            mailFilter.recipientCategoryCode?.code,
                        recipientTypeCode: mailFilter.recipientTypeCode?.code,
                        fromDate: mailFilter.fromDate,
                        toDate: mailFilter.toDate,
                        readStatus: mailFilter.readStatus,
                        hasAttachment: mailFilter.hasAttachment,
                        subject: mailFilter.subject));
                  });
            } else if (state is MarkAsReadMailFailedState) {
              showAppDialog(
                  alertType: AlertType.FAIL,
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                  message: state.message,
                  onPositiveCallback: () {});
            } else if (state is DeleteMailSuccessState) {
              showAppDialog(
                  alertType: AlertType.SUCCESS,
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_SUCCESS),
                  message: splitAndJoinAtBrTags(state.message??""),
                  onPositiveCallback: () {
                    inboxSelectedMail.clear();
                    pageNumberInbox = 1;
                    pageNumberSent = 1;
                    pageNumberDraft = 1;
                    setState(() {});
                    bloc.add(GetViewMailEvent(
                        page: 1,
                        size: 20,
                        recipientCategoryCode:
                            mailFilter.recipientCategoryCode?.code,
                        recipientTypeCode: mailFilter.recipientTypeCode?.code,
                        fromDate: mailFilter.fromDate,
                        toDate: mailFilter.toDate,
                        readStatus: mailFilter.readStatus,
                        hasAttachment: mailFilter.hasAttachment,
                        subject: mailFilter.subject));
                  });
            } else if (state is DeleteMailFailedState) {
              showAppDialog(
                  alertType: AlertType.FAIL,
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                  message: state.message,
                  onPositiveCallback: () {});
            } else if (state is RecipientCategorySuccessState) {
              recipientCategory = state.data;
              searchRecipientCategory = state.data;
              setState(() {});
            } else if (state is RecipientTypeSuccessState) {
              recipientType = state.data;
              setState(() {});
            } else if (state is RecipientTypeFailedState) {
            } else if (state is RecipientCategoryFailedState) {}
          },
          child: Stack(
                children: [
                 ((inboxData.isEmpty && currentTab == 0 )|| (sentData.isEmpty && currentTab == 1) ||( draftData.isEmpty && currentTab == 2)) &&
                      (((mailFilter.fromDate != null ||
                                  mailFilter.toDate != null ||
                                  mailFilter.recipientCategoryCode != null ||
                                  mailFilter.recipientTypeCode != null ||
                                  mailFilter.readStatus != null ||
                                  mailFilter.subject != null ||
                                  mailFilter.hasAttachment != null) &&
                              currentTab == 0) ||
                          ((mailFilter.fromDate != null ||
                                  mailFilter.toDate != null ||
                                  mailFilter.recipientCategoryCode != null ||
                                  mailFilter.recipientTypeCode != null ||
                                  mailFilter.readStatus != null ||
                                  mailFilter.subject != null ||
                                  mailFilter.hasAttachment != null) &&
                              currentTab == 1) ||
                          ((mailFilter.fromDate != null ||
                                  mailFilter.toDate != null ||
                                  mailFilter.recipientCategoryCode != null ||
                                  mailFilter.recipientTypeCode != null ||
                                  mailFilter.readStatus != null ||
                                  mailFilter.subject != null ||
                                  mailFilter.hasAttachment != null) &&
                              currentTab == 2))
                  ?
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                      PhosphorIcons.envelopeSimple(
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
                                      'filterd_empty_mail_title'),
                                  style: size18weight700.copyWith(
                                      color: colors(context)
                                          .blackColor),
                                ),
                                4.verticalSpace,
                                Text(
                                  AppLocalizations.of(context)
                                      .translate(
                                      'filterd_empty_mail'),
                                      textAlign: TextAlign.center,
                                  style: size14weight400.copyWith(
                                      color: colors(context)
                                          .greyColor),
                                )
                              ],
                            ),
                          ),
                        ) :((inboxData.isEmpty && currentTab==0) || (sentData.isEmpty && currentTab==1)|| (draftData.isEmpty && currentTab==2))?
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  PhosphorIcons.envelopeSimple(
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
                                  'empty_mail_title'),
                              style: size18weight700.copyWith(
                                  color: colors(context)
                                      .blackColor),
                            ),
                            4.verticalSpace,
                            Text(
                              AppLocalizations.of(context)
                                  .translate('empty_mail'),
                                  textAlign: TextAlign.center,
                              style: size14weight400.copyWith(
                                  color: colors(context)
                                      .greyColor),
                            )
                                                  ],
                                                ),
                          ),
                        ):SizedBox.shrink(),
                  Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.fromLTRB(20.w, 24.h, 20.w,(mailFilter.fromDate != null ||
                        mailFilter.toDate != null ||
                        mailFilter.recipientCategoryCode != null ||
                        mailFilter.recipientTypeCode != null ||
                        mailFilter.readStatus != null ||
                        mailFilter.subject != null ||
                        mailFilter.hasAttachment != null)?12.h: 24.h),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: colors(context).primaryColor50!),
                              color: colors(context).whiteColor,
                              borderRadius: BorderRadius.circular(8).r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int index = 0;
                                  index < tabs.length;
                                  index++)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentTab = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(8).r,
                                      color: index == currentTab
                                          ? colors(context).primaryColor
                                          : Colors.transparent,
                                    ),
                                    child: Padding(
                                      padding:
                                           EdgeInsets.symmetric(
                                                  horizontal:index==0? 32.w:index == 1?13.w:14.w,
                                                  vertical: 8.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              tabsTitleLang(
                                                  context, index),
                                              style: size14weight700
                                                  .copyWith(
                                                      color: index ==
                                                              currentTab
                                                          ? colors(
                                                                  context)
                                                              .whiteColor
                                                          : colors(
                                                                  context)
                                                              .blackColor),
                                            ),
                                          ),
                                          8.horizontalSpace,
                                          if (tabs[index] == tabs[0])
                                            Container(
                                                decoration:
                                                    BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius
                                                              .circular(
                                                                  8)
                                                          .r,
                                                  color: index ==
                                                          currentTab
                                                      ? colors(context)
                                                          .whiteColor
                                                      : colors(context)
                                                          .primaryColor,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                  child: Center(
                                                    child: Padding(
                                                            padding: const EdgeInsets.all(3.2).w,
                                                      child: Text(
                                                        inboxCount
                                                            .toString(),
                                                        style: size14weight700.copyWith(
                                                            color: index ==
                                                                    currentTab
                                                                ? colors(
                                                                        context)
                                                                    .primaryColor
                                                                : colors(
                                                                        context)
                                                                    .whiteColor),
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                          else if (tabs[index] ==
                                              tabs[1])
                                            (Container(
                                                decoration:
                                                    BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius
                                                              .circular(
                                                                  8)
                                                          .r,
                                                  color: index ==
                                                          currentTab
                                                      ? colors(context)
                                                          .whiteColor
                                                      : colors(context)
                                                          .primaryColor,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                  child: Center(
                                                      child: Padding(
                                                            padding: const EdgeInsets.all(3.2).w,
                                                    child: Text(
                                                      sentCount
                                                          .toString(),
                                                      style: size14weight700.copyWith(
                                                          color: index == currentTab
                                                              ? colors(
                                                                      context)
                                                                  .primaryColor
                                                              : colors(
                                                                      context)
                                                                  .whiteColor),
                                                    ),
                                                  )),
                                                )))
                                          else
                                            (Container(
                                                decoration:
                                                    BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius
                                                              .circular(
                                                                  8)
                                                          .r,
                                                  color: index ==
                                                          currentTab
                                                      ? colors(context)
                                                          .whiteColor
                                                      : colors(context)
                                                          .primaryColor,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                  child: Center(
                                                      child: Padding(
                                                            padding: const EdgeInsets.all(3.2).w,
                                                    child: Text(
                                                      draftCount
                                                          .toString(),
                                                      style: size14weight700.copyWith(
                                                          color: index == currentTab
                                                              ? colors(
                                                                      context)
                                                                  .primaryColor
                                                              : colors(
                                                                      context)
                                                                  .whiteColor),
                                                    ),
                                                  )),
                                                )))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                       (mailFilter.fromDate != null ||
                    mailFilter.toDate != null ||
                    mailFilter.recipientCategoryCode != null ||
                    mailFilter.recipientTypeCode != null ||
                    mailFilter.readStatus != null ||
                    mailFilter.subject != null ||
                    mailFilter.hasAttachment != null)  ?
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:  EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                          child: Wrap(
                            
                            children: [
                            if (mailFilter.fromDate != null  && mailFilter.toDate == null)
                              FilteredChip(
                                onTap: () {
                                  mailFilter.fromDate = null;
                                  fromDateV = null;
                                  fromDate = null;
                                  setState(() {});
                                  filterChipClose();
                                },
                                children: [
                                  Text(
                                    "${DateFormat("dd-MMM-yyyy").format(DateTime.parse(mailFilter.fromDate!.toIso8601String()))}",
                                    style: size14weight400.copyWith(
                                        color: colors(context).greyColor),
                                  ),
                                ],
                              ),
                            if (mailFilter.toDate != null && mailFilter.fromDate == null)
                              FilteredChip(
                                  onTap: () {
                                    mailFilter.toDate = null;
                                    toDateV = null;
                                    toDate = null;
                                    setState(() {});
                                    filterChipClose();
                                  },
                                  children: [
                                    Text(
                                      "${DateFormat("dd-MMM-yyyy").format(DateTime.parse(mailFilter.toDate!.toIso8601String()))}",
                                      style: size14weight400.copyWith(
                                          color: colors(context).greyColor),
                                    ),
                                  ]),
                            if (mailFilter.toDate != null && mailFilter.fromDate != null)
                              FilteredChip(
                                  onTap: () {
                                    mailFilter.fromDate = null;
                                    fromDateV = null;
                                    fromDate = null;
                                    mailFilter.toDate = null;
                                    toDateV = null;
                                    toDate = null;
                                    setState(() {});
                                    filterChipClose();
                                  },
                                  children: [
                                    Text(
                                      "${DateFormat("dd-MMM-yyyy").format(DateTime.parse(mailFilter.fromDate!.toIso8601String()))} to ${DateFormat("dd-MMM-yyyy").format(DateTime.parse(mailFilter.toDate!.toIso8601String()))}",
                                      style: size14weight400.copyWith(
                                          color: colors(context).greyColor),
                                    ),
                                  ]),
                            if (mailFilter.recipientCategoryCode != null)
                              FilteredChip(
                                  onTap: () {
                                    mailFilter.recipientCategoryCode = null;
                                    initialRecipientCategory = null;
                                    tempRecipientCategory = null;
                                    setState(() {});
                                    filterChipClose();
                                  },
                                  children: [
                                    Text(
                                      "${mailFilter.recipientCategoryCode?.description}",
                                      style: size14weight400.copyWith(
                                          color: colors(context).greyColor),
                                    ),
                                  ]),
                            if (mailFilter.recipientTypeCode != null)
                              FilteredChip(
                                onTap: () {
                                  mailFilter.recipientTypeCode = null;
                                  initialRecipientType = null;
                                  tempRecipientType = null;
                                  setState(() {});
                                  filterChipClose();
                                },
                                children: [
                                  Text(
                                    "${mailFilter.recipientTypeCode?.description}",
                                    style: size14weight400.copyWith(
                                        color: colors(context).greyColor),
                                  ),
                                ],
                              ),
                            if (mailFilter.readStatus != null)
                              FilteredChip(
                                  onTap: () {
                                    mailFilter.readStatus = null;
                                    status = null;
                                    setState(() {});
                                    filterChipClose();
                                  },
                                  children: [
                                    Text(
                                      "${mailFilter.readStatus == "read" ?AppLocalizations.of(context).translate("read") : AppLocalizations.of(context).translate("unread")}",
                                      style: size14weight400.copyWith(
                                          color: colors(context).greyColor),
                                    ),
                                  ]),
                            if (mailFilter.subject != null)
                              FilteredChip(
                                onTap: () {
                                  mailFilter.subject = null;
                                  _subjectController.clear();
                                  setState(() {});
                                  filterChipClose();
                                },
                                children: [
                                  Text(
                                    "${mailFilter.subject}",
                                    style: size14weight400.copyWith(
                                        color: colors(context).greyColor),
                                  ),
                                ],
                              ),
                            if (mailFilter.hasAttachment != null)
                              FilteredChip(
                                onTap: () {
                                  mailFilter.hasAttachment = null;
                                  hasAttachment = false;
                                  setState(() {});
                                  filterChipClose();
                                },
                                children: [
                                  Text(
                                    "Has Attachment",
                                    style: size14weight400.copyWith(
                                        color: colors(context).greyColor),
                                  ),
                                ],
                              ),
                          ]),
                        ),
                      ),
                    ],
                  ):SizedBox.shrink(),
                   if (currentTab == 0)
                                     inboxData.isNotEmpty ? Expanded(
                    child: Column(
                      children: [
                         Expanded(
                            child: ListView.builder(
                              key: Key("inbox"),
                          controller: _scrollControllerInbox,
                          itemCount: inboxData.length,
                              padding: EdgeInsets.only(bottom: 20.h),
                          itemBuilder: (BuildContext context, int index) {
                            final inbox = inboxData[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MailboxComponent(
                                  viewMailData: inbox,
                                  messageType: 0,
                                  onPressed: () async {
                                    if (inboxSelectedMail.isNotEmpty) {
                                      if (inboxSelectedMail.any((element) =>
                                          element == inbox.inboxId)) {
                                        inboxSelectedMail
                                            .remove(inbox.inboxId);
                                      } else {
                                        inboxSelectedMail
                                            .add(inbox.inboxId!);
                                      }
                                      setState(() {});
                                    } else {
                                      setState(() {});
                                      inboxSelectedMail.clear();
                                      setState(() {});
                                      final result =
                                          await Navigator.pushNamed(context,
                                              Routes.kMailBoxPreview,
                                              arguments: MailData(
                                                  messageType: 0,
                                                  viewMailData: inbox)) as ComposeMailResult;
                                      if(result.result == true){
                                         setState(() {
                                          where =result.where;
                                        });
                                        setState(() {
                                          pageNumberInbox = 1;
                                          pageNumberSent = 1;
                                          pageNumberDraft = 1;
                                        });
                                        bloc.add(GetViewMailEvent(
                                            page: 1,
                                            size: 20,
                                            recipientCategoryCode:
                                                mailFilter
                                                    .recipientCategoryCode
                                                    ?.code,
                                            recipientTypeCode: mailFilter
                                                .recipientTypeCode?.code,
                                            fromDate: mailFilter.fromDate,
                                            toDate: mailFilter.toDate,
                                            readStatus:
                                                mailFilter.readStatus,
                                            hasAttachment:
                                                mailFilter.hasAttachment,
                                            subject: mailFilter.subject));
                                
                                      }
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20).w,
                                  child: Divider(
                                    thickness: 1.w,
                                    height: 0,
                                  ),
                                )
                              ],
                            );
                          },
                        ))
                      ],
                    ),
                  ): SizedBox.shrink(),
                  if (currentTab == 1)
                  sentData.isNotEmpty ? Expanded(
                    child: Column(
                      children: [
                         Expanded(
                            child: ListView.builder(
                              key: Key("sent"),
                          controller: _scrollControllerSent,
                          itemCount: sentData.length,
                              padding: EdgeInsets.only(bottom: 20.h),
                          itemBuilder: (BuildContext context, int index) {
                            final sent = sentData[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MailboxComponent(
                                  messageType: 1,
                                  viewMailData: sent,
                                  onPressed: () async {
                                    final result =
                                        await Navigator.pushNamed(
                                            context, Routes.kMailBoxPreview,
                                            arguments: MailData(
                                                messageType: 1,
                                                viewMailData: sent))as ComposeMailResult;
                                     
                                      if(result.result == true){
                                         setState(() {
                                          where =result.where;
                                        });
                                        setState(() {
                                          pageNumberInbox = 1;
                                          pageNumberSent = 1;
                                          pageNumberDraft = 1;
                                        });
                                        bloc.add(GetViewMailEvent(
                                            page: 1,
                                            size: 20,
                                            recipientCategoryCode:
                                                mailFilter
                                                    .recipientCategoryCode
                                                    ?.code,
                                            recipientTypeCode: mailFilter
                                                .recipientTypeCode?.code,
                                            fromDate: mailFilter.fromDate,
                                            toDate: mailFilter.toDate,
                                            readStatus:
                                                mailFilter.readStatus,
                                            hasAttachment:
                                                mailFilter.hasAttachment,
                                            subject: mailFilter.subject));
                                
                                      }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20).w,
                                  child: Divider(
                                    thickness: 1.w,
                                    height: 0,
                                  ),
                                )
                              ],
                            );
                          },
                        )),
                      ],
                    ),
                  ) :SizedBox.shrink() ,
                  if (currentTab == 2)
                    draftData.isNotEmpty? Expanded(
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                              key: Key("draft"),
                          controller: _scrollControllerDraft,
                          itemCount: draftData.length,
                          padding: EdgeInsets.only(bottom: 20.h),
                          itemBuilder: (BuildContext context, int index) {
                            final draft = draftData[index];
                            return Column(
                              children: [
                                MailboxComponent(
                                  viewMailData: draft,
                                  messageType: 2,
                                  onPressed: () async {
                                    if (draft.mailResponseDtoList?.first.status =="active") {
                                      final result =
                                          await Navigator.pushNamed(context,
                                                  Routes.kMailBoxPreview,
                                                  arguments: MailData(
                                                      messageType: 2,
                                                      viewMailData: draft))
                                              as ComposeMailResult;
                                      if (result.result == true && result.where == WHERE.REPLY) {
                                        setState(() {
                                          where =result.where;
                                        });
                                        showAppDialog(
                                            alertType: AlertType.SUCCESS,
                                            isSessionTimeout: true,
                                            title:
                                                AppLocalizations.of(context).translate(ErrorHandler.TITLE_SUCCESS),
                                            message: splitAndJoinAtBrTags(result.message),
                                            onPositiveCallback: () {});
                                        setState(() {
                                          pageNumberInbox = 1;
                                          pageNumberSent = 1;
                                          pageNumberDraft = 1;
                                        });
                                        bloc.add(GetViewMailEvent(
                                            page: 1,
                                            size: 20,
                                            recipientCategoryCode:
                                                mailFilter
                                                    .recipientCategoryCode
                                                    ?.code,
                                            recipientTypeCode: mailFilter
                                                .recipientTypeCode?.code,
                                            fromDate: mailFilter.fromDate,
                                            toDate: mailFilter.toDate,
                                            readStatus:
                                                mailFilter.readStatus,
                                            hasAttachment:
                                                mailFilter.hasAttachment,
                                            subject: mailFilter.subject));
                                      }else{
                                         setState(() {
                                          where =result.where;
                                        });
                                        setState(() {
                                          pageNumberInbox = 1;
                                          pageNumberSent = 1;
                                          pageNumberDraft = 1;
                                        });
                                        bloc.add(GetViewMailEvent(
                                            page: 1,
                                            size: 20,
                                            recipientCategoryCode:
                                                mailFilter
                                                    .recipientCategoryCode
                                                    ?.code,
                                            recipientTypeCode: mailFilter
                                                .recipientTypeCode?.code,
                                            fromDate: mailFilter.fromDate,
                                            toDate: mailFilter.toDate,
                                            readStatus:
                                                mailFilter.readStatus,
                                            hasAttachment:
                                                mailFilter.hasAttachment,
                                            subject: mailFilter.subject));
                                
                                      }
                                    } else {
                                
                                      final result =
                                          await Navigator.pushNamed(context,
                                                  Routes.kMailBoxNewMessage,
                                                  arguments: MailData(
                                                      messageType: 2,
                                                      viewMailData: draft))
                                              as ComposeMailResult;
                                      if (result.result == true && result.where == WHERE.NEW) {
                                         setState(() {
                                          where =result.where;
                                        });
                                        showAppDialog(
                                            alertType: AlertType.SUCCESS,
                                            isSessionTimeout: true,
                                            title:
                                                AppLocalizations.of(context).translate(ErrorHandler.TITLE_SUCCESS),
                                            message: splitAndJoinAtBrTags(result.message),
                                            onPositiveCallback: () {});
                                        setState(() {
                                          pageNumberInbox = 1;
                                          pageNumberSent = 1;
                                          pageNumberDraft = 1;
                                        });
                                        bloc.add(GetViewMailEvent(
                                            page: 1,
                                            size: 20,
                                            recipientCategoryCode:
                                                mailFilter
                                                    .recipientCategoryCode
                                                    ?.code,
                                            recipientTypeCode: mailFilter
                                                .recipientTypeCode?.code,
                                            fromDate: mailFilter.fromDate,
                                            toDate: mailFilter.toDate,
                                            readStatus:
                                                mailFilter.readStatus,
                                            hasAttachment:
                                                mailFilter.hasAttachment,
                                            subject: mailFilter.subject));
                                
                                      }else{
                                         setState(() {
                                          where =result.where;
                                        });
                                         setState(() {
                                          pageNumberInbox = 1;
                                          pageNumberSent = 1;
                                          pageNumberDraft = 1;
                                        });
                                        bloc.add(GetViewMailEvent(
                                            page: 1,
                                            size: 20,
                                            recipientCategoryCode:
                                                mailFilter
                                                    .recipientCategoryCode
                                                    ?.code,
                                            recipientTypeCode: mailFilter
                                                .recipientTypeCode?.code,
                                            fromDate: mailFilter.fromDate,
                                            toDate: mailFilter.toDate,
                                            readStatus:
                                                mailFilter.readStatus,
                                            hasAttachment:
                                                mailFilter.hasAttachment,
                                            subject: mailFilter.subject));
                                
                                      }
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20).w,
                                  child: Divider(
                                    thickness: 1.w,
                                    height: 0,
                                  ),
                                )
                              ],
                            );
                          },
                        )),
                      ],
                    ),
                  ):SizedBox.shrink(),
                    ],
                  ),
                  Positioned(
                       bottom: 42.h+AppSizer.getHomeIndicatorStatus(context),
                    right: 24,
                    child: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.pushNamed(
                              context, Routes.kMailBoxNewMessage,
                              arguments: MailData(
                                  isNewCompose: true,
                                  messageType: 99,
                                  viewMailData: ViewMailData())) as ComposeMailResult;
                          if (result.result == true && result.where ==WHERE.NEW) {
                            setState(() {
                              where = result.where;

                            });

                            showAppDialog(
                                alertType: AlertType.SUCCESS,
                                isSessionTimeout: true,
                                title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_SUCCESS),
                                message: splitAndJoinAtBrTags(result.message),
                                onPositiveCallback: () {});
                            setState(() {
                              pageNumberInbox = 1;
                              pageNumberSent = 1;
                              pageNumberDraft = 1;
                            });
                            bloc.add(GetViewMailEvent(
                                page: 1,
                                size: 20,
                                recipientCategoryCode:
                                    mailFilter.recipientCategoryCode?.code,
                                recipientTypeCode: mailFilter.recipientTypeCode?.code,
                                fromDate: mailFilter.fromDate,
                                toDate: mailFilter.toDate,
                                readStatus: mailFilter.readStatus,
                                hasAttachment: mailFilter.hasAttachment,
                                subject: mailFilter.subject));
                          }else{
                            setState(() {
                              where = result.where;

                            });
                            setState(() {
                              pageNumberInbox = 1;
                              pageNumberSent = 1;
                              pageNumberDraft = 1;
                            });
                            bloc.add(GetViewMailEvent(
                                page: 1,
                                size: 20,
                                recipientCategoryCode:
                                    mailFilter.recipientCategoryCode?.code,
                                recipientTypeCode: mailFilter.recipientTypeCode?.code,
                                fromDate: mailFilter.fromDate,
                                toDate: mailFilter.toDate,
                                readStatus: mailFilter.readStatus,
                                hasAttachment: mailFilter.hasAttachment,
                                subject: mailFilter.subject));

                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors(context).primaryColor),
                            child: Padding(
                              padding: const EdgeInsets.all(17).w,
                              child: PhosphorIcon(
                                size: 24.w,
                                PhosphorIcons.pencilSimple(PhosphorIconsStyle.bold),
                                color: colors(context).whiteColor,
                              ),
                            ))),
                  ),
                 
                ],
          ),
        ),
      ),
    );
  }

  filterChipClose() {
    setState(() {
      pageNumberInbox = 1;
      pageNumberSent = 1;
      pageNumberDraft = 1;
    });
    bloc.add(GetViewMailEvent(
        page: 1,
        size: 20,
        recipientCategoryCode: mailFilter.recipientCategoryCode?.code,
        recipientTypeCode: mailFilter.recipientTypeCode?.code,
        fromDate: mailFilter.fromDate,
        toDate: mailFilter.toDate,
        readStatus: mailFilter.readStatus,
        hasAttachment: mailFilter.hasAttachment,
        subject: mailFilter.subject));
  }

  bool _isDateRangeValid() {
    if (fromDateV != null && toDateV != null) {
      return toDateV!.isBefore(fromDateV!);
    }
    // else if(fromDateV!=null && toDateV==null || toDateV!=null && fromDateV==null){
    //   return true;
    // }
    return false;
  }

  bool validate() {
    if (_subjectController.text.isEmpty &&
        status == null &&
        hasAttachment == false &&
        fromDateV == null &&
        toDateV == null &&
        initialRecipientCategory == null &&
        initialRecipientType == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
