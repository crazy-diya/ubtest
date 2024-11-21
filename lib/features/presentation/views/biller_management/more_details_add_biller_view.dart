// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import '../../../../core/service/dependency_injection.dart';
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
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';
import '../request_money/widgets/ub_request_money_data_component.dart';
import 'edit_biller_view.dart';

class EditBillerDetailsViewArgs {
  final SavedBillerEntity? savedBillerEntity;
  final bool? isEditView;
  final int billerId;
  final String route;

  EditBillerDetailsViewArgs({
    this.savedBillerEntity,
    this.isEditView,
    required this.billerId,
    required this.route,
  });
}

class EditBillerMoreDetailsView extends BaseView {
  final EditBillerDetailsViewArgs? editBillerDetailsViewArgs;

  EditBillerMoreDetailsView({this.editBillerDetailsViewArgs});

  @override
  _EditBillerMoreDetailsViewState createState() =>
      _EditBillerMoreDetailsViewState();
}

class _EditBillerMoreDetailsViewState
    extends BaseViewState<EditBillerMoreDetailsView> {
  var _bloc = injection<BillerManagementBloc>();
  bool isUpdated = false;
  bool? toggleValue;

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        Navigator.pop(context, isUpdated);
        return false;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          actions: [
            widget.editBillerDetailsViewArgs!.savedBillerEntity!
                .isFavorite ==
                true ?
            IconButton(
              splashRadius: 1,
                icon:  PhosphorIcon(
                        PhosphorIcons.star(PhosphorIconsStyle.bold),
                        color: colors(context).secondaryColor,
                      ), onPressed: () {  },) :
                SizedBox.shrink()
          ],
          title: AppLocalizations.of(context).translate("biller_details"),
          onBackPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        body: BlocProvider<BillerManagementBloc>(
          create: (_) => _bloc,
          child: BlocListener<BillerManagementBloc,
              BaseState<BillerManagementState>>(
            listener: (context, state) {
              if (state is DeleteBillerSuccessState) {
                Navigator.pushNamed(context, Routes.kOtpView,
                        arguments: OTPViewArgs(
                            phoneNumber:
                                AppConstants.profileData.mobileNo.toString(),
                            appBarTitle: 'otp_verification',
                            requestOTP: true,
                            otpType: kBillerMange,
                            ids: state.id,
                            action: "delete"))
                    .then((value) {
                  if (value ==true) {
                    ToastUtils.showCustomToast(
                        context, state.message.toString(), ToastStatus.SUCCESS);
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.kBillersView,
                        arguments: widget.editBillerDetailsViewArgs?.route,
                        (route) =>
                            route.settings.name ==
                            widget.editBillerDetailsViewArgs?.route);
                  }
                });
                // Navigator.of(context).pop(true);
                // Navigator.pushNamed(context, Routes.kBillersView);
                // _bloc.add(GetSavedBillersEvent());
              }
              if (state is FavouriteBillerSuccessState) {
                setState(() {
                  widget.editBillerDetailsViewArgs!.savedBillerEntity!
                      .isFavorite = true;
                  isUpdated = true;
                });
              }
              if (state is UnFavouriteBillerSuccessState) {
                setState(() {
                  widget.editBillerDetailsViewArgs!.savedBillerEntity!
                      .isFavorite = false;
                  isUpdated = true;
                });
              }
              if (state is FavouriteBillerFailedState) {
                setState(() {
                  widget.editBillerDetailsViewArgs!.savedBillerEntity!
                      .isFavorite = false;
                });
                ToastUtils.showCustomToast(
                    context, state.message!, ToastStatus.FAIL);
              }
              if (state is UnFavouriteBillerFailedState) {
                setState(() {
                  widget.editBillerDetailsViewArgs!.savedBillerEntity!
                      .isFavorite = true;
                });
                ToastUtils.showCustomToast(
                    context, state.message!, ToastStatus.FAIL);
              }
              if (state is DeleteBillerFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message!, ToastStatus.FAIL);
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
                          padding: const EdgeInsets.all(16.0).w,
                          child: Column(
                            children: [
                              UBRequestMoneyDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("nickname"),
                                data: widget.editBillerDetailsViewArgs
                                        ?.savedBillerEntity?.nickName ??
                                    "-",
                              ),
                              UBRequestMoneyDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("biller_category"),
                                data: widget
                                        .editBillerDetailsViewArgs
                                        ?.savedBillerEntity
                                        ?.billerCategory
                                        ?.categoryName ??
                                    "-",
                              ),
                              UBRequestMoneyDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("service_provider"),
                                data: widget
                                        .editBillerDetailsViewArgs
                                        ?.savedBillerEntity
                                        ?.serviceProvider
                                        ?.billerName ??
                                    "-",
                              ),
                              UBRequestMoneyDataComponent(
                                title: AppLocalizations.of(context)
                                    .translate("Mobile_Number"),
                                data: formatMobileNumber(widget.editBillerDetailsViewArgs!
                                    .savedBillerEntity!.value ?? "-"),
                                isLastItem: true,
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //       border: Border.all(
                              //         width: 1,
                              //       ),
                              //       borderRadius: const BorderRadius.all(
                              //           Radius.circular(10))),
                              //   child: Column(
                              //     children: [
                              //       Container(
                              //         child: Row(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.center,
                              //           children: [
                              //             Padding(
                              //               padding: const EdgeInsets.only(
                              //                   left: 12, bottom: 12, top: 12),
                              //               child: Image.network(
                              //                 widget
                              //                     .editBillerDetailsViewArgs!
                              //                     .savedBillerEntity!
                              //                     .serviceProvider!
                              //                     .billerImage!,
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
                              //                         .editBillerDetailsViewArgs!
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
                              //                         .editBillerDetailsViewArgs!
                              //                         .savedBillerEntity!
                              //                         .serviceProvider!
                              //                         .billerName!,
                              //                     //"widget.savedBillerEntity!.billerCategory!.billers!.reversed.first.billerName!",
                              //                     // billPaymentViewArgs!
                              //                     //     .billerEntity!.billerName!,
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
                              //   field1: AppLocalizations.of(context)
                              //       .translate("nickname"),
                              //   field2: widget.editBillerDetailsViewArgs!
                              //       .savedBillerEntity!.nickName!,
                              //   //field2: widget.payeeDetails.nickName,
                              // ),
                              // DetailsField(
                              //     field1: AppLocalizations.of(context)
                              //         .translate("account_reference_number"),
                              //     field2:( widget.editBillerDetailsViewArgs!.savedBillerEntity!.value ?? "48395854"),
                              //
                              //     // widget.editBillerDetailsViewArgs!
                              //     //         .savedBillerEntity!.mobileNumber ??
                              //     //     widget
                              //     //         .editBillerDetailsViewArgs!
                              //     //         .savedBillerEntity!
                              //     //         .customFieldEntityList![0]
                              //     //         .customFieldValue!
                              //     //widget.editBillerDetailsViewArgs!.savedBillerEntity!.referenceNumber!,
                              //     ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       AppLocalizations.of(context)
                              //           .translate("added_as_favourite"),
                              //       style: TextStyle(
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w600,
                              //         color: colors(context).greyColor,
                              //       ),
                              //     ),
                              //
                              //     widget.editBillerDetailsViewArgs!
                              //                 .savedBillerEntity!.isFavorite ==
                              //             true
                              //         ? const Icon(
                              //             Icons.favorite,
                              //             color: Color(0xFFFF9F46),
                              //           )
                              //         : const Icon(
                              //             Icons.favorite_border,
                              //             color: Color(0xFFFF9F46),
                              //           ),
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
                              AppLocalizations.of(context).translate("edit"),
                          onTapButton: () {
                            Navigator.pushNamed(
                              context,
                              Routes.kEditBillerView,
                              arguments: EditBillerViewArgs(
                                  route:
                                      widget.editBillerDetailsViewArgs!.route,
                                  billerId: widget
                                      .editBillerDetailsViewArgs!.billerId,
                                  isFavorite: widget.editBillerDetailsViewArgs!
                                      .savedBillerEntity!.isFavorite,
                                  savedBillerEntity: widget
                                      .editBillerDetailsViewArgs!
                                      .savedBillerEntity),
                            );
                          }),
                      16.verticalSpace,
                      AppButton(
                        buttonType: ButtonType.OUTLINEENABLED,
                        buttonColor: Colors.transparent,
                        buttonText:
                            AppLocalizations.of(context).translate("delete"),
                        onTapButton: () {
                          showAppDialog(
                              title: AppLocalizations.of(context).translate("delete_biller"),
                              alertType: AlertType.DELETE,
                              message:AppLocalizations.of(context).translate("delete_biller_des_1"),
                              positiveButtonText: AppLocalizations.of(context)
                                  .translate("yes_delete"),
                              negativeButtonText:
                                  AppLocalizations.of(context).translate("no"),
                              onNegativeCallback: () {
                                Navigator.pop(context);
                              },
                              onPositiveCallback: () {
                                _bloc.add(DeleteBillerEvent(deleteAccountList: [
                                  widget.editBillerDetailsViewArgs!
                                      .savedBillerEntity!.id!
                                      .toInt(),
                                ]));
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
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
