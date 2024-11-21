import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/portfolio/portfolio_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/settings/settings_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/settings/settings_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/settings/settings_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';

import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../utils/app_assets.dart';
import '../../../../../../utils/app_localizations.dart';
import '../../../../../../utils/enums.dart';
import '../../../../widgets/app_button.dart';

import '../../../../widgets/appbar.dart';
import '../../../../widgets/bottom_sheet.dart';
import '../../../../widgets/image_cropper.dart';
import '../../../../widgets/pop_scope/ub_pop_scope.dart';

class FullViewOfProfileArgs {
  final Uint8List? image;
  final String nickname;

  FullViewOfProfileArgs({this.image, required this.nickname});
}

class FullViewOfProfile extends BaseView {
  final FullViewOfProfileArgs? fullViewOfProfileArgs;

  FullViewOfProfile({this.fullViewOfProfileArgs});

  @override
  _FullViewOfProfileState createState() => _FullViewOfProfileState();
}

class _FullViewOfProfileState extends BaseViewState<FullViewOfProfile> {
  final settingBloc = injection<SettingsBloc>();
  final portfolioBloc = injection<PortfolioBloc>();
  LocalDataSource localDataSource = injection<LocalDataSource>();
  File? image;
  bool isEdited = false;
  bool isPickImage = false;

