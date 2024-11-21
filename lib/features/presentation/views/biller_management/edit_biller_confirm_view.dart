// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_extensions.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/saved_biller_entity.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_event.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';
import '../request_money/widgets/ub_request_money_data_component.dart';

class EditBillerConfirmViewArgs {
  final SavedBillerEntity? savedBillerEntity;
  final bool? isFavorite;
  final String? refnum;
  final int billerId;
  final String route;
  final String? categoryName;
  final String? billerName;

  EditBillerConfirmViewArgs({
    this.savedBillerEntity,
    this.isFavorite,
    this.refnum,
    this.categoryName,
    this.billerName,
    required this.billerId,
    required this.route,
  });
}

class EditBillerConfirmView extends BaseView {
  final EditBillerConfirmViewArgs? editBillerConfirmViewArgs;

  EditBillerConfirmView({this.editBillerConfirmViewArgs});

  @override
  _EditBillerConfirmViewState createState() => _EditBillerConfirmViewState();
}

class _EditBillerConfirmViewState extends BaseViewState<EditBillerConfirmView> {
  var _bloc = injection<BillerManagementBloc>();
  bool? toggleValue;

  @override
  void initState() {
    super.initState();
    setState(() {
      toggleValue = widget.editBillerConfirmViewArgs!.isFavorite;
    });
  }

