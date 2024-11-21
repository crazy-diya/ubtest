import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/dependency_injection.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/bloc/quick_access/quick_access_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/quick_access/quick_access_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/quick_access/quick_access_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/personalization_setting/data/quick_access_data.dart';
import 'package:union_bank_mobile/features/presentation/widgets/app_button.dart';
import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/app_sizer.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../utils/app_constants.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import 'widgets/quick_access_tile.dart';

class ManageQuickAccessMenuView extends BaseView {
  ManageQuickAccessMenuView({super.key});

  @override
  _ManageQuickAccessMenuViewState createState() =>
      _ManageQuickAccessMenuViewState();
}

class _ManageQuickAccessMenuViewState
    extends BaseViewState<ManageQuickAccessMenuView> {
  var bloc = injection<QuickAccessBloc>();

  List<QuickAccessData> currentList = [];
  List<QuickAccessData> addableList = [];


  double animateOpacity = 0;

  bool isEdit = false;

  @override
  void initState() {
    bloc.add(GetQuickAccessEvent());
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        checkQuickAccessWhenPop();
        return true;
      },
      child: Scaffold(
        backgroundColor: colors(context).primaryColor50,
        appBar: UBAppBar(
          title: AppLocalizations.of(context)
              .translate("manage_quick_access_menu"),
          onBackPressed: () {
            checkQuickAccessWhenPop();
          },
        ),
        body: BlocProvider<QuickAccessBloc>(
          create: (context) => bloc,
          child: BlocListener<QuickAccessBloc, BaseState<QuickAccessState>>(
            bloc: bloc,
            listener: (context, state) {
              if (state is QuickAccessLoadSuccessState) {
                if (state.quickAccessList != null) {
                  fixedQuickAccessTile().forEach((element) {
                    if (!state.quickAccessList!.contains(element.id)) {
                      addableList.add(element);
                    }
                  });
                  state.quickAccessList?.forEach(
                    (element) {
                      if (fixedQuickAccessTile().any((e) => e.id == element)) {
                        currentList.add(fixedQuickAccessTile()
                            .firstWhere((r) => r.id == element));
                      }
                    },
                  );
                  setState(() {});
                }
              } else if (state is QuickAccessLoadFailedState) {}

              if (state is QuickAccessAddSuccessState) {
                ToastUtils.showCustomToast(context,AppLocalizations.of(context)
                                            .translate("remove_quick_access_success_1"),ToastStatus.SUCCESS);
              } else if (state is QuickAccessAddFailedState) {}
              if (state is QuickAccessAddSuccessStateWhenPop) {
                Navigator.of(context).pop();
              } else if (state is QuickAccessAddFailedStateWhenPop) {}
            },
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20+AppSizer.getHomeIndicatorStatus(context)),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppSizer.verticalSpacing(24),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: colors(context).whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context).translate(
                                              "personalize_select_4_feature"),
                                          style: size18weight700.copyWith(
                                              color: colors(context).blackColor)),
                                      AppSizer.verticalSpacing(8),
                                      Text(
                                          AppLocalizations.of(context).translate(
                                              "personalization_instruction_1"),
                                          style: size16weight400.copyWith(
                                              color: colors(context).greyColor)),
                                    ],
                                  ),
                                ),
                              ),
                              AppSizer.verticalSpacing(16),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: colors(context).whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)
                                              .translate("favourites"),
                                          style: size18weight700.copyWith(
                                              color: colors(context).blackColor)),
                                      AppSizer.verticalSpacing(20),
                                      ReorderableListView.builder(
                                          proxyDecorator: (child, index, animation) {
                                            return Material(
                                              key: ValueKey(index),
                                              elevation: 10,
                                              color: Colors.transparent,
                                              child: child,
                                            );
                                          },
                                          buildDefaultDragHandles: false,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return QuickAccessTile(
                                              key: ValueKey(index),
                                              index: index,
                                              quickAccessData: currentList[index],
                                              isCurrent: true,
                                              isFirstItem: index ==0,
                                              isLastItem: index == (currentList.length -1),
                                              onTap: () {
                                                if(isEdit){
                                                final item =
                                                    currentList.removeAt(index);
                                                addableList.add(item);
                                                animateOpacity = 1.0;
                                                setState(() {});

                                                }
                                              },
                                            );
                                          },
                                          itemCount: currentList.length,
                                          onReorder: (oldIndex, newIndex) {
                                            if (newIndex > oldIndex) {
                                              newIndex = newIndex - 1;
                                            }
                                            final item =
                                                currentList.removeAt(oldIndex);
                                            currentList.insert(newIndex, item);
                      
                                            setState(() {});
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                      
                              if (isEdit)  AppSizer.verticalSpacing(16),
                              if (isEdit)
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: colors(context).whiteColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)
                                                .translate("other_actions"),
                                            style: size18weight700.copyWith(
                                                color: colors(context).blackColor)),
                                        AppSizer.verticalSpacing(8),
                                        Text(
                                          AppLocalizations.of(context).translate(
                                              "personalization_instruction_2"),
                                          style: size16weight400.copyWith(
                                              color: colors(context).greyColor),
                                        ),
                                        AppSizer.verticalSpacing(20),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                QuickAccessTile(
                                                  key: ValueKey(index),
                                                  index: index,
                                                  quickAccessData: addableList[index],
                                                  isCurrent: false,
                                                   isFirstItem: index ==0,
                                                  isLastItem: index == (addableList.length -1),
                                                  onTap: () {
                                                    if (currentList.length == 4) {
                                                      ToastUtils.showCustomToast(
                                                          context, AppLocalizations.of(context).translate("remove_quick_access_error_1"),
                                                          ToastStatus.ERROR);
                                                    } else {
                                                      final item = addableList.removeAt(index);
                                                      currentList.add(item);
                                                      setState(() {});
                                                      
                                                    }
                                                    
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                          itemCount: addableList.length,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          )),
                    ),
                    
                AppSizer.verticalSpacing(20),
                AppButton(
                    // buttonType:(_subjectController.text.isEmpty || _messageController.text.isEmpty || initialRecipient.isEmpty)? ButtonType.DISABLED: ButtonType.ENABLED,
                    buttonType:currentList.length == 4 ? ButtonType.PRIMARYENABLED:ButtonType.PRIMARYDISABLED,
                    buttonText: AppLocalizations.of(context).translate(isEdit? "save":"edit"),
                    onTapButton: () {
                        if (!isEdit) {
                          setState(() {
                            isEdit = true;
                          });
                        } else {
                          setState(() {
                            isEdit = false;
                          });
                          checkQuickAccess();
                        }
                      },
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void checkQuickAccess() {
    if (currentList.length != 4) {
      ToastUtils.showCustomToast(
          context,
          "${AppLocalizations.of(context).translate("remove_quick_access_error_part_1")} ${4 - currentList.length} ${AppLocalizations.of(context).translate("remove_quick_access_error_part_2")}",
          ToastStatus.ERROR);
    } else {
      bloc.add(AddQuickAccessEvent(ids: currentList.map((e) => e.id).toList()));
    }
  }

  void checkQuickAccessWhenPop() {
    if (currentList.length != 4) {
      ToastUtils.showCustomToast(
          context,
          "${AppLocalizations.of(context).translate("remove_quick_access_error_part_1")} ${4-currentList.length} ${AppLocalizations.of(context).translate("remove_quick_access_error_part_2")}",
          ToastStatus.ERROR);
    } else {
      bloc.add(AddQuickAccessEventWhenPop(ids: currentList.map((e) => e.id).toList()));
    }
  }

  List<QuickAccessData> fixedQuickAccessTile() => [
        QuickAccessData(
            id: "0",
            icon: PhosphorIcons.qrCode(PhosphorIconsStyle.bold),
            title: "qr_pay"),
        QuickAccessData(
            id: "1",
            icon: PhosphorIcons.arrowsLeftRight(PhosphorIconsStyle.bold),
            title: "transfers"),
        QuickAccessData(
            id: "2",
            icon:  PhosphorIcons.fileText(PhosphorIconsStyle.bold),
            title: 'bill_payments'),
        QuickAccessData(
            id: "3",
            icon:  PhosphorIcons.creditCard(PhosphorIconsStyle.bold),
            title: "my_cards"),
       
        QuickAccessData(
            id: "4",
            icon: PhosphorIcons.users(PhosphorIconsStyle.bold),
            title: "my_payees"),
        QuickAccessData(
            id: "5",
            icon: PhosphorIcons.shareFat(PhosphorIconsStyle.bold),
            title: "request_money"),
        QuickAccessData(
            id: "6",
            icon: PhosphorIcons.calculator(PhosphorIconsStyle.bold),
            title: "calculators"),
        QuickAccessData(
            id: "7",
            icon: PhosphorIcons.sealCheck(PhosphorIconsStyle.bold),
            title: "promotions"),
        QuickAccessData(
            id: "8",
            icon: PhosphorIcons.chartBar(PhosphorIconsStyle.bold),
            title: "rates"),
        QuickAccessData(
            id: "9",
            icon: PhosphorIcons.mapPinLine(PhosphorIconsStyle.bold),
            title: "locator"),
        QuickAccessData(
            id: "10",
            icon: PhosphorIcons.phone(PhosphorIconsStyle.bold),
            title: "contact_us"),
        QuickAccessData(
            id: "12",
            imageIcon: AppAssets.quickBillerManagement,
            title: 'billers'),
        QuickAccessData(
            id: "13",
            icon: PhosphorIcons.video(PhosphorIconsStyle.bold),
            title: "demo_tour"),
        QuickAccessData(
            id: "14",
            icon:  PhosphorIcons.info(PhosphorIconsStyle.bold),
            title: 'faq'),
        QuickAccessData(
          id: "15",
            icon:  PhosphorIcons.calendarBlank(PhosphorIconsStyle.bold),
          title: 'schedules'),
        QuickAccessData(
          id: "16",
            icon:  PhosphorIcons.keyboard(PhosphorIconsStyle.bold),
          title: 'cheque_status'),
        QuickAccessData(
          id: "17",
            icon:  PhosphorIcons.newspaper(PhosphorIconsStyle.bold),
          title: 'news'),
        QuickAccessData(
          id: "18",
            icon:  PhosphorIcons.trainSimple(PhosphorIconsStyle.bold),
          title: 'train_schedule'),
        // QuickAccessData(
        //   id: "19",
        //     icon:  PhosphorIcons.creditCard(PhosphorIconsStyle.bold),
        //   title: 'card_management'),
        QuickAccessData(
          id: "20",
          imageIcon: AppAssets.quickPayeeManagement,
          title: 'payee_management'),
        QuickAccessData(
          id: "21",
            icon:  PhosphorIcons.handTap(PhosphorIconsStyle.bold),
          title: 'manage_other_account'),
    if (AppConstants.IS_CURRENT_AVAILABLE == true)
      QuickAccessData(
          id: "22",
            icon:  PhosphorIcons.file(PhosphorIconsStyle.bold),
          title: 'float_request'),
    if (AppConstants.IS_CURRENT_AVAILABLE == true)
      QuickAccessData(
          id: "23",
            icon:  PhosphorIcons.headset(PhosphorIconsStyle.bold),
          title: 'service_request'),
      ];

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
// QuickAccess(
//     title: 'trainTickets',
//     icon: AppImages.ic_train,
//     onTap: () => Navigator.pushNamed(context, Routes.kTrainTicket),
//   ),
//   QuickAccess(
//     title: 'news',
//     icon: AppImages.ic_news,
//     onTap: () => Navigator.pushNamed(context, Routes.kNewsFeed),
//   ),
