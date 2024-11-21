import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/service/storage_service.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_thread_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/mailbox/mailbox_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/mailbox/mailbox_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/mailbox/mailbox_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/attachment_data.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/compose_mail_result.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/mail_data.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/mail_sent_data.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/mailbox_otp_view.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/widgets/mailbox_attachment_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/bottom_sheet.dart';
import 'package:union_bank_mobile/features/presentation/widgets/drop_down_widgets/drop_down.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/features/presentation/widgets/ub_radio_button.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';

import '../../../../utils/app_sizer.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';

class MailBoxNewMessage extends BaseView {
  final MailData mailData;
  MailBoxNewMessage({required this.mailData, Key? key}) : super(key: key);

  @override
  State<MailBoxNewMessage> createState() => _MailBoxViewState();
}

class _MailBoxViewState extends BaseViewState<MailBoxNewMessage> {
  var bloc = injection<MailBoxBloc>();
  final localDataSource = injection<LocalDataSource>();

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  CommonDropDownResponse? initialRecipientType;
  CommonDropDownResponse? initialRecipientCategory;

  List<AttachmentData> pickedFiles = [];

  ThreadMessageResponseData? draftMail;

  bool isDraft = false;

  List<CommonDropDownResponse> recipientCategory = [];
  CommonDropDownResponse? tempRecipientCategory = CommonDropDownResponse();
  List<CommonDropDownResponse> searchRecipientCategory = [];

  List<CommonDropDownResponse> recipientType = [];
  CommonDropDownResponse? tempRecipientType = CommonDropDownResponse();

  bool isChange = false;
  WHERE where = WHERE.NONE;

