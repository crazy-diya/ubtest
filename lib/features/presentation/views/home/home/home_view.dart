import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/service/platform_services.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/error/messages.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/features/data/models/responses/city_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/portfolio_loan_details_response.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_event.dart';
import 'package:union_bank_mobile/features/presentation/bloc/base_state.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/home/home/components/new_user_demo_tour.dart';
import 'package:union_bank_mobile/features/presentation/views/home/home/data/home_quick_access_data.dart';
import 'package:union_bank_mobile/features/presentation/views/payee_manegement/payee_management_save_payee_view.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/Data/card_txn_details.dart';
import 'package:union_bank_mobile/features/presentation/views/portfolio/portfolio_view.dart';
import 'package:union_bank_mobile/features/presentation/views/transaction_history/widgets/transaction_history_component.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';
import 'package:union_bank_mobile/utils/app_extensions.dart';
import 'package:union_bank_mobile/utils/app_utils.dart';

import '../../../../../core/service/app_permission.dart';
import '../../../../../core/service/dependency_injection.dart';
import '../../../../../utils/app_assets.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/model/bank_icons.dart';
import '../../../../../utils/navigation_routes.dart';

import '../../../../data/models/responses/account_details_response_dtos.dart';
import '../../../../data/models/responses/card_management/card_list_response.dart';
import '../../../../data/models/responses/portfolio_lease_details_response.dart';
import '../../../../data/models/responses/portfolio_userfd_details_response.dart';
import '../../../../data/models/responses/promotions_response.dart' as promo;
import '../../../../data/models/responses/transcation_details_response.dart';
import '../../../../domain/entities/response/account_entity.dart';
import '../../../bloc/portfolio/portfolio_bloc.dart';
import '../../../bloc/portfolio/portfolio_event.dart';
import '../../../bloc/portfolio/portfolio_state.dart';
import '../../../widgets/rounded_avatar.dart';
import '../../../widgets/toast_widget/toast_widget.dart';
import '../../notifications/notifications_view.dart';
import '../../transaction_history/transaction_history_status_view.dart';
import 'components/home_card.dart';
import 'components/home_promotions.dart';
import 'components/notification_icon.dart';
import 'widgets/home_quick_access_tile.dart';

class HomeView extends BaseView {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseViewState<HomeView> {
  final portfolioBloc = injection<PortfolioBloc>();

  LocalDataSource localDataSource = injection<LocalDataSource>();

  bool isLoaded = false;
  String accountTotalAmount = '0';
  String ccTotalAmount = '0';

  List<AccountDetailsResponseDto>?  accountDatas = [];
  PortfolioUserFdDetailsResponse? fdDetails;
  PortfolioLoanDetailsResponse? loanDetails;
  PortfolioLeaseDetailsResponse? leaseDetails;
  CardListResponse? ccDetails;
  // TransactionDetailsResponse? transactionDetails;
  List<TxnDetailList> itemsList = [];

  double totalAccBalance = 0;
  double totalLseBalance = 0;
  double totalCCBalance = 0;
  double totalInvestmentBalance = 0;
  double totalLnBalance = 0;
  int? allNotificationCount;

  List<promo.PromotionList> promoData = [];

  bool isPromoLoaded = false;

  List<StackList> widgetList = [];

  // double menuCardPadding = 18.75.h;

  int timeFrame = 700;

  List<HomeQuickAccessData> homeQuickAccessDataList = [];

  String _termsData = '';
  int? _termID = 0;

  // List<BaseEvent> events = [GetLeaseDetailsEvent(),GetLoanDetailsEvent(),GetFDDetailsEvent(),GetCCDetailsEvent(),GetAccDetailsEvent()];

  @override
  void initState() {
    super.initState();
    checkProfileImage();
    initQuickAccessMenu();
    isNewDevice();
    portfolioBloc.add(GetHomeTransactionDetailsEvent(page: 0, size: 20));
    portfolioBloc.add(GetHomePromotionsEvent());
    portfolioBloc.add(GetLeaseDetailsEvent());
    portfolioBloc.add(GetLoanDetailsEvent());
    portfolioBloc.add(GetFDDetailsEvent());
    // portfolioBloc.add(GetCCDetailsEvent());
    portfolioBloc.add(GetCreditCardEvent());
    portfolioBloc.add(GetAccDetailsEvent());
    portfolioBloc.add(CountNotificationsForHomeEvent(
        readStatus: "all", notificationType: "ALL"));
  }

  void initQuickAccessMenu() {
    localDataSource.getQuickAccessList().forEach(
      (element) {
        if (fixedHomeQuickAccessTile().any((e) => e.id == element)) {
          homeQuickAccessDataList.add(
              fixedHomeQuickAccessTile().firstWhere((r) => r.id == element));
        }
      },
    );
  }

