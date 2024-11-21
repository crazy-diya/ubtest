import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/service/storage_service.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
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
import 'package:union_bank_mobile/features/presentation/views/mailbox/widgets/mailbox_attachment_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:union_bank_mobile/utils/navigation_routes.dart';


import '../../widgets/pop_scope/ub_pop_scope.dart';

class MailBoxPreview extends BaseView {
  final MailData mailData;
  MailBoxPreview({required this.mailData, Key? key}) : super(key: key);

  @override
  State<MailBoxPreview> createState() => _MailBoxPreviewState();
}

class _MailBoxPreviewState extends BaseViewState<MailBoxPreview> {
  var bloc = injection<MailBoxBloc>();

  String titleLang(BuildContext context, int type) {
    switch (type) {
      case 0:
        return AppLocalizations.of(context).translate("inbox");
      case 1:
        return AppLocalizations.of(context).translate("sent");
      case 2:
        return AppLocalizations.of(context).translate("draft");
      default:
        return AppLocalizations.of(context).translate("inbox");
    }
  }

   late TextEditingController _messageController;

  List<int> expandlist = [];

  List<ExpansionTileController> expansionTileControllersExpnad = [];

  List<ThreadMessageResponseData> mailThreadResponseExpnad = [];
  List<ThreadMessageResponseData> mailThreadResponseCollapse = [];
  ThreadMessageResponseData? draftReplyMail;

  List<AttachmentData> pickedFiles = [];

  bool refreshData = false;

  

  final _scrollController = ScrollController();
  @override
  void initState() {
    // expandlist.add(0);
     _messageController = TextEditingController();
    bloc.add(GetMailThreadEvent(
        inboxId: widget.mailData.viewMailData.inboxId, isComposeDraft:widget.mailData.messageType ==2? true:false));
    super.initState();
  }


