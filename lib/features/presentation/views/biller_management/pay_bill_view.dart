import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/responses/get_biller_list_response.dart';
import '../../../domain/entities/response/biller_category_entity.dart';
import '../../../domain/entities/response/biller_entity.dart';
import '../../../domain/entities/response/charee_code_entity.dart';
import '../../../domain/entities/response/saved_biller_entity.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_event.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/appbar.dart';
import '../../widgets/text_fields/app_search_text_field.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';
import 'biller_management_bill_payment_billers_view.dart';
import '../bill_payment/widgets/pay_bills_component.dart';

class PayBillerData {
  String routeType;

  PayBillerData({required this.routeType});
}

class PayBillView extends BaseView {
  final PayBillerData payBillerData;

  PayBillView({required this.payBillerData});

  @override
  _PayBillViewState createState() => _PayBillViewState();
}

class _PayBillViewState extends BaseViewState<PayBillView> {
  var _bloc = injection<BillerManagementBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetBillerCategoryListEvent());
    // setState(() {
    //   savedBillers.clear();
    // });
  }

  List<BillerCategoryEntity> categoryList = [];
  List<BillerCategoryEntity> searchCategoryList = [];
  List<SavedBillerEntity> savedBillers = [];
  String message = '';
  final searchController = TextEditingController();

  initBillerData(List<BillerList> billerList) {
    savedBillers.addAll(
      billerList
          .map(
            (e) => SavedBillerEntity(
              id: e.id,
              nickName: e.nickName,
              //userId: e.userId,
              referenceNumber: e.referenceNumber,
              billerCategory: BillerCategoryEntity(
                  categoryName: e.categoryName,
                  categoryCode: e.categoryCode,
                  categoryId: e.categoryId),
              serviceProvider: BillerEntity(
                  billerId: e.serviceProviderId,
                  billerName: e.serviceProviderName,
                  billerCode: e.serviceProviderCode,
                  billerImage: e.imageUrl),
              chargeCodeEntity: ChargeCodeEntity(
                  chargeAmount: double.parse(e.serviceCharge as String),
                  chargeCode: e.categoryCode),
              isFavorite: e.isFavourite,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("bill_categories"),
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is GetBillerCategorySuccessState) {
              categoryList = state.billerCategoryList!
                  .where((biller) => biller.categoryName!
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase())).toSet()
                  .toList();
              searchCategoryList = categoryList;
              setState(() {});
            }
            if (state is GetBillerCategoryListFailedState) {
              ToastUtils.showCustomToast(context,
                  state.message ?? "Something Went Wrong", ToastStatus.FAIL);
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w,  0),
            child: Column(
              children: [
                24.verticalSpace,
                SearchTextField(
                  hintText: AppLocalizations.of(context).translate("search"),
                  isBorder: false,
                  onChange: (value) {
                    setState(() {
                      searchFromCat(message);
                    });
                  },
                ),
                24.verticalSpace,
                // Padding(
                //   padding: const EdgeInsets.only(left: 24, right: 24),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: <Widget>[
                //       Expanded(child: _buildTextField()),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.only(bottom: 20.h + AppSizer.getHomeIndicatorStatus(context)),
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8).r,
                          color: colors(context).whiteColor,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: searchCategoryList.length,
                                itemBuilder: (_, index) => Column(
                                  children: [
                                    PayBillsComponent(
                                      billerCategoryEntity:
                                          searchCategoryList[index],
                                      // onTap: () {
                                      //   Navigator.pushNamed(
                                      //       context, Routes.kBillPaymentBillersView,
                                      //       arguments: state.billerCategoryList![index]);
                                      // },
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            Routes
                                                .kBillerMnagementBillPaymentBillerView,
                                            arguments:
                                                BillerManagementViewArgs(
                                                    biller: categoryList[
                                                        index],
                                                    routeType: widget
                                                        .payBillerData
                                                        .routeType)
                                            //arguments: state.billerCategoryList![index]
                                            );
                                      },
                                    ),
                                    if (searchCategoryList.length - 1 !=
                                        index)
                                      Divider(
                                        thickness: 1,
                                        height: 0,
                                        color: colors(context).greyColor100,
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    String message = '';
    return LayoutBuilder(builder: (context, size) {
      final TextSpan text = TextSpan(
        text: searchController.text,
      );
      final TextPainter tp = TextPainter(
        text: text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
      );
      tp.layout(maxWidth: size.maxWidth);

      final int lines = (tp.size.height / tp.preferredLineHeight).ceil();
      const int maxLines = 1;

      return Scrollbar(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            // Hide the default border
            hintText: AppLocalizations.of(context).translate("search"),
            hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            suffixIcon: Icon(Icons.search, color: colors(context).blackColor),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
          scrollPhysics: const BouncingScrollPhysics(),
          controller: searchController,
          // maxLines: lines < maxLines ? null : maxLines,
          contextMenuBuilder: (context, editableTextState) {
            return SizedBox.shrink();
          },
          onChanged: (value) {
            message = value;
            setState(() {
              searchFromCat(message);
            });
          },

          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: colors(context).blackColor),
        ),
      );
    });
  }

  void searchFromCat(String message) {
    if (message.trim().isEmpty) {
      searchCategoryList = categoryList;
    } else {
      searchCategoryList = categoryList
          .where((element) => element.categoryName!
              .toLowerCase()
              .contains(message.toLowerCase())).toSet()
          .toList();
    }
    setState(() {});
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