  void checkProfileImage() {
    if (localDataSource.hasProfileImageKey()) {
      if (!localDataSource.hasProfileImageByte() ||
          localDataSource.getProfileImageKey() !=
              AppConstants.profileData.profileImageKey) {
        portfolioBloc.add(GetProfileImageEvent(
            imageKey: AppConstants.profileData.profileImageKey ?? ""));
      } else {
        AppConstants.profileData.profileImage =
            localDataSource.getProfileImageByte();
      }
    }
  }

  void isNewDevice() {
    if (localDataSource.getNewDeviceState() == JustPayState.INIT.name) {
      portfolioBloc.add(GetJustpayInstrumentPortfolioEvent());
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: colors(context).primaryColor50,
      body: BlocProvider(
      create: (context) => portfolioBloc,
      child: BlocListener<PortfolioBloc, BaseState<PortfolioState>>(
        listener: (context, state) {
          if (state is JustPayHomeChallengeIdSuccessState) {
            log("JustPay Challenge Id Success");
            if (state.justPayChallengeIdResponse?.challengeId != null) {
              portfolioBloc.add(JustPayHomeSDKCreateIdentityEvent(
                  challengeId:
                      state.justPayChallengeIdResponse?.challengeId));
            }
          } else if (state is JustPayHomeSDKCreateIdentitySuccessState) {
            log("SDK SIGN");
            portfolioBloc.add(JustPayHomeSDKTCSignEvent(termAndCondition: _termsData));
          } else if (state is JustPayHomeSDKTCSignSuccessState) {
            log("API SIGN");
            portfolioBloc.add(JustPayHomeTCSignEvent( termAndCondition: state.justPayPayload?.data.toString()));
          } else if (state is JustPayHomeTCSignSuccessState) {
            portfolioBloc.add(HomeAcceptTermsEvent(
                termType: kJustPayTermType,
                acceptedDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                    .format(DateTime.now()),
                termId: _termID));
          } else if (state is JustPayHomeChallengeIdFailedState) {
            log("Challenge Id failed");
            ToastUtils.showCustomToast(
                context, state.message!, ToastStatus.FAIL);
          } else if (state is JustPayHomeTCSignFailedState) {
            log("JustPayTC failed");
            ToastUtils.showCustomToast(
                context, state.message!, ToastStatus.FAIL);
          } else if (state is JustPayHomeSDKTCSignFailedState) {
            log("JustPaySDKTC failed");
            ToastUtils.showCustomToast(
                context, state.message!, ToastStatus.FAIL);
          }
      if (state is JustpayTermsLoadedState) {
         setState(() {
          _termsData = state.termsData?.termBody != null
              ? state.termsData!.termBody!
              : '';
          _termID = state.termsData!.termId!;
          log(_termsData);
        });
        showAppDialog(
          alertType: AlertType.SUCCESS,
          title:  AppLocalizations.of(context).translate("accept_just_pay_terms_title"),
          dialogContentWidget: Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                     TextSpan(
                      text: AppLocalizations.of(context).translate("please_accept_just_pay_terms"),
                      style:
                           TextStyle(color: colors(context).blackColor), // Set the color you want
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate("review_just_pay_terms"),
                      style: TextStyle(color: colors(context).primaryColor),
                      // Set the color you want
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                            context,
                            Routes.kHomeJustPayTnCView,
                            arguments: _termsData,
                          ).then((value) {
                            if (value is bool && value) {}
                          });
                        },
                    ),
                    TextSpan(
                      text:AppLocalizations.of(context).translate("just_pay_click_here") ,
                      style:
                           TextStyle(color: colors(context).blackColor), // Set the color you want
                    ),
                  ],
                ),
              ),
            ],
          ),
          onPositiveCallback: () {
            _onRequestPermissionsResult();

          },
          positiveButtonText: AppLocalizations.of(context).translate("Accept"),
        );

      } else if (state is JustpayTermsSubmittedState) {
        localDataSource.setNewDeviceState(JustPayState.FINISH.name);
      }else if (state is JustpayTermsFailedState) {
        localDataSource.setNewDeviceState(JustPayState.INIT.name);
        ToastUtils.showCustomToast(
            context,
            state.message ?? AppLocalizations.of(context).translate("something_went_wrong"),
            ToastStatus.FAIL);
      }
      if (state is GetPaymentInstrumentPortfolioSuccessState) {
        if (state.getUserInstList !=null) {
        final value =  state.getUserInstList?.any((element) => element.bankCode != AppConstants.ubBankCode.toString());
        if (value == true) {
            portfolioBloc.add(GetHomeTermsEvent());
          }
        }
      } else if (state is GetPaymentInstrumentPortfolioFailedState) {
        ToastUtils.showCustomToast(
            context,
            state.message ?? AppLocalizations.of(context).translate("something_went_wrong"),
            ToastStatus.FAIL);
      }
      if (state is CountNotificationForHomeSuccessState) {
        setState(() {
          allNotificationCount = state.allNotificationCount;
        });
      } else if (state is CountNotificationForHomeFailedState) {
        ToastUtils.showCustomToast(
            context,
            state.message ?? AppLocalizations.of(context).translate("something_went_wrong"),
            ToastStatus.FAIL);
      }
      if (state is AccountDetailsSuccessState) {
        accountDatas = state.accDetails!.accountDetailsResponseDtos;
        accountDatas = accountDatas?.where((element) =>
                              (element.cfprcd?.toUpperCase().trim() != "SSHADOW")).toList();
        if (accountDatas!.length >=
                1) {
          accountDatas!
              .forEach((element) {
              totalAccBalance +=
                  double.parse(element.convertedActualBalance!);
          });
        }
        setState(() {
          AppConstants.totalAccountBalance = totalAccBalance;
          AppConstants.accountDetailsResponseDtos =
              accountDatas!;
        });
        if (accountDatas != null) {
          final isTrue =accountDatas!.length > 1;
          widgetList.add(StackList(
              widget: HomeCard(
                onTap: () => Navigator.pushNamed(
                    context, Routes.kPortfolioView,
                    arguments: PortfolioTypeArgs(
                        tabType: AccountType.ACCOUNTS)),
                currency: AppLocalizations.of(context) .translate("lkr"),
                amount: isTrue
                    ? totalAccBalance
                        .toString()
                        .withThousandSeparator()
                    : accountDatas![0]
                        .availableBalance!
                        .withThousandSeparator(),
                hintColor: colors(context).greyColor,
                accountType: AccountType.ACCOUNTS,
                amountOfAccounts: isTrue
                    ? accountDatas!.length
                    : 1,
                topMargin: 0, lastTile: false, firstTile: false,
              ),
              index: 4));
          setState(() {});
        }

        //Check Current Account Availability
        //TODO
        setState(() {
          AppConstants.IS_CURRENT_AVAILABLE = accountDatas
              ?.any((element) =>
          (element.accountType == "D"
          && element.status?.toUpperCase()=="ACTIVE"
          )) ?? false;

          if (AppConstants.IS_CURRENT_AVAILABLE) {
                  kActiveCurrentAccountList = state
                      .accDetails!.accountDetailsResponseDtos!
                      .where((element) => (element.accountType == "D"
                          && element.status?.toUpperCase()=="ACTIVE"

                          )).map((e) => CommonDropDownResponse(
                            id: e.hashCode,
                            code: e.accountNumber.toString(),
                            description: e.accountNumber,
                            key: e.accountNumber
                          )).toList();
                  kCurrentAccountList = accountDatas!.where
                    ((_element) => (_element.accountType == "D"
                      && _element.status?.toUpperCase()=="ACTIVE"
                  )).map((e) =>AccountEntity(
                    status: e.status,
                    instrumentId: e.instrumentId,
                    bankName: e.bankName,
                    bankCode: e.bankCode ?? AppConstants.ubBankCode.toString(),
                    accountNumber: e.accountNumber,
                    icon: bankIcons.firstWhere((element) =>
                      element.bankCode == (e.bankCode ?? AppConstants.ubBankCode.toString()),
                      orElse: () => BankIcon(),
                    ).icon,
                    nickName: e.nickName ?? "",
                    availableBalance: double.parse(e.availableBalance ?? "0.00"),
                    accountType: e.accountType,
                    isPrimary: true,
                  )).toList();
            }
              });
            }
      // else if (state is FDDetailsSuccessState) {}
      if (state is FDDetailsSuccessState) {
        if(state.portfolioUserFdDetailsResponse?.fdDetailsResponseDtoList?.length!=0)
        {
        if (state.portfolioUserFdDetailsResponse!.fdDetailsResponseDtoList != null &&
            state.portfolioUserFdDetailsResponse!.fdDetailsResponseDtoList!.length >= 1) {
          state.portfolioUserFdDetailsResponse!.fdDetailsResponseDtoList!
              .forEach((element) {
                  totalInvestmentBalance += double.parse(element.convertedActualBalance);
          });
        }
        setState(() {
          fdDetails = state.portfolioUserFdDetailsResponse;
          AppConstants.totalInvestmentBalance = totalInvestmentBalance;
          AppConstants.fdDetailsResponseDtoList = fdDetails!.fdDetailsResponseDtoList!;
        });
        if (fdDetails != null) {
          final isTrue =
              fdDetails!.fdDetailsResponseDtoList!.length > 1;
          widgetList.add(StackList(
              widget: HomeCard(
                onTap: () => Navigator.pushNamed(
                    context, Routes.kPortfolioView,
                    arguments: PortfolioTypeArgs(
                        tabType: AccountType.INVESTMENT)),
                currency: AppLocalizations.of(context) .translate("lkr"),
                amount: isTrue
                    ? totalInvestmentBalance
                        .toString()
                        .withThousandSeparator()
                    : fdDetails!.fdDetailsResponseDtoList![0].convertedActualBalance
                        .withThousandSeparator(),
                hintColor: colors(context).greyColor,
                accountType: AccountType.FIXED_DEPO,
                amountOfAccounts: isTrue
                    ? fdDetails!.fdDetailsResponseDtoList!.length
                    : 1,
                topMargin: 0, lastTile: false, firstTile: false,
              ),
              index: 2));
          setState(() {});
        }
        }
      } else if (state is LoanDetailsSuccessState) {
        if(state.portfolioLoanDetailsResponse?.loanDetailsResponseDtoList?.length!=0){

        
        if (state.portfolioLoanDetailsResponse!
                    .loanDetailsResponseDtoList!.length >=
                1) {
          state.portfolioLoanDetailsResponse!
              .loanDetailsResponseDtoList
              ?.forEach((element) {
                if(element.cfcurr == "LKR"){
                  totalLnBalance += (double.parse(element.outStandingBalance??"0") );
                }
          });
        }
        setState(() {
          loanDetails = state.portfolioLoanDetailsResponse;
          AppConstants.totalLoanBalance = double.parse(loanDetails?.totalOutStandingBalance.toString()??"0.00");
          AppConstants.loanDetailsResponseDtoList =
              loanDetails!.loanDetailsResponseDtoList!;
        });
        if (loanDetails != null) {
          final isTrue =
              loanDetails!.loanDetailsResponseDtoList!.length > 1;
          widgetList.add(StackList(
              widget: HomeCard(
                onTap: () => Navigator.pushNamed(
                    context, Routes.kPortfolioView,
                    arguments:
                        PortfolioTypeArgs(tabType: AccountType.LOAN)),
                currency: AppLocalizations.of(context) .translate("lkr"),
                amount: loanDetails!.totalOutStandingBalance
                        .toString()
                        .withThousandSeparator(),
                hintColor: colors(context).greyColor,
                accountType: AccountType.LOAN,
                amountOfAccounts: isTrue
                    ? loanDetails!.loanDetailsResponseDtoList!.length
                    : 1,
                topMargin: 0,lastTile: false, firstTile: false,
              ),
              index: 1));
          setState(() {});
        }
        }
      } else if (state is LeaseDetailsSuccessState) {
        if(state.portfolioLeaseDetailsResponse?.leaseDetailsResponseDtoList?.length != 0){

       
        if (state.portfolioLeaseDetailsResponse!
                    .leaseDetailsResponseDtoList!.length >=
                1) {
          state.portfolioLeaseDetailsResponse!
              .leaseDetailsResponseDtoList!
              .forEach((element) {
            totalLseBalance += double.parse(element.leaseAmount!);
          });
        }
        setState(() {
          leaseDetails = state.portfolioLeaseDetailsResponse;
          AppConstants.totalLeaseBalance = totalLseBalance;
          AppConstants.leaseDetailsResponseDtoList =
              leaseDetails!.leaseDetailsResponseDtoList!;
        });
        if (leaseDetails != null) {
          final isTrue =
              leaseDetails!.leaseDetailsResponseDtoList!.length > 1;
          widgetList.add(StackList(
              widget: HomeCard(
                onTap: () => Navigator.pushNamed(
                    context, Routes.kPortfolioView,
                    arguments: PortfolioTypeArgs(
                        tabType: AccountType.LEASE)),
                currency: AppLocalizations.of(context) .translate("lkr"),
                amount: isTrue
                    ? leaseDetails!.totalOutStandingBalance
                        .toString()
                        .withThousandSeparator()
                    : leaseDetails!
                        .leaseDetailsResponseDtoList![0].leaseAmount!
                        .withThousandSeparator(),
                hintColor: colors(context).greyColor,
                accountType: AccountType.LEASE,
                amountOfAccounts: isTrue
                    ? leaseDetails!
                        .leaseDetailsResponseDtoList!.length
                    : 0,
                topMargin: 0, lastTile: false, firstTile: false,
              ),
              index: 0));
          setState(() {});
        }
         }
      } else if (state is AccountDetailFailState) {
        ToastUtils.showCustomToast(
            context,
            state.errorMessage ?? AppLocalizations.of(context).translate("something_went_wrong"),
            ToastStatus.FAIL);
      } else if (state is HomeTransactionDetailsSuccessState) {
        setState(() {
          itemsList = state.txnDetailList ?? [];
        });
      } else if (state is HomePromotionsSuccessState) {
        setState(() {
          promoData.clear();
          promoData.addAll(state.promotions!);
          isPromoLoaded = true;
        });
      } else if (state is HomePromotionsFailedState) {
        ToastUtils.showCustomToast(
            context,
            state.message ?? AppLocalizations.of(context).translate("something_went_wrong"),
            ToastStatus.FAIL);
        // showAppDialog(
        //   alertType: AlertType.FAIL,
        //   title: ErrorHandler.TITLE_OOPS,
        //   message: state.message,
        //   onPositiveCallback: () {},
        // );
      } else if (state is GetProfileImageSuccessState) {
              if (state.retrieveProfileImageResponse?.imageKey != null) {
                localDataSource.setProfileImageKey(
                    state.retrieveProfileImageResponse!.imageKey!);

                AppConstants.profileData.profileImageKey =
                    state.retrieveProfileImageResponse!.imageKey!;
              }
              if (state.retrieveProfileImageResponse?.dataType != null) {
                localDataSource.setProfileImageByte(
                    "${state.retrieveProfileImageResponse?.dataType!},${state.retrieveProfileImageResponse!.image!}");
                 AppConstants.profileData.profileImage = AppUtils.decodeBase64(
                  "${state.retrieveProfileImageResponse?.dataType!},${state.retrieveProfileImageResponse!.image!}");
              }
             
              setState(() {});
      } else if (state is GetCreditCardSuccessState) {
        if(state.cardListResponse!=null){
        if (state.cardListResponse!.resPrimaryCardDetails!.length >= 1) {
          state.cardListResponse!.resPrimaryCardDetails!.forEach((element) {
            totalCCBalance += (double.parse(element.resCurrentOutstandingBalance??"0.00") );
          });
        }
        setState(() {
          ccDetails = state.cardListResponse;
          AppConstants.totalCardBalance = totalCCBalance;
          AppConstants.cardDetailsResponseDtoList = [
                  ...ccDetails!.resPrimaryCardDetails!
                      .map((e) => CardTxnDetails(
                          currentOutstandingBalance: e.resCurrentOutstandingBalance,
                          maskedPrimaryCardNumber:e.resMaskedPrimaryCardNumber,
                          cmsAccNo:e.resCmsAccNo,
                          minAmtDue:e.resMinAmtDue,
                          availableBalance:e.resAvailableBalance,
                          pymtDueDate:e.resPymtDueDate,
                          cardTypeWithDesc:e.resCardTypeWithDesc,
                          cardStatusWithDesc:e.resCardStatusWithDesc,
                          cashLimit:e.resCashLimit,
                          cardCustomerName:e.resCardCustName,
                          last5Txns: e.resLast5Txns,
                          creditLimit:e.resCreditLimit,
                          displayFlag: e.displayFlag,
                          currency: AppLocalizations.of(context).translate("lkr"),
                          isPrimary: true
                          ))
                      .toList(),
                  // ...ccDetails!.resAddonCardDetails!
                  //     .map((e) => CardTxnDetails(
                  //       maskedPrimaryCardNumber:e.resAddonMaskedCardNumber,
                  //       cmsAccNo:e.resCmsAccNo,
                  //       cardTypeWithDesc:e.resAddonCardTypeWithDesc,
                  //       cardStatusWithDesc:e.resAddonCardStatusWithDesc,
                  //       cashLimit:e.resAddonCashLimit,
                  //       cardCustomerName:e.resAddonCustomerName,
                  //       creditLimit:e.resAddonCreditLimit,
                  //       isPrimary: false))
                  //     .toList()
                ];
          AppConstants.cardDetailsResponseDtoList = AppConstants.cardDetailsResponseDtoList.where((element) => (element.displayFlag?.toUpperCase() == "Y")).toList();
        });
        if(AppConstants.cardDetailsResponseDtoList.length != 0){
          if (ccDetails != null) {
            final isTrue =  AppConstants.cardDetailsResponseDtoList.length > 1;
            widgetList.add(StackList(
                widget: HomeCard(
                  onTap: () => Navigator.pushNamed(
                      context, Routes.kPortfolioView,
                      arguments: PortfolioTypeArgs(
                          tabType: AccountType.CARDS)),
                  currency: AppLocalizations.of(context) .translate("lkr"),
                  amount: isTrue
                      ? AppConstants.totalCardBalance
                      .toString()
                      .withThousandSeparator()
                      : AppConstants.cardDetailsResponseDtoList[0]
                      .availableBalance
                      .toString()
                      .withThousandSeparator(),
                  hintColor: colors(context).greyColor,
                  accountType: AccountType.CARDS,
                  amountOfAccounts: isTrue
                      ? AppConstants.cardDetailsResponseDtoList.length
                      : 1,
                  topMargin: 0, lastTile: false, firstTile: false,
                ),
                index: 3));
            setState(() {});
          }
        }
      }
      }
        },
        child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
              child: Column(
        children: [
          Container(
            //Background Image
            padding: EdgeInsets.only(bottom: 0.h),
            decoration:  BoxDecoration(
              color:colors(context).primaryColor!,
              border: Border(bottom: BorderSide(width: 0.w,color: colors(context).primaryColor50!))
            ),
            child: Column(
              children: [
                //Top Profile View
                Padding(
                  padding:  EdgeInsets.fromLTRB(20.w, 64.h, 20.w,0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RoundedAvatarView(
                        backgroundColor: colors(context).whiteColor!,
                        forgroundColor: colors(context).secondaryColor100!,
                        isOnline: true,
                        image: AppConstants.profileData.profileImage,
                        name: AppConstants.profileData.cName??AppConstants.profileData.fName,
                        size: 20.w,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.kSettingPasswordView,
                              arguments: true);
                        },
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                                      "${AppLocalizations.of(context).translate("${greeting()}")}, ${(AppConstants.profileData.cName != null || AppConstants.profileData.cName != "") ? AppConstants.profileData.cName : AppConstants.profileData.fName ?? ""}!",
                                      style: size16weight700.copyWith(
                                          color: colors(context).whiteColor)),
                                ],
                              ),
                      ),
                      12.horizontalSpace,
                      NotificationIcon(
                        showIndicator: allNotificationCount == 0 ? false : true,
                        notificationCount: allNotificationCount ?? 0,
                        indicatorColor:
                            colors(context).secondaryColor!,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.kNotificationsView);
                        },
                      ),
                    ],
                  ),
                  ),
                //Card List
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20).w,
                //   child: Stack(
                //     children: [
                //       Container(
                //               decoration: BoxDecoration(
                //                 color: colors(context).whiteColor,
                //                 borderRadius: BorderRadius.circular(8).r,
                //               ),
                //               child: Stack(
                //                 children: [...sortList()],
                //               ),
                //             ),
                     
                //     ],
                //   ),
                // ),
                // menuCardPadding.verticalSpace,
                Column(
                  children: [
                    Padding( 
                     padding: EdgeInsets.only(top: 36).h,
                                 child: Column(
                                   children: [
                                     Stack(
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.symmetric(horizontal: 20).w,
                                           child: Container(
                                                   decoration: BoxDecoration(
                                                     color: colors(context).whiteColor,
                                                     borderRadius: BorderRadius.circular(8).r,
                                                   ),
                                                   child: Stack(
                                                     children: [...sortList()],
                                                   ),
                                                 ),
                                         ),
                                        
                                       ],
                                     ),
                                 if(sortList().isNotEmpty)16.verticalSpace,
                                     IntrinsicHeight(
                                       child: Stack(
                                         children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                               padding: const EdgeInsets.only(bottom: 47.37).h,
                                               child: Container(height: 8.w,width: double.infinity,color: colors(context).secondaryColor!),
                                             ),
                                          ),
                                           Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(height: 47.37.h,width: double.infinity,color:colors(context).primaryColor50),
                                          ),
                                           
                                           Padding(
                                             padding: const EdgeInsets.symmetric(horizontal: 20).w,
                                             child: Container(
                                               decoration: BoxDecoration(color: colors(context).whiteColor,borderRadius: BorderRadius.circular(8).r),
                                             
                                               child: Padding(
                                                 padding:  EdgeInsets.symmetric(horizontal: 39.5.w,vertical: 16.h),
                                                 child: Row(
                                                   mainAxisAlignment:
                                                       MainAxisAlignment.spaceAround,
                                                   children: [
                                                     ...List.generate(
                                                         homeQuickAccessDataList.length,
                                                         (index) => Expanded(
                                                               child: HomeQuickAccessTile(
                                                                 homeQuickAccessData:
                                                                     homeQuickAccessDataList[
                                                                         index],
                                                                 index: index,
                                                               ),
                                                             )),
                                                   ],
                                                 ),
                                               ),
                                             ),
                                           ),
                                           
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                  ],
                ),
              ],
            ),
          ),
          16.verticalSpace,
         localDataSource.getNewUserDemoTour() == true? Padding(
            padding:  EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
            child: NewUserDemoTour(),
          ):SizedBox.shrink(),
          isPromoLoaded
              ? promoData.isNotEmpty
                  ? Padding(
                    padding:  EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
                    child: HomePromotions(
                        promoData: promoData,
                      ),
                  )
                  : const SizedBox.shrink()
              : const SizedBox.shrink(),
          Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20).w,
            child: Container(
              decoration: BoxDecoration(
                color: colors(context).whiteColor,
                 borderRadius: BorderRadius.circular(8).r
              ),
              child: Padding(
                 padding:  EdgeInsets.only(left:  16.w,right: 16.w,top: 16.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            AppLocalizations.of(context)
                                .translate("recent_activities"),
                            style: size18weight700.copyWith(color:colors(context).blackColor)),
                      ],
                    ),
                    8.verticalSpace,
                    if (itemsList.isNotEmpty)
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: itemsList.length >= 5 ? 5 : itemsList.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context,
                                Routes.kTransactionHistoryStatusView,
                                arguments: TranArgs(
                                    tranItem: itemsList[index],
                                    txnType: itemsList[index].txnType!));
                          },
                          child: TransactionHistoryComponent(
                            isLastItem:(itemsList.length >= 5 ? 5 : itemsList.length) -1 == index,
                            txnType: itemsList[index].txnType,
                            title:itemsList[index].txnType??"",
                            data: itemsList[index].amount.toString(),
                            subData: itemsList[index].modifiedDate!,
                            isCR: itemsList[index].crDr!,
                            logo: itemsList[index].billProviderLogo,
                            txnDescription: itemsList[index].txnDescription,
                          ),
                        );
                      },
                    )
                  else
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           40.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                color: colors(context)
                                    .secondaryColor300,
                                shape: BoxShape.circle),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(14).w,
                              child: PhosphorIcon(
                                PhosphorIcons.article(
                                    PhosphorIconsStyle.bold),size: 28.w,
                                color:
                                    colors(context).whiteColor,
                              ),
                            ),
                          ),
                          16.verticalSpace,
                          Text(
                            AppLocalizations.of(context)
                                .translate(
                                    'no_recent_activities_title'),
                            style: size18weight700.copyWith(
                                color:
                                    colors(context).blackColor),
                          ),
                          4.verticalSpace,
                          Text(
                            AppLocalizations.of(context)
                                .translate(
                                    'no_recent_activities_description'),
                            style: size14weight400.copyWith(
                                color:
                                    colors(context).greyColor),
                          ),
                          40.verticalSpace
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
           20.verticalSpace,
        ],
              ),
        ),
      ),
      ),
    );
  }

  _onRequestPermissionsResult() {
    AppPermissionManager.requestReadPhoneStatePermission(context, () async {
      showProgressBar();
      if (await PlatformServices.isJustPayIdentityExists()) {
        // log("SDK SIGN");
        portfolioBloc.add(JustPayHomeSDKTCSignEvent(termAndCondition: _termsData));
      } else {

        try {
          String data = await PlatformServices.getJustPayDeviceId();
          if (data.isNotEmpty && data != "ERR_DID") {
            //  hideProgressBar();
            portfolioBloc.add(JustPayHomeChallengeIdEvent(
              isOnboarded: true,
                challengeReqDeviceId: data));
          } else {
             hideProgressBar();
            ToastUtils.showCustomToast(
                context, AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED), ToastStatus.FAIL);
          }
        } catch (e) {
          hideProgressBar();
          ToastUtils.showCustomToast(
              context, AppLocalizations.of(context).translate(ErrorHandler.TITLE_FAILED), ToastStatus.FAIL);
        }
      }
    });
  }

  List<HomeQuickAccessData> fixedHomeQuickAccessTile() => [
        HomeQuickAccessData(
            id: "0",
            icon:  PhosphorIcons.qrCode(PhosphorIconsStyle.bold),
            title: "qr_pay",
            onTap: () {
              AppPermissionManager.requestCameraPermission(context, () {
                Navigator.pushNamed(
                  context,
                  Routes.kScanQRCodeView,arguments: Routes.kHomeBaseView
                );
              });
            }),
        HomeQuickAccessData(
            id: "1",
            icon: PhosphorIcons.arrowsLeftRight(PhosphorIconsStyle.bold),
            title: "transfers",
            onTap: () {
              Navigator.pushNamed(context, Routes.kFundTransferNewView,
                  arguments: RequestMoneyValues(
                    route: Routes.kHomeBaseView
                  ));
            }),
        HomeQuickAccessData(
            id: "2",
            icon: PhosphorIcons.fileText(PhosphorIconsStyle.bold),
            title: "bill_payments",
            onTap: () {
              Navigator.pushNamed(context, Routes.kPayBillsMenuView,
                  arguments: Routes.kHomeBaseView);
            }),
      HomeQuickAccessData(
        id: "3",
        icon: PhosphorIcons.creditCard(PhosphorIconsStyle.bold),
        title: "my_cards",
        onTap: () {
          Navigator.pushNamed(
              context, Routes.kCreditCardManagementView , arguments:  Routes.kHomeBaseView);
        }),
        HomeQuickAccessData(
            id: "4",
            icon: PhosphorIcons.users(PhosphorIconsStyle.bold),
            title: "my_payees",
            onTap: () {
              Navigator.pushNamed(
                  context, Routes.kPayeeManagementSavedPayeeView,
                  arguments: PayeeManagementSavedPayeeViewArgs(
                      isFromFundTransfer: false));
            }),
        HomeQuickAccessData(
            id: "5",
            icon: PhosphorIcons.shareFat(PhosphorIconsStyle.bold),
            title: "request_money",
            onTap: () {
              Navigator.pushNamed(context, Routes.kRequestMoneyView);
            }),
        HomeQuickAccessData(
            id: "6",
            icon:PhosphorIcons.calculator(PhosphorIconsStyle.bold),
            title: "calculators",
            onTap: () {
              Navigator.pushNamed(context, Routes.kCalculatorsView,arguments: false);
            }),
        HomeQuickAccessData(
            id: "7",
            icon: PhosphorIcons.sealCheck(PhosphorIconsStyle.bold),
            title: "promotions",
            onTap: () {
              Navigator.pushNamed(context, Routes.kPromotionsOffersView,arguments:false);
            }),
        HomeQuickAccessData(
            id: "8",
            icon: PhosphorIcons.chartBar(PhosphorIconsStyle.bold),
            title: "rates",
            onTap: () {
              Navigator.pushNamed(context, Routes.kRatesView);
            }),
        HomeQuickAccessData(
            id: "9",
            icon: PhosphorIcons.mapPinLine(PhosphorIconsStyle.bold),
            title: "locator",
            onTap: () {
              Navigator.pushNamed(context, Routes.kMapLocatorView);
            }),
        HomeQuickAccessData(
            id: "10",
            icon: PhosphorIcons.phone(PhosphorIconsStyle.bold),
            title: "contact_us",
            onTap: () {
              Navigator.pushNamed(context, Routes.kContactUsView);
            }),
        HomeQuickAccessData(
            id: "12",
            imageIcon: AppAssets.quickBillerManagement,
            title: "billers",
            onTap: () {
              Navigator.pushNamed(context, Routes.kBillersView,arguments:  Routes.kHomeBaseView);
            }),
        HomeQuickAccessData(
            id: "13",
            icon: PhosphorIcons.video(PhosphorIconsStyle.bold),
            title: "demo_tour",
            onTap: () {
              Navigator.pushNamed(context, Routes.kDemoTourView);
            }),
        HomeQuickAccessData(
            icon: PhosphorIcons.info(PhosphorIconsStyle.bold),
            id: "14",
            title: "faq",
            onTap: () {
              Navigator.pushNamed(context, Routes.kFAQView);
            }),
        HomeQuickAccessData(
            id: "15",
            icon: PhosphorIcons.calendarBlank(PhosphorIconsStyle.bold),
            title: "schedules",
            onTap: () {
              Navigator.pushNamed(context, Routes.kScheduleCategoryListView);
            }),
        HomeQuickAccessData(
            id: "16",
            icon: PhosphorIcons.keyboard(PhosphorIconsStyle.bold),
            title: "cheque_status",
            onTap: () {
              Navigator.pushNamed(context, Routes.kChequeStatusView);
            }),
        HomeQuickAccessData(
            id: "17",
            icon: PhosphorIcons.newspaper(PhosphorIconsStyle.bold),
            title: "news",
            onTap: () {
              Navigator.pushNamed(context, Routes.kNewsFeed);
            }),
        HomeQuickAccessData(
            id: "18",
            icon: PhosphorIcons.trainSimple(PhosphorIconsStyle.bold),
            title: "train_schedule",
            onTap: () {
              Navigator.pushNamed(context, Routes.kTrainTicket);
            }),
        // HomeQuickAccessData(
        //     id: "19",
        //     icon: PhosphorIcons.creditCard(PhosphorIconsStyle.bold),
        //     title: "card_management",
        //     onTap: () {
        //       Navigator.pushNamed(context, Routes.kCreditCardManagementView,
        //           arguments: Routes.kHomeBaseView);
        //     }),
        HomeQuickAccessData(
            id: "20",
            imageIcon: AppAssets.quickPayeeManagement,
            title: "payee_management",
            onTap: () {
              Navigator.pushNamed(
                  context, Routes.kPayeeManagementSavedPayeeView,
                  arguments:
                  PayeeManagementSavedPayeeViewArgs(isFromFundTransfer: false));
            }),
        HomeQuickAccessData(
            id: "21",
            icon: PhosphorIcons.handTap(PhosphorIconsStyle.bold),
            title: "manage_other_account",
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.kMainOtherBankView,
              );
            }),
    if (AppConstants.IS_CURRENT_AVAILABLE == true)
      HomeQuickAccessData(
            id: "22",
            icon: PhosphorIcons.file(PhosphorIconsStyle.bold),
            title: "float_request",
            onTap: () {
              Navigator.pushNamed(context, Routes.kFloatInquiryView);
            }),
    if (AppConstants.IS_CURRENT_AVAILABLE == true)
      HomeQuickAccessData(
            id: "23",
            icon: PhosphorIcons.headset(PhosphorIconsStyle.bold),
            title: "service_request",
            onTap: () {
              Navigator.pushNamed(context, Routes.kSeviceReqCategoryView);
            }),
      ];

  List<Widget> sortList() {
    final sortList = widgetList
      ..sort((a, b) => b.index.compareTo(a.index))
      ..toList();
    final finalList = List.generate(
        sortList.length,
        (index) => HomeCard(
                onTap: sortList[index].widget.onTap,
                currency: sortList[index].widget.currency,
                amount: sortList[index].widget.amount,
                topMargin: index * 64,
                hintColor: sortList[index].widget.hintColor,
                accountType: sortList[index].widget.accountType,
                amountOfAccounts: sortList[index].widget.amountOfAccounts, 
                lastTile: (sortList.length -1) == index ?true:false,
                 firstTile: index == 0?true:false,
                
                ));

    // Timer(const Duration(seconds: 0), () {
    //   setState(() {
    //     menuCardPadding = ((finalList.length * 64)+64.63);
    //     // menuCardPadding = ((finalList.length * 7.4.h) + 18.75.h+(finalList.length==0? 0: 16));
    //   });
    // });
    return finalList;
  }

  // Color? getCardColor(int index) {
  //   if (index == 0) {
  //     return colors(context).positiveColor;
  //   } else if (index == 1) {
  //     return colors(context).positiveColor300;
  //   } else if (index == 2) {
  //     return colors(context).positiveColor200;
  //   } else if (index == 3) {
  //     return colors(context).positiveColor100;
  //   } else {
  //     return colors(context).secondaryColor300;
  //   }
  // }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return portfolioBloc;
  }
}

class StackList {
  HomeCard widget;
  int index;

  StackList({
    required this.widget,
    required this.index,
  });
}