  @override
  Widget buildView(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width - 48;
    return UBPopScope(
      onPopInvoked: () async{
        if (image != null) {
          Navigator.pop(context, image);
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
          appBar: UBAppBar(
            title: AppLocalizations.of(context).translate("profile_settings"),
            onBackPressed: () {
              goBack();
            },
          ),
          body: BlocProvider(
            create: (_) => settingBloc,
            child: BlocListener<SettingsBloc, BaseState<SettingsState>>(
              listener: (context, state) {
                if (state is ProfileImageUploadSuccessState) {
                   
                    showAppDialog(
                        title:AppLocalizations.of(context).translate(ErrorHandler.TITLE_SUCCESS),
                        message: AppLocalizations.of(context)
                            .translate("profile_image_upload_success"),
                        alertType: AlertType.SUCCESS,
                        onPositiveCallback: () {
                          Navigator.of(context).pop(image);
                          setState(() { });
                        },
                      );
                } else if (state is ProfileImageUploadFailedState) {
                   showAppDialog(
                        title: AppLocalizations.of(context)
                    .translate(ErrorHandler.TITLE_ERROR),
                        message: state.message,
                        alertType: AlertType.FAIL,
                        onPositiveCallback: () {
                        },
                      );
                }
              },
              child: Padding(
                padding:  EdgeInsets.fromLTRB(20,24,20,20+AppSizer.getHomeIndicatorStatus(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: !isPickImage
                            ? SizedBox(
                                width: width,
                                height: height,
                                child:
                                    widget.fullViewOfProfileArgs?.image ==
                                            null
                                        ? Container(
                                            color: const Color(0xFFCEE5D4),
                                            width: width,
                                            height: height,
                                            child: Center(
                                                child: Text(
                                              widget.fullViewOfProfileArgs!
                                                  .nickname
                                                  .getNameInitial()!,
                                              style: size24weight400.copyWith(
                                      color: colors(context).greyColor200,fontSize: 150
                                    ),
                                            )),
                                          )
                                        : Image.memory(
                                            width: width,
                                            height: height,
                                             widget.fullViewOfProfileArgs!
                                                .image!,
                                            fit: BoxFit.cover,
                                          ),
                              )
                            : Image.file(
                                image!,
                                width: width,
                                height: height,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        AppButton(
                          buttonText: isEdited
                              ? AppLocalizations.of(context)
                                  .translate("save_image")
                              : AppLocalizations.of(context)
                                  .translate("edit"),
                          onTapButton: () {
                            if (isEdited == true && isPickImage == true) {
                              settingBloc.add(UpdateProfileImageEvent(
                                  image: image?.path,extention: getFileExtension(image!.path)));
                              return;
                            }
                            isEdited = !isEdited;
                            setState(() {});
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AppButton(
                                          buttonType: ButtonType.OUTLINEENABLED,
                            buttonText: isEdited
                                ? AppLocalizations.of(context)
                                    .translate("change_image")
                                : AppLocalizations.of(context)
                                    .translate("close"),
                           
                            onTapButton: () {
                              if (isEdited) {
                                // _showBottomSheet();
                                 {
                                  final result =  showModalBottomSheet<bool>(
                                      isScrollControlled: true,
                                      useRootNavigator: true,
                                      useSafeArea: true,
                                      context: context,
                                      barrierColor: colors(context).blackColor?.withOpacity(.85),
                                      backgroundColor: Colors.transparent,
                                      builder: (context,) => StatefulBuilder(
                                          builder: (context,changeState) {
                                            return BottomSheetBuilder(
                                              isAttachmentSheet: true,
                                              title: AppLocalizations.of(context).translate('change_your_image'),
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    image = await pickImageCamera();
                                                    checkImage(image);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      PhosphorIcon(
                                                        PhosphorIcons.camera(PhosphorIconsStyle.bold),
                                                        color: colors(context).blackColor,
                                                        size: 24,
                                                      ),
                                                      8.horizontalSpace,
                                                      Text(
                                                        AppLocalizations.of(context).translate("take_photo"),
                                                        style: size16weight700.copyWith(color: colors(context).greyColor),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                24.verticalSpace,
                                                InkWell(
                                                  onTap: () async {
                                                    image = await pickImageGallery();
                                                    checkImage(image);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          AppAssets.gallery
                                                      ),
                                                      // PhosphorIcon(
                                                      //   PhosphorIcons.folder(PhosphorIconsStyle.bold),
                                                      //   color: colors(context).blackColor,
                                                      // ),
                                                      8.horizontalSpace,
                                                      Text(
                                                        "Choose from library",
                                                        // AppLocalizations.of(context).translate("choose_files"),
                                                        style: size16weight700.copyWith(color: colors(context).greyColor),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            );
                                          }
                                      ));
                                  setState(() {});
                                  };
                              } else {
                                goBack();
                              }
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void goBack() {
    if (image != null) {
      Navigator.pop(context, image);
    } else {
      Navigator.pop(context);
    }
  }


  void checkImage(File? pickImage) {
    if (getFileSizeInMB(pickImage?.path ?? "") <= 2) {
      if (mounted) {
        isPickImage = true;
        setState(() {});
        Navigator.of(context).pop();
      }
    } else {
      showAppDialog(
          alertType: AlertType.FAIL,
          isSessionTimeout: true,
          title: "Image Size Exceeded",
          message: "Profile image size exceeds 2MB",
          onPositiveCallback: () {
            // logout();
          });
    }
  }

  Future<File?> pickImageCamera() async {
    try {
      final result = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
          maxHeight: 800,
          maxWidth: 800);
      if (result != null) {
        final CroppedFile? cropped =
            await AppImageCropper().getCroppedImage(PickedFile(result.path),context);
        if (cropped != null) {
          final photo = File(cropped.path);
          return photo;
        }
        return null;
      }
    } on PlatformException {
    }
    return null;
  }

  Future<File?> pickImageGallery() async {
    try {
      final result = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
          maxHeight: 800,
          maxWidth: 800);
      if (result != null) {
        final CroppedFile? cropped =
            await AppImageCropper().getCroppedImage(PickedFile(result.path),context);
        if (cropped != null) {
          final photo = File(cropped.path);
          return photo;
        }
        return null;
      }
    } on PlatformException {
    }
    return null;
  }

  double getFileSizeInMB(String filepath) {
    var file = File(filepath);
    int bytes = file.lengthSync();
    if (bytes <= 0) return 0.0;
    double sizeInMb = bytes / (1024 * 1024);
    return double.parse(sizeInMb.toStringAsFixed(2));
  }

   String getFileExtension(String filepath) {
    return filepath.split('.').last;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return settingBloc;
  }
}
