import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';
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
import 'package:union_bank_mobile/features/presentation/views/mailbox/widgets/mailbox_attachment_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/enums.dart';


import '../../../../utils/app_sizer.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';

class MailBoxReplyMail extends BaseView {
  final MailData previewMailData;
  MailBoxReplyMail({required this.previewMailData, Key? key}) : super(key: key);

  @override
  State<MailBoxReplyMail> createState() => _MailBoxReplyMailState();
}

class _MailBoxReplyMailState extends BaseViewState<MailBoxReplyMail> {
  var bloc = injection<MailBoxBloc>();

  // late TextEditingController _subjectController;
  late TextEditingController _messageController;

  CommonDropDownResponse? initialRecipientType;
  CommonDropDownResponse? initialRecipientCategory;

  List<AttachmentData> pickedFiles = [];

  WHERE where = WHERE.NONE;

  @override
  void initState() {
    // _subjectController = TextEditingController(text: widget.previewMailData.viewMailData.subject);
    _messageController = TextEditingController();
    initialRecipientCategory = CommonDropDownResponse(
                      code: widget.previewMailData.viewMailData.recipientCategoryCode,
                      description:widget.previewMailData.viewMailData.recipientCategoryName 
                      );
    initialRecipientType = CommonDropDownResponse(
        code: widget.previewMailData.viewMailData.recipientTypeCode,
        description:widget.previewMailData.viewMailData.recipientTypeName,
        key: widget.previewMailData.viewMailData.recipientTypeEmail 
        );
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async{
        checkDraftStatus();
        return true;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          onBackPressed: () {
            checkDraftStatus();
          },
          backPressedIcon: Icons.close,
          title: AppLocalizations.of(context).translate("reply"),
        ),
        body: BlocProvider<MailBoxBloc>(
          create: (_) => bloc,
          child: BlocListener<MailBoxBloc, BaseState<MailBoxState>>(
            listener: (context, state) {
              if (state is ReplyMailSuccessState) {

          Navigator.of(context).pop(ComposeMailResult(result: true, message: state.message??"",where:where));  

              } else if (state is ReplyMailFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message??"", ToastStatus.FAIL);
              }
            },
            child: Padding(
              padding:  EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text(
                                          AppLocalizations.of(context).translate("recipient_category"),
                                          style: size14weight700.copyWith(
                                              color: colors(context).blackColor),
                                        ),
                                        Text(initialRecipientCategory
                                                ?.description ??
                                            "", style: size14weight400.copyWith(
                                              color: colors(context).greyColor),)
                                    ],),
                                    12.verticalSpace,
                                    Divider(color: colors(context).greyColor100,height: 0,thickness: 1.w,),
                                    12.verticalSpace,
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text(
                                          AppLocalizations.of(context).translate("recipient_type"),
                                          style: size14weight700.copyWith(
                                              color: colors(context).blackColor),
                                        ),
                                        Text(initialRecipientType?.description ??
                                            "", style: size14weight400.copyWith(
                                              color: colors(context).greyColor),)
                                    ],),
                                    12.verticalSpace,
                                    Divider(color: colors(context).greyColor100,height: 0,thickness: 1.w,),
                                    12.verticalSpace,
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text(
                                          AppLocalizations.of(context).translate("subject"),
                                          style: size14weight700.copyWith(
                                              color: colors(context).blackColor),
                                        ),
                                        Text(widget.previewMailData.viewMailData.subject ??
                                            "", style: size14weight400.copyWith(
                                              color: colors(context).greyColor),)
                                    ],),
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
                                child: Column(
                                  children: [
                                    Text("On ${AppUtils.formattedDate2(widget.previewMailData.viewMailData.mailResponseDtoList?.first.createdDate)} Union Bank <unionbank.com> wrote:",style: size14weight400.copyWith(
                                              color: colors(context).greyColor)),
                                  AppTextField(
                                      controller: _messageController,
                                      maxLines: null,
                                      maxLength: 300,
                                      hint:
                                          AppLocalizations.of(context).translate("message"),
                                      isCurrency: false,
                                      inputType: TextInputType.text,
                                      isLabel: false,
                                      onTextChanged: (value) {
                                        // setState(() {});
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
                                        pickedFiles: pickedFiles,
                                        draftAttachment: [],
                                      )))),
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
                      if (initialRecipientType == null) {
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
    
                      // if (_subjectController.text.isEmpty) {
                      //   showAppDialog(
                      //       alertType: AlertType.FAIL,
                      //       isSessionTimeout: true,
                      //       title: AppLocalizations.of(context)
                    // .translate(ErrorHandler.TITLE_ERROR),
                      //       message: AppLocalizations.of(context)
                      //           .translate("mailbox_subject_required"),
                      //       onPositiveCallback: () {});
                      //   return;
                      // }
                      if (_messageController.text.isEmpty) {
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

                        setState(() {
                                      where = WHERE.REPLY;
                                    });
    
                      bloc.add(ReplyMailEvent(
                           inboxId:  widget.previewMailData.viewMailData.inboxId,
                           replyType: "SENT",
                           isDraft: false,
                           message: _messageController.text,
                           recipientTypeCode: widget.previewMailData.viewMailData.recipientTypeCode ?? '',
                           subject:  widget.previewMailData.viewMailData.subject,
                           attachment: pickedFiles,
                           ));
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
    if ( _messageController.text.isNotEmpty) {
      showAppDialog(
          alertType: AlertType.MAIL,
          isSessionTimeout: true,
          title: AppLocalizations.of(context).translate("save_draft"),
          message: AppLocalizations.of(context).translate("save_draft_des"),
          negativeButtonText: AppLocalizations.of(context).translate("no"),
          positiveButtonText: AppLocalizations.of(context).translate("yes_save"),
          onNegativeCallback: () => Navigator.pop(context,ComposeMailResult(result: false, message: "",where: where)),
          onPositiveCallback: () {
            bloc.add(ReplyMailEvent(
              inboxId:  widget.previewMailData.viewMailData.inboxId,
              replyType: "DRAFT",
              isDraft: false,
              message: _messageController.text,
              recipientTypeCode: widget.previewMailData.viewMailData.recipientTypeCode ?? '',
              subject:  widget.previewMailData.viewMailData.subject,
              attachment: pickedFiles));
          });
          setState(() {
            where = WHERE.DRAFT;
          });
          
    }else{
      Navigator.pop(context,ComposeMailResult(result: false, message: "",where: where));
    }
  }


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
