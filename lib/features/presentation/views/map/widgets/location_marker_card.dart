import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/configurations/app_config.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../../domain/entities/response/locator_entity.dart';

class LocationMarkerCard extends StatelessWidget {
  final LocatorEntity? branchResponseEntity;
  final Function? closeFunction;

  LocationMarkerCard({this.branchResponseEntity, this.closeFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 24.h + AppSizer.getHomeIndicatorStatus(context),right: 20.w,left: 20.w),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8).w,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 26,vertical: 20).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${branchResponseEntity?.merchantName} , ${branchResponseEntity?.city!=null?branchResponseEntity?.city:branchResponseEntity?.city}" ?? "",
                        style: size18weight700.copyWith(color: colors(context).blackColor),
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,
                if (branchResponseEntity?.services != null)
                  Row(
                    children: List.generate(
                        branchResponseEntity!.services!.length,
                        (index) => Row(
                              children: [
                                Text(branchResponseEntity!.services![index],style: size14weight400.copyWith(color: colors(context).greyColor,)),
                                if (index !=
                                    branchResponseEntity!.services!.length - 1)
                                   Text(" & ",style: size14weight400.copyWith(color: colors(context).greyColor),),
                              ],
                            )),
                  ),
                
                Text(
                  branchResponseEntity?.address ?? "",
                  style: size14weight400.copyWith(color: colors(context).greyColor),
                ),
                8.verticalSpace,
                Visibility(
                  visible: branchResponseEntity?.startTime != null &&
                      branchResponseEntity?.startTime != null,
                  child: Wrap(
                    children: [
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: branchResponseEntity?.status ?? "",
                            style: size14weight700.copyWith(
                                color: branchResponseEntity?.status == "Open "
                                    ? colors(context).positiveColor
                                    : colors(context).negativeColor) 
                          ),
                          TextSpan(
                            text:  "${AppLocalizations.of(context).translate("opens")} ${branchResponseEntity?.startTime} - ${branchResponseEntity?.endTime}  ${getDayOfWeek(branchResponseEntity?.startDayOfWeek)} - ${getDayOfWeek(branchResponseEntity?.endDayOfWeek)}",
                            style: size14weight700.copyWith(color: colors(context).greyColor)
                          ),
                        ])

                       ),
                    // Text(branchResponseEntity?.status ?? "",textAlign: TextAlign.center,
                    //         style: size14weight700.copyWith(
                    //             color: branchResponseEntity?.status == "Open "
                    //                 ? colors(context).positiveColor
                    //                 : colors(context).negativeColor)),
                    // 2.horizontalSpace,
                    // Text(
                    //   "Opens ${branchResponseEntity?.startTime} - ${branchResponseEntity?.endTime}  ${getDayOfWeek(branchResponseEntity?.startDayOfWeek)} - ${getDayOfWeek(branchResponseEntity?.endDayOfWeek)}",
                    //   style: size14weight700.copyWith(color: colors(context).greyColor),textAlign: TextAlign.center,
                    // ),
                    ],
                  )
                ),
                8.verticalSpace,
                      branchResponseEntity?.landMark!=null &&  branchResponseEntity?.landMark!=""?
                      Text(
                        branchResponseEntity?.landMark ?? "",
                        style: size14weight700.copyWith(color: colors(context).greyColor),
                      ):const SizedBox.shrink(),
                8.verticalSpace,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          double latitude = double.parse(
                              branchResponseEntity?.latitude ?? "0");
                          double longitude = double.parse(
                              branchResponseEntity?.longitude ?? "0");
                      if (AppConfig.deviceOS == DeviceOS.HUAWEI) {
                            openHuaweiMaps(latitude, longitude);
                          } else {
                            openGoogleMaps(latitude, longitude);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).w,
                            color: colors(context).primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8,horizontal:8).w,
                            child: Row(
                              children: [
                                PhosphorIcon(
                                  PhosphorIcons.path(
                                      PhosphorIconsStyle.bold),size: 20.w,
                                  color: colors(context).whiteColor,
                                ),
                                8.horizontalSpace,
                                Text(
                                  AppLocalizations.of(context).translate("direction"),
                                  style: size14weight700.copyWith( color: colors(context).whiteColor,),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            branchResponseEntity?.locationCategory == "branch",
                        child: InkWell(
                          onTap: () async {
                            await launchUrl(Uri.parse("${AppLocalizations.of(context).translate("tel")}:${int.parse(branchResponseEntity?.telNumber ?? "")}"));
                           
                          },
                          child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).w,
                            color: colors(context).primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8).w,
                            child: Row(
                              children: [
                                PhosphorIcon(
                                  PhosphorIcons.phone(
                                      PhosphorIconsStyle.bold),size: 20.w,
                                  color: colors(context).whiteColor,
                                ),
                                8.horizontalSpace,
                                  Text(
                                    AppLocalizations.of(context).translate("call"),
                                    style:  size14weight700.copyWith( color: colors(context).whiteColor,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            branchResponseEntity?.locationCategory == "branch",
                        child: InkWell(
                          onTap: () {
                            sendEmailWithAddress(
                                branchResponseEntity?.email ?? "");
                          },
                          child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8).w,
                            color: colors(context).primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8,horizontal:8).w,
                            child: Row(
                              children: [
                                PhosphorIcon(
                                  PhosphorIcons.envelopeSimple(
                                      PhosphorIconsStyle.bold),size: 20.w,
                                  color: colors(context).whiteColor,
                                ),
                                8.horizontalSpace,
                                  Text(
                                    AppLocalizations.of(context).translate("Email"),
                                    style:  size14weight700.copyWith( color: colors(context).whiteColor,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool getStatus(
      String startDate, String endDate, String startTime, String endTime) {
    DateTime today = DateTime.now();

    List<String> startSlot = startTime.split(":");
    List<String> endSlot = endTime.split(":");
    TimeOfDay tod1 = TimeOfDay(
        hour: int.parse(startSlot[0]), minute: int.parse(startSlot[1]));
    TimeOfDay tod2 =
    TimeOfDay(hour: int.parse(endSlot[0]), minute: int.parse(endSlot[1]));
    final dt1 =
    DateTime(today.year, today.month, today.day, tod1.hour, tod1.minute);
    final dt2 =
    DateTime(today.year, today.month, today.day, tod2.hour, tod2.minute);

    if (today.weekday >= int.parse(startDate) &&
        today.weekday <= int.parse(endDate)) {
      if (today.isAfter(dt1) && today.isBefore(dt2)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  String getDayOfWeek(int? day) {
    switch (day) {
      case 1:
        return ("Mon");
      case 2:
        return ("Tue");
      case 3:
        return ("Wed");
      case 4:
        return ("Thu");
      case 5:
        return ("Fri");
      case 6:
        return ("Sat");
      case 7:
        return ("Sun");
      default:
        return ("Invalid day of week");
    }
  }


  void openGoogleMaps(double latitude, double longitude) async {
    String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
    await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not launch Google Maps';
    }
  }

    void openHuaweiMaps(double latitude, double longitude) async {
    String huaweiMapsUrl =
        'https://www.petalmaps.com/place/?z=15&marker=$latitude,$longitude';

    if (await canLaunchUrl(Uri.parse(huaweiMapsUrl))) {
    await launchUrl(Uri.parse(huaweiMapsUrl));
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  void sendEmailWithAddress(String toEmail) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      queryParameters: {},
    );

    if (await canLaunchUrl(_emailLaunchUri)) {
      await launchUrl(_emailLaunchUri);
    } else {
      throw 'Could not launch email';
    }
  }
}
