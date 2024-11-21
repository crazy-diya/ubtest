import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/data/models/responses/account_statements_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/float_inquiry_response.dart';
import 'package:union_bank_mobile/features/data/repository/repository_impl.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/float_inquiry/float_inquiry_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/float_inquiry/float_inquiry_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/float_inquiry/float_inquiry_state.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/enums.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/navigation_routes.dart';

import '../../../data/models/responses/city_response.dart';
import '../../widgets/app_button.dart';
import '../../widgets/appbar.dart';
import '../../widgets/carousel_widget/app_carousel_widget.dart';
import '../base_view.dart';
import 'float_inquary_details_view.dart';


class FloatInquiryView extends BaseView {

  @override
  _FloatInquiryViewState createState() => _FloatInquiryViewState();
}

class _FloatInquiryViewState extends BaseViewState<FloatInquiryView> {
  var bloc = injection<FloatInquiryBloc>();
  final _formKey = GlobalKey<FormState>();
  CommonDropDownResponse? dropDownValue;
  bool isButtonClicked = false;
  bool isFloatStatusAvailable = false;
  CarouselSliderController carouselController1 = CarouselSliderController();
  int? currentIndex = 0;
  String? accountNo;

  List<String> tabs = [
    "today_float",
    "realize_today",
  ];
  int current = 0;

  List<CommonDropDownResponse>? itemList; 

  List<FloatInquiryCbsResponseList>?  todayInFloats = [];
  List<FloatInquiryCbsResponseList>?  realizeByTodays = [];

  

