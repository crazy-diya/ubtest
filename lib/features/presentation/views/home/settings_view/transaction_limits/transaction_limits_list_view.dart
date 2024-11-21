import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';

import '../../../../../../core/service/dependency_injection.dart';
import '../../../../../../core/theme/text_styles.dart';
import '../../../../../../core/theme/theme_data.dart';
import '../../../../../../utils/app_constants.dart';
import '../../../../../../utils/app_localizations.dart';
import '../../../../../../utils/app_sizer.dart';
import '../../../../../../utils/enums.dart';
import '../../../../../../utils/navigation_routes.dart';
import '../../../../../data/models/requests/settings_update_txn_limit_request.dart';
import '../../../../bloc/settings/settings_bloc.dart';
import '../../../../bloc/settings/settings_event.dart';
import '../../../../bloc/settings/settings_state.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/appbar.dart';
import '../../../../widgets/toast_widget/toast_widget.dart';
import '../../../otp/otp_view.dart';
import '../data/settings_tran_limit_entity.dart';

class TransactionListView extends BaseView {
  TransactionListView({super.key});

  @override
  _TransactionListViewState createState() => _TransactionListViewState();
}

class _TransactionListViewState extends BaseViewState<TransactionListView> {
  var _bloc = injection<SettingsBloc>();
  final tranLimitEntity = TranLimitEntity();
  List<TranLimitEntity> tansactionList = [];
  List<TransactionLimit> tranUpdateList = [];
  List<TransactionLimit> txnLimitList = [];
  String? selectedMonth;
  String? selectedInterestedType;
  String? selectedPurposeLoan;
  String? valueFromDouble;
  String maxTran = "000";
  double divisor = 0.0;
  double division = 0.0;
  double division2 = 0.0;
  int? divInt;
  String? minValue;
  String? minValueForSlider;
  double maxValue = 3000000.0;
  bool isLargeAmount = false;
  late final TextEditingController textEditingController;
  List<TextEditingController> textControllers = List.generate(
    30,
    (index) => TextEditingController(),
  );
  List<TextEditingController> textControllers1 = List.generate(
    30,
    (index) => TextEditingController(),
  );
  List<TextEditingController> textControllers2 = List.generate(
    30,
    (index) => TextEditingController(),
  );

  List<int> textFieldValue = [];

  Map<int, TransactionLimit> txnLimitDetailMap = {};

  List<double> initialValue = List.generate(30, (index) => 0.0);

  List<double> userEnterMaxLimit = List.generate(30, (index) => 0.0);

  List<bool> toggleValue = List.generate(30, (index) => false);

  List<bool> isMaxDailyLimitEdited = List.generate(30, (index) => false);

  List<bool> isMaxPerTranEdited = List.generate(30, (index) => false);

  List<bool> isMaxPerTranEditedTextField = List.generate(30, (index) => false);

  List<bool> expansionStates = List.generate(30, (index) => false);

  List<bool> expansionStatesForContainer = List.generate(30, (index) => false);

  List<bool> expansionStatesForEdit = List.generate(30, (index) => false);

  bool isMinimun = false;

  final _formKey = GlobalKey<FormState>();

  void _toggleExpansionState(int index) {
    setState(() {
      expansionStates[index] = !expansionStates[index];
    });
  }

  bool isTap = false;

