// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/document_data.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/save_and_exits_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/bottom_sheet.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../bloc/on_boarding/document_verification/document_verification_bloc.dart';
import '../../../bloc/on_boarding/document_verification/document_verification_event.dart';
import '../../../bloc/on_boarding/document_verification/document_verification_state.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/image_cropper.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../base_view.dart';
import '../../otp/otp_view.dart';
import '../ub_account_onboarding/ub_terms_and_conditions_view.dart';

class DocumentVerificationOtherBankView extends BaseView {
  final SaveAndExist saveAndExist;
  DocumentVerificationOtherBankView({
    required this.saveAndExist,
  });

  @override
  DocumentVerificationOtherBankViewState createState() =>
      DocumentVerificationOtherBankViewState();
}

class DocumentVerificationOtherBankViewState
    extends BaseViewState<DocumentVerificationOtherBankView> {
  final _documentVerificationBloc = injection<DocumentVerificationBloc>();
  final localDataSource = injection<LocalDataSource>();
  File? imageSelfie;
  File? imageIdBack;
  File? imageIdFront;

  String? image1;
  String? image2;
  String? image3;

  @override
  void initState() {
    if (localDataSource.getSaveAndExist().image1 != null)
      image1 = localDataSource.getSaveAndExist().image1!;
    if (localDataSource.getSaveAndExist().image2 != null)
      image2 = localDataSource.getSaveAndExist().image2!;
    if (localDataSource.getSaveAndExist().image3 != null)
      image3 = localDataSource.getSaveAndExist().image3!;
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("document_verify"),
      ),
      body: BlocProvider<DocumentVerificationBloc>(
        create: (_) => _documentVerificationBloc,
        child: BlocListener<DocumentVerificationBloc,
            BaseState<DocumentVerificationState>>(
          listener: (context, state) {
            if (state is DocumentVerificationInformationFailedState) {
            }
            else if (state is DocumentVerificationAPIFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            }
            else if (state is DocumentVerificationAPISuccessState) {
              Navigator.pushNamed(context, Routes.kTnCOtherBankView,
                  arguments: TermsArgs(
                    termsType: kTermType,
                  )).then((value) {
                if (value is bool && value) {
                  Navigator.pushNamed(context, Routes.kOtpView,
                      arguments: OTPViewArgs(
                        isSingleOTP: false,
                        otpResponseArgs: OtpResponseArgs(isOtpSend: false),
                        otpType: kOtpMessageTypeOnBoarding,
                        routeName:
                            Routes.kJustPayUserScheduleForVerificationView,
                        requestOTP: true,
                        appBarTitle: "otp_verification",
                        title: AppLocalizations.of(context)
                            .translate("mobile_number_and_email_verification"),
                      ));
                }
              });
            }
          },
          child: Padding(
            padding:  EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              AppLocalizations.of(context)
                                  .translate("Enter_Other_Payment"),
                              style: size16weight400.copyWith(
                                color: colors(context).greyColor,
                              ),
                              textAlign: TextAlign.left),
                          24.verticalSpace,
                          Text(
                              AppLocalizations.of(context)
                                  .translate("Add_an_Image"),
                              style: size14weight700.copyWith(
                                color: colors(context).blackColor,
                              ),
                              textAlign: TextAlign.left),
                          12.verticalSpace,
                          Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (imageSelfie != null || image1 != null) {
                                    Navigator.pushNamed(
                                            context, Routes.kDocumentView,
                                            arguments: DocumentData(
                                                title:
                                                    AppLocalizations.of(context)
                                                        .translate("selfie_view"),
                                                fileImage: imageSelfie,
                                                memoryImage: image1))
                                        .then((value) {
                                      if (value != null && value is File) {
                                        setState(() {
                                          imageSelfie = value;
                                        });
                                      }
                                    });
                                  } else {
                                    _showBottomSheet(
                                        context, DocumentImageType.SELFIE);
                                  }
                                },
                                child: DottedBorder(
                                  color: imageSelfie == null && image1 == null
                                      ? colors(context).primaryColor!
                                      : Colors.transparent,
                                  dashPattern: const [4, 4],
                                  strokeCap: StrokeCap.round,
                                  radius: const Radius.circular(8).r,
                                  borderType: BorderType.RRect,
                                  padding: const EdgeInsets.all(1),
                                  child: Container(
                                    width: double.infinity,
                                    height: 164,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: colors(context).primaryColor50,
                                      border: Border.all(
                                          width: 1,
                                          color: colors(context).primaryColor!,
                                          style: imageSelfie == null &&
                                                  image1 == null
                                              ? BorderStyle.none
                                              : BorderStyle.solid),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        imageSelfie != null
                                            ? Padding(
                                                padding: EdgeInsets.symmetric( vertical: 16.h , horizontal: 116.w),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8).r,
                                                  child: InkWell(
                                                    child: Container(
                                                      // width: 30.w,
                                                      height: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(8).r,
                                                        //DarkColorsList.darkSplashSubColor,
                                                      ),
                                                      child: Image.file(
                                                          imageSelfie!,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : image1 != null
                                                ? Padding(
                                                    padding: const EdgeInsets.all(8).w,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(8).r,
                                                      child: InkWell(
                                                        child: Container(
                                                          // width: 30.w,
                                                          // height: double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8).r,
                                                            //DarkColorsList.darkSplashSubColor,
                                                          ),
                                                          child: Image.memory(
                                                              base64Decode(image1!),
                                                              fit: BoxFit.cover),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                  padding: EdgeInsets.only(top: 16.h , bottom: 16.h),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context).translate("selfie_image"),
                                                        style: size14weight700.copyWith(
                                                          color: colors(context).blackColor,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      PhosphorIcon(
                                                        PhosphorIcons.uploadSimple(PhosphorIconsStyle.bold),
                                                        color: colors(context).greyColor,
                                                        size: 32.w,
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        AppLocalizations.of(context).translate("capture_or_upload"),
                                                        style: size12weight700.copyWith(
                                                          color: colors(context).blackColor,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        "${AppLocalizations.of(context).translate("max_image_size").split("2MB").first}2MB\n${AppLocalizations.of(context).translate("max_image_size").split("2MB").last}",
                                                        textAlign: TextAlign.center,
                                                        style: size12weight400.copyWith(
                                                          color: colors(context).greyColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: imageSelfie != null || image1 != null,
                                child: Positioned(
                                  top: 5.w,
                                  right: 5.w,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        imageSelfie = null;
                                        image1 = null;
                                      });
                                    },
                                    child: PhosphorIcon(
                                      PhosphorIcons.xCircle(
                                          PhosphorIconsStyle.bold),
                                      color: colors(context).greyColor300,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          24.verticalSpace,
                          Text(
                            AppLocalizations.of(context)
                                .translate("prefered_identification_method"),
                            style: size14weight700.copyWith(
                              color: colors(context).blackColor,
                            ),
                          ),
                          12.verticalSpace,
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (imageIdFront != null) {
                                              Navigator.pushNamed(context,
                                                      Routes.kDocumentView,
                                                      arguments: DocumentData(
                                                          title: AppLocalizations
                                                                  .of(context)
                                                              .translate(
                                                                  "front_image_id"),
                                                          fileImage: imageIdFront,
                                                          memoryImage: image2))
                                                  .then((value) {
                                                if (value != null &&
                                                    value is File) {
                                                  setState(() {
                                                    imageIdFront = value;
                                                  });
                                                }
                                              });
                                            } else {
                                              _showBottomSheet(context,
                                                  DocumentImageType.NICFRONT);
                                            }
                                          },
                                          child: DottedBorder(
                                            color: imageIdFront == null && image2 == null
                                                ? colors(context).primaryColor!
                                                : Colors.transparent,
                                            dashPattern: const [4, 4],
                                            strokeCap: StrokeCap.round,
                                            radius: const Radius.circular(8).r,
                                            borderType: BorderType.RRect,
                                            padding: const EdgeInsets.all(1),
                                            child: Container(
                                              width: double.infinity,
                                              height: 164,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8).r,
                                                color: colors(context).primaryColor50,
                                                border: Border.all(
                                                    width: 1,
                                                    color: colors(context).primaryColor!,
                                                    style: imageIdFront == null && image2 == null
                                                        ? BorderStyle.none
                                                        : BorderStyle.solid),
                                              ),
                                              child: Stack(
                                                children: [
                                                  imageIdFront != null
                                                      ? Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 16).w,
                                                          child: Center(
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(8).r,
                                                              child: Container(
                                                                // // width: 30.w,
                                                                // height: double
                                                                //     .infinity,
                                                                decoration: BoxDecoration(borderRadius:
                                                                  BorderRadius.circular(8).r,
                                                                  color: colors(context).blackColor300,
                                                                ),
                                                                child: Image.file(imageIdFront!,),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : image2 != null
                                                          ? Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 16).w,
                                                              child: Center(
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(8).r,
                                                                  child: Container(
                                                                     // width: 88.w,
                                                                    // height: double
                                                                    //     .infinity,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(8).r,
                                                                      color: colors(context).blackColor300,
                                                                    ),
                                                                    child: Image.memory(
                                                                      base64Decode(image2!),),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Padding(
                                                            padding: EdgeInsets.only(top: 16.h , bottom: 16.h),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  AppLocalizations.of(context).translate("front_of_id"),
                                                                  style: size14weight700.copyWith(
                                                                    color: colors(context).blackColor,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                PhosphorIcon(
                                                                  PhosphorIcons
                                                                      .uploadSimple(
                                                                          PhosphorIconsStyle
                                                                              .bold),
                                                                  size: 25.w,
                                                                  color: colors(
                                                                          context)
                                                                      .greyColor,
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          "capture_or_upload"),
                                                                  style: size12weight700
                                                                      .copyWith(
                                                                    color: colors(
                                                                            context)
                                                                        .blackColor,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)
                                                                      .translate(
                                                                          "max_image_size"),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: size12weight400
                                                                      .copyWith(
                                                                    color: colors(
                                                                            context)
                                                                        .greyColor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: imageIdFront != null ||
                                              image2 != null,
                                          child: Positioned(
                                            top: 5.w,
                                            right: 5.w,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  imageIdFront = null;
                                                  image2 = null;
                                                });
                                              },
                                              child: PhosphorIcon(
                                                PhosphorIcons.xCircle(
                                                    PhosphorIconsStyle.bold),
                                                color:
                                                    colors(context).greyColor300,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  25.horizontalSpace,
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (imageIdBack != null) {
                                              Navigator.pushNamed(context,
                                                      Routes.kDocumentView,
                                                      arguments: DocumentData(
                                                          title: AppLocalizations.of(context).translate('back_image_id'),
                                                          fileImage: imageIdBack,
                                                          memoryImage: image3))
                                                  .then((value) {
                                                if (value != null && value is File) {
                                                  setState(() {
                                                    imageIdBack = value;
                                                  });
                                                }
                                              });
                                            } else {
                                              _showBottomSheet(context, DocumentImageType.NICBACK);
                                            }
                                          },
                                          child: DottedBorder(
                                            color: imageIdBack == null &&
                                                    image3 == null
                                                ? colors(context).primaryColor!
                                                : Colors.transparent,
                                            dashPattern: const [4, 4],
                                            strokeCap: StrokeCap.round,
                                            radius: const Radius.circular(8).r,
                                            borderType: BorderType.RRect,
                                            padding: const EdgeInsets.all(1),
                                            child: Container(
                                              height: 164,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8).r,
                                                color: colors(context)
                                                    .primaryColor50,
                                                border: Border.all(
                                                    width: 1,
                                                    color: colors(context).primaryColor!,
                                                    style: imageIdBack == null && image3 == null
                                                        ? BorderStyle.none
                                                        : BorderStyle.solid),
                                              ),
                                              child: Stack(
                                                children: [
                                                  imageIdBack != null
                                                      ? Padding(
                                                          padding: EdgeInsets.symmetric(
                                                                      horizontal: 16,
                                                                      vertical: 37).w,
                                                          child: Center(
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(8).r,
                                                              child: Container(
                                                                // width: 30.w,
                                                                height: double.infinity,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(8).r,
                                                                  color: colors(context).primaryColor50,
                                                                ),
                                                                child: Image.file(
                                                                    imageIdBack!,
                                                                    fit: BoxFit.cover),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : image3 != null
                                                          ? Padding(
                                                              padding: const EdgeInsets.symmetric(
                                                                      horizontal: 16,
                                                                      vertical: 37).w,
                                                              child: Center(
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(8).r,
                                                                  child:
                                                                      Container(
                                                                    // width: 30.w,
                                                                    height: double.infinity,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(8).r,
                                                                      color: colors(context).primaryColor400,
                                                                    ),
                                                                    child: Image.memory(
                                                                        base64Decode(image3!),
                                                                        fit: BoxFit.cover),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Padding(
                                                              padding: EdgeInsets.only(top: 16.h , bottom: 16.h),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        .translate(
                                                                            "back_of_id"),
                                                                    style: size14weight700
                                                                        .copyWith(
                                                                      color: colors(
                                                                              context)
                                                                          .blackColor,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  PhosphorIcon(
                                                                    PhosphorIcons
                                                                        .uploadSimple(
                                                                            PhosphorIconsStyle
                                                                                .bold),
                                                                    size: 25.w,
                                                                    color: colors(
                                                                            context)
                                                                        .greyColor,
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        .translate(
                                                                            "capture_or_upload"),
                                                                    style: size12weight700
                                                                        .copyWith(
                                                                      color: colors(
                                                                              context)
                                                                          .blackColor,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        .translate(
                                                                            "max_image_size"),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: size12weight400
                                                                        .copyWith(
                                                                      color: colors(
                                                                              context)
                                                                          .greyColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: imageIdBack != null ||
                                              image3 != null,
                                          child: Positioned(
                                            top: 5.w,
                                            right: 5.w,
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  imageIdBack = null;
                                                  image3 = null;
                                                });
                                              },
                                              child: PhosphorIcon(
                                                PhosphorIcons.xCircle(
                                                    PhosphorIconsStyle.bold),
                                                color:
                                                    colors(context).greyColor300,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    AppButton(
                      buttonText:
                          AppLocalizations.of(context).translate("next"),
                      buttonType: _isValidated()
                          ? ButtonType.PRIMARYENABLED
                          : ButtonType.PRIMARYDISABLED,
                      onTapButton: () async {
                        showProgressBar();
                        final value = await localDataSource.setSaveAndExist(
                            SaveAndExist(
                                mobilenumber: widget.saveAndExist.mobilenumber,
                                email: widget.saveAndExist.email,
                                nic: widget.saveAndExist.nic,
                                image1: image1 ??
                                    base64Encode(File(imageSelfie!.path)
                                        .readAsBytesSync()),
                                image2: image2 ??
                                    base64Encode(File(imageIdFront!.path)
                                        .readAsBytesSync()),
                                image3: image3 ??
                                    base64Encode(File(imageIdBack!.path)
                                        .readAsBytesSync())));
                        hideProgressBar();
                        if (value) {
                          _documentVerificationBloc.add(
                            SendDocumentVerificationInformationEvent(
                              selfie: image1 != null
                                  ? AppUtils.convertBase64(image1!)
                                  : AppUtils.convertBase64(base64Encode(
                                      File(imageSelfie!.path)
                                          .readAsBytesSync())),
                              icFront: image2 != null
                                  ? AppUtils.convertBase64(image2!)
                                  : AppUtils.convertBase64(base64Encode(
                                      File(imageIdFront!.path)
                                          .readAsBytesSync())),
                              icBack: image3 != null
                                  ? AppUtils.convertBase64(image3!)
                                  : AppUtils.convertBase64(base64Encode(
                                      File(imageIdBack!.path)
                                          .readAsBytesSync())),
                            ),
                          );
                        }
                      },
                    ),
                    16.verticalSpace,
                    AppButton(
                      buttonType: _isValidated()
                          ? ButtonType.OUTLINEENABLED
                          : ButtonType.OUTLINEDISABLED,
                      buttonColor: Colors.transparent,
                      buttonText:
                          AppLocalizations.of(context).translate("save_exit"),
                      onTapButton: () async {
                        showProgressBar();
                        final value = await localDataSource.setSaveAndExist(
                            SaveAndExist(
                                mobilenumber: widget.saveAndExist.mobilenumber,
                                email: widget.saveAndExist.email,
                                nic: widget.saveAndExist.nic,
                                image1: image1 ??
                                    base64Encode(File(imageSelfie!.path)
                                        .readAsBytesSync()),
                                image2: image2 ??
                                    base64Encode(File(imageIdFront!.path)
                                        .readAsBytesSync()),
                                image3: image3 ??
                                    base64Encode(File(imageIdBack!.path)
                                        .readAsBytesSync())));
                        hideProgressBar();
                        if (value) {
                          await Navigator.pushNamedAndRemoveUntil(
                              context, Routes.kLoginView, (route) => false);
                        }
                      },
                    ),
                    // AppSizer.verticalSpacing(AppSizer.getHomeIndicatorStatus(context))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showBottomSheet(
      BuildContext context, DocumentImageType documentImageType) async {
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
                    AppLocalizations.of(context).translate("choose_your_image"),
                buttons: [],
                children: [
                  InkWell(
                      onTap: () async {
                        pickImageCamera(documentImageType);
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
                            AppLocalizations.of(context)
                                .translate("take_photo"),
                            style: size16weight700.copyWith(
                                color: colors(context).greyColor),
                          )
                        ],
                      )),
                  24.verticalSpace,
                  InkWell(
                      onTap: () async {
                        pickImage(documentImageType);
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
                            AppLocalizations.of(context)
                                .translate("choose_files"),
                            style: size16weight700.copyWith(
                                color: colors(context).greyColor),
                          )
                        ],
                      )),
                ],
              );
            }));
    setState(() {});
  }

  Future pickImage(DocumentImageType documentImageType) async {
    try {
      final file = await ImagePicker().pickImage(
        imageQuality: 80,
          maxHeight: 800,
          maxWidth: 800,
        source: ImageSource.gallery);
      if (file != null) {
        final CroppedFile? cropped = await AppImageCropper()
            .getCroppedImage(PickedFile(file.path), context);
        if (cropped != null) {
          final output = File(cropped.path);
          if (output?.path != null) {
            if (getFileSizeInMB(output?.path ?? "") <=
                AppConstants.UPLOAD_FILE_SIZE_IN_MB_IN_ONBOARDING) {
              if (mounted) {
                switch (documentImageType) {
                  case DocumentImageType.NICFRONT:
                    setState(() {
                      imageIdFront = output;
                    });
                    return;
                  case DocumentImageType.NICBACK:
                    setState(() {
                      imageIdBack = output;
                    });
                    return;
                  case DocumentImageType.SELFIE:
                    setState(() {
                      imageSelfie = output;
                    });
                    return;
                  case DocumentImageType.LICENCEFRONT:
                    return;
                  case DocumentImageType.LICENCEBACK:
                    return;
                  case DocumentImageType.PASSPORTFRONT:
                    return;
                  case DocumentImageType.PASSPORTBACK:
                    return;
                  case DocumentImageType.BILLINGPROOF:
                    // setState(() {
                    //   imageBilling = output;
                    // });
                    return;
                }
              }
            } else {
              showAppDialog(
                  alertType: AlertType.FAIL,
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context)
                      .translate(ErrorHandler.TITLE_ERROR),
                  message: AppLocalizations.of(context)
                      .translate("maximum_size_shall_be_2"),
                  onPositiveCallback: () {
                    // logout();
                  });
            }
          }
        }
      }
    } on PlatformException {}
  }

  Future pickImageCamera(DocumentImageType documentImageType) async {
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
          if (output?.path != null) {
            if (getFileSizeInMB(output?.path ?? "") <=
                AppConstants.UPLOAD_FILE_SIZE_IN_MB_IN_ONBOARDING) {
              if (mounted) {
                switch (documentImageType) {
                  case DocumentImageType.NICFRONT:
                    setState(() {
                      imageIdFront = output;
                    });
                    return;
                  case DocumentImageType.NICBACK:
                    setState(() {
                      imageIdBack = output;
                    });
                    return;
                  case DocumentImageType.SELFIE:
                    setState(() {
                      imageSelfie = output;
                    });
                    return;
                  case DocumentImageType.LICENCEFRONT:
                  case DocumentImageType.LICENCEBACK:
                    return;
                  case DocumentImageType.PASSPORTFRONT:
                    return;
                  case DocumentImageType.PASSPORTBACK:
                    return;
                  // case DocumentImageType.BILLINGPROOF:
                  //   setState(() {
                  //     imageBilling = output;
                  //   });
                  //   return;
                  case DocumentImageType.BILLINGPROOF:
                }
              }
            } else {
              showAppDialog(
                  alertType: AlertType.FAIL,
                  isSessionTimeout: true,
                  title: AppLocalizations.of(context)
                      .translate(ErrorHandler.TITLE_ERROR),
                  message: AppLocalizations.of(context)
                      .translate("maximum_size_shall_be_2"),
                  onPositiveCallback: () {
                    // logout();
                  });
            }
          }
        }
      }
    } on PlatformException {}
  }

  /// Validate
  bool _isValidated() {
    bool iDValidated = false;
    // bool billValidated = true;

    if (imageSelfie != null || image1 != null) {
      if ((imageIdFront != null || image2 != null) &&
          (imageIdBack != null || image3 != null)) {
        iDValidated = true;
      } else {
        iDValidated = false;
      }
    } else {
      return false;
    }

    return iDValidated;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _documentVerificationBloc;
  }
}
