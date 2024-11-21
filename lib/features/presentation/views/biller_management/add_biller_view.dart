import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/widgets/text_fields/app_text_field.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_validator.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';


import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/responses/city_response.dart';
import '../../../domain/entities/response/biller_category_entity.dart';
import '../../../domain/entities/response/biller_entity.dart';
import '../../../domain/entities/response/custom_field_entity.dart';
import '../../../domain/entities/response/saved_biller_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/app_button.dart';

import '../../widgets/app_switch/app_switch.dart';
import '../../widgets/appbar.dart';

import '../../widgets/pop_scope/ub_pop_scope.dart';
import 'data/add_biller_args.dart';

class AddBillerViewArgs {
  final BillerCategoryEntity? billerCategoryEntity;
  final CustomFieldEntity? customFieldEntity;
  final BillerEntity? billerEntity;
  final SavedBillerEntity? savedBillerEntity;
  final bool? isSaved;
  String routeType;

  AddBillerViewArgs({
    this.billerCategoryEntity,
    this.customFieldEntity,
    this.billerEntity,
    this.savedBillerEntity,
    this.isSaved = false,
    required this.routeType,
  });
}

class AddBillerView extends BaseView {
  final AddBillerViewArgs? billPaymentViewArgs;

  AddBillerView({this.billPaymentViewArgs});

  @override
  _AddBillerView createState() => _AddBillerView();
}

class _AddBillerView extends BaseViewState<AddBillerView> {
  var _bloc = injection<BillerManagementBloc>();
  bool enableButton = false;
  bool isNickNameFilled = false;
  bool isMobileNuFilled = false;

  /// Variables
  List<BillerCategoryEntity> billerCategoryList = [];
  BillerCategoryEntity? _billerCategoryEntity;
  BillerEntity? _billerEntity;
  String? nickName;
  String? accNumber;
  String? mobileNumber;
  final TextEditingController mobileNumberController = TextEditingController();
 late String regexPattern;
 late String hint;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    regexPattern = widget.billPaymentViewArgs!.billerEntity!.referencePattern??"";
    hint = widget.billPaymentViewArgs!.billerEntity!.referenceSample??"";