  String? billerId;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        actions: [
      widget.editBillerConfirmViewArgs!.isFavorite == true?
          IconButton(
            splashRadius: 1,
              onPressed: () {},
              icon: PhosphorIcon(
                      PhosphorIcons.star(PhosphorIconsStyle.bold),
                      color: colors(context).secondaryColor,
                    )) : SizedBox.shrink()
        ],
        title: AppLocalizations.of(context).translate("edit_biller"),
      ),
      body: BlocProvider<BillerManagementBloc>(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {
            if (state is EditUserBillerSuccessState) {
              //Navigator.of(context)..pop()..pop(true);
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
                return;
              }
              else if (state.responseCode == "842") {
                showAppDialog(
                  alertType: AlertType.WARNING,
                  title: AppLocalizations.of(context)
                      .translate("already_added_nickname"),
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
                              // recognizer: TapGestureRecognizer()
                              //   ..onTap = () async {
                              //     splitAndJoinAtBrTags(extractTextWithinTags(input:  state.message ?? "")[1]);
                              //   },
                                text:" ${splitAndJoinAtBrTags(extractTextWithinTags(input:  state.responseDes ?? "")[1])}" ,
                                style:size14weight700.copyWith(color: colors(context).greyColor)
                            ),
                          ])

                      )
                    ],
                  ),
                  positiveButtonText:
                      AppLocalizations.of(context).translate("close"),
                  onPositiveCallback: () {
                    Navigator.pop(context);
                  },
                );
                return;
              }
              else if (state.responseCode == "dbp-407"){
                billerId = state.billerId.toString();
                Navigator.pushNamed(context, Routes.kOtpView,
                    arguments: OTPViewArgs(
                      phoneNumber: AppConstants.profileData.mobileNo.toString(),
                      appBarTitle: 'otp_verification',
                      requestOTP: true,
                      otpType: kBillerMange,
                      action: "edit",
                      id: widget
                          .editBillerConfirmViewArgs!.savedBillerEntity!.id
                          .toString(),
                    )).then((value) {
                  final result = value as bool;
                  if (result == true) {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.kBillersView,
                        arguments: widget.editBillerConfirmViewArgs?.route,
                        (route) =>
                            route.settings.name ==
                            widget.editBillerConfirmViewArgs?.route);
                    ToastUtils.showCustomToast(
                        context,
                        AppLocalizations.of(context)
                            .translate("edit_biller_success_message"),
                        ToastStatus.SUCCESS);
                  }
                });
              }
              else {
                Navigator.of(context)..pop();
                ToastUtils.showCustomToast(
                    context, state.responseDes ?? "", ToastStatus.FAIL);
              }
              // Navigator.pushNamed(context, Routes.kBillersView);
            }
            if (state is EditUserBillerFailedState) {
              Navigator.of(context)..pop();
              ToastUtils.showCustomToast(
                  context, state.message.toString(), ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
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
                                  .translate("nickname"),
                              data: widget.editBillerConfirmViewArgs
                                      ?.savedBillerEntity?.nickName ??
                                  "-",
                            ),
                            UBRequestMoneyDataComponent(
                              title: AppLocalizations.of(context)
                                  .translate("biller_category"),
                              data: widget.editBillerConfirmViewArgs
                                      ?.categoryName ??
                                  "-",
                            ),
                            UBRequestMoneyDataComponent(
                              title: AppLocalizations.of(context)
                                  .translate("service_provider"),
                              data: widget
                                      .editBillerConfirmViewArgs?.billerName ??
                                  "-",
                            ),
                            UBRequestMoneyDataComponent(
                              title: AppLocalizations.of(context)
                                  .translate("Mobile_Number"),
                              data: formatMobileNumber(widget.editBillerConfirmViewArgs?.refnum ??
                                  widget.editBillerConfirmViewArgs
                                      ?.savedBillerEntity?.value ??
                                  "-"),
                              isLastItem: true,
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //       border: Border.all(
                            //         width: 1,
                            //       ),
                            //       borderRadius:
                            //           const BorderRadius.all(Radius.circular(10))),
                            //   child: Column(
                            //     children: [
                            //       Container(
                            //         child: Row(
                            //           crossAxisAlignment: CrossAxisAlignment.center,
                            //           children: [
                            //             Padding(
                            //               padding: const EdgeInsets.only(
                            //                   left: 12, bottom: 12, top: 12),
                            //               child: Image.network(
                            //                 widget.editBillerConfirmViewArgs!.savedBillerEntity!.serviceProvider!.billerImage!,
                            //                 width: 50,
                            //                 height: 40,
                            //                 fit: BoxFit.contain,
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
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceBetween,
                            //                 children: [
                            //                   Text(
                            //                     widget
                            //                         .editBillerConfirmViewArgs!
                            //                         .savedBillerEntity!
                            //                         .billerCategory!
                            //                         .categoryName!,
                            //                     style: const TextStyle(
                            //                         fontSize: 16,
                            //                         fontWeight: FontWeight.w600),
                            //                   ),
                            //                   const SizedBox(
                            //                     width: 12,
                            //                   ),
                            //                   Text(
                            //                     widget
                            //                         .editBillerConfirmViewArgs!
                            //                         .savedBillerEntity!
                            //                         .serviceProvider!
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
                            // DetailsField(
                            //   field1: AppLocalizations.of(context).translate("nickname"),
                            //   field2: widget.editBillerConfirmViewArgs!.savedBillerEntity!.nickName!,
                            //   //field2: widget.payeeDetails.nickName,
                            // ),
                            // DetailsField(
                            //     field1: AppLocalizations.of(context).translate("account_reference_number"),
                            //     // field2: widget.editBillerConfirmViewArgs!
                            //     //         .savedBillerEntity!.mobileNumber ??
                            //     //     widget
                            //     //         .editBillerConfirmViewArgs!
                            //     //         .savedBillerEntity!
                            //     //         .customFieldEntityList![0]
                            //     //         .customFieldValue!
                            //     field2: widget.editBillerConfirmViewArgs!.refnum ?? widget.editBillerConfirmViewArgs!.savedBillerEntity!.value!,
                            //     ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       AppLocalizations.of(context).translate("added_as_favourite"),
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w600,
                            //         color: colors(context).greyColor,
                            //       ),
                            //     ),
                            //     widget.editBillerConfirmViewArgs!.isFavorite!
                            //         ? const Icon(Icons.favorite, color: Color(0xFFFF9F46))
                            //         : const Icon(
                            //       Icons.favorite_border,
                            //       color: Color(0xFFFF9F46),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    20.verticalSpace,
                    AppButton(
                      buttonText:
                          AppLocalizations.of(context).translate("confirm"),
                      onTapButton: () {
                        // Navigator.pushNamed(context, Routes.kOtpView,
                        //     arguments: OTPViewArgs(
                        //       phoneNumber: AppConstants.profileData.mobileNo.toString(),
                        //       appBarTitle: 'billers',
                        //       requestOTP: true,
                        //       otpType: kBillerMange,
                        //       action: Status.EDIT.toString(),
                        //       id: billerId
                        //     )).then((value) {
                        //   final result = value as bool;
                        //   if(result == true){
                        //     _bloc!.add(
                        //       EditUserBillerEvent(
                        //         accNum: widget.editBillerConfirmViewArgs!.refnum ?? widget.editBillerConfirmViewArgs!.savedBillerEntity!.value!,
                        //         isFavorite: widget.editBillerConfirmViewArgs!.isFavorite,
                        //         nickName: widget.editBillerConfirmViewArgs!
                        //             .savedBillerEntity!.nickName,
                        //         serviceProviderId: widget
                        //             .editBillerConfirmViewArgs!
                        //             .savedBillerEntity!
                        //             .serviceProvider!
                        //             .billerId
                        //             .toString(),
                        //         billerId: widget.editBillerConfirmViewArgs!
                        //             .savedBillerEntity!.id,
                        //         categoryId: widget
                        //             .editBillerConfirmViewArgs!
                        //             .savedBillerEntity!
                        //             .billerCategory!
                        //             .categoryId
                        //             .toString(),
                        //       ),
                        //     );
                        //   }
                        //   // if (value != null) {
                        //   //   _bloc!.add(
                        //   //     EditUserBillerEvent(
                        //   //       accNum: widget.editBillerConfirmViewArgs!.refnum ?? widget.editBillerConfirmViewArgs!.savedBillerEntity!.value!,
                        //   //       isFavorite: widget.editBillerConfirmViewArgs!.isFavorite,
                        //   //       nickName: widget.editBillerConfirmViewArgs!
                        //   //           .savedBillerEntity!.nickName,
                        //   //       serviceProviderId: widget
                        //   //           .editBillerConfirmViewArgs!
                        //   //           .savedBillerEntity!
                        //   //           .serviceProvider!
                        //   //           .billerId
                        //   //           .toString(),
                        //   //       billerId: widget.editBillerConfirmViewArgs!
                        //   //           .savedBillerEntity!.id,
                        //   //       categoryId: widget
                        //   //           .editBillerConfirmViewArgs!
                        //   //           .savedBillerEntity!
                        //   //           .billerCategory!
                        //   //           .categoryId
                        //   //           .toString(),
                        //   //     ),
                        //   //   );
                        //   // }
                        // });
                        _bloc.add(
                          EditUserBillerEvent(
                            accNum: widget.editBillerConfirmViewArgs!.refnum ??
                                widget.editBillerConfirmViewArgs!
                                    .savedBillerEntity!.value!,
                            isFavorite:
                                widget.editBillerConfirmViewArgs!.isFavorite,
                            nickName: widget.editBillerConfirmViewArgs!
                                .savedBillerEntity!.nickName,
                            serviceProviderId: widget.editBillerConfirmViewArgs!
                                .savedBillerEntity!.serviceProvider!.billerId
                                .toString(),
                            billerId: widget.editBillerConfirmViewArgs!
                                .savedBillerEntity!.id,
                            categoryId: widget.editBillerConfirmViewArgs!
                                .savedBillerEntity!.billerCategory!.categoryId
                                .toString(),
                          ),
                        );
                      },
                    ),
                    16.verticalSpace,
                    AppButton(
                      buttonType: ButtonType.OUTLINEENABLED,
                      buttonColor: Colors.transparent,
                      buttonText:
                          AppLocalizations.of(context).translate("Cancel"),
                      onTapButton: () {
                        showAppDialog(
                            alertType: AlertType.DOCUMENT2,
                            title: AppLocalizations.of(context)
                                .translate("cancel_edit_biller_process"),
                            message: AppLocalizations.of(context)
                                .translate("cancel_edit_biller_des"),
                            negativeButtonText:
                                AppLocalizations.of(context).translate("no"),
                            positiveButtonText:
                                AppLocalizations.of(context).translate("yes_cancel"),
                            onNegativeCallback: () {},
                            onPositiveCallback: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Routes.kHomeBaseView, (route) => false);
                            });
                      },
                    ),
                  ],
                ),
              ],
            ),
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