  void _scrollToBottom() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
    );
  });
}
  bool expand = true;

  WHERE where = WHERE.NONE;

  bool isChange = false;

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async{
        checkDraftStatus();
        return false;
      },
      child: Scaffold(
         backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          onBackPressed: () => checkDraftStatus(),
          title: titleLang(context, widget.mailData.messageType),
          // actions: [
          //   //  if(widget.previewMailData.messageType != 1)
          //   InkWell(
          //     onTap: () {
          //       showAppDialog(
          //           alertType: AlertType.WARNING,
          //           isSessionTimeout: true,
          //           title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_QUESTION),
          //           message: "Are you sure want to delete selected mail ?",
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
          // ],
        ),
        body: BlocProvider<MailBoxBloc>(
          create: (context) => bloc,
          child: BlocListener<MailBoxBloc, BaseState<MailBoxState>>(
            listener: (context, state) {
              if (state is DeleteMailSuccessState) {
                showAppDialog(
                  alertType: AlertType.SUCCESS,
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_SUCCESS),
                  message:widget.mailData.messageType ==1? "Sent delete success":"Inbox delete success",
                  onPositiveCallback: () {
                    Navigator.pop(context, true);
                  }); 
              } else if (state is DeleteMailFailedState) {
                showAppDialog(
                    alertType: AlertType.FAIL,
                    isSessionTimeout: true,
                    title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                    message: state.message,
                    onPositiveCallback: () {});
              }else if (state is DeleteMailMessageSuccessState) {
               ToastUtils.showCustomToast(context, state.message ?? "", ToastStatus.SUCCESS);
                bloc.add(GetMailThreadEvent(inboxId: widget.mailData.viewMailData.inboxId, isComposeDraft: false));
              } else if (state is DeleteMailMessageFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.FAIL);
              } else if (state is ComposeMailSuccessState) {
                Navigator.pop(context, ComposeMailResult(result: true, message: state.message??"", where: where));
              } else if (state is ComposeMailFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.FAIL);
              } else if (state is ReplyMailSuccessState) {
                if(widget.mailData.messageType == 2){
                  Navigator.pop(context,ComposeMailResult(result: true,message: state.message??"",where: where));
                }
                // else{
                //    showAppDialog(
                //       alertType: AlertType.SUCCESS,
                //       isSessionTimeout: true,
                //       title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_SUCCESS),
                //       message: state.message,
                //       onPositiveCallback: () {});

                //   bloc.add(GetMailThreadEvent(
                //     inboxId: widget.mailData.viewMailData.inboxId,
                //     isComposeDraft: false));

                // }
              } else if (state is ReplyMailFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.FAIL);
              } else if (state is MarkAsReadMailSuccessState) {
                setState(() {
                  refreshData = true;
                });
              } else if (state is GetMailThreadLoadedState) {
                mailThreadResponseExpnad.clear();
                mailThreadResponseCollapse.clear();
                draftReplyMail = ThreadMessageResponseData();
                if (state.mailThread?.totalUnread != 0 &&
                    widget.mailData.messageType == 0)
                  bloc.add(MarkAsReadMailEvent(
                      inboxIdList: [widget.mailData.viewMailData.inboxId!],
                      isSilent: false));
                if (state.mailThread?.inboxResponseDto
                            ?.threadMessageResponseDtos !=
                        [] ||
                    state.mailThread?.inboxResponseDto
                            ?.threadMessageResponseDtos !=
                        null) {
                  state.mailThread?.inboxResponseDto?.threadMessageResponseDtos?.forEach((element) {
                    if (element.replyType == "DRAFT") {
                      draftReplyMail = element;
                    } else {
                      mailThreadResponseExpnad.add(element);
                     
                    }
                  });
                  expansionTileControllersExpnad.addAll(List.generate(mailThreadResponseExpnad.length, (index) => ExpansionTileController()));
                  if(mailThreadResponseExpnad.length >3){
                    mailThreadResponseCollapse.addAll([
                      mailThreadResponseExpnad[0],
                      mailThreadResponseExpnad[1],
                      mailThreadResponseExpnad.last
                    ]);
                    expand = false;
                  }
                  
                }
                _messageController =
                    TextEditingController(text: draftReplyMail?.message ?? "");
                expandlist.add(mailThreadResponseExpnad.length > 3
                    ? mailThreadResponseCollapse.length - 1
                    : mailThreadResponseExpnad.length - 1);
                setState(() {});
              } else if (state is GetMailThreadFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.FAIL);
                Navigator.pop(context,ComposeMailResult(result: false, message: state.message??"", where: where));
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
                    isComposeDraft: false));
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.SUCCESS);
              } else if (state is DeleteMailAttachmentFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message ?? "", ToastStatus.FAIL);
              }
            },
            child: Padding(
              padding:  EdgeInsets.symmetric( horizontal:  20,).w,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                               Padding(
                                  padding: EdgeInsets.only(top:24,bottom: 20+AppSizer.getHomeIndicatorStatus(context)).h,
                                child: ClipRRect(
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
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                widget.mailData.viewMailData.subject ?? "",
                                                style: size18weight700.copyWith(color: colors(context).blackColor), 
                                                overflow: TextOverflow.clip,
                                              )),
                                            ],
                                          ),
                                          ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemCount:
                                                mailThreadResponseExpnad.length > 3 && !expand
                                                    ? mailThreadResponseCollapse.length
                                                    : mailThreadResponseExpnad.length,
                                            itemBuilder: (context, index) {
                                              final mailResponseData = mailThreadResponseExpnad.length > 3 && !expand?mailThreadResponseCollapse[index]:mailThreadResponseExpnad[index];
                                              return Column(
                                                children: [
                                                  if (!(mailResponseData.status == "draft" &&
                                                      (mailThreadResponseExpnad.length > 3 && !expand?   mailThreadResponseCollapse.length - 1: mailThreadResponseCollapse.length - 1) == index)
                                                      // &&( expand)
                                                      )
                                                    ExpansionTile(
                                                      controller:expansionTileControllersExpnad[index],
                  
                                                      shape: Border(
                                                        bottom: BorderSide(
                                                                    color: Colors.transparent),
                                                      ),
                                                      trailing: (expandlist.any((element) =>
                                                                  element == index))
                                                              ? const SizedBox.shrink()
                                                              : mailResponseData.attachments!.isEmpty
                                                                  ? const SizedBox.shrink()
                                                                  : IntrinsicWidth(
                                                                    child: Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(8).r,
                                                                          color: colors(context).primaryColor50,
                                                                          border: Border.all(color: colors(context).primaryColor300!)),
                                                                      child: Padding(
                                                                        padding:  EdgeInsets.symmetric(vertical: 4.w,horizontal: 8.w),
                                                                        child: Row(children: [
                                                                        PhosphorIcon(
                                                                            PhosphorIcons.paperclip(PhosphorIconsStyle.bold),
                                                                            size: 16.w,
                                                                            color: colors(context).greyColor,
                                                                          ),
                                                                          4.horizontalSpace,
                                                                            Text(mailResponseData.attachments!.length.toString()
                                                                                  ,
                                                                              style: size12weight400.copyWith(
                                                                                  color: colors(context).greyColor),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                      initiallyExpanded: index ==( mailThreadResponseExpnad.length > 3 && !expand ? mailThreadResponseCollapse.length - 1:  mailThreadResponseExpnad.length - 1),
                                                      leading:   Container(
                                                        decoration: BoxDecoration(
                                                          color: colors(context).whiteColor,
                                                            shape: BoxShape.circle,
                                                            border: Border.all(
                                                                color: colors(context).greyColor300!)),
                                                        child: CircleAvatar(
                                                          backgroundColor: colors(context).whiteColor,
                                                          radius: 24.w,
                                                          child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(100),
                                                            child: Image.asset(
                                                            AppAssets.ubBank,
                                                                                                                    ),
                                                          ),
                                                        ),
                                                        ),
                                                      // mailResponseData.createdBy == AppConstants.profileData.userName
                                                      //   ? Container(
                                                      //       decoration: BoxDecoration(
                                                      //           shape: BoxShape.circle,
                                                      //           border: Border.all(
                                                      //               color: colors(context).greyColor300!)),
                                                      //       child: CircleAvatar(
                                                      //         backgroundColor: colors(context).secondaryColor100,
                                                      //         radius: 6.w,
                                                      //         child: Text(
                                                      //         mailResponseData.createdBy?.getNameInitial() ??
                                                      //               "",
                                                      //           style: size20weight700.copyWith(
                                                      //               color: colors(context).secondaryColor800),
                                                      //         ),
                                                      //       ),
                                                      //     ) : AppConstants.profileData.profileImage != null? Container(
                                                      //       decoration: BoxDecoration(
                                                      //           shape: BoxShape.circle,
                                                      //           border: Border.all(
                                                      //               color: colors(context).greyColor300!)),
                                                      //       child: CircleAvatar(
                                                      //         radius: 6.w,
                                                      //         backgroundImage: MemoryImage(
                                                      //             AppConstants.profileData.profileImage!),
                                                      //       ),
                                                      //     )
                                                      //   : Container(
                                                      //       decoration: BoxDecoration(
                                                      //           shape: BoxShape.circle,
                                                      //           border: Border.all(
                                                      //               color: colors(context).greyColor300!)),
                                                      //       child: CircleAvatar(
                                                      //         backgroundColor: colors(context).secondaryColor100,
                                                      //         radius: 6.w,
                                                      //         child: Text(
                                                      //           AppConstants.profileData.cName
                                                      //                   ?.getNameInitial() ??
                                                      //               "",
                                                      //           style: size20weight700.copyWith(
                                                      //               color: colors(context).secondaryColor800),
                                                      //         ),
                                                      //       ),
                                                      //     ),
                  
                                                      collapsedShape: Border(
                                                        bottom: BorderSide(
                                                            color: Colors.transparent),
                                                      ),
                                                      tilePadding: EdgeInsets.zero,
                                                      onExpansionChanged: (value) {
                                                        if (value) {
                                                          expandlist.add(index);
                                                        } else {
                                                          expandlist.remove(index);
                                                        }
                                                        setState(() {});
                                                      },
                                                      title: Row(
                                                        children: [
                                                          Text(
                                                            widget.mailData.viewMailData.recipientCategoryName ?? "",
                                                            style: size16weight700.copyWith(color: colors(context).blackColor)
                                                          ),
                                                          8.horizontalSpace,
                                                          Text(AppUtils.formattedDate(
                                                                  mailResponseData.createdDate),
                                                              style: size14weight400.copyWith(color: colors(context).blackColor,overflow:
                                                                      TextOverflow.ellipsis)
                                                              ),
                  
                  
                                                                  // Row(
                                                                  //     children: [
                                                                  //       PhosphorIcon(
                                                                  //       PhosphorIcons.paperclip(PhosphorIconsStyle.bold),
                                                                  //       size: 4.5.w,
                                                                  //       color: colors(context).greyColor,
                                                                  //     ),
                                                                  //     2.5.horizontalSpace,
                                                                  //       Text(
                                                                  //         mailResponseData.attachments!.length.toString(),
                                                                  //         style: size14weight400.copyWith(color: colors(context).blackColor,overflow: TextOverflow.ellipsis)
                                                                  //       ),
                                                                  //     ],
                                                                  //   )
                                                        ],
                                                      ),
                                                      subtitle: Text(
                                                      "${AppLocalizations.of(context).translate("recipient_type")} : ${widget.mailData.viewMailData.recipientTypeName!}",
                                                        style: size14weight400.copyWith(color: colors(context).blackColor,overflow: TextOverflow.ellipsis)
                                                      ),
                                                      children: [
                                                        Column(children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Expanded(
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment.centerLeft,
                                                                    child: Text(
                                                                      mailResponseData
                                                                              .message ??
                                                                          "",
                                                                      style: size14weight400.copyWith(color: colors(context).greyColor)
                                                                    )),
                                                              ),
                  
                                                            ],
                                                          ),
                                                           24.verticalSpace,
                  
                                                          if (mailResponseData
                                                              .attachments!.isNotEmpty)
                                                            GridView.count(
                                                              mainAxisSpacing: 10.w,
                                                              crossAxisSpacing: 10.w,
                                                              crossAxisCount: 3,
                                                              key: const Key("grid"),
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              children: [
                                                                ...mailResponseData.attachments
                                                                        ?.map((e) => Stack(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap: () {
                                                                          bloc.add(GetMailAttachmentEvent(attachmentId: e.attachmentId));
                                                                          },
                                                                          child: Container(
                                                                              width: double.infinity,
                                                                              height: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                  color: colors(context).primaryColor50,
                                                                                  borderRadius: BorderRadius.circular(8).r,
                                                                                  border: Border.all(
                                                                                      color: colors(context).primaryColor!)),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8).w,
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    Text(
                                                                                      e.attachmentName!,
                                                                                      maxLines: 1,
                                                                                      textAlign: TextAlign.center,
                                                                                      overflow: TextOverflow.clip,
                                                                                      style: size12weight400.copyWith(
                                                                                          color: colors(context).blackColor),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              )),
                                                                        ),
                                                                        Positioned(
                                                                          top: 8.w,
                                                                          left: 8.w,
                                                                          child: PhosphorIcon(
                                                                            AppUtils.getAttachMentIcon(e.attachmentType!),
                                                                              color: colors(context).primaryColor,size: 20.w,
                                                                          ),
                                                                        ),
                                                                                  ],
                                                                                ))
                                                                        .toList() ??
                                                                    [],
                                                              ],
                                                            ),
                                                             if (mailResponseData
                                                              .attachments!.isNotEmpty) 24.verticalSpace,
                                                        ]),
                                                      ],
                                                    ),
                                                    mailThreadResponseExpnad.length >  3 && !expand && index == 1
                                                      ? Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Container(
                                                              color: colors(context)
                                                                  .primaryColor100!,
                                                              height: 8.h,
                                                              width: double.infinity,
                                                            ),
                  
                                                            InkWell(
                                                              onTap: () {
                                                                expand = true;
                                                                setState(() {});
                                                                 expansionTileControllersExpnad.forEach((element) {
                                                                  try {
                                                                    element.collapse();
                                                                  } catch (e) {
                                                                    return;
                                                                  }
                                                                });
                                                                _scrollToBottom();
                                                              },
                                                              child: Container(
                  
                                                                    decoration: BoxDecoration( color: colors(context)
                                                                    .primaryColor!,borderRadius: BorderRadius.circular(8).r),
                                                                  child: Padding(
                                                                    padding:  EdgeInsets.symmetric(vertical:2.h,horizontal: 8.w),
                                                                    child: Text("${mailThreadResponseExpnad.length-3}",style: size14weight700.copyWith(color: colors(context).whiteColor),),
                                                                  ),
                                                              ),
                                                            ),
                                                        ],
                                                      )
                                                      : Container(
                                                          color: colors(context)
                                                              .greyColor100!,
                                                          height: 1.w,
                                                          width: double.infinity,
                                                        )
                                                ],
                                              );
                                            },
                                          ),
                                          if (draftReplyMail?.replyType == "DRAFT")
                                          ExpansionTile(
                                            enabled: false,
                                                      shape: Border(
                                                        bottom: BorderSide.none),
                                                      trailing: const SizedBox.shrink(),
                                                      initiallyExpanded: true,
                                                      leading: Container(
                                                      decoration: BoxDecoration(
                                                        color: colors(context).whiteColor,
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                              color: colors(context).greyColor300!)),
                                                      child: CircleAvatar(
                                                        backgroundColor: colors(context).whiteColor,
                                                        radius: 24.w,
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(100),
                                                          child: Image.asset(
                                                          AppAssets.ubBank,
                                                                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                      
                                                      // draftReplyMail?.createdBy == AppConstants.profileData.userName
                                                      //   ? Container(
                                                      //       decoration: BoxDecoration(
                                                      //           shape: BoxShape.circle,
                                                      //           border: Border.all(
                                                      //               color: colors(context).greyColor300!)),
                                                      //       child: CircleAvatar(
                                                      //         backgroundColor: colors(context).secondaryColor100,
                                                      //         radius: 6.w,
                                                      //         child: Text(
                                                      //         draftReplyMail?.createdBy?.getNameInitial() ??
                                                      //               "",
                                                      //           style: size20weight700.copyWith(
                                                      //               color: colors(context).secondaryColor),
                                                      //         ),
                                                      //       ),
                                                      //     ) : AppConstants.profileData.profileImage != null? Container(
                                                      //       decoration: BoxDecoration(
                                                      //           shape: BoxShape.circle,
                                                      //           border: Border.all(
                                                      //               color: colors(context).greyColor300!)),
                                                      //       child: CircleAvatar(
                                                      //         radius: 6.w,
                                                      //         backgroundImage: MemoryImage(
                                                      //             AppConstants.profileData.profileImage!),
                                                      //       ),
                                                      //     )
                                                      //   : Container(
                                                      //       decoration: BoxDecoration(
                                                      //           shape: BoxShape.circle,
                                                      //           border: Border.all(
                                                      //               color: colors(context).greyColor300!)),
                                                      //       child: CircleAvatar(
                                                      //         backgroundColor: colors(context).secondaryColor100,
                                                      //         radius: 6.w,
                                                      //         child: Text(
                                                      //           AppConstants.profileData.cName
                                                      //                   ?.getNameInitial() ??
                                                      //               "",
                                                      //           style: size20weight700.copyWith(
                                                      //               color: colors(context).secondaryColor800),
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                      
                                                      collapsedShape: Border(
                                                        bottom: BorderSide.none),
                                                      tilePadding: EdgeInsets.zero,
                                                      onExpansionChanged: (value) {
                                                      },
                                                      title:  Row(
                                                        children: [
                                                          Text(
                                                            widget.mailData.viewMailData.recipientCategoryName ?? "",
                                                            style: size16weight700.copyWith(color: colors(context).blackColor) 
                                                          ),
                                                          8.horizontalSpace,
                                                          Text(
                                                            AppLocalizations.of(context)
                                                                .translate("draft"),
                                                            style:size16weight700.copyWith(color: colors(context)
                                                                    .negativeColor) ,
                                                          ),
                                                          const Spacer(),
                                                        ],
                                                      ),
                                                      subtitle: Text(
                                                      "${AppLocalizations.of(context).translate("recipient_type")} : ${widget.mailData.viewMailData.recipientTypeName!}",
                                                        style: size14weight400.copyWith(color: colors(context).blackColor,overflow: TextOverflow.ellipsis) 
                                                      ),
                                                      children: [
                                                        Column(children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Expanded(
                                                                child: Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: AppTextField(
                                                                    controller: _messageController,
                                                                    maxLines: 5,
                                                                    maxLength: 300,
                                                                    hint: AppLocalizations.of(context)
                                                                        .translate("message"),
                                                                    isCurrency: false,
                                                                    inputType: TextInputType.text,
                                                                    isLabel: false,
                                                                    onTextChanged: (value) {
                  
                                                                      isChange = true;
                                                                      setState(() {});
                                                                    },
                                                                  ),),
                                                              ),
                                                             
                                                            ],
                                                          ),
                                                           4.verticalSpace,
                                                        ]),
                                                      ],
                                                    ),
                                            
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (draftReplyMail?.replyType == "DRAFT") Column(
                                children: [
                                  // 16.verticalSpace,
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
                                             bloc.add(DeleteMailAttachmentEvent(
                                                 attachmentId: id));
                                           },
                                           draftAttachmentValue: (id) {
                                             bloc.add(GetMailAttachmentEvent(
                                                 attachmentId: id));
                                           },
                                           newAttachmentValue: (path) async {
                                             await OpenFilex.open(path);
                                           },
                                           pickedFiles: pickedFiles,
                                           draftAttachment:
                                               draftReplyMail?.attachments ?? [],
                                         ),
                                       ),
                                     ),
                                   ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      //  if(widget.previewMailData.messageType != 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: (draftReplyMail?.replyType == "DRAFT")
                                  ? Padding(
                                    padding:  EdgeInsets.only(bottom: 20 + AppSizer.getHomeIndicatorStatus(context),top: 20).h,
                                    child: AppButton(
                                        // buttonType:(_subjectController.text.isEmpty || _messageController.text.isEmpty || initialRecipient.isEmpty)? ButtonType.DISABLED: ButtonType.ENABLED,
                                        buttonType: ButtonType.PRIMARYENABLED,
                                        buttonText: AppLocalizations.of(context)
                                            .translate("send"),
                                        onTapButton: () {
                                          if (_messageController.text == "" ) {
                                            showAppDialog(
                                                alertType: AlertType.FAIL,
                                                isSessionTimeout: true,
                                                title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                                                message: AppLocalizations.of(context)
                                                    .translate(
                                                        "mailbox_empty_submission"),
                                                onPositiveCallback: () {});
                                            return;
                                          }
                  
                                           setState(() {
                                            where = WHERE.REPLY;
                                          });
                  
                                          bloc.add(ReplyMailEvent(
                                              replyType: "SENT",
                                              isDraft: false,
                                              inboxId: widget
                                                  .mailData.viewMailData.inboxId,
                                              message: _messageController.text,
                                              msgId: draftReplyMail?.id,
                                              recipientTypeCode: widget
                                                      .mailData
                                                      .viewMailData
                                                      .recipientTypeCode ??
                                                  '',
                                              subject: widget
                                                  .mailData.viewMailData.subject,
                                              attachment: pickedFiles));
                                          expandlist.clear();
                                          setState(() {});
                                        },
                                      ),
                                  )
                                  : SizedBox.shrink())
                  
                                  // Padding(
                                  //     padding: const EdgeInsets.only(top: 20),
                                  //     child: AppButton(
                                  //       buttonText: AppLocalizations.of(context)
                                  //           .translate("reply"),
                                  //       onTapButton: () async {
                                  //         final result = await Navigator.pushNamed(
                                  //             context, Routes.kMailBoxReplyMail,
                                  //             arguments: widget.mailData);
                                  //         if (result == true) {
                                  //           bloc.add(GetMailThreadEvent(
                                  //               inboxId: widget
                                  //                   .mailData.viewMailData.inboxId,
                                  //               isComposeDraft: false));
                                  //           setState(() {
                                  //             refreshData = true;
                                  //           });
                                  //         }
                                  //       },
                                  //     ),
                                  //   )),
                        ],
                      )
                    ],
                  ),
                  (draftReplyMail?.replyType != "DRAFT") ?  Positioned(
                    bottom: 42.h+AppSizer.getHomeIndicatorStatus(context),
                    right: 4,
                      child: InkWell(
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                  context, Routes.kMailBoxReplyMail,
                                  arguments: widget.mailData) as ComposeMailResult;
                              if (result.result == true &&( result.where == WHERE.REPLY) ) {
                                    setState(() {
                                      where = result.where;
                                    });
                                    showAppDialog(
                                      alertType: AlertType.SUCCESS,
                                      isSessionTimeout: true,
                                      title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_SUCCESS),
                                      message:splitAndJoinAtBrTags(result.message) ,
                                      onPositiveCallback: () {
                                        setState(() {
                                          refreshData = true;
                                        });
                                      
                                  }); 
                                bloc.add(GetMailThreadEvent(
                                    inboxId: widget.mailData.viewMailData.inboxId,
                                    isComposeDraft: false));
                                
                              }else{
                                setState(() {
                                  where = result.where;
                                    setState(() {
                                      refreshData = true;
                                    });
                                  });
                                  bloc.add(GetMailThreadEvent(
                                    inboxId: widget.mailData.viewMailData.inboxId,
                                    isComposeDraft: false));

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
                                    PhosphorIcons.arrowBendUpLeft(PhosphorIconsStyle.bold),
                                    color: colors(context).whiteColor,
                                  ),
                                ))),
                    ) : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

    void checkDraftStatus() {
    if (_messageController.text.isNotEmpty &&
        ((draftReplyMail?.replyType == "DRAFT" && isChange) ||
            pickedFiles.isNotEmpty)) {
      showAppDialog(
          alertType: AlertType.MAIL,
          isSessionTimeout: true,
          title: "Save as a Draft?",
          message: "Do you want to save this is as a draft?",
          negativeButtonText: "No",
          positiveButtonText: "Yes, Save",
          onNegativeCallback: () =>   Navigator.pop(context,  ComposeMailResult(result: refreshData,message: "",where: where)),
          onPositiveCallback: () {
            bloc.add(ReplyMailEvent(
                inboxId: widget.mailData.viewMailData.inboxId,
                replyType: "DRAFT",
                isDraft: false,
                message: _messageController.text,
                recipientTypeCode:
                    widget.mailData.viewMailData.recipientTypeCode ?? '',
                subject: widget.mailData.viewMailData.subject,
                attachment: pickedFiles));
          });
      setState(() {
        where = WHERE.DRAFT;
      });
    } else {
           Navigator.pop(context,  ComposeMailResult(result: refreshData,message: "",where: where));
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