    // _bloc.add(GetBillerCategoryListEvent());
    _billerEntity =  widget.billPaymentViewArgs!.billerEntity!;
    _scrollController.addListener(_onScrollPadding);
  }

  _onScrollPadding(){
    final minScroll = _scrollController.position.minScrollExtent;
    final currentScroll = _scrollController.position.pixels;

  }

  bool toggleValue = false;
  bool isAddNickName = false;
  bool isAddAccNum = false;

  final _formKey = GlobalKey<FormState>();


  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async{
          if (isAddNickName == true ||
              isAddAccNum == true
          ) {
            showAppDialog(
                title: AppLocalizations.of(context).translate("cancel_process"),
                alertType: AlertType.DOCUMENT2,
                message: AppLocalizations.of(context).translate("cancel_add_biller_process_des"),
                positiveButtonText: AppLocalizations.of(context).translate("yes,_cancel"),
                negativeButtonText: AppLocalizations.of(context).translate("no"),
                onPositiveCallback: () {
                  Navigator.pushNamedAndRemoveUntil(context,
                      Routes.kHomeBaseView, (route) => false);
                });
          } else {
            Navigator.of(context).pop();
          }
          return true;
        },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          title: AppLocalizations.of(context).translate("add_biller"),
          onBackPressed: (){
            if (isAddNickName == true ||
                isAddAccNum == true
                ) {
              showAppDialog(
                  title: AppLocalizations.of(context).translate("cancel_process"),
                  alertType: AlertType.DOCUMENT2,
                  message: AppLocalizations.of(context).translate("cancel_add_biller_process_des"),
                  positiveButtonText: AppLocalizations.of(context).translate("yes,_cancel"),
                  negativeButtonText: AppLocalizations.of(context).translate("no"),
                  onPositiveCallback: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        Routes.kHomeBaseView, (route) => false);
                  });
            } else {
              Navigator.of(context).pop();
            }


          },
        ),
        body: BlocProvider<BillerManagementBloc>(
          create: (_) => _bloc,
          child: BlocListener<BillerManagementBloc, BaseState<BillerManagementState>>(
            listener: (context, state) {
              if (state is GetBillerCategorySuccessState) {
                setState(() {
                  kBillerCategoryList.clear();
                  billerCategoryList.clear();
                  billerCategoryList.addAll(state.billerCategoryList!);
                  kBillerCategoryList.addAll(state.billerCategoryList!
                      .map(
                        (e) => CommonDropDownResponse(
                            id: e.categoryId,
                            description: e.categoryName,
                            key: e.categoryCode),
                      )
                      .toList());

                  try {
                    _billerCategoryEntity = billerCategoryList[0];
                    _billerEntity = _billerCategoryEntity!.billers![0];
                    kBillerList.clear();
                    kBillerList.addAll(_billerCategoryEntity!.billers!
                        .map((e) => CommonDropDownResponse(
                            id: e.billerId,
                            description: e.displayName,
                            key: e.billerCode))
                        .toList());
                  } catch (e) {}
                });
              }
            },
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
                                      InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 64.w,
                                                height: 64.w,
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
                                                widget.billPaymentViewArgs?.billerEntity?.billerImage == null ?
                                                Center(
                                                  child: Text(
                                                    widget.billPaymentViewArgs!.billerCategoryEntity?.categoryName?.toString().getNameInitial() ?? "",
                                                    style: size20weight700.copyWith(
                                                        color: colors(context).primaryColor),
                                                  ),
                                                ) :
                                                CachedNetworkImage(
                                                  imageUrl: widget.billPaymentViewArgs!.billerEntity!.billerImage!,
                                                  imageBuilder:
                                                      (context, imageProvider) =>
                                                      Container(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(8).r,
                                                          image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.fitWidth,
                                                          ),
                                                        ),
                                                      ),
                                                  placeholder: (context, url) =>
                                                      Center(
                                                        child: SizedBox(
                                                          height: 20.w,
                                                          width: 20.w,
                                                          child:
                                                          CircularProgressIndicator(
                                                              color: colors(
                                                                  context)
                                                                  .primaryColor),
                                                        ),
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                      PhosphorIcon(
                                                        PhosphorIcons.warningCircle(
                                                            PhosphorIconsStyle.bold),
                                                      ),
                                                )
                                                // ClipRRect(
                                                //   borderRadius: BorderRadius.circular(8).r,
                                                //   child: Image.network(
                                                //     widget.billPaymentViewArgs!.billerEntity!.billerImage!,
                                                //     scale: 6,
                                                //   ),
                                                // ),
                                              ),
                                              24.horizontalSpace,
                                              Container(
                                                child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  widget.billPaymentViewArgs!.billerCategoryEntity!.categoryName!,
                                                  style: size16weight700.copyWith(color: colors(context).blackColor)
                                                ),
                                                8.verticalSpace,
                                                Text(
                                                  widget.billPaymentViewArgs!.billerEntity!.billerName!,
                                                  style: size14weight400.copyWith(color: colors(context).blackColor)
                                                ),
                                              ],),),
                                              Spacer(),
                                              PhosphorIcon(PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                                                color: colors(context).greyColor300,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              16.verticalSpace,
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16).w,
                                  child: AppTextField(
                                    isInfoIconVisible: false,
                                    inputType: AppValidator.isNumber(regexPattern) ? TextInputType.number: TextInputType.text,
                                    hint: hint,
                                    title: hint,
                                    validator: (value){
                                      RegExp regex = AppValidator.isNumberRegex(regexPattern);
                                      if(value==null || value==""){
                                        return AppLocalizations.of(context).translate("mandatory_field_msg");
                                      } else {
                                        if (regex.hasMatch(value)) {
                                          return null;
                                        } else {
                                          return AppLocalizations.of(context).translate("invalid_format");

                                        }
                                      }
                                    },
                                    onTextChanged: (value) {
                                      setState(() {
                                        mobileNumber = value;
                                        isMobileNuFilled = value.trim().isNotEmpty;
                                        updateSaveButtonState();
                                        isAddAccNum = true;
                                      });
                                    },
                                    controller: mobileNumberController,
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
                                        isInfoIconVisible: false,
                                        hint: AppLocalizations.of(context).translate("enter_nickname"),
                                        title: AppLocalizations.of(context).translate("nickname"),
                                        inputType: TextInputType.text,
                                        // inputFormatter: [
                                        //   FilteringTextInputFormatter.allow(
                                        //       RegExp("[A-Z a-z ]")),
                                        // ],
                                        key: const Key("keyNickName"),
                                        validator: (value){
                                          if(value==null || value=="")
                                          {
                                            return AppLocalizations.of(context).translate("mandatory_field_msg");
                                          } else {
                                            return null;
                                          }
                                        },
                                        initialValue: '',
                                        onTextChanged: (value) {
                                          setState(() {
                                            nickName = value;
                                            isNickNameFilled = value.trim().isNotEmpty;
                                            updateSaveButtonState();
                                            isAddNickName = true;
                                          });
                                        },
                                      ),
                                    ),
                                    ///todo update padding
                                    AppSwitch(
                                      title: AppLocalizations.of(context).translate("add_favorite"),
                                      addExtraPadding: false,
                                      value: toggleValue,
                                      onChanged: (value) {
                                        setState(() {
                                          toggleValue = value;
                                        });
                                      },
                                      switchItems: [],
                                    ),
                                  ],
                                ),
                              ),
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
                            //     CupertinoSwitch(
                            //       value: toggleValue,
                            //      trackColor: colors(context).greyColor?.withOpacity(.65),
                            //               activeColor:colors(context).primaryColor,
                            //       onChanged: (value) {
                            //         setState(() {
                            //           toggleValue = value;
                            //         });
                            //       },
                            //     ),
                            //     // Optional spacing between the switch and description
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
                        buttonText: AppLocalizations.of(context).translate("add"),
                        onTapButton: () {
                          if(_formKey.currentState?.validate()==true){Navigator.pushNamed(context,
                            Routes.kBillerAddConfirmView,
                            arguments: AddBillerArgs(
                              mobileNumber: mobileNumber,
                              nickName: nickName,
                              customFields: _billerEntity!.customFieldList,
                              billerName: widget.billPaymentViewArgs!.billerEntity!.billerName,
                              // accNumber: accNumber,
                              billerCategoryEntity: widget.billPaymentViewArgs!.billerCategoryEntity,
                              billerEntity: widget.billPaymentViewArgs!.billerEntity,
                              isFavorite: toggleValue,
                              routeType: widget.billPaymentViewArgs!.routeType,
                            ),
                          );}},
                      ),
                      16.verticalSpace,
                      AppButton(
                        buttonType: ButtonType.OUTLINEENABLED,
                        buttonColor: Colors.transparent,
                        buttonText: AppLocalizations.of(context).translate("cancel"),
                        onTapButton: () {
                          showAppDialog(
                              title: AppLocalizations.of(context).translate("cancel_process"),
                              alertType: AlertType.DOCUMENT1,
                              message: AppLocalizations.of(context).translate("cancel_add_biller_process_des"),
                              positiveButtonText: AppLocalizations.of(context).translate("yes,_cancel"),
                              negativeButtonText: AppLocalizations.of(context).translate("no"),
                              onPositiveCallback: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    Routes.kHomeBaseView, (route) => false);
                              });
                        },
                      ),
                    ],
                  ),
                ],),
              ),
            )
        ),
      ),
    ));
  }

  /// Validate
  bool _isValidated() {
    if (_billerCategoryEntity == null ||
            _billerEntity == null ||
            nickName == null ||
            nickName == ""
        // accNumber == null ||
        // accNumber == ""
        ) {
      return false;
    }
    return true;
  }

  void updateSaveButtonState() {
    setState(() {
      enableButton = isNickNameFilled && isMobileNuFilled;
    });
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