  @override
  void initState() {
    if (widget.mailData.messageType == 2) {
      bloc.add(GetMailThreadEvent(
          inboxId: widget.mailData.viewMailData.inboxId, isComposeDraft: true));
      bloc.add(MailboxRecipientTypesEvent(
          recipientCode: widget.mailData.viewMailData.recipientCategoryCode));
    }
     
    bloc.add(MailboxRecipientCategoryEvent());
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        checkDraftStatus();
        return true;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          actions: [
            //  if(widget.previewMailData.messageType != 1)
            // if(widget.mailData.messageType ==2)  InkWell(
            //     onTap: () {
            //       showAppDialog(
            //           alertType: AlertType.WARNING,
            //           isSessionTimeout: true,
            //           title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_QUESTION),
            //           message: "Are you sure want to delete selected draft mail ?",
            //           negativeButtonText: "No",
            //           positiveButtonText: "Yes",
            //           onPositiveCallback: () {
            //             bloc.add(DeleteMailEvent(inboxIdList: [
            //               widget.mailData.viewMailData.inboxId!
            //             ]));
            //           });
            //     },
            //     child: Image.asset(
            //       AppAssets.icMailboxDelete,
            //       scale: 2.7,
            //     ),
            //   ),
          ],
          onBackPressed: () {
            checkDraftStatus();
          },
          backPressedIcon: Icons.close,
          title: widget.mailData.messageType == 2
              ? AppLocalizations.of(context).translate("draft")
              : AppLocalizations.of(context).translate("new_message"),
        ),
        body: BlocProvider<MailBoxBloc>(
          create: (_) => bloc,
          child: BlocListener<MailBoxBloc, BaseState<MailBoxState>>(
            listener: (context, state) {
              if (state is ComposeMailSuccessState) {
                if (isDraft == true) {
                  Navigator.pop(context, ComposeMailResult(result: true,message: state.message??"",where: WHERE.DRAFT));
                }else{
                   Navigator.pop(context, ComposeMailResult(result: true,message: state.message??"",where: WHERE.NEW));
                }
              } else if (state is ComposeMailFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.FAIL);
                Navigator.pop(context, ComposeMailResult(result: false,message: "",where: WHERE.NONE));
              }
              // else if (state is ReplyMailSuccessState) {
              //   //TODO
              // } else if (state is ReplyMailFailedState) {
              //   //TODO
              // }
              else if (state is GetMailThreadLoadedState) {
                if (widget.mailData.messageType == 2) {
                  draftMail = state.mailThread?.inboxResponseDto
                      ?.threadMessageResponseDtos?.first;
                  _subjectController.text =
                      widget.mailData.viewMailData.subject ?? "";
                  _messageController.text = widget.mailData.viewMailData
                          .mailResponseDtoList?.first.message ??
                      "";
                  initialRecipientCategory = CommonDropDownResponse(
                      code: widget.mailData.viewMailData.recipientCategoryCode,
                      description:
                          widget.mailData.viewMailData.recipientCategoryName);
                  initialRecipientType = CommonDropDownResponse(
                      code: widget.mailData.viewMailData.recipientTypeCode,
                      description:
                          widget.mailData.viewMailData.recipientTypeName,
                      key: widget.mailData.viewMailData.recipientTypeEmail);

                   tempRecipientCategory = CommonDropDownResponse(
                      code: widget.mailData.viewMailData.recipientCategoryCode,
                      description:
                          widget.mailData.viewMailData.recipientCategoryName);
                  tempRecipientType = CommonDropDownResponse(
                      code: widget.mailData.viewMailData.recipientTypeCode,
                      description:
                          widget.mailData.viewMailData.recipientTypeName,
                      key: widget.mailData.viewMailData.recipientTypeEmail);
                }
                setState(() {});
              } else if (state is GetMailThreadFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.FAIL);
                Navigator.pop(context,ComposeMailResult(result: false,message: "", where: WHERE.NONE,));
              } else if (state is GetMailAttachmentFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.FAIL);
              } else if (state is GetMailAttachmentLoadedState) {
                StorageService(directoryName: 'UB').storeFile(
                    fileName:
                        state.mailAttachmentResponse?.attachmentName ?? "",
                    fileExtension:
                        state.mailAttachmentResponse?.attachmentType ?? "",
                    fileData: base64Decode(
                        state.mailAttachmentResponse?.attachment ?? ""),
                    onComplete: (file) async {
                      await OpenFilex.open(file.path);
                    },
                    onError: (error) {
                      ToastUtils.showCustomToast(
                          context, error, ToastStatus.FAIL);
                    });
              } else if (state is DeleteMailAttachmentSuccessState) {
                bloc.add(GetMailThreadEvent(
                    inboxId: widget.mailData.viewMailData.inboxId,
                    isComposeDraft: true));
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.SUCCESS);
              } else if (state is DeleteMailAttachmentFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.FAIL);
              }
              //   else if(state is DeleteMailSuccessState) {
              //   showAppDialog(
              //       alertType: AlertType.SUCCESS,
              //       isSessionTimeout: true,
              //       title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_SUCCESS),
              //       message: "Draft delete success",
              //       onPositiveCallback: () {
              //         Navigator.pop(context, true);
              //       });
              // }else if(state is DeleteMailFailedState) {
              //   showAppDialog(
              //       alertType: AlertType.FAIL,
              //       isSessionTimeout: true,
              //       title: AppLocalizations.of(context)
                    // .translate(ErrorHandler.TITLE_ERROR),
              //       message: state.message,
              //       onPositiveCallback: () {});
              // }
              else if (state is RecipientCategorySuccessState) {
                recipientCategory = state.data;
                searchRecipientCategory = state.data;
                setState(() {});
              } else if (state is RecipientTypeSuccessState) {
                recipientType = state.data;
                setState(() {});
              } else if (state is RecipientTypeFailedState) {
              } else if (state is RecipientCategoryFailedState) {}
            },
            child: Padding(
              padding:  EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8).r,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor),
                              child: Padding(
                                padding: const EdgeInsets.all(16).w,
                                child: Column(
                                  children: [
                                    AppDropDown(
                                      labelText: AppLocalizations.of(context)
                                          .translate("select_recipient_category"),
                                      label: AppLocalizations.of(context)
                                          .translate("recipient_category"),
                                      onTap: () async {
                                        final result =
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
                                                    StatefulBuilder(builder:
                                                        (context, changeState) {
                                                      return BottomSheetBuilder(
                                                        isSearch: true,
                                                        onSearch: (p0) {
                                                          changeState(() {
                                                            if (p0.isEmpty ||
                                                                p0 == '') {
                                                              searchRecipientCategory =
                                                                  recipientCategory;
                                                            } else {
                                                              searchRecipientCategory = recipientCategory
                                                                  .where((element) => element
                                                                      .description!
                                                                      .toLowerCase()
                                                                      .contains(p0
                                                                          .toLowerCase())).toSet()
                                                                  .toList();
                                                            }
                                                          });
                                                        },
                                                        title: AppLocalizations
                                                                .of(context)
                                                            .translate(
                                                                "select_category"),
                                                        buttons: [
                                                          Expanded(
                                                            child: AppButton(
                                                                buttonType: ButtonType
                                                                    .PRIMARYENABLED,
                                                                buttonText: AppLocalizations
                                                                        .of(
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
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(true);
                                                                  changeState(
                                                                      () {});
                                                                  setState(() {});
                                                                }),
                                                          ),
                                                        ],
                                                        children: [
                                                          ListView.builder(
                                                            physics: NeverScrollableScrollPhysics(),
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
                                                                  changeState(
                                                                      () {});
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
                                                                            searchRecipientCategory[index]
                                                                                .description!,
                                                                            style:
                                                                                size16weight700.copyWith(
                                                                              color:
                                                                                  colors(context).blackColor,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(right: 8).w,
                                                                            child: UBRadio<
                                                                                dynamic>(
                                                                              value:
                                                                                  searchRecipientCategory[index].code ?? "",
                                                                              groupValue:
                                                                                  tempRecipientCategory?.code,
                                                                              onChanged:
                                                                                  (dynamic value) {
                                                                                tempRecipientCategory = searchRecipientCategory[index];
                                                                                changeState(() {});
                                                                              },
                                                                                                                                                        ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                   if(searchRecipientCategory.length-1 != index) Divider(
                                                                      thickness:
                                                                          1.w,
                                                                          height: 0,
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
                                        setState(() {});
                                        if (result == true) {
                                          bloc.add(MailboxRecipientTypesEvent(
                                              recipientCode:
                                                  initialRecipientCategory
                                                      ?.code));
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
                                                StatefulBuilder(builder:
                                                    (context, changeState) {
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
                                                              isChange = true;

                                                              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                              Navigator.of(
                                                                      context)
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
                                                                          color: colors(context)
                                                                              .blackColor,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(right: 8).w,
                                                                        child: UBRadio<
                                                                            dynamic>(
                                                                          value: recipientType[index].code ??
                                                                              "",
                                                                          groupValue:
                                                                              tempRecipientType?.code,
                                                                          onChanged:
                                                                              (dynamic
                                                                                  value) {
                                                                            tempRecipientType =
                                                                                recipientType[index];
                                                                            changeState(
                                                                                () {});
                                                                          },
                                                                                                                                                ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                               if(recipientType.length-1 != index) Divider(
                                                                      thickness:
                                                                          1.w,
                                                                          height: 0,
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
                                        setState(() {});
                                      },
                                      initialValue:
                                          initialRecipientType?.description,
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
                                        isChange =true;
                                        setState(() {});
                                      },
                                    ),
                                    24.verticalSpace,
                                    AppTextField(
                                      controller: _messageController,
                                      maxLines: null,
                                      maxLength: 300,
                                      hint: AppLocalizations.of(context)
                                          .translate("enter_your_message"),
                                      title: AppLocalizations.of(context)
                                          .translate("message"),
                                      inputType: TextInputType.text,
                                      onTextChanged: (value) {
                                         isChange =true;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          16.verticalSpace,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8).r,
                            child: Container(
                              decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8).r,
                                    color: colors(context).whiteColor),
                              child: Padding(
                                padding: const EdgeInsets.all(16).w,
                                child: MailBoxAttachmentView(
                                  deleteDraftAttachmentValue: (id) {
                                    bloc.add(
                                        DeleteMailAttachmentEvent(attachmentId: id));
                                  },
                                  draftAttachmentValue: (id) {
                                    bloc.add(
                                        GetMailAttachmentEvent(attachmentId: id));
                                  },
                                  newAttachmentValue: (path) async {
                                    await OpenFilex.open(path);
                                  },
                                  pickedFiles: pickedFiles,
                                  draftAttachment: draftMail?.attachments ?? [],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  AppButton(
                    // buttonType:(_subjectController.text.isEmpty || _messageController.text.isEmpty || initialRecipient.isEmpty)? ButtonType.DISABLED: ButtonType.ENABLED,
                    buttonType: ButtonType.PRIMARYENABLED,
                    buttonText: AppLocalizations.of(context).translate("send"),
                    onTapButton: () {
                      if (initialRecipientType?.code == null ||
                          initialRecipientType?.code == "") {
                        showAppDialog(
                            alertType: AlertType.FAIL,
                            isSessionTimeout: true,
                            title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                            message: AppLocalizations.of(context)
                                .translate("mailbox_recipient_required"),
                            onPositiveCallback: () {});
                        return;
                      }

                      if (_subjectController.text == "") {
                        showAppDialog(
                            alertType: AlertType.FAIL,
                            isSessionTimeout: true,
                            title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                            message: AppLocalizations.of(context)
                                .translate("mailbox_subject_required"),
                            onPositiveCallback: () {});
                        return;
                      }
                      if (_messageController.text == "") {
                        showAppDialog(
                            alertType: AlertType.FAIL,
                            isSessionTimeout: true,
                            title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                            message: AppLocalizations.of(context)
                                .translate("mailbox_empty_submission"),
                            onPositiveCallback: () {});
                        return;
                      }
                      // TODO NEED TO ADD REPLY TYPE
                      // if(true){
                      //   bloc.add(ReplyMailEvent(
                      //     // replyType: ,
                      //     status: "active",
                      //     inboxId: widget.mailData.viewMailData.inboxId!,
                      //     message: _messageController.text,
                      //     attachment: pickedFiles,
                      //     msgId: widget.mailData.viewMailData.mailResponseData?.firstWhere((element) => element.status=="draft").msgId));
                      // }
                      log(widget.mailData.isNewCompose.toString());

                      // TODO MAILBOX NEW MESSAGE)

                      // final otpRes = localDataSource.getOtpHandler();
                      // final sendTime = (otpRes.otpSendTime != null &&
                      //           otpRes.otpSendTime != "" &&
                      //           otpRes.countdownTime != "00:00")
                      //         ? int.parse(otpRes.countdownTime??"0")-(DateTime.now().difference(otpRes.otpSendTime!).inSeconds)
                      //       : 0;
                      //   if( sendTime >0 && otpRes.previousRoute == AppConstants.MAILBOX_NEWMESSAGE){
                      //     Navigator.pushNamed(context, Routes.kMailBoxOtpView,
                      //       arguments: MailboxOTPViewArgs(
                      //         otpResponseArgs: MailboxOtpResponseArgs(
                      //           previousRoute: otpRes.previousRoute,
                      //           isOtpSend: true,
                      //           otpType: otpRes.otpType,
                      //           otpTranId: otpRes.otpTranId,
                      //           email: otpRes.email,
                      //           mobile: otpRes.mobile,
                      //           countdownTime: sendTime,
                      //           otpLength: otpRes.otpLength,
                      //           resendAttempt: otpRes.resendAttempt,
                      //         ),
                      //         mailComposeData: MailComposeData(
                      //             status: widget.mailData.viewMailData
                      //                 .mailResponseDtoList?.first.status,
                      //             message: _messageController.text,
                      //             requestType: initialRecipientType?.code,
                      //             subject: _subjectController.text,
                      //             inboxId: widget.mailData.viewMailData.inboxId,
                      //             msgId: draftMail?.id,
                      //             isNewCompose: widget.mailData.isNewCompose,
                      //             attachment: pickedFiles),
                      //         otpType: "mailbox",
                      //         requestOTP: false,
                      //       ));
                      //   }else{
                      //     localDataSource.clearOtpHandler();
                      Navigator.pushNamed(context, Routes.kMailBoxOtpView,
                          arguments: MailboxOTPViewArgs(
                            otpResponseArgs: MailboxOtpResponseArgs(
                              previousRoute: AppConstants.MAILBOX_NEWMESSAGE,
                            ),
                            mailComposeData: MailComposeData(
                                status: widget.mailData.viewMailData
                                    .mailResponseDtoList?.first.status,
                                message: _messageController.text,
                                requestType: initialRecipientType?.code,
                                subject: _subjectController.text,
                                inboxId: widget.mailData.viewMailData.inboxId,
                                msgId: draftMail?.id,
                                isNewCompose: widget.mailData.isNewCompose,
                                attachment: pickedFiles),
                            otpType: "mailbox",
                            requestOTP: true,
                          ));
                      // }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkDraftStatus() {
    if (initialRecipientType?.code != null &&
        _messageController.text.isNotEmpty &&
        _subjectController.text.isNotEmpty &&
        (widget.mailData.isNewCompose == true ||
            (isChange && widget.mailData.messageType == 2) ||
            pickedFiles.isNotEmpty)) {
      showAppDialog(
          alertType: AlertType.MAIL,
          isSessionTimeout: true,
          title: AppLocalizations.of(context).translate("save_draft"),
          message: AppLocalizations.of(context).translate("save_draft_des"),
          negativeButtonText: AppLocalizations.of(context).translate("no"),
          positiveButtonText: AppLocalizations.of(context).translate("yes_save"),
          onNegativeCallback: () => Navigator.pop(context, ComposeMailResult(result: false,message: "",where: where)),
          onPositiveCallback: () {
            
            bloc.add(ComposeMailEvent(
                replyType: "SENT",
                isDraft: true,
                message: _messageController.text,
                recipientTypeCode: initialRecipientType?.code ?? '',
                subject: _subjectController.text,
                attachment: pickedFiles));
            setState(() {
              isDraft = true;
            });
          });
    } else {
      Navigator.pop(context, ComposeMailResult(result: false,message: "",where: where));
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
