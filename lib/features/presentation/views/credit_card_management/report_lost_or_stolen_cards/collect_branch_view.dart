import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/features/domain/entities/response/saved_payee_entity.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/theme/theme_data.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/app_sizer.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../data/models/responses/city_response.dart';
import '../../../bloc/credit_card_management/credit_card_management_bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/bottom_sheet.dart';
import '../../../widgets/drop_down_widgets/drop_down.dart';
import '../../../widgets/ub_radio_button.dart';
import '../../otp/otp_view.dart';

class LostStolenArgs{
  String? maskCardNumber;
  bool? isBranhSelected;
  String? branchCode;
  String? reIsueReq;

  LostStolenArgs({this.maskCardNumber, this.isBranhSelected, this.branchCode,this.reIsueReq});
}



class CollectionBranchView extends BaseView {
  LostStolenArgs lostStolenArgs;


  CollectionBranchView({required this.lostStolenArgs});
  @override
  State<CollectionBranchView> createState() =>
      _CollectBranchViewState();
}

class _CollectBranchViewState
    extends BaseViewState<CollectionBranchView> {
  final bloc = injection<CreditCardManagementBloc>();
  SavedPayeeEntity savedPayeeEntity = SavedPayeeEntity();
  final _formKey = GlobalKey<FormState>();
  List<CommonDropDownResponse>? branchList = [];
  List<CommonDropDownResponse>? searchBranchList = [];
  List<CommonDropDownResponse> searchBankList = [];
  String? branchName;
  String? branchCode;
  String? branchNameTemp;
  String? branchCodeTemp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(GetPayeeBankBranchEventForCard(
      bankCode: "7302",
    ));
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          title: AppLocalizations.of(context)
              .translate("report_lost_card_title"),
          goBackEnabled: true,
        ),
        body: BlocProvider<CreditCardManagementBloc>(
          create: (context) => bloc,
          child: BlocListener<CreditCardManagementBloc,
              BaseState<CreditCardManagementState>>(
              bloc: bloc,
              listener:(context, state){
                if (state is GetPayeeBranchSuccessStateForCard) {
                  branchList = state.data;
                  searchBranchList = branchList;
                  setState(() {});
                }
                if(state is GetCardLostStolenSuccessState){
                  if(state.resCode == "00")
                    showAppDialog(
                      title: AppLocalizations.of(context).translate("Send_request_successful"),
                      alertType: AlertType.SUCCESS,
                      message: AppLocalizations.of(context).translate("stolen_crd_success_des"),
                      positiveButtonText: AppLocalizations.of(context).translate("done"),
                      onPositiveCallback: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
                  if(state.resCode != "00") {
                    showAppDialog(
                      title: AppLocalizations.of(context).translate("unable_to_proceed"),
                      alertType: AlertType.FAIL,
                      message: state.resDescription ?? AppLocalizations.of(context).translate("fail"),
                      positiveButtonText: AppLocalizations.of(context).translate("ok"),
                      onPositiveCallback: () {
                      },
                    );
                  }
                }
                if(state is GetCardLostStolenFailedState){
                  showAppDialog(
                    title: AppLocalizations.of(context).translate("something_went_wrong"),
                    alertType: AlertType.FAIL,
                    message: state.message ?? AppLocalizations.of(context).translate("fail"),
                    positiveButtonText: AppLocalizations.of(context).translate("ok"),
                    onPositiveCallback: () {
                    },
                  );
                }
              },
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20.w, 0.h, 20.w, 20.h + AppSizer.getHomeIndicatorStatus(context)),
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              24.verticalSpace,
                              Text(
                                AppLocalizations.of(context)
                                    .translate("collection_branch"),
                                style: size14weight700.copyWith(
                                    color: colors(context).blackColor),
                              ),
                              16.verticalSpace,
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8).r,
                                  color: colors(context).whiteColor,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                                  child: AppDropDown(
                                    validator: (value) {
                                      if (branchCode == null ||
                                          branchCode == "") {
                                        return AppLocalizations.of(context)
                                            .translate(
                                            "mandatory_field_msg_selection");
                                      } else {
                                        return null;
                                      }
                                    },
                                    label: AppLocalizations.of(context).translate("branch"),
                                    labelText: AppLocalizations.of(context)
                                        .translate("select_branch"),
                                    onTap: () async {
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
                                              StatefulBuilder(
                                                  builder: (context, changeState) {
                                                    return BottomSheetBuilder(
                                                      isSearch: true,
                                                      onSearch: (p0) {
                                                        changeState(() {
                                                          if (p0.isEmpty || p0 == '') {
                                                            searchBranchList = branchList;
                                                          } else {
                                                            searchBranchList = branchList
                                                                ?.where((element) => element
                                                                .description!
                                                                .toLowerCase()
                                                                .contains(p0.toLowerCase())).toSet()
                                                                .toList();
                                                          }
                                                        });
                                                      },
                                                      title: AppLocalizations.of(context)
                                                          .translate('select_branch'),
                                                      buttons: [
                                                        Expanded(
                                                          child: AppButton(
                                                              buttonType:
                                                              ButtonType.PRIMARYENABLED,
                                                              buttonText:
                                                              AppLocalizations.of(context)
                                                                  .translate("continue"),
                                                              onTapButton: () {
                                                                branchCode = branchCodeTemp;
                                                                branchName = branchNameTemp;
                                                                savedPayeeEntity.branchCode =
                                                                    branchCode;
                                                                savedPayeeEntity.branchName =
                                                                    branchName;
                                                                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                                                Navigator.of(context).pop(true);
                                                                changeState(() {});
                                                                setState(() {});
                                                              }),
                                                        ),
                                                      ],
                                                      children: [
                                                        ListView.builder(
                                                          itemCount: searchBranchList?.length,
                                                          shrinkWrap: true,
                                                          padding: EdgeInsets.zero,
                                                          physics:
                                                          NeverScrollableScrollPhysics(),
                                                          itemBuilder: (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                branchCodeTemp =
                                                                    searchBranchList![index]
                                                                        .key;
                                                                branchNameTemp =
                                                                    searchBranchList![index]
                                                                        .description;
                                                                changeState(() {});
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                    EdgeInsets.fromLTRB(
                                                                        0,
                                                                        index == 0
                                                                            ? 0
                                                                            : 20,
                                                                        0,
                                                                        20)
                                                                        .h,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Text(
                                                                            searchBranchList![
                                                                            index]
                                                                                .description ??
                                                                                "",
                                                                            style:
                                                                            size16weight700
                                                                                .copyWith(
                                                                              color: colors(
                                                                                  context)
                                                                                  .blackColor,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                              right: 8)
                                                                              .w,
                                                                          child:
                                                                          UBRadio<dynamic>(
                                                                            value:
                                                                            searchBranchList![
                                                                            index]
                                                                                .key ??
                                                                                "",
                                                                            groupValue:
                                                                            branchCodeTemp,
                                                                            onChanged: (value) {
                                                                              branchCodeTemp =
                                                                                  value;
                                                                              branchNameTemp =
                                                                                  searchBranchList![
                                                                                  index]
                                                                                      .description;
                                                                              changeState(
                                                                                      () {});
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  if ((searchBranchList
                                                                      ?.length ??
                                                                      0) -
                                                                      1 !=
                                                                      index)
                                                                    Divider(
                                                                      height: 0,
                                                                      thickness: 1,
                                                                      color: colors(context)
                                                                          .greyColor100,
                                                                    )
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      ],
                                                    );
                                                  }));

                                      searchBranchList = branchList;
                                      setState(() {});
                                    },
                                    initialValue: branchName,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        )),
                    Column(
                      children: [
                        20.verticalSpace,
                        AppButton(
                          buttonText: AppLocalizations.of(context).translate("submit"),
                          onTapButton: () async {
                            if(_formKey.currentState?.validate() == false){
                              return;
                            }
                            Navigator.pushNamed(context, Routes.kOtpView,
                                    arguments: OTPViewArgs(
                                        phoneNumber: AppConstants.profileData.mobileNo
                                            .toString(),
                                        appBarTitle: "otp_verification",
                                        otpType: "lostorstolencard",
                                        requestOTP: true))
                                .then((value) {
                              if (value == true) {
                                bloc.add(GetCardLostStolenEvent(
                                    maskedCardNumber: widget.lostStolenArgs.maskCardNumber,
                                    reissueRequest: widget.lostStolenArgs.reIsueReq,
                                    isBranch: widget.lostStolenArgs.isBranhSelected,
                                    branchCode: branchCode
                                ));
                                // ToastUtils.showCustomToast(
                                //     context, "success", ToastStatus.SUCCESS);
                              }
                            });
                          },
                        ),
                        16.verticalSpace,
                        AppButton(
                          buttonColor: colors(context).primaryColor50,
                          borderColor: colors(context).primaryColor,
                          textColor: colors(context).primaryColor,
                          buttonText: AppLocalizations.of(context).translate("cancel"),
                          onTapButton: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