  var thousandFormatter = ThousandsSeparatorInputFormatter();

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: valueFromDouble);
    setState(() {
      _bloc.add(GetTranLimitEvent(
        channelType: "MB",
        messageType: "txnDetailsReq",
      ));
    });
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("transaction_limits"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<SettingsBloc, BaseState<SettingsState>>(
          bloc: _bloc,
          listener: (_, state) {
            if (state is GetTransLimitSuccessState) {
              ///todo: metana tw response code thyenna plwn ewa define krma e tika dann oni
              if (state.code == "01") {
                ToastUtils.showCustomToast(context,
                    state.message ?? AppLocalizations.of(context).translate("connection_exception"), ToastStatus.FAIL);
              } else if (state.code == "001") {
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
              } else {
                tansactionList.clear();
                tansactionList.addAll(state.tranLimitDetails!
                    .map((e) => TranLimitEntity(
                        transactionType: e.transactionType,
                        description: e.description,
                        maxUserAmountPerDay: e.maxUserAmountPerDay,
                        maxUserAmountPerTran: e.maxUserAmountPerTran,
                        maxGlobalLimitPerTran: e.maxGlobalLimitPerTran,
                        twoFactorLimmit: e.twoFactorLimit,
                        isTwofactorEnabble: e.enabledTwoFactorLimit,
                        minUserAmountPerTran: e.minUserAmountPerTran,
                        globalTwoFactorLimit: e.globalTwoFactorLimit,
                        maxGlobalLimitPerDay: e.maxGlobalLimitPerDay))
                    .toList());

                setState(() {});
              }
            }
            if (state is GetTransLimitFailedState) {
              ToastUtils.showCustomToast(context,
                  state.message ?? AppLocalizations.of(context).translate("connection_exception"), ToastStatus.FAIL);
            }
            if (state is ResetTxnLimitSuccessState) {
              ToastUtils.showCustomToast(
                  context, state.message ?? AppLocalizations.of(context).translate("success"), ToastStatus.SUCCESS);
              Navigator.pop(context);
            }
            if (state is ResetTxnLimitFailedState) {
              ToastUtils.showCustomToast(context,
                  state.message ?? AppLocalizations.of(context).translate("connection_exception"), ToastStatus.FAIL);
            }
            if (state is UpdateTxnLimitSuccessState) {
              if (state.code == "01") {
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
              } else if (state.code == "001") {
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("fail"), ToastStatus.FAIL);
              } else {
                ToastUtils.showCustomToast(
                    context, state.message ?? AppLocalizations.of(context).translate("success"), ToastStatus.SUCCESS);

                ///To load Init and Remove true value
                Navigator.pushReplacementNamed(
                    context, Routes.kTransactionListView);
                // _bloc.add(GetTranLimitEvent(
                //   channelType: "MB",
                //   messageType: "txnDetailsReq",
                // ));
              }
            }
            if (state is UpdateTxnLimitFailedState) {
              showAppDialog(
                title: AppLocalizations.of(context).translate("something_gone_wrong"),
                message: state.message ?? AppLocalizations.of(context).translate("something_gone_wrong"),
                alertType: AlertType.FAIL,
                onPositiveCallback: () {},
                positiveButtonText: AppLocalizations.of(context).translate("ok"),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,0.h,),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: colors(context).whiteColor),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0).w,
                      child: Text(
                        AppLocalizations.of(context).translate(
                          "please_set_the_per",
                        ),
                        style: size16weight400.copyWith(
                            color: colors(context).greyColor),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h+ AppSizer.getHomeIndicatorStatus(context)),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: tansactionList.length,
                            itemBuilder: (context, int index) {
                              return Stack(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 16.0).h,
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(8).r,
                                                    color:
                                                        colors(context).whiteColor,
                                                    border: Border.all(
                                                      color: expansionStates[index]
                                                          ? colors(context)
                                                                  .blackColor300 ??
                                                              Colors.black
                                                          : Colors.transparent,
                                                    )),
                                                child: Padding(
                                                  padding: expansionStates[index]
                                                      ? const EdgeInsets.fromLTRB(
                                                              16, 32, 16, 16)
                                                          .w
                                                      : const EdgeInsets.all(16.0).w,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Text(
                                                                tansactionList[
                                                                            index]
                                                                        .description ??
                                                                    AppLocalizations.of(context).translate("no_title"),
                                                                maxLines: 2,
                                                                style: size14weight700.copyWith(
                                                                    color: colors(
                                                                            context)
                                                                        .blackColor),
                                                                textAlign: TextAlign
                                                                    .justify,
                                                              ),
                                                            ),
                                                            8.verticalSpace,
                                                            Text(
                                                              "${AppLocalizations.of(context).translate("lkr")} ${tansactionList[index].maxUserAmountPerDay?.withThousandSeparator()}",
                                                              style: size16weight400
                                                                  .copyWith(
                                                                      color: colors(
                                                                              context)
                                                                          .greyColor),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      PhosphorIcon(
                                                        PhosphorIcons
                                                            .pencilSimpleLine(
                                                                PhosphorIconsStyle
                                                                    .bold),
                                                        color:
                                                        expansionStates.contains(true)
                                                                ? colors(context)
                                                                    .greyColor300
                                                                : colors(context)
                                                                    .blackColor,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if (expansionStates[index])
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight:
                                                                    Radius.circular(
                                                                            8)
                                                                        .r,
                                                                bottomLeft: Radius
                                                                        .circular(8)
                                                                    .r),
                                                        color: colors(context)
                                                            .blackColor300,
                                                        border: Border.all(
                                                          color: colors(context)
                                                                  .blackColor300 ??
                                                              Colors.black,
                                                        )),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.fromLTRB(16,5,16,5)
                                                              .w,
                                                      child: Text(
                                                        AppLocalizations.of(context).translate("edited"),
                                                        style: size12weight400
                                                            .copyWith(
                                                                color: colors(
                                                                        context)
                                                                    .whiteColor),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            Navigator.pushNamed(context,
                                                Routes.kTransactionLimitDetailsView,
                                                arguments: TranLimitEntity(
                                                  transactionType:
                                                      tansactionList[index]
                                                          .transactionType,
                                                  maxUserAmountPerDay:
                                                      tansactionList[index]
                                                          .maxUserAmountPerDay!
                                                          .withThousandSeparator(),
                                                  maxUserAmountPerTran:
                                                      tansactionList[index]
                                                          .maxUserAmountPerTran!
                                                          .withThousandSeparator(),
                                                  maxGlobalLimitPerTran:
                                                      tansactionList[index]
                                                          .maxGlobalLimitPerTran,
                                                  maxGlobalLimitPerDay:
                                                      tansactionList[index]
                                                          .maxGlobalLimitPerDay,
                                                  minUserAmountPerTran:
                                                      tansactionList[index]
                                                          .minUserAmountPerTran!
                                                          .withThousandSeparator(),
                                                  globalTwoFactorLimit:
                                                      tansactionList[index]
                                                          .globalTwoFactorLimit,
                                                  description: tansactionList[index]
                                                      .description,
                                                  twoFactorLimmit:
                                                      tansactionList[index]
                                                          .twoFactorLimmit!
                                                          .withThousandSeparator(),
                                                  isTwofactorEnabble:
                                                      tansactionList[index]
                                                          .isTwofactorEnabble,
                                                )).then((value) {
                                              if (value != null &&
                                                  value is TransactionLimit) {
                                                txnLimitDetailMap[index] =
                                                    TransactionLimit(
                                                  transactionType:
                                                      value.transactionType,
                                                  maxAmountPerTran:
                                                      value.maxAmountPerTran,
                                                  maxAmountPerDay:
                                                      value.maxAmountPerDay,
                                                  twoFactorLimit:
                                                      value.twoFactorLimit,
                                                  twoFactorEnable:
                                                      value.twoFactorEnable,
                                                  minAmountPerTran: value.minAmountPerTran
                                                );
                                                _toggleExpansionState(index);
                                              }
                                            });
                                            // expansionStatesForContainer[index] = true;
                                            // isTap = true;
                                            // // tranLimitEntity.minUserAmountPerTran = tansactionList[index].minUserAmountPerTran;
                                            // // tranLimitEntity.maxUserAmountPerTran = tansactionList[index].maxUserAmountPerTran;
                                            // // tranLimitEntity.twoFactorLimmit = tansactionList[index].twoFactorLimmit;
                                            // // tranLimitEntity.isTwofactorEnabble = tansactionList[index].isTwofactorEnabble;
                                            // // tranLimitEntity.maxGlobalLimitPerTran = tansactionList[index].maxGlobalLimitPerTran;
                                            // // tranLimitEntity.maxUserAmountPerDay = tansactionList[index].maxUserAmountPerDay;
                                            // // tranLimitEntity.description = tansactionList[index].description;
                                            // // tranLimitEntity.transactionType = tansactionList[index].transactionType;
                                            // textControllers[index].text = tansactionList[index].maxUserAmountPerTran ?? "";
                                            // textControllers1[index].text = tansactionList[index].maxUserAmountPerDay ?? "";
                                            // textControllers2[index].text = tansactionList[index].twoFactorLimmit.toString();
                                            // minValue = tansactionList[index].minUserAmountPerTran ?? "";
                                            // minValueForSlider = tansactionList[index].minUserAmountPerTran ?? "";
                                            // // minValue = 0.0;
                                            // maxValue = double.parse(tansactionList[index].maxUserAmountPerTran!);
                                            // maxTran = tansactionList[index].maxGlobalLimitPerTran!;
                                            // String result = maxTran.substring(0, maxTran.length - 2);
                                            // divisor = double.parse(result);
                                            // division = int.parse(tansactionList[index].maxGlobalLimitPerTran!) / divisor;
                                            // divInt = division.toInt();
                                            //   txnLimitDetailMap[index] = TransactionLimit(
                                            //           transactionType: tansactionList[index].transactionType,
                                            //           maxAmountPerTran: int.parse(textControllers[index].text.replaceAll(',', '')),
                                            //           minAmountPerTran: int.parse(tansactionList[index].minUserAmountPerTran!),
                                            //           maxAmountPerDay: int.parse(textControllers1[index].text.replaceAll(',', '')),
                                            //           twoFactorLimit: int.parse(textControllers2[index].text.replaceAll(',', '')),
                                            //           twoFactorEnable: tansactionList[index].isTwofactorEnabble,
                                            //       );
                                          });
                                        },
                                      ),
                                      // if (expansionStates[index])
                                      //   Padding(
                                      //     padding: const EdgeInsets.only(
                                      //         left: 6, right: 6),
                                      //     child: Column(
                                      //       children: [
                                      //         const SizedBox(
                                      //           height: 16,
                                      //         ),
                                      //         SettingsTextField(
                                      //           validator: (a){
                                      //             if(double.parse(textControllers[index].text.replaceAll(',', '')) < double.parse(tansactionList[index].minUserAmountPerTran!)){
                                      //               return AppLocalizations.of(context)
                                      //                   .translate("tran_limit_error_msg");
                                      //             }else{
                                      //               return null;
                                      //             }
                                      //           },
                                      //           controller: textControllers[index],
                                      //           showCurrencySymbol: true,
                                      //           maxLength: 9,
                                      //           inputFormatter: [thousandFormatter],
                                      //           // inputFormatter: [
                                      //           //   thousandFormatter,
                                      //           //   FilteringTextInputFormatter.allow(
                                      //           //       RegExp("[0-9.,]")),
                                      //           // ],
                                      //           inputType: TextInputType.number,
                                      //           hint: "Maximum Per Transaction Limit",
                                      //           isLabel: true,
                                      //           isCurrency: true,
                                      //           initialValue: tansactionList[index]
                                      //               .maxUserAmountPerTran,
                                      //           onTextChanged: (value) {
                                      //             setState(() {
                                      //               expansionStatesForEdit[index] = true;
                                      //               isMaxPerTranEditedTextField[index] = true;
                                      //               // if (isLargeAmount == true) {
                                      //               //   value = initialValue.toString();
                                      //               // }
                                      //               double parsedValue = double.parse(
                                      //                   value.replaceAll(',', '')
                                      //                 // value.replaceAll(',', '')
                                      //               );
                                      //               initialValue[index] = parsedValue;
                                      //               tansactionList[index].maxUserAmountPerTran = parsedValue.toString();
                                      //               if (double.parse(textControllers[index].text.replaceAll(',', ''))>
                                      //                   double.parse(tansactionList[index].maxGlobalLimitPerTran!)) {
                                      //                 setState(() {
                                      //                   textControllers[index].text = tansactionList[index].maxGlobalLimitPerTran!;
                                      //                   initialValue[index] = double.parse(tansactionList[index].maxGlobalLimitPerTran!);
                                      //                   tansactionList[index].maxUserAmountPerTran = tansactionList[index].maxGlobalLimitPerTran!;
                                      //                   isLargeAmount = true;
                                      //                 });
                                      //               }
                                      //               if(double.parse(textControllers[index].text.replaceAll(',', '')) < double.parse(tansactionList[index].minUserAmountPerTran!)){
                                      //                 setState(() {
                                      //                 isMinimun = true;
                                      //                 minValueForSlider = "0";
                                      //                 });
                                      //               } else {
                                      //                 isMinimun = false;
                                      //                 minValueForSlider = tansactionList[index].minUserAmountPerTran ?? "";
                                      //                 setState(() {
                                      //
                                      //                 });
                                      //               }
                                      //               if (isMaxPerTranEditedTextField[
                                      //               index] ==
                                      //                   true) {
                                      //                 setState(() {
                                      //                   txnLimitDetailMap[index] = TransactionLimit(
                                      //                     transactionType: tansactionList[index].transactionType,
                                      //                     maxAmountPerTran: double.parse(textControllers[index].text.replaceAll(',', '')),
                                      //                     minAmountPerTran: int.parse(tansactionList[index].minUserAmountPerTran!),
                                      //                     maxAmountPerDay: double.parse(textControllers1[index].text.replaceAll(',', '')),
                                      //                     twoFactorLimit: double.parse(textControllers2[index].text.replaceAll(',', '')),
                                      //                     twoFactorEnable: tansactionList[index].isTwofactorEnabble,
                                      //                   );
                                      //                 });
                                      //               }
                                      //             });
                                      //           },
                                      //         ),
                                      //         const SizedBox(
                                      //           height: 14,
                                      //         ),
                                      //         SliderTheme(
                                      //           data:
                                      //           SliderTheme.of(context).copyWith(
                                      //             // Customize division colors
                                      //             activeTrackColor: colors(context)
                                      //                 .primaryColor,
                                      //             inactiveTrackColor: colors(context)
                                      //                 .primaryColor,
                                      //             thumbColor:
                                      //             colors(context).primaryColor,
                                      //
                                      //             ///Customize division sizes
                                      //             trackHeight: 6.0,
                                      //             thumbShape: const RoundSliderThumbShape(
                                      //                 enabledThumbRadius: 8.0,
                                      //                 pressedElevation: 6),
                                      //             overlayShape:
                                      //             const RoundSliderOverlayShape(
                                      //               overlayRadius: 18.0,
                                      //             ),
                                      //
                                      //             // Customize division appearance
                                      //             valueIndicatorColor:
                                      //             colors(context).primaryColor,
                                      //             valueIndicatorTextStyle: const TextStyle(
                                      //               color: Colors.white,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //           child: Slider(
                                      //             activeColor:
                                      //             colors(context).primaryColor,
                                      //             thumbColor: colors(context)
                                      //                 .primaryColor,
                                      //             inactiveColor: colors(context)
                                      //                 .primaryColor,
                                      //             divisions: (double.parse(tansactionList[index].maxGlobalLimitPerTran!).toInt() - double.parse(tansactionList[index].minUserAmountPerTran!).toInt()),
                                      //             label: initialValue[index]
                                      //                 .round()
                                      //                 .toString(),
                                      //             min: double.parse(minValueForSlider ?? "0.0"),
                                      //             // 0.00,
                                      //             // double.parse(
                                      //             //     tansactionList[index]
                                      //             //         .minUserAmountPerTran!),
                                      //             max: double.parse(
                                      //                 tansactionList[index]
                                      //                     .maxGlobalLimitPerTran!),
                                      //             value: isMaxPerTranEdited[index]
                                      //                 ? initialValue[index]
                                      //                 : double.parse(
                                      //                 tansactionList[index]
                                      //                     .maxUserAmountPerTran!),
                                      //             // initialValue[index],
                                      //             onChanged: (double value) {
                                      //               setState(() {
                                      //                 expansionStatesForEdit[index] =
                                      //                 true;
                                      //                 isMaxPerTranEdited[index] =
                                      //                 true;
                                      //                 initialValue[index] = value;
                                      //                 valueFromDouble = NumberFormat
                                      //                     .decimalPattern()
                                      //                     .format(value);
                                      //                 userEnterMaxLimit[index] =
                                      //                     value;
                                      //                 if (mounted) {
                                      //                   // textEditingController.text =
                                      //                   // valueFromDouble!;
                                      //                   textControllers[index].text =
                                      //                   valueFromDouble!;
                                      //                 }
                                      //                 initialValue[index] =
                                      //                     double.parse(textControllers[index].text
                                      //                             .replaceAll(
                                      //                             ',', ''));
                                      //                 tansactionList[index].maxUserAmountPerTran = textControllers[index].text;
                                      //               });
                                      //               setState(() {
                                      //                 txnLimitDetailMap[index] =
                                      //                 txnLimitDetailMap[index] = TransactionLimit(
                                      //                   transactionType: tansactionList[index].transactionType,
                                      //                   maxAmountPerTran: double.parse(textControllers[index].text.replaceAll(',', '')),
                                      //                   minAmountPerTran: int.parse(tansactionList[index].minUserAmountPerTran!),
                                      //                   maxAmountPerDay: double.parse(textControllers1[index].text.replaceAll(',', '')),
                                      //                   twoFactorLimit: double.parse(textControllers2[index].text.replaceAll(',', '')),
                                      //                   twoFactorEnable: tansactionList[index].isTwofactorEnabble,
                                      //                 );
                                      //               });
                                      //             },
                                      //           ),
                                      //         ),
                                      //         Row(
                                      //           mainAxisAlignment:
                                      //           MainAxisAlignment.spaceBetween,
                                      //           children: [
                                      //             Column(
                                      //               crossAxisAlignment:
                                      //               CrossAxisAlignment.start,
                                      //               children: [
                                      //                 Text(
                                      //                   AppLocalizations.of(context)
                                      //                       .translate(
                                      //                       "minimum_limit"),
                                      //                   style: TextStyle(
                                      //                       color: colors(context)
                                      //                           .blackColor,
                                      //                       fontWeight:
                                      //                       FontWeight.w400,
                                      //                       fontSize: 16),
                                      //                 ),
                                      //                 SizedBox(
                                      //                   height: 1.h,
                                      //                 ),
                                      //                 Text(
                                      //                   minValue ?? "0" + ".00",
                                      //                   style: TextStyle(
                                      //                       color: colors(context)
                                      //                           .blackColor,
                                      //                       fontWeight:
                                      //                       FontWeight.w600,
                                      //                       fontSize: 16),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //             Column(
                                      //               crossAxisAlignment:
                                      //               CrossAxisAlignment.end,
                                      //               children: [
                                      //                 Text(
                                      //                   AppLocalizations.of(context)
                                      //                       .translate(
                                      //                       "maximum_limit"),
                                      //                   style: TextStyle(
                                      //                       color: colors(context)
                                      //                           .blackColor,
                                      //                       fontWeight:
                                      //                       FontWeight.w400,
                                      //                       fontSize: 16),
                                      //                 ),
                                      //                 SizedBox(
                                      //                   height: 1.h,
                                      //                 ),
                                      //                 Text(
                                      //                   tansactionList[index]
                                      //                       .maxGlobalLimitPerTran! +
                                      //                       ".00",
                                      //                   style: TextStyle(
                                      //                       color: colors(context)
                                      //                           .blackColor,
                                      //                       fontWeight:
                                      //                       FontWeight.w600,
                                      //                       fontSize: 16),
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         const SizedBox(
                                      //           height: 24,
                                      //         ),
                                      //         SettingsTextField(
                                      //           hint: AppLocalizations.of(context)
                                      //               .translate("maximum_daily_limit"),
                                      //           isLabel: true,
                                      //           controller: textControllers1[index],
                                      //           isCurrency: true,
                                      //           maxLength: 15,
                                      //           inputType: TextInputType.number,
                                      //           initialValue: tansactionList[index]
                                      //               .maxUserAmountPerDay ==
                                      //               "null"
                                      //               ? ""
                                      //               : tansactionList[index]
                                      //               .maxUserAmountPerDay!,
                                      //           inputFormatter: [
                                      //             thousandFormatter,
                                      //             FilteringTextInputFormatter.allow(
                                      //                 RegExp("[0-9.,]")),
                                      //           ],
                                      //           onTextChanged: (value) {
                                      //             setState(() {
                                      //               expansionStatesForEdit[index] =
                                      //               true;
                                      //               isMaxDailyLimitEdited[index] =
                                      //               true;
                                      //               if (double.parse(textControllers1[index].text.replaceAll(',', ''))>
                                      //                   double.parse(tansactionList[index].maxGlobalLimitPerDay!)) {
                                      //                 setState(() {
                                      //                   textControllers1[index].text = tansactionList[index].maxGlobalLimitPerDay!;
                                      //                 });
                                      //               }
                                      //             });
                                      //             setState(() {
                                      //               txnLimitDetailMap[index] = TransactionLimit(
                                      //                 transactionType: tansactionList[index].transactionType,
                                      //                 maxAmountPerTran: double.parse(textControllers[index].text.replaceAll(',', '')),
                                      //                 minAmountPerTran: int.parse(tansactionList[index].minUserAmountPerTran!),
                                      //                 maxAmountPerDay: double.parse(textControllers1[index].text.replaceAll(',', '')),
                                      //                 twoFactorLimit: double.parse(textControllers2[index].text.replaceAll(',', '')),
                                      //                 twoFactorEnable: tansactionList[index].isTwofactorEnabble,
                                      //               );
                                      //             });
                                      //           },
                                      //           isInfoIconVisible: false,
                                      //         ),
                                      //         const SizedBox(
                                      //           height: 24,
                                      //         ),
                                      //         Row(
                                      //           mainAxisAlignment:
                                      //           MainAxisAlignment.spaceBetween,
                                      //           children: [
                                      //             Text(
                                      //               AppLocalizations.of(context)
                                      //                   .translate(
                                      //                   "two_factor_authentication"),
                                      //               style: TextStyle(
                                      //                 fontSize: 18,
                                      //                 fontWeight: FontWeight.w600,
                                      //                 color: colors(context)
                                      //                     .blackColor,
                                      //               ),
                                      //             ),
                                      //             Switch(
                                      //               value: tansactionList[index]
                                      //                   .isTwofactorEnabble == null ? toggleValue[index] = false : tansactionList[index]
                                      //                   .isTwofactorEnabble!,
                                      //               activeColor:
                                      //               colors(context).blackColor,
                                      //               onChanged: (value) {
                                      //                 setState(() {
                                      //                   expansionStatesForEdit[
                                      //                   index] = true;
                                      //                   toggleValue[index] = value;
                                      //                   tansactionList[index].isTwofactorEnabble = toggleValue[index];
                                      //                   txnLimitDetailMap[index] = TransactionLimit(
                                      //                     transactionType: tansactionList[index].transactionType,
                                      //                     maxAmountPerTran: double.parse(textControllers[index].text.replaceAll(',', '')),
                                      //                     minAmountPerTran: int.parse(tansactionList[index].minUserAmountPerTran!),
                                      //                     maxAmountPerDay: double.parse(textControllers1[index].text.replaceAll(',', '')),
                                      //                     twoFactorLimit: double.parse(textControllers2[index].text.replaceAll(',', '')),
                                      //                     twoFactorEnable: tansactionList[index].isTwofactorEnabble,
                                      //                   );
                                      //                 });
                                      //               },
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         const SizedBox(
                                      //           height: 10,
                                      //         ),
                                      //         Visibility(
                                      //           visible: tansactionList[index]
                                      //               .isTwofactorEnabble ?? toggleValue[index],
                                      //           child: SettingsTextField(
                                      //             controller: textControllers2[index],
                                      //             inputFormatter: [thousandFormatter],
                                      //             initialValue: tansactionList[index]
                                      //                 .twoFactorLimmit == null
                                      //                 ? ""
                                      //                 : tansactionList[index]
                                      //                 .twoFactorLimmit.toString(),
                                      //             inputType: TextInputType.number,
                                      //             hint: AppLocalizations.of(context)
                                      //                 .translate(
                                      //                 "two_factor_authentication"),
                                      //             // isCurrency: true,
                                      //             isLabel: true,
                                      //             isEnable: true,
                                      //             action:
                                      //             CommonToolTips(
                                      //               title: "By enabling secondary verification and configuring a limit, you can add extra security for transaction that exceeds this limit amount.",
                                      //               content: [""],
                                      //             ),
                                      //
                                      //             onTextChanged: (value) {
                                      //               expansionStatesForEdit[
                                      //               index] = true;
                                      //               setState(() {
                                      //                 if (double.parse(textControllers2[index].text.replaceAll(',', ''))>
                                      //                     double.parse(tansactionList[index].globalTwoFactorLimit!)) {
                                      //                   setState(() {
                                      //                     textControllers2[index].text = tansactionList[index].globalTwoFactorLimit!;
                                      //                   });
                                      //                 }
                                      //                 txnLimitDetailMap[index] = TransactionLimit(
                                      //                   transactionType: tansactionList[index].transactionType,
                                      //                   maxAmountPerTran: double.parse(textControllers[index].text.replaceAll(',', '')),
                                      //                   minAmountPerTran: int.parse(tansactionList[index].minUserAmountPerTran!),
                                      //                   maxAmountPerDay: double.parse(textControllers1[index].text.replaceAll(',', '')),
                                      //                   twoFactorLimit: double.parse(textControllers2[index].text.replaceAll(',', '')),
                                      //                   twoFactorEnable: tansactionList[index].isTwofactorEnabble,
                                      //                 );
                                      //               });
                                      //             },
                                      //           ),
                                      //         ),
                                      //         SizedBox(
                                      //           height: 3.h,
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   )
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                  ),
                  if (expansionStates.contains(true))
                    Padding(
                      padding: EdgeInsets.only(bottom: 0.h+ AppSizer.getHomeIndicatorStatus(context)),
                      child: Column(
                        children: [
                          8.verticalSpace,
                          AppButton(
                              buttonText:
                                  AppLocalizations.of(context).translate("save"),
                              onTapButton: () {
                                // if(_formKey.currentState?.validate() == false){
                                //  return;
                                // }
                                // if(isMinimun == true){
                                //   showAppDialog(
                                //       title: AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED),
                                //       alertType: AlertType.WARNING,
                                //       message: AppLocalizations.of(context).translate("tran_limit_error_msg"),
                                //       positiveButtonText: AppLocalizations.of(context).translate("ok"),
                                //       onPositiveCallback: () {});
                                // }
                                List<TransactionLimit> txnLimitList =
                                    txnLimitDetailMap.values.toList();
                                Navigator.pushNamed(context, Routes.kOtpView,
                                        arguments: OTPViewArgs(
                                            phoneNumber: AppConstants
                                                .profileData.mobileNo
                                                .toString(),
                                            appBarTitle: 'otp_verification',
                                            requestOTP: true,
                                            otpType: 'txnlimit'))
                                    .then((value) {
                                  if (value is bool && value) {
                                    setState(() {
                                      _bloc.add(UpdateTxnLimitEvent(
                                          messageType: 'txnDetailsReq',
                                          channelType: 'MB',
                                          txnLimit: txnLimitList));
                                    }
                                        // expansionStates = expansionStates
                                        //     .map((e) => e == true ? false : e)
                                        //     .toList();
                                        // expansionStatesForContainer =
                                        //     expansionStatesForContainer
                                        //         .map((e) => e == true ? false : e)
                                        //         .toList();
                                        // expansionStatesForEdit =
                                        //     expansionStatesForEdit
                                        //         .map((e) => e == true ? false : e)
                                        //         .toList();
                                        );
                                  }
                                });
                              }),
                          16.verticalSpace,
                          AppButton(
                            buttonType: ButtonType.OUTLINEENABLED,
                            buttonColor: Colors.transparent,
                            buttonText:
                                AppLocalizations.of(context).translate("reset"),
                            onTapButton: () {
                              showAppDialog(
                                  title: AppLocalizations.of(context).translate("are_you_sure?"),
                                  message:
                                      AppLocalizations.of(context).translate("restore_the_limits_des"),
                                  alertType: AlertType.INFO,
                                  onPositiveCallback: () {
                                    _bloc.add(ResetTranLimitEvent(
                                      messageType: "txnDetailsReq",
                                    ));
                                  },
                                  positiveButtonText: "Yes",
                                  negativeButtonText: "NO",
                                  onNegativeCallback: () {});
                            },
                          ),
                          20.verticalSpace
                        ],
                      ),
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

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final numericValue = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');
    final formattedValue =
        NumberFormat('#,###.##').format(double.tryParse(numericValue) ?? 0);
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
