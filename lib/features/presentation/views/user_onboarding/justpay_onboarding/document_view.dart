// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/document_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/bottom_sheet.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_localizations.dart';

import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';

import '../../../bloc/on_boarding/document_verification/document_verification_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/image_cropper.dart';
import '../../base_view.dart';

class DocumentView extends BaseView {
  final DocumentData documentData;
  DocumentView({
    required this.documentData,
  });

  @override
  DocumentViewState createState() =>
      DocumentViewState();
}

class DocumentViewState
    extends BaseViewState<DocumentView> {
  final _documentVerificationBloc = injection<DocumentVerificationBloc>();

   File? fileImage;


  @override
  void initState() {
   if(widget.documentData.fileImage != null) fileImage = widget.documentData.fileImage;
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: widget.documentData.title,
      ),
      body: Padding(
        padding:  EdgeInsets.fromLTRB(20.w,24.w,20.w,(20.h + AppSizer.getHomeIndicatorStatus(context))),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors(context).whiteColor,
                  borderRadius: BorderRadius.circular(2).w
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16).w,
                    child: fileImage != null
                        ? Image.file(fileImage!,
                            fit: BoxFit.contain)
                        : Image.memory(
                            base64Decode( widget.documentData.memoryImage!),
                            fit: BoxFit.contain)),
              ),
            ),
           20.verticalSpace,
            
            Column(
              children: [
               widget.documentData.fileImage == fileImage? AppButton(
                  buttonText:
                      AppLocalizations.of(context).translate("edit"),
                  buttonType: ButtonType.PRIMARYENABLED,
                  onTapButton: () async {
                    _showBottomSheet(context);
                  },
                ): AppButton(
                  buttonText:
                      AppLocalizations.of(context).translate("save"),
                  buttonType: ButtonType.PRIMARYENABLED,
                  onTapButton: () async {
                     Navigator.of(context).pop(fileImage);
                  },
                ),
                16.verticalSpace,
               widget.documentData.fileImage == fileImage? AppButton(
                  buttonType: ButtonType.OUTLINEENABLED,
                      buttonColor: Colors.transparent,
                  buttonText:
                      AppLocalizations.of(context).translate("close"),
                  onTapButton: () async {
                    Navigator.of(context).pop();
                    
                  },
                ):AppButton(
                  buttonType: ButtonType.OUTLINEENABLED,
                      buttonColor: Colors.transparent,
                  buttonText:
                      AppLocalizations.of(context).translate("cancel"),
                  onTapButton: () async {
                    Navigator.of(context).pop();
                    
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
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
                    AppLocalizations.of(context).translate("edit_your_image"),
                buttons: [],
                children: [
                  InkWell(
                      onTap: () async {
                        pickImageCamera();
                        Navigator.of(context).pop(true);
                        changeState(() {});
                      },
                      child: Row(
                        children: [
                           PhosphorIcon(
                            PhosphorIcons.camera(PhosphorIconsStyle.bold),
                            color: colors(context).blackColor,
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
                         pickImage();
                    Navigator.of(context).pop(true);
                    changeState(() {});
                      },
                      child: Row(
                        children: [
                          PhosphorIcon(
                            PhosphorIcons.folder(PhosphorIconsStyle.bold),
                            color: colors(context).blackColor,
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


  Future pickImage() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        final CroppedFile? cropped = await AppImageCropper()
            .getCroppedImage(PickedFile(file.path), context);
        if (cropped != null) {
          final output = File(cropped.path);
          fileImage = output;
           setState(() {});
        }
      }
    } on PlatformException {}
  }

  Future pickImageCamera() async {
    try {
      final file = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
          maxHeight: 800,
          maxWidth: 800);
      if (file != null) {
        final CroppedFile? cropped = await AppImageCropper()
            .getCroppedImage(PickedFile(file.path), context);
        if (cropped != null) {
          final output = File(cropped.path);
          fileImage = output;
          setState(() {});
        }
      }
    } on PlatformException {}
  }


  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _documentVerificationBloc;
  }
}
