import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/common_status_icon.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';


import '../../../utils/enums.dart';
import 'app_button.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String? description;
  final Color? descriptionColor;
  final String? subDescription;
  final Color? subDescriptionColor;
  final AlertType? alertType;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final VoidCallback? onPositiveCallback;
  final VoidCallback? onNegativeCallback;
  final Widget? dialogContentWidget;
  final VoidCallback? onBottomButtonCallback;
  final String? bottomButtonText;

  final bool? isSessionTimeout;

  final bool? isAlertTypeEnable;

  AppDialog(
      {required this.title,
      this.description,
      this.descriptionColor,
      this.subDescription,
      this.subDescriptionColor,
      this.alertType,
      this.onPositiveCallback,
      this.onNegativeCallback,
      this.positiveButtonText,
      this.negativeButtonText,
      this.dialogContentWidget,
      this.isSessionTimeout,
      this.bottomButtonText,
      this.onBottomButtonCallback, 
      this.isAlertTypeEnable});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
            alignment: FractionalOffset.center,
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Wrap(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: colors(context).whiteColor,
                    ),
                    child: Padding(
                      padding:  EdgeInsets.fromLTRB(0,32,0,0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        if(isAlertTypeEnable??true) getIcon(alertType!, context,),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style:size18weight700.copyWith(color: colors(context).blackColor),
                          ),
                          dialogContentWidget != null
                              ? Padding(
                                  padding:  EdgeInsets.only(
                                     top: 4,left:  12.5,right: 12.5),
                                  child: dialogContentWidget,
                                )
                              : const SizedBox(),
                          description != null
                              ? Padding(
                                  padding:  EdgeInsets.only(top: 4,left:  12.5,right: 12.5),
                                  child: Text(
                                    description ?? "",
                                    textAlign: TextAlign.center,
                                    style:size14weight400.copyWith(color: colors(context).greyColor),
                                  ),
                                )
                              : const SizedBox(),
                          subDescription != null
                              ? Padding(
                                  padding:  EdgeInsets.only(top: 4,left:  12.5,right: 12.5),
                                  child: Text(
                                    subDescription ?? "",
                                    textAlign: TextAlign.center,
                                    style:size14weight700.copyWith(color: colors(context).primaryColor)
                                  ),
                                )
                              : const SizedBox(),
                          Padding(
                            padding:  EdgeInsets.only(top: 20,left: 16,right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                negativeButtonText != null
                                    ? Expanded(
                                        child: AppButton(
                                          buttonType: ButtonType.OUTLINEENABLED,
                                          buttonColor: Colors.transparent,
                                          buttonText: negativeButtonText!,
                                          onTapButton: () {
                                            Navigator.pop(context);
                                            if (onNegativeCallback != null) {
                                              onNegativeCallback!();
                                            }
                                          },
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                negativeButtonText != null
                                    ? 16.horizontalSpace
                                    : const SizedBox.shrink(),
                                negativeButtonText != null
                                    ? Expanded(
                                        child: AppButton(
                                          buttonText:
                                              positiveButtonText ?? AppLocalizations.of(context).translate("ok"),
                                          onTapButton: () {
                                            Navigator.pop(context);
                                            if (onPositiveCallback != null) {
                                              onPositiveCallback!();
                                            }
                                          },
                                        ),
                                      )
                                    : Expanded(
                                        child: AppButton(
                                          buttonText:
                                              positiveButtonText ?? AppLocalizations.of(context).translate("ok"),
                                          onTapButton: () {
                                            Navigator.pop(context);
                                            if (onPositiveCallback != null) {
                                              onPositiveCallback!();
                                            }
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 16 , vertical: 12),
                            child: bottomButtonText != null
                                ?  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      if (onBottomButtonCallback != null) {
                                        onBottomButtonCallback!();
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 24, bottom: 16),
                                      child: Text(
                                        bottomButtonText ?? "",
                                        textAlign: TextAlign.center,
                                        style: size16weight700.copyWith(color:colors(context).primaryColor )),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }


Widget getIcon(AlertType alertType, BuildContext context) {
  switch (alertType) {
    case AlertType.SUCCESS:
      return dialogIcon(
           icon: PhosphorIcons.check(PhosphorIconsStyle.bold),
            backGroundColor: colors(context).positiveColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!);
    case AlertType.FAIL:
      return dialogIcon(
         backGroundColor: colors(context).negativeColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.warning(PhosphorIconsStyle.bold));
    case AlertType.WARNING:
      return dialogIcon(
          backGroundColor: colors(context).negativeColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.warning(PhosphorIconsStyle.bold));
    case AlertType.INFO:
      return dialogIcon(
            icon: PhosphorIcons.question(PhosphorIconsStyle.bold),
            backGroundColor: colors(context).greyColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!);
    case AlertType.DOCUMENT1:
        return dialogIcon(
            backGroundColor: colors(context).greyColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.files(PhosphorIconsStyle.bold));
    case AlertType.DOCUMENT2:
      return dialogIcon(
          backGroundColor: colors(context).greyColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.fileText(PhosphorIconsStyle.bold));
    case AlertType.DOCUMENT3:
      return dialogIcon(
          backGroundColor: colors(context).warningColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).blackColor!,
            icon: PhosphorIcons.article(PhosphorIconsStyle.bold));
    case AlertType.CONNECTION:
      return dialogIcon(
           backGroundColor: colors(context).negativeColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.plugs(PhosphorIconsStyle.bold));
    case AlertType.PASSWORD:
      return dialogIcon(
          backGroundColor: colors(context).negativeColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.password(PhosphorIconsStyle.bold));
    case AlertType.FINGERPRINT:
      return dialogIcon(
        svgIcon: AppAssets.dialogFingerprint,
          backGroundColor: colors(context).negativeColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,);
    case AlertType.FACEID:
      return dialogIcon(
         svgIcon: AppAssets.dialogFaceId,
          backGroundColor: colors(context).negativeColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,);
    case AlertType.USER1:
        return dialogIcon(
            backGroundColor: colors(context).negativeColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.userCircle(PhosphorIconsStyle.bold));
    case AlertType.USER2:
      return dialogIcon(
              backGroundColor: colors(context).greyColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.user(PhosphorIconsStyle.bold));
    case AlertType.USER3:
      return dialogIcon(
          backGroundColor: colors(context).greyColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.userPlus(PhosphorIconsStyle.bold));
    case AlertType.MAIL:
      return dialogIcon(
          backGroundColor: colors(context).greyColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.envelopeSimple(PhosphorIconsStyle.bold));
    case AlertType.MOBILE:
        return dialogIcon(
            backGroundColor: colors(context).negativeColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.deviceMobile(PhosphorIconsStyle.bold));
    case AlertType.DELETE:
        return dialogIcon(
            backGroundColor: colors(context).negativeColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.trash(PhosphorIconsStyle.bold));
    case AlertType.LANGUAGE:
      return dialogIcon(
           backGroundColor: colors(context).greyColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.globe(PhosphorIconsStyle.bold));
    case AlertType.MONEY1:
      return dialogIcon(
           backGroundColor: colors(context).greyColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.handCoins(PhosphorIconsStyle.bold));
    case AlertType.MONEY2:
      return dialogIcon(
           backGroundColor: colors(context).negativeColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.coins(PhosphorIconsStyle.bold));
    case AlertType.QR:
      return dialogIcon(
           backGroundColor: colors(context).greyColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.qrCode(PhosphorIconsStyle.bold));
    case AlertType.TRANSFER:
      return dialogIcon(
           backGroundColor: colors(context).greyColor!,
            context: context,
            alertType: alertType,
            iconColor: colors(context).whiteColor!,
            icon: PhosphorIcons.arrowsLeftRight(PhosphorIconsStyle.bold));
    case AlertType.SERVER:
      return dialogIcon(
          backGroundColor: colors(context).negativeColor!,
          context: context,
          alertType: alertType,
          iconColor: colors(context).whiteColor!,
          icon: PhosphorIcons.gitBranch(PhosphorIconsStyle.bold));

    case AlertType.SECURITY:
       return dialogIcon(
          backGroundColor: colors(context).greyColor!,
          context: context,
          alertType: alertType,
          iconColor: colors(context).whiteColor!,
          icon: PhosphorIcons.shieldCheckered(PhosphorIconsStyle.bold));
    case AlertType.STATEMENT:
       return dialogIcon(
          backGroundColor: colors(context).greyColor!,
          context: context,
          alertType: alertType,
          iconColor: colors(context).whiteColor!,
          icon: PhosphorIcons.notebook(PhosphorIconsStyle.bold));
       case AlertType.CHECKBOOK:
       return dialogIcon(
          backGroundColor: colors(context).greyColor!,
          context: context,
          alertType: alertType,
          iconColor: colors(context).whiteColor!,
          icon: PhosphorIcons.book(PhosphorIconsStyle.bold));
  }
}

Widget dialogIcon({
    PhosphorIconData? icon,
    String? svgIcon,
    required Color backGroundColor,
    required BuildContext context,
    required AlertType alertType,
    required Color iconColor,

  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: CommonStatusIcon(backGroundColor: backGroundColor,icon: icon,svgIcon:svgIcon,iconColor: iconColor,)
    );
  }
}
