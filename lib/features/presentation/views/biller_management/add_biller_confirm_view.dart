import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_event.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../otp/otp_view.dart';
import '../request_money/widgets/ub_request_money_data_component.dart';
import 'data/add_biller_args.dart';

class AddBillerConfirmView extends BaseView {
  final AddBillerArgs? addBillerArgs;

  AddBillerConfirmView({this.addBillerArgs});

  @override
  _AddBillerConfirmView createState() => _AddBillerConfirmView();
}

class _AddBillerConfirmView extends BaseViewState<AddBillerConfirmView> {
  // var bloc = injection<SplashBloc>();
  var _bloc = injection<BillerManagementBloc>();
  bool toggleValue = false;
  String? billerId;
  @override
  void initState() {
    super.initState();
    // widget.addBillerArgs!.customFields!.forEach((element) {
    //   element.customFieldDetailsEntity!.fieldTypeEntity!.name =
    //       fieldTypeOneLineLabelField;
    // });
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        actions: [
          widget.addBillerArgs!.isFavorite! ?
          IconButton(
            onPressed: (){},
              icon:  PhosphorIcon(
                      PhosphorIcons.star(PhosphorIconsStyle.bold),
                      color: colors(context).secondaryColor,
                    )) : SizedBox.shrink()
        ],
        title: AppLocalizations.of(context).translate("add_biller"),
        goBackEnabled: true,
      ),
      body: BlocProvider<BillerManagementBloc>(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {
            if (state is AddBillerSuccessState) {
              // billerId = state.billerId.toString();
              if (state.responseCode == "843") {
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title: AppLocalizations.of(context)
                      .translate("already_added_nickname"),
                  message: splitAndJoinAtBrTags(state.responseDes ?? ""),
                  positiveButtonText:
                      AppLocalizations.of(context).translate("try_again"),
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  },
                );
              }
              else if (state.responseCode == "842") {
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title: AppLocalizations.of(context)
                      .translate("account_already_exists"),
                  // message: splitAndJoinAtBrTags(state.responseDes ?? ""),
                  dialogContentWidget: Column(
                    children: [
                      Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            TextSpan(
                                text: splitAndJoinAtBrTags(
                                    extractTextWithinTags(
                                        input: state.responseDes ?? "")[0]),
                                style: size14weight400.copyWith(
                                    color: colors(context).greyColor)),
                            TextSpan(
                                text:
                                    " ${splitAndJoinAtBrTags(extractTextWithinTags(input: state.responseDes ?? "")[1])}",
                                style: size14weight700.copyWith(
                                    color: colors(context).greyColor)),
                          ]))
                    ],
                  ),
                  positiveButtonText:
                      AppLocalizations.of(context).translate("close"),
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  },
                );
              } else {
                Navigator.pushNamed(context, Routes.kOtpView,
                    arguments: OTPViewArgs(
                      phoneNumber: AppConstants.profileData.mobileNo.toString(),
                      appBarTitle: 'otp_verification',
                      requestOTP: true,
                      id: state.billerId.toString(),
                      action: "create",

                      ///todo: change the OTP type
                      otpType: kBillerMange,
                    )).then((value) {
                  if (value != null) {
                    if (value != false) {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.kBillersView,
                          arguments: widget.addBillerArgs?.routeType,
                          (route) =>
                              route.settings.name ==
                              widget.addBillerArgs?.routeType);
                      ToastUtils.showCustomToast(
                          context,
                          AppLocalizations.of(context)
                              .translate("biller_added_successfully"),
                          ToastStatus.SUCCESS);
                    }
                  }
                });
              }
            }
            if (state is AddBillerFailedState) {
              Navigator.of(context)..pop();
              ToastUtils.showCustomToast(
                  context, state.message.toString(), ToastStatus.FAIL);
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w , 24.h , 20.w , 20.h),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16).w,
                          child: Column(
                            children: [
                              UBRequestMoneyDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("Nick_Name"),
                                data: widget.addBillerArgs?.nickName ?? "-",
                              ),
                              UBRequestMoneyDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("biller_category"),
                                data: widget.addBillerArgs?.billerCategoryEntity
                                        ?.categoryName ??
                                    "-",
                              ),
                              UBRequestMoneyDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("service_provider"),
                                data: widget.addBillerArgs?.billerName ?? "-",
                              ),
                              UBRequestMoneyDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("Mobile_Number"),
                                data: formatMobileNumberForBiller(
                                    widget.addBillerArgs!.mobileNumber ??
                                        "-"),
                                isLastItem: true,
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //       border: Border.all(
                              //         width: 1,
                              //       ),
                              //       borderRadius: const BorderRadius.all(Radius.circular(10))),
                              //   child: Column(
                              //     children: [
                              //       Container(
                              //         child: Row(
                              //           crossAxisAlignment: CrossAxisAlignment.center,
                              //           children: [
                              //             Padding(
                              //               padding: const EdgeInsets.all(8.0),
                              //               child: SizedBox(
                              //                 width: 40,
                              //                 height: 40,
                              //                 child: Image.network(
                              //                   widget.addBillerArgs!.billerEntity!
                              //                       .billerImage!,
                              //                   width: 50,
                              //                   height: 40,
                              //                   fit: BoxFit.contain,
                              //                 ),
                              //               ),
                              //             ),
                              //             const SizedBox(
                              //               width: 15,
                              //             ),
                              //             Expanded(
                              //                 child: Container(
                              //               child: Column(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: [
                              //                   Text(
                              //                     widget
                              //                         .addBillerArgs!
                              //                         .billerCategoryEntity!
                              //                         .categoryDescription!,
                              //                     style: const TextStyle(
                              //                         fontSize: 16,
                              //                         fontWeight: FontWeight.w600),
                              //                   ),
                              //                   Text(
                              //                     widget.addBillerArgs!.billerEntity!
                              //                         .billerName!,
                              //                     style: const TextStyle(
                              //                         fontSize: 14,
                              //                         fontWeight: FontWeight.w400),
                              //                   ),
                              //                 ],
                              //               ),
                              //             )),
                              //             const SizedBox(
                              //               width: 10,
                              //             ),
                              //             const Icon(Icons.navigate_next)
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //         AppLocalizations.of(context).translate("nickname"),
                              //         style: TextStyle(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w600,
                              //           color: colors(context).greyColor,
                              //         )),
                              //     Text(widget.addBillerArgs!.nickName!,
                              //         style: const TextStyle(
                              //           fontSize: 18,
                              //           fontWeight: FontWeight.w600,
                              //         ))
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 25,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //         widget.addBillerArgs!.billerCategoryEntity!.billers!.first.referenceSample!,
                              //         // AppLocalizations.of(context)
                              //         //     .translate("mobile_number"),
                              //         style: TextStyle(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w600,
                              //           color: colors(context).greyColor,
                              //         )),
                              //     Text(widget.addBillerArgs!.mobileNumber!,
                              //         style: const TextStyle(
                              //           fontSize: 18,
                              //           fontWeight: FontWeight.w600,
                              //         ))
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 25,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       AppLocalizations.of(context)
                              //           .translate("add_favorite"),
                              //       style: TextStyle(
                              //         fontSize: 18,
                              //         fontWeight: FontWeight.w600,
                              //         color: colors(context).blackColor,
                              //       ),
                              //     ),
                              //     widget.addBillerArgs!.isFavorite!
                              //         ? const Icon(Icons.favorite, color: Color(0xFFFF9F46))
                              //         : const Icon(
                              //             Icons.favorite_border,
                              //             color: Color(0xFFFF9F46),
                              //           ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w,20.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
                child: Column(
                  children: [
                    AppButton(
                      buttonText:
                          AppLocalizations.of(context).translate("confirm"),
                      onTapButton: () {
                        // Navigator.pushNamed(context, Routes.kOtpView,
                        //     arguments: OTPViewArgs(
                        //       phoneNumber: AppConstants.profileData.mobileNo.toString(),
                        //       appBarTitle: 'add_biller',
                        //       requestOTP: true,
                        //       ///todo: change the OTP type
                        //       otpType: kBillerMange,
                        //     )).then((value) {
                        //       if(value != null){
                        //         if(value != false) {
                        //           _bloc.add(AddBillerEvent(
                        //             isFavorite: widget.addBillerArgs!
                        //                 .isFavorite! ? true : false,
                        //             nickName: widget.addBillerArgs!.nickName,
                        //             //accNumber: widget.addBillerArgs!.accNumber,
                        //             serviceProviderId:
                        //             widget.addBillerArgs!.billerEntity!
                        //                 .billerId,
                        //             customFields: widget.addBillerArgs!
                        //                 .customFields,
                        //             billerNo: widget.addBillerArgs!
                        //                 .mobileNumber!,
                        //             //customFields: widget.addBillerArgs!.mobileNumber,
                        //           ));
                        //         }
                        //       }
                        //
                        // });
                        _bloc.add(AddBillerEvent(
                          verified: false,
                          isFavorite:
                              widget.addBillerArgs!.isFavorite! ? true : false,
                          nickName: widget.addBillerArgs!.nickName,
                          //accNumber: widget.addBillerArgs!.accNumber,
                          serviceProviderId:
                              widget.addBillerArgs!.billerEntity!.billerId,
                          customFields: widget.addBillerArgs!.customFields,
                          billerNo: widget.addBillerArgs!.mobileNumber!,
                          //customFields: widget.addBillerArgs!.mobileNumber,
                        ));
                      },
                    ),
                    16.verticalSpace,
                    AppButton(
                      buttonType: ButtonType.OUTLINEENABLED,
                      buttonColor: Colors.transparent,
                      buttonText:
                          AppLocalizations.of(context).translate("cancel"),
                      onTapButton: () {
                        showAppDialog(
                            title: AppLocalizations.of(context)
                                .translate("cancel_process"),
                            alertType: AlertType.DOCUMENT2,
                            message: AppLocalizations.of(context)
                                .translate("cancel_add_biller_process_des"),
                            positiveButtonText: AppLocalizations.of(context)
                                .translate("yes,_cancel"),
                            negativeButtonText:
                                AppLocalizations.of(context).translate("no"),
                            onPositiveCallback: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Routes.kHomeBaseView, (route) => false);
                            });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}

String formatMobileNumberForBiller(String number) {
  String cleanedNumber = number.replaceAll(' ', '');
  if (cleanedNumber.length != 10) {
    return number;
  }
  RegExp regExp = RegExp(r'(\d{3})(\d{3})(\d{4})');
  String formattedNumber = cleanedNumber.replaceAllMapped(
      regExp, (Match match) => '${match[1]} ${match[2]} ${match[3]}');
  return formattedNumber;
}
