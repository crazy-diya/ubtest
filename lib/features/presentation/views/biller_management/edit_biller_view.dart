// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';

import '../../../domain/entities/response/saved_biller_entity.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/app_button.dart';

import '../../widgets/app_switch/app_switch.dart';
import '../../widgets/appbar.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../../widgets/text_fields/app_text_field.dart';
import '../base_view.dart';
import 'edit_biller_confirm_view.dart';

class EditBillerViewArgs {
  final SavedBillerEntity? savedBillerEntity;
  bool? isFavorite;
  final int billerId;
  final String route;

  EditBillerViewArgs({
    this.savedBillerEntity,
    this.isFavorite,
    required this.billerId,
    required this.route,
  });
}

class EditBillerView extends BaseView {
  final EditBillerViewArgs? editBillerViewArgs;

  EditBillerView({this.editBillerViewArgs});

  @override
  _EditBillerViewState createState() => _EditBillerViewState();
}

class _EditBillerViewState extends BaseViewState<EditBillerView> {
  var _bloc = injection<BillerManagementBloc>();
  String? nickName;
  String? referenceNumber;
  bool? toggleValue;
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _referenceNumberController = TextEditingController();
  bool isEditNickName = false;
  bool isEditAccNum = false;
  bool isChangeToggleValue = false;
  bool saveEnableButton = false;
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setState(() {
      toggleValue = widget.editBillerViewArgs!.isFavorite!;
      _nickNameController.text =
          widget.editBillerViewArgs!.savedBillerEntity!.nickName!;
      _referenceNumberController.text = (widget.editBillerViewArgs!.savedBillerEntity!.value ?? "5848495");
      // _referenceNumberController.text =
      //     widget.editBillerViewArgs!.savedBillerEntity!.mobileNumber ??
      //         widget.editBillerViewArgs!.savedBillerEntity!
      //             .customFieldEntityList![0].customFieldValue!;
      _scrollController.addListener(_onScrollPadding);
    });
  }

  _onScrollPadding(){
    final minScroll = _scrollController.position.minScrollExtent;
    final currentScroll = _scrollController.position.pixels;
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async{
                if (isEditNickName == true ||
                    isEditAccNum == true ||
                    isChangeToggleValue == true) {
                  showAppDialog(
                      alertType: AlertType.DOCUMENT2,
                      title: AppLocalizations.of(context).translate("cancel_edit_biller_process"),
                      message: AppLocalizations.of(context).translate("cancel_edit_biller_des"),
                      negativeButtonText: AppLocalizations.of(context).translate("no"),
                      positiveButtonText: AppLocalizations.of(context).translate("yes_cancel"),
                      onNegativeCallback: () {},
                      onPositiveCallback: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            Routes.kHomeBaseView, (route) => false);
                      });
                } else {
                  Navigator.pop(context);
                }
                return true;
        },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("edit_biller"),
          onBackPressed: () {
            if (isEditNickName == true ||
                isEditAccNum == true ||
                isChangeToggleValue == true) {
              showAppDialog(
                  alertType: AlertType.DOCUMENT2,
                  title: AppLocalizations.of(context).translate("cancel_edit_biller_process"),
                  message: AppLocalizations.of(context).translate("cancel_edit_biller_des"),
                  negativeButtonText: AppLocalizations.of(context).translate("no"),
                  positiveButtonText: AppLocalizations.of(context).translate("yes_cancel"),
                  onNegativeCallback: () {},
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        Routes.kHomeBaseView, (route) => false);
                  });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        body: BlocProvider<BillerManagementBloc>(
          create: (_) => _bloc,
          child: BlocListener<BillerManagementBloc, BaseState<BillerManagementState>>(
            listener: (context, state) {},
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w,0.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Padding(
                          padding: EdgeInsets.only(top: 24.h),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context).translate("pay_to"),
                                        style: size14weight700.copyWith(color: colors(context).blackColor),
                                      ),
                                      16.verticalSpace,
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 48.w,
                                            height: 48.w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8).r,
                                                border: Border.all(color: colors(context).greyColor300!)
                                            ),
                                            child:
                                            // Center(
                                            //   child:SvgPicture.asset(
                                            //     billerEntity!.billerImage ?? "",
                                            //   ),
                                            // ),
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(8).r,
                                              child: Image.network(
                                                widget.editBillerViewArgs!.savedBillerEntity!.serviceProvider!.billerImage!,
                                                scale: 6,
                                              ),
                                            ),
                                          ),
                                          12.horizontalSpace,
                                          Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                    widget.editBillerViewArgs!.savedBillerEntity!.billerCategory!.categoryName!,
                                                    style: size16weight700.copyWith(color: colors(context).blackColor)
                                                ),
                                                4.verticalSpace,
                                                Text(
                                                    widget.editBillerViewArgs!.savedBillerEntity!.serviceProvider!.billerName!,
                                                    style: size14weight400.copyWith(color: colors(context).blackColor)
                                                ),
                                              ],),),
                                          Spacer(),
                                          PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                                            color: colors(context).greyColor300,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
                              //                 widget
                              //                     .editBillerViewArgs!
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
                              //                         .editBillerViewArgs!
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
                              //                         .editBillerViewArgs!
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
                              16.verticalSpace,
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16).w,
                                  child: AppTextField(
                                    validator: (value){
                                      if(_referenceNumberController.text.isEmpty || _referenceNumberController.text == ""){
                                        return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                      }else{
                                        return null;
                                      }
                                    },
                                    isEnable: false,
                                    isInfoIconVisible: false,
                                    initialValue: _referenceNumberController.text,
                                    hint: AppLocalizations.of(context).translate("account_reference_number"),
                                    title: AppLocalizations.of(context).translate("account_reference_number"),
                                    controller: _referenceNumberController,
                                    inputType: TextInputType.phone,
                                    textCapitalization: TextCapitalization.none,
                                    onTextChanged: (value) {
                                      setState(() {
                                        _referenceNumberController.text = value;
                                        saveEnableButton = true;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              16.verticalSpace,
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16).w,
                                      child: AppTextField(
                                        validator: (value){
                                          if(_nickNameController.text.isEmpty || _nickNameController.text == ""){
                                            return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                                          }else{
                                            return null;
                                          }
                                        },
                                        isInfoIconVisible: false,
                                        initialValue: widget.editBillerViewArgs!.savedBillerEntity!.nickName,
                                        hint: AppLocalizations.of(context).translate("nickname"),
                                        title: AppLocalizations.of(context).translate("nickname"),
                                        controller: _nickNameController,
                                        inputType: TextInputType.text,
                                        // inputFormatter: [
                                        //   FilteringTextInputFormatter.allow(
                                        //       RegExp("[A-Z a-z ]")),
                                        // ],
                                        textCapitalization: TextCapitalization.words,
                                        onTextChanged: (value) {
                                          setState(() {
                                            isEditNickName = true;
                                            widget.editBillerViewArgs!.savedBillerEntity!
                                                .nickName = value;
                                            if(value.length == 0){
                                              saveEnableButton = false;
                                            }else{
                                              saveEnableButton = true;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    ///todo : update the padding-
                                    AppSwitch(
                                      title: AppLocalizations.of(context).translate("added_as_favourite"),
                                      addExtraPadding: false,
                                      value: toggleValue!,
                                      onChanged: (value) {
                                        setState(() {
                                          isChangeToggleValue = true;
                                          toggleValue = value;
                                          saveEnableButton =true;
                                          widget.editBillerViewArgs!.isFavorite = toggleValue;
                                        });
                                      },
                                      switchItems: [],
                                    ),
                                  ],
                                ),
                              ),

                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(
                              //       AppLocalizations.of(context)
                              //           .translate("account_reference_number"),
                              //     style: const TextStyle(
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w400,
                              //         color: Color(0xFF5D5D5D)),
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 12,
                              // ),
                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(
                              //     _referenceNumberController.text,
                              //     style: TextStyle(
                              //         fontSize: 18,
                              //         fontWeight: FontWeight.w600,
                              //         color: colors(context).blackColor),
                              //   ),
                              // ),
                              //
                              // // AppTextField(
                              // //   isInfoIconVisible: false,
                              // //   isReadOnly: true,
                              // //   hint: AppLocalizations.of(context)
                              // //       .translate("account_reference_number"),
                              // //   inputTextStyle: TextStyle(
                              // //       fontSize: 16,
                              // //       fontWeight: FontWeight.w400,
                              // //       color: Color(0xFF5D5D5D)),
                              // //   //inputTextStyle: TextStyle(color: Color(0xFF252525)),
                              // //   controller: _referenceNumberController,
                              // //   isLabel: true,
                              // //   textCapitalization: TextCapitalization.words,
                              // //   onTextChanged: (value) {
                              // //     setState(() {
                              // //       isEditAccNum = true;
                              // //       widget.editBillerViewArgs!.savedBillerEntity!.value= value;
                              // //       if(value.length == 0){
                              // //         saveEnableButton = false;
                              // //       }else{
                              // //         saveEnableButton = true;
                              // //       }
                              // //     });
                              // //   },
                              // // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
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
                              //     CupertinoSwitch(
                              //       value: toggleValue!,
                              //       trackColor: colors(context).greyColor?.withOpacity(.65),
                              //               activeColor:colors(context).primaryColor,
                              //       onChanged: (value) {
                              //         setState(() {
                              //           isChangeToggleValue = true;
                              //           toggleValue = value;
                              //           saveEnableButton =true;
                              //         });
                              //       },
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        20.verticalSpace,
                        AppButton(
                            buttonText:
                                AppLocalizations.of(context).translate("save"),
                            buttonType: saveEnableButton == true && _nickNameController.text.isNotEmpty && _referenceNumberController.text.isNotEmpty
                                ? ButtonType.PRIMARYENABLED
                                : ButtonType.PRIMARYDISABLED,
                            onTapButton: () {
                              if(_formKey.currentState?.validate() == false){
                                return;
                              }
                              Navigator.pushNamed(
                                context, Routes.kEditBillerConfirmView,
                                arguments: EditBillerConfirmViewArgs(
                                  route: widget.editBillerViewArgs!.route,
                                  billerId: widget.editBillerViewArgs!.billerId,
                                  refnum: _referenceNumberController.text,
                                  savedBillerEntity: widget.editBillerViewArgs!.savedBillerEntity,
                                  isFavorite:  widget.editBillerViewArgs!.isFavorite,
                                  categoryName: widget.editBillerViewArgs!.savedBillerEntity!.billerCategory!.categoryName!,
                                  billerName: widget.editBillerViewArgs!.savedBillerEntity!.serviceProvider!.billerName!
                                ),
                                //arguments: widget.editBillerViewArgs!.savedBillerEntity,
                              );
                            }),
                        16.verticalSpace,
                        AppButton(
                          buttonType: ButtonType.OUTLINEENABLED,
                          buttonColor: Colors.transparent,
                          buttonText: AppLocalizations.of(context).translate("cancel"),
                          onTapButton: () {
                            showAppDialog(
                                alertType: AlertType.DOCUMENT2,
                                title: AppLocalizations.of(context).translate("cancel_edit_biller_process"),
                                message: AppLocalizations.of(context).translate("cancel_edit_biller_des"),
                                negativeButtonText: AppLocalizations.of(context).translate("no"),
                                positiveButtonText: AppLocalizations.of(context).translate("yes_cancel"),
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
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
