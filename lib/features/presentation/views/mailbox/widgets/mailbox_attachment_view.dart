// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_thread_response.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/attachment_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_dialog.dart';
import 'package:union_bank_mobile/features/presentation/widgets/bottom_sheet.dart';
import 'package:union_bank_mobile/features/presentation/widgets/image_cropper.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';
import 'package:union_bank_mobile/utils/enums.dart';

class MailBoxAttachmentView extends StatefulWidget {
  final List<AttachmentData> pickedFiles;
  final List<Attachment> draftAttachment;
  Function(int)? draftAttachmentValue;
  Function(int)? deleteDraftAttachmentValue;
  Function(String)? newAttachmentValue;
  MailBoxAttachmentView(
      {Key? key,
      required this.pickedFiles,
      required this.draftAttachment,
      this.draftAttachmentValue,
      this.newAttachmentValue,
      this.deleteDraftAttachmentValue})
      : super(key: key);

  @override
  State<MailBoxAttachmentView> createState() => _MailBoxAttachmentViewState();
}

class _MailBoxAttachmentViewState extends State<MailBoxAttachmentView> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).translate("attachments"),
                style:
                    size14weight700.copyWith(color: colors(context).blackColor),
              ),
              3.verticalSpace,
              Text("${AppLocalizations.of(context).translate("max_size")} : 1MB \n${AppLocalizations.of(context).translate("supports")}: PDF, JPG, JPEG, PNG, XLS",
                  style: size14weight400.copyWith(
                      color: colors(context).greyColor)),
            ],
          ),
        ),
        24.verticalSpace,
        GridView.count(
          mainAxisSpacing: 10.w,
          crossAxisSpacing: 10.w,
          crossAxisCount: 3,
          key: const Key("grid"),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            InkWell(
              onTap: () {
                if ((widget.pickedFiles.length +
                        widget.draftAttachment.length) <
                    5) {
                  _showBottomSheet(context);
                } else {
                  _showDialog();
                }
              },
              child: DottedBorder(
                  color: colors(context).primaryColor!,
                  dashPattern:  [3.w, 3.w],
                  strokeCap: StrokeCap.round,
                  radius: const Radius.circular(8).r,
                  borderType: BorderType.RRect,
                  padding: const EdgeInsets.all(1).w,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                   
                    decoration: BoxDecoration( color: colors(context).primaryColor50,borderRadius: BorderRadius.circular(8).r),
                    child: Center(
                        child: PhosphorIcon(
                      PhosphorIcons.plus(PhosphorIconsStyle.bold),
                      size: 32.w,
                      color: colors(context).primaryColor,
                    )),
                  )),
            ),
            ...widget.draftAttachment
                .map((e) => Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            widget.draftAttachmentValue!(e.attachmentId!);
                            setState(() {});
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
                                      path.basenameWithoutExtension(e.attachmentName!) ,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
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
                        Positioned(
                          top: 5.w,
                          right: 5.w,
                          child: InkWell(
                              onTap: () {
                                widget.deleteDraftAttachmentValue!(
                                    e.attachmentId!);
                                setState(() {});
                              },
                              child: PhosphorIcon(
                                PhosphorIcons.xCircle(PhosphorIconsStyle.bold),size: 24.w,
                                color: colors(context).greyColor300,
                              )),
                        ),
                      ],
                    ))
                .toList(),
            if (widget.draftAttachment.length < 5)
              ...widget.pickedFiles
                  .map((e) => Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              widget.newAttachmentValue!(e.file.path);
                              setState(() {});
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
                                     path.basenameWithoutExtension(e.fileName) ,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
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
                              AppUtils.getAttachMentIcon(e.extension),
                              color: colors(context).primaryColor,
                            ),
                          ),
                          Positioned(
                            top: 5.w,
                            right: 5.w,
                            child: InkWell(
                                onTap: () {
                                  widget.pickedFiles.remove(e);
                                  setState(() {});
                                },
                                child: PhosphorIcon(
                                  PhosphorIcons.xCircle(
                                      PhosphorIconsStyle.bold),
                                  color: colors(context).greyColor300,size: 24.w,
                                )),
                          ),
                        ],
                      ))
                  .toList()
          ],
        )
      ],
    );
    
  }
  

  void _showDialog() {
    showGeneralDialog(
        context: context,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AppDialog(
                  alertType: AlertType.FAIL,
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                  description: AppLocalizations.of(context).translate("maximum_attachment_only"),
                  onPositiveCallback: () {}),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return const SizedBox.shrink();
        });
  }

  Future<File?> pickImageCamera() async {
    try {
      final result = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
          maxHeight: 800,
          maxWidth: 800);
      if (result != null) {
        final CroppedFile? cropped = await AppImageCropper()
            .getCroppedImage(PickedFile(result.path), context);
        if (cropped != null) {
          final photo = File(cropped.path);
          return photo;
        }
        return null;
      }
    } on PlatformException {}
    return null;
  }

  Future<File?> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ["pdf", "jpeg", "jpg", "png", "xls"]);
      if (result != null) {
        File file = File(result.files.first.path!);
        return file;
      }
    } on PlatformException {}
    return null;
  }

  

  showAppDialog(
      {required String title,
      String? message,
      Color? messageColor,
      String? subDescription,
      Color? subDescriptionColor,
      AlertType alertType = AlertType.SUCCESS,
      String? positiveButtonText,
      String? negativeButtonText,
      String? bottomButtonText,
      VoidCallback? onPositiveCallback,
      VoidCallback? onNegativeCallback,
      VoidCallback? onBottomButtonCallback,
      Widget? dialogContentWidget,
      bool shouldDismiss = false,
      bool? shouldEnableClose,
      bool isSessionTimeout = false,
      bool isAlertTypeEnable = true}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: shouldDismiss,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AppDialog(
                title: title,
                description: message,
                descriptionColor: messageColor,
                subDescription: subDescription,
                subDescriptionColor: subDescriptionColor,
                alertType: alertType,
                positiveButtonText: positiveButtonText,
                negativeButtonText: negativeButtonText,
                onNegativeCallback: onNegativeCallback,
                onPositiveCallback: onPositiveCallback,
                dialogContentWidget: dialogContentWidget,
                isSessionTimeout: isSessionTimeout,
                bottomButtonText: bottomButtonText,
                onBottomButtonCallback: onBottomButtonCallback,
                isAlertTypeEnable: isAlertTypeEnable,
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return const SizedBox.shrink();
        });
  }

  Future<void> _showBottomSheet(BuildContext context) async {
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
                isAttachmentSheet: true,
                title:
                    AppLocalizations.of(context).translate("add_attachments"),
                buttons: null,
                children: [
                  InkWell(
                      onTap: () async {
                        final file = await pickImageCamera();
                        if (file?.path != null) {
                          if (getFileSizeInMB(file?.path ?? "") <=
                              AppConstants.UPLOAD_FILE_SIZE_IN_MB_IN_MAILBOX) {
                            if (mounted) {
                              widget.pickedFiles.add(AttachmentData(
                                base64File: base64Encode(
                                    File(file!.path).readAsBytesSync()),
                                extension: getFileExtension(file.path),
                                fileName: getFileName(file.path),
                                filePath: file.path,
                                file: File(file.path),
                              ));
                              Navigator.of(context).pop(true);
                              changeState(() {});
                              setState(() {});
                            }
                          } else {
                            showAppDialog(
                                alertType: AlertType.FAIL,
                                isSessionTimeout: true,
                                title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                                message: AppLocalizations.of(context).translate("maximum_size_shall_be"),
                                onPositiveCallback: () {
                                  // logout();
                                });
                          }
                        }
                      },
                      child: Row(
                        children: [
                           PhosphorIcon(
                            PhosphorIcons.camera(PhosphorIconsStyle.bold),
                            color: colors(context).blackColor,size: 24.w,
                          ),
                          8.horizontalSpace,
                          Text(
                            AppLocalizations.of(context).translate("take_photo"),
                            style: size16weight700.copyWith(color: colors(context).greyColor),
                          )
                        ],
                      )),
                  24.verticalSpace,
                  InkWell(
                      onTap: () async {
                        final file = await pickFiles();
                        if (file?.path != null) {
                          if (getFileSizeInMB(file?.path ?? "") <=
                              AppConstants.UPLOAD_FILE_SIZE_IN_MB_IN_MAILBOX) {
                            if (mounted) {
                              widget.pickedFiles.add(AttachmentData(
                                base64File: base64Encode(
                                  File(file!.path).readAsBytesSync(),
                                ),
                                extension: getFileExtension(file.path),
                                fileName: getFileName(file.path),
                                filePath: file.path,
                                file: File(file.path),
                              ));
                              Navigator.of(context).pop(true);
                              changeState(() {});
                              setState(() {});
                            }
                          } else {
                            showAppDialog(
                                alertType: AlertType.FAIL,
                                isSessionTimeout: true,
                                title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                                message: AppLocalizations.of(context).translate("maximum_size_shall_be"),
                                onPositiveCallback: () {
                                  // logout();
                                });
                          }
                        }
                      },
                      child: Row(
                        children: [
                          PhosphorIcon(
                            PhosphorIcons.folder(PhosphorIconsStyle.bold),
                            color: colors(context).blackColor,size: 24.w,
                          ),
                         8.horizontalSpace,
                          Text(
                            AppLocalizations.of(context).translate("choose_files"),
                             style: size16weight700.copyWith(color: colors(context).greyColor),
                          )
                        ],
                      )),
                ],
              );
            }));
    setState(() {});
  }
}