  @override
  void initState() {
    itemList = [
      // CommonDropDownResponse(
      //     id: 00001234, code: "All", description: "All", key: "All"),
      ...kActiveCurrentAccountList
    ];
    if(kActiveCurrentAccountList.length==1){
      dropDownValue =kActiveCurrentAccountList.first;
    }
    accountNo = kCurrentAccountList[0].accountNumber;
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("float_inquiry"),
        goBackEnabled: true,
      ),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<FloatInquiryBloc, BaseState<FloatInquiryState>>(
          bloc: bloc,
          listener: (context, state) {
            if(state is FloatInquirySuccessState){
              state.floatInquiryResponse?.floatInquiryCbsResponseList?.forEach((element) { 
                // if(element.cicdt6 == DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)){
                if(element.cistat == "In-Process"){
                  todayInFloats?.add(element);
                }
                if(element.cistat == "In-Process" && element.cicdt6 == DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)){
                   realizeByTodays?.add(element);
                }
              });
              if(state.floatInquiryResponse?.floatInquiryCbsResponseList!=0){
                isFloatStatusAvailable =true;
              }else{
              isButtonClicked =false;
              }
              Navigator.pushNamed(context, Routes.kFloatInquiryDetailsView, arguments: FloatInqArgs(
                  todayInFloats: todayInFloats ?? [],
                  realizeByTodays: realizeByTodays ?? []
              ));
              setState((){});
            }
            if(state is FloatInquiryFailState){
               ToastUtils.showCustomToast(context, state.message??"", ToastStatus.FAIL);
              isButtonClicked =false;
              setState(() {});

            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,20.h + AppSizer.getHomeIndicatorStatus(context)),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            AppLocalizations.of(context).translate("select_account"),
                            textAlign: TextAlign.start,
                            style: size14weight700.copyWith(color: colors(context).blackColor)),
                        16.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(8).r,
                            color: colors(context).whiteColor,
                          ),
                          child: AppCarouselWidget(
                              carouselController: carouselController1,
                              accountList: kCurrentAccountList,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                  accountNo = kCurrentAccountList[index].accountNumber;
                                });
                                // if (currentIndex == index) {
                                //   carauselValue.fillRange(0, carauselValue.length, false); // Set all items to false.
                                //   if (index >= 0 && index < carauselValue.length) {
                                //     carauselValue[index] = true; // Set the specified index to true.
                                //   }
                                // }
                              }),
                        ),
                      ],
                    ),
                  ),
                  // AppDropDown(
                  //       validator: (value){
                  //         if(dropDownValue == null || dropDownValue == ""){
                  //           return AppLocalizations.of(context).translate("mandatory_field_msg_selection");
                  //         }else{
                  //           return null;
                  //         }
                  //       },
                  //       isDisable: false,
                  //       labelText: AppLocalizations.of(context)
                  //           .translate("account"),
                  //       onTap: () {
                  //         Navigator.pushNamed(context, Routes.kDropDownView,
                  //             arguments: DropDownViewScreenArgs(
                  //               itemList: itemList,
                  //               isSearchable: true,
                  //               isAnEvent: false,
                  //               pageTitle: AppLocalizations.of(context)
                  //                   .translate("account"),
                  //             )).then((value) {
                  //           if (value != null &&
                  //               value is CommonDropDownResponse) {
                  //             setState(() {
                  //               dropDownValue = value;
                  //               isButtonClicked = false;
                  //             });
                  //           }
                  //         });
                  //       },
                  //       initialValue: dropDownValue?.description,
                  //     ),
                  // Expanded(
                  //   child: Column(
                  //     children: [
                  //       // SizedBox(height: 2.h,),
                  //       isFloatStatusAvailable ?
                  //           SingleChildScrollView(
                  //             scrollDirection: Axis.horizontal,
                  //             child: Padding(
                  //               padding: const EdgeInsets.symmetric(vertical: 25),
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                 children: [
                  //                   for (int index = 0; index < tabs.length; index++)
                  //                     GestureDetector(
                  //                       onTap: () {
                  //                         setState(() {
                  //                           current = index;
                  //                         });
                  //                       },
                  //                       child: Container(
                  //                         margin: const EdgeInsets.only(right: 20),
                  //                         padding: const EdgeInsets.symmetric(
                  //                           horizontal: 20,
                  //                           vertical: 10,
                  //                         ),
                  //                         decoration: BoxDecoration(
                  //                           borderRadius: BorderRadius.circular(8),
                  //                           color: index == current
                  //                               ? colors(context).greyColor300
                  //                               : Colors.transparent,
                  //                         ),
                  //                         child: Text(
                  //                           AppLocalizations.of(context).translate(tabs[index]),
                  //                           style: TextStyle(
                  //                             fontSize: 16,
                  //                             fontWeight: FontWeight.w500,
                  //                             color: index == current
                  //                                 ? colors(context).whiteColor
                  //                                 : colors(context).blackColor,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ):
                  //       Padding(
                  //         padding:  EdgeInsets.only(top: 10.h),
                  //         child: Column(
                  //           children: [
                  //             // Image.asset(
                  //             //   AppAssets.icCsiEmpty,
                  //             //   scale: 3,
                  //             //   width: 40.w,
                  //             // ),
                  //             Text(
                  //               AppLocalizations.of(context).translate("csi_no_record_des"),
                  //               style: TextStyle(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.w600,
                  //                 color: colors(context).greyColor200,
                  //               ),
                  //               textAlign: TextAlign.center,
                  //             ),
                  //             SizedBox(
                  //               height: 2.h,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       if(isFloatStatusAvailable)  Expanded(
                  //               child: current == 0 ?
                  //               ListView.builder(
                  //                   shrinkWrap: true,
                  //                   scrollDirection: Axis.vertical,
                  //                   physics: const BouncingScrollPhysics(),
                  //                   padding: const EdgeInsets.only(
                  //                     bottom: 8,
                  //                     top: 8,
                  //                   ),
                  //                   itemCount: todayInFloats?.length,
                  //                   itemBuilder: (context, int index) {
                  //                    final todayInFloat = todayInFloats?[index];
                  //                     return FIDataComponent(
                  //                       fiData: FIData(
                  //                         chequeNumber: todayInFloat?.cicnum,
                  //                         status: todayInFloat?.cistat,
                  //                         type: todayInFloat?.citype,
                  //                         dateRecieved: DateFormat('dd MMMM yyyy').format(todayInFloat!.circv6!),
                  //                         amount: todayInFloat.ciamt,
                  //                       ),
                  //                     );
                  //                   }) :
                  //               current == 1 ?
                  //               ListView.builder(
                  //                   shrinkWrap: true,
                  //                   scrollDirection: Axis.vertical,
                  //                   physics: const BouncingScrollPhysics(),
                  //                   padding: const EdgeInsets.only(
                  //                     bottom: 8,
                  //                     top: 8,
                  //                   ),
                  //                   itemCount: realizeByTodays?.length,
                  //                   itemBuilder: (context, int index) {
                  //                     final realizeByToday = realizeByTodays?[index];
                  //                     return FIDataComponent(
                  //                       fiData: FIData(
                  //                        chequeNumber: realizeByToday?.cicnum,
                  //                         status: realizeByToday?.cistat,
                  //                         type: realizeByToday?.citype,
                  //                         dateRecieved: DateFormat('dd MMMM yyyy').format(realizeByToday!.circv6!),
                  //                         amount: realizeByToday.ciamt,
                  //                       ),
                  //                     );
                  //                   }) : const SizedBox.shrink(),
                  //           ),
                  //
                  //     ],
                  //   ),
                  // ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: AppButton(
                            buttonText: AppLocalizations.of(context).translate("continue"),
                            onTapButton: () {
                              if(_formKey.currentState?.validate() == false){
                                return;
                              } else {
                                isButtonClicked = true;
                                bloc.add(
                                    FloatInquiryGetEvent(
                                        checkAllAccount: false,
                                        accountType: "D",
                                        accountNo: accountNo));
                                setState(() {});
                              }
                            }
                        ),
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
    return bloc;
  }
}