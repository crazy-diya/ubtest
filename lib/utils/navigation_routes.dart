import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:union_bank_mobile/features/data/models/responses/promotions_response.dart';
import 'package:union_bank_mobile/features/domain/entities/request/card_management/loyalty_points/card_details_entity.dart';
import 'package:union_bank_mobile/features/presentation/views/add_biometrics_view/add_biometrics_view.dart';
import 'package:union_bank_mobile/features/presentation/views/credit_card_management/credit_card_payment/data/credit_card_payment_args.dart';
import 'package:union_bank_mobile/features/presentation/views/deeplinking/security_question_reset/sequrity_question_reset_view.dart';
import 'package:union_bank_mobile/features/presentation/views/demo_tour/demo_tour_view.dart';
import 'package:union_bank_mobile/features/presentation/views/force_update/force_update.dart';
import 'package:union_bank_mobile/features/presentation/views/forgot_password/data/forgot_password_security_questions_verify_data.dart';
import 'package:union_bank_mobile/features/presentation/views/forgot_password/forgot_password_reset_methods.dart';
import 'package:union_bank_mobile/features/presentation/views/forgot_password/forgot_password_reset_using_username.dart';
import 'package:union_bank_mobile/features/presentation/views/forgot_password/forgot_password_security_questions.dart';
import 'package:union_bank_mobile/features/presentation/views/forgot_password/forgot_password_security_questions_verify.dart';
import 'package:union_bank_mobile/features/presentation/views/home/home/justpay_home_tc.dart';
import 'package:union_bank_mobile/features/presentation/views/home/home_base_view.dart';
import 'package:union_bank_mobile/features/presentation/views/home/mailbox/mailbox.dart';
import 'package:union_bank_mobile/features/presentation/views/home/settings_view/setting_password_view.dart';
import 'package:union_bank_mobile/features/presentation/views/home/settings_view/security/change_passworrd_view.dart';
import 'package:union_bank_mobile/features/presentation/views/home/settings_view/security/security_settings_view.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/data/mail_data.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/mailbox_new_message.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/mailbox_otp_view.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/mailbox_preview.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/mailbox_reply_mail.dart';
import 'package:union_bank_mobile/features/presentation/views/mailbox/mailbox_view.dart';
import 'package:union_bank_mobile/features/presentation/views/migrate_user/add_security_question/add_security_question.dart';
import 'package:union_bank_mobile/features/presentation/views/migrate_user/migrate_user_state/migrate_user_state.dart';
import 'package:union_bank_mobile/features/presentation/views/migrate_user/reset_password/reset_password.dart';
import 'package:union_bank_mobile/features/presentation/views/migrate_user/terms_and_condition/migrate_user_terms_and_conditions_view.dart';
import 'package:union_bank_mobile/features/presentation/views/notifications/widget/notice_view.dart';
import 'package:union_bank_mobile/features/presentation/views/personalization_setting/manage_quick_access_menu_view.dart';
import 'package:union_bank_mobile/features/presentation/views/personalization_setting/personalization_settings_view.dart';
import 'package:union_bank_mobile/features/presentation/views/map/map_locator.dart';
import 'package:union_bank_mobile/features/presentation/views/request_call_back/data/request_call_back_data.dart';

import 'package:union_bank_mobile/features/presentation/views/splash_view/splash_view.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/document_data.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/save_and_exits_data.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/data/user_data.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/justpay_onboarding/document_verification_other_bank_view.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/justpay_onboarding/document_view.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/justpay_onboarding/just_pay_other_bank_register_details.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/justpay_onboarding/just_pay_user_schedule_for_verification_view.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/justpay_onboarding/justpay_onboarding_otp.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/justpay_onboarding/justpay_terms_and_conditions_view.dart';
import 'package:union_bank_mobile/features/presentation/views/user_onboarding/ub_account_onboarding/ub_register_debit_card_details_view.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../features/data/models/responses/card_management/card_list_response.dart';
import '../features/domain/entities/request/card_management/loyalty_points/select_voucher_entity.dart';
import '../features/domain/entities/response/saved_payee_entity.dart';
import '../features/presentation/views/Manage_Payment_Intruments/add_manage_other_bank_view.dart';
import '../features/presentation/views/Manage_Payment_Intruments/edit_manage_other_bank_view.dart';
import '../features/presentation/views/Manage_Payment_Intruments/edit_union_bank_account.dart';
import '../features/presentation/views/Manage_Payment_Intruments/main_manage_other_bank_view.dart';
import '../features/presentation/views/Manage_Payment_Intruments/manage_other_bank_details.dart';

import '../features/presentation/views/Manage_Payment_Intruments/manage_other_bank_terms.dart';
import '../features/presentation/views/Manage_Payment_Intruments/otherBank_otp_view.dart';
import '../features/presentation/views/bbc_cnn_NewsFeed/news_feed.dart';
import '../features/presentation/views/bill_payment/bill_payment_summary_view.dart';
import '../features/presentation/views/biller_management/add_biller_view.dart';
import '../features/presentation/views/bill_payment/save_biller.dart';
import '../features/presentation/views/bill_payment/bill_payment_billers_view.dart';
import '../features/presentation/views/biller_management/add_biller_confirm_view.dart';
import '../features/presentation/views/bill_payment/bill_payment_fail.dart';
import '../features/presentation/views/bill_payment/bill_payment_process_view.dart';
import '../features/presentation/views/bill_payment/pay_bills_menu_view.dart';
import '../features/presentation/views/biller_management/billers_view.dart';
import '../features/presentation/views/biller_management/data/add_biller_args.dart';
import '../features/presentation/views/biller_management/edit_biller_confirm_view.dart';
import '../features/presentation/views/biller_management/edit_biller_view.dart';
import '../features/presentation/views/biller_management/more_details_add_biller_view.dart';
import '../features/presentation/views/biller_management/pay_bill_view.dart';
import '../features/presentation/views/biller_management/biller_management_bill_payment_billers_view.dart';
import '../features/presentation/views/bill_payment/bill_payment_sucess.dart';
import '../features/presentation/views/calculators/fixed_deposit_calculator/apply_fixed_deposit.dart';
import '../features/presentation/views/calculators/fixed_deposit_calculator/fd_interest_rate_view.dart';
import '../features/presentation/views/calculators/fixed_deposit_calculator/fixed_deposit_calculator.dart';
import '../features/presentation/views/calculators/housing_loan_calculator/apply_housing_loan.dart';
import '../features/presentation/views/calculators/housing_loan_calculator/housing_loan_calculator.dart';
import '../features/presentation/views/calculators/leasing_calculator/apply_for_leasing.dart';
import '../features/presentation/views/calculators/leasing_calculator/leasing_calculator_view.dart';
import '../features/presentation/views/calculators/leasing_calculator/personal_information_view.dart';
import '../features/presentation/views/calculators/personal_loan_calculator/apply_personal_loan.dart';
import '../features/presentation/views/calculators/calculators.dart';
import '../features/presentation/views/calculators/personal_loan_calculator/personal_loan_calculator.dart';
import '../features/presentation/views/cheque_status_inquiry/cheque_status_summary_view.dart';
import '../features/presentation/views/cheque_status_inquiry/cheque_status_view.dart';
import '../features/presentation/views/cheque_status_inquiry/widgets/csi_data_component.dart';
import '../features/presentation/views/credit_card_management/credit_card_details/credit_card_details_view.dart';
import '../features/presentation/views/credit_card_management/credit_card_management_category_list_view.dart';
import '../features/presentation/views/credit_card_management/credit_card_payment/credit_card_payment_category_view.dart';
import '../features/presentation/views/credit_card_management/credit_card_payment/credit_card_payment_failed_view.dart';
import '../features/presentation/views/credit_card_management/credit_card_payment/credit_card_payment_success_view.dart';
import '../features/presentation/views/credit_card_management/credit_card_payment/credit_card_payment_summary_view.dart';
import '../features/presentation/views/credit_card_management/credit_card_payment/credit_card_payment_view.dart';
import '../features/presentation/views/credit_card_management/credit_card_payment/data/select_credit_card_view_args.dart';
import '../features/presentation/views/credit_card_management/credit_card_payment/select_credit_card_view.dart';
import '../features/presentation/views/credit_card_management/manage_loayalty_point/loyalty_management_view.dart';
import '../features/presentation/views/credit_card_management/manage_loayalty_point/redeem_points_view.dart';
import '../features/presentation/views/credit_card_management/manage_loayalty_point/redemtion_summary_view.dart';
import '../features/presentation/views/credit_card_management/manage_loayalty_point/select_vouchers_view.dart';
import '../features/presentation/views/credit_card_management/new_pin_request/new_pin_request_view.dart';
import '../features/presentation/views/credit_card_management/report_lost_or_stolen_cards/collect_branch_view.dart';
import '../features/presentation/views/credit_card_management/report_lost_or_stolen_cards/report_lost_or_stolen_cards.dart';
import '../features/presentation/views/credit_card_management/self_care/e_statement_view.dart';
import '../features/presentation/views/credit_card_management/self_care/self_care_category_list_view.dart';
import '../features/presentation/views/credit_card_management/supplementary_cards/supplementary_cards_view.dart';
import '../features/presentation/views/credit_card_management/widgets/credit_card_details_card.dart';
import '../features/presentation/views/float_inquiry/float_inquary_details_view.dart';
import '../features/presentation/views/float_inquiry/float_inquiry_view.dart';
import '../features/presentation/views/forgot_password/forgot_password_create _new_password.dart';
import '../features/presentation/views/forgot_password/forgot_password_reset_using_account.dart';
import '../features/presentation/views/fund_transfer/data/fund_transfer_args.dart';
import '../features/presentation/views/fund_transfer/data/fund_transfer_recipt_view_args.dart';
import '../features/presentation/views/fund_transfer/fail/own_acct_now_fail.dart';
import '../features/presentation/views/fund_transfer/fund_transfer_new_view.dart';
import '../features/presentation/views/fund_transfer/otp/ft_otp_view.dart';
import '../features/presentation/views/fund_transfer/save_payee/fund_transfer_save_payee_view.dart';
import '../features/presentation/views/fund_transfer/sucess/own_acct_now_success.dart';
import '../features/presentation/views/fund_transfer/summeries/fund_transfer_new_payee_recurring.dart';
import '../features/presentation/views/fund_transfer/widgets/ft_password_confirmation_view.dart';
import '../features/presentation/views/home/settings_view/data/settings_tran_limit_entity.dart';
import '../features/presentation/views/home/settings_view/language_settings/language_selection.dart';
import '../features/presentation/views/home/settings_view/notification_settings/notification_settings_view.dart';
import '../features/presentation/views/home/settings_view/profile_settings/full_view_of_profile_pic_view.dart';
import '../features/presentation/views/home/settings_view/profile_settings/profile_details_view.dart';
import '../features/presentation/views/home/settings_view/profile_settings/profile_settings.dart';
import '../features/presentation/views/home/settings_view/settings_view.dart';
import '../features/presentation/views/home/settings_view/transaction_limits/transaction_limit_details_view.dart';
import '../features/presentation/views/home/settings_view/transaction_limits/transaction_limits_list_view.dart';
import '../features/presentation/views/language_view/language_view.dart';
import '../features/presentation/views/lanka_qr_pay/qrPayment_status_fail_view.dart';
import '../features/presentation/views/lanka_qr_pay/qrPayment_status_success_view.dart';
import '../features/presentation/views/lanka_qr_pay/qr_payment_summary_view.dart';
import '../features/presentation/views/lanka_qr_pay/qr_payment_view_view.dart';
import '../features/presentation/views/lanka_qr_pay/scan_qr_code_view.dart';
import '../features/presentation/views/login_view/crate_new_password/login_creat_new_password.dart';
import '../features/presentation/views/login_view/password_expired/password_expired_change_password_view.dart';
import '../features/presentation/views/main_menu_and_prelogin_menu/main_menu/main_menu_carousel.dart';
import '../features/presentation/views/payee_manegement/edit_payee_view.dart';
import '../features/presentation/views/notifications/notifications_view.dart';
import '../features/presentation/views/notifications/widget/offer_notification_preview.dart';
import '../features/presentation/views/otp/otp_view.dart';

import '../features/presentation/views/payee_manegement/add_payee_confirm_view.dart';
import '../features/presentation/views/portfolio/loan_details_view.dart';
import '../features/presentation/views/payee_manegement/add_payee_view.dart';
import '../features/presentation/views/payee_manegement/edit_payee_confirm_view.dart';
import '../features/presentation/views/payee_manegement/payee_details_view.dart';
import '../features/presentation/views/payee_manegement/payee_management_save_payee_view.dart';
import '../features/presentation/views/portfolio/filter_past_card_statements.dart';

import '../features/presentation/views/portfolio/account_details_view.dart';

import '../features/presentation/views/portfolio/account_statement_view.dart';

import '../features/presentation/views/portfolio/account_transaction_history.dart';
import '../features/presentation/views/portfolio/card_transaction_view.dart';
import '../features/presentation/views/portfolio/card_details_view.dart';

import '../features/presentation/views/portfolio/investment_details_view.dart';
import '../features/presentation/views/portfolio/loan_payment_history.dart';

import '../features/presentation/views/portfolio/portfolio_view.dart';
import '../features/presentation/views/portfolio/account_transaction_history_details_view.dart';
import '../features/presentation/views/contact_us/pre_login_contact_us.dart';
import '../features/presentation/views/faq/pre_login_faq_view.dart';
import '../features/presentation/views/main_menu_and_prelogin_menu/prelogin_menu/pre_login_carousel.dart';
import '../features/presentation/views/login_view/login_view.dart';
import '../features/presentation/views/promotion_&_offers/promotions_&_offers_details_view.dart';
import '../features/presentation/views/promotion_&_offers/promotions_&_offers_view.dart';
import '../features/presentation/views/rates_view/rates_view.dart';
import '../features/presentation/views/request_call_back/request_call_back_filter_view.dart';
import '../features/presentation/views/request_call_back/request_call_back_history_details_view.dart';
import '../features/presentation/views/request_call_back/request_call_back_history_view.dart';
import '../features/presentation/views/request_call_back/request_call_back_summary_view.dart';
import '../features/presentation/views/request_call_back/request_call_back_view.dart';
import '../features/presentation/views/request_money/request_money_2fa_password_view.dart';
import '../features/presentation/views/request_money/request_money_contact_list_view.dart';
import '../features/presentation/views/request_money/request_money_summary_view.dart';
import '../features/presentation/views/request_money/request_money_view.dart';
import '../features/presentation/views/deeplinking/admin_reset_password/create_new_password.dart';
import '../features/presentation/views/deeplinking/admin_reset_password/tempory_password_view.dart';
import '../features/presentation/views/schedule/schedule_bill_payment/edit_schedule_bill_payment_view.dart';
import '../features/presentation/views/schedule/schedule_bill_payment/schedule_bill_payment_history_view.dart';
import '../features/presentation/views/schedule/schedule_bill_payment/schedule_bill_payment_summary_view.dart';
import '../features/presentation/views/schedule/schedule_bill_payment/schedule_bill_payment_view.dart';
import '../features/presentation/views/schedule/schedule_bill_payment/widgets/bill_payment_schedule_args.dart';
import '../features/presentation/views/schedule/schedule_fund_transfer/edit_schedule.dart';
import '../features/presentation/views/schedule/schedule_fund_transfer/fund_transfer_history_view.dart';
import '../features/presentation/views/schedule/schedule_fund_transfer/fund_transfer_scheduling.dart';
import '../features/presentation/views/schedule/schedule_fund_transfer/fund_transfer_scheduling_summary.dart';
import '../features/presentation/views/schedule/schedule_category_list_view.dart';
import '../features/presentation/views/service_request/cheque_book/cheque_book_history_view.dart';
import '../features/presentation/views/service_request/cheque_book/cheque_book_password_view.dart';
import '../features/presentation/views/service_request/cheque_book/cheque_book_req_details_view.dart';
import '../features/presentation/views/service_request/cheque_book/cheque_book_req_summary.dart';
import '../features/presentation/views/service_request/cheque_book/cheque_book_req_view.dart';
import '../features/presentation/views/service_request/data/service_req_args.dart';
import '../features/presentation/views/service_request/filter/service_req_filter_view.dart';
import '../features/presentation/views/service_request/service_request_category_view.dart';
import '../features/presentation/views/splash_view/introduction_view.dart';
import '../features/presentation/views/train_schedule/train_schedule_view.dart';

import '../features/presentation/views/transaction_history/transaction_history_status_view.dart';
import '../features/presentation/views/transaction_history/transaction_history_view.dart';
import '../features/presentation/views/user_onboarding/justpay_onboarding/other_bank_sequrity_questions_view.dart';
import '../features/presentation/views/user_onboarding/justpay_onboarding/other_bank_setup_login_details_view.dart';
import '../features/presentation/views/user_onboarding/justpay_onboarding/terms_and_conditions_otherbank_view.dart';
import '../features/presentation/views/user_onboarding/registration_methods_view.dart';
import '../features/presentation/views/user_onboarding/ub_account_onboarding/ub_register_details_view.dart';
import '../features/presentation/views/user_onboarding/ub_account_onboarding/ub_sequrity_questions_view.dart';
import '../features/presentation/views/user_onboarding/ub_account_onboarding/ub_setup_login_details_view.dart';
import '../features/presentation/views/user_onboarding/ub_account_onboarding/ub_terms_and_conditions_view.dart';
import '../features/presentation/views/user_onboarding/union_bank_customer_view.dart';
import '../features/presentation/widgets/drop_down_widgets/drop_down_view.dart';

class Routes {
  static const String kSplashView = "kSplashView";
  static const String kLoginView = "kLoginView";
  static const String kPreLoginMenu = "kPreLoginMenu";
  static const String kPromotionsOffersView = "kPromotionsOffersView";
  static const String kPromotionsAndOfferDetailsView =
      "kPromotionsAndOfferDetailsView";
  static const String kFAQView = "kFAQView";
  static const String kContactUsView = "kContactUsView";
  static const String kLanguageView = "kLanguageView";
  static const String kRegistrationMethodView = "kRegistrationMethodView";
  static const String kPersonalInformationView = "kPersonalInformationView";
  static const String kDropDownView = "kDropDownView";
  static const String kAccountDropDownView = "kAccountDropDownView";
  static const String kSettingsUbView = "kSettingsUbView";
  static const String kPortfolioAccountTransactionHistoryView =
      "kPortfolioAccountTransactionHistoryView";
  static const String kOtpView = "kOtpView";
  static const String kCreateProfileView = "kCreateProfileView";
  static const String kCreateProfileCompleteView = "kCreateProfileCompleteView";
  static const String kPayeeManagementAddPayeeView =
      "kPayeeManagementAddPayeeView";
  static const String kSetupLoginDetailsView = "kSetupLoginDetailsView";

  // static const String kEnableBiometricsSettingsView =
  //     "kEnableBiometricsSettingsView";
  static const String kRegistrationInProgressView =
      "kRegistrationInProgressView";
  static const String kContactInformationView = "kContactInformationView";
  static const String kPortfolioTransactionHistoryStatusView =
      "kPortfolioTransactionHistoryStatusView";
  static const String kEmployeementDetailsView = "kEmployeementDetailsView";
  static const String kOtherInformationView = "kOtherInformationView";
  static const String kDocumentVerificationView = "kDocumentVerificationView";
  static const String kDocumentVerificationOtherBankView =
      "kDocumentVerificationOtherBankView";
  static const String kReviewDetailsView = "kReviewDetailsView";
  static const String kEditPersonalInfoView = "kEditPersonalInfoView";
  static const String kEditContactInfoView = "kEditContactInfoView";
  static const String kSecuritySettingsView = "kSecuritySettingsView";
  static const String kBillPaymentBillersView = "kBillPaymentBillersView";
  static const String kEditEmployeeDetailsView = "kEditEmployeeDetailsView";
  static const String kPayeeManagementSavedPayeeView =
      "kPayeeManagementSavedPayeeView";

  static const String kEditOtherInfoView = "kEditOtherInfoView";
  static const String kNotificationsView = "kNotificationsView";
  static const String kEditDocumentVerificationView =
      "kEditDocumentVerificationView";
  static const String kEditScheduleVerificationView =
      "kEditScheduleVerificationView";
  static const String kSecurityQuestionsView = "kSecurityQuestionsView";
  static const String kTnCView = "kTnCView";
  static const String kTnCOtherBankView = "kTnCOtherBankView";
  static const String kTnCManageOtherBankView = "kTnCManageOtherBankView";
  static const String kJustPayOtherBankView = "kJustPayOtherBankView";
  static const String kJustPayOtherBankDetailsView =
      "kJustPayOtherBankDetailsView";
  static const String kJustPayUserScheduleForVerificationView =
      "kJustPayUserScheduleForVerificationView";
  static const String kUserScheduleForVerificationView =
      "kUserScheduleForVerificationView";
  static const String kTouchIdView = "kTouchIdView";
  static const String kTouchIdScanView = "kTouchIdScanView";

  // static const String kFundTransfer2FAPasswordView =
  //     "kFundTransfer2FAPasswordView";
  static const String kAddBiometricsView = "kAddBiometricsView";
  static const String kOtherProductView = "kOtherProductView";
  static const String kPayToMobileView = "kPayToMobileView";
  static const String kTouchIdSuccessView = "kTouchIdSuccessView";
  static const String kPayToMobile2FAPasswordView =
      "kPayToMobile2FAPasswordView";
  static const String kDocumentView = "kSelfieView";
  static const String kPayToMobileSummery = "kPayToMobileSummery";
  static const String kOfferPreview = "kOfferPreview";
  static const String kFrontImageLicenceView = "kFrontImageLicenceView";
  static const String kBackImageLicenceView = "kBackImageLicenceView";
  static const String kFrontImagePassportView = "kFrontImagePassportView";
  static const String kBackImagePassportView = "kBackImagePassportView";
  static const String kAddBillerView = "kAddBillerView";
  static const String kBillingProofView = "kBillingProofView";
  static const String kBillersView = "kBillersView";
  static const String kAddPayDetailsConfirmView = "kAddPayDetailsView";
  static const String kRegistrationInProgressOtherBankView =
      "kRegistrationInProgressOtherBankView";

  // static const String kRegistrationInUsingOtherBankAccountView =
  //     "kRegistrationInUsingOtherBankAccountView";
  static const String kUbRegisterDetailsView = "kUbRegisterDetailsView";
  static const String kUbRegisterDebitCardDetailsView =
      "kUbRegisterDebitCardDetailsView";
  static const String kUBAccountTnCView = "kUBAccountTnCView";

  // static const String kUBCreateProfileView = "kUBCreateProfileView";
  static const String kGoogleMapView = "kGoogleMapView";
  static const String kScheduleFundTransferSummeryOneTime =
      "kScheduleFundTransferSummeryOneTime";
  static const String kUBCreateProfileCompleteView =
      "kUBCreateProfileCompleteView";
  static const String kUBSetupLoginDetailsView = "kUBSetupLoginDetailsView";
  static const String kMapLocatorView = "kMapLocatorView";
  static const String kUBSecurityQuestionsView = "kUBSecurityQuestionsView";
  static const String kUBOtherProductView = "kUBOtherProductView";

  // static const String kUBAccountCreationView = "kUBAccountCreationView";
  static const String kPmSavePayeeView = "kPmSavePayeeView";
  static const String kJustPayTnCView = "kJustPayTnCView";
  static const String kFilterPromotions = "kFilterPromotions";
  static const String kFundTransferSummery = "kFundTransferSummery";
  static const String kScheduleFundTransferSummery =
      "kScheduleFundTransferSummery";
  static const String kForgotPasswordCreateNewPasswordView =
      "kForgotPasswordCreateNewPasswordView";

  // static const String kOtherBankAccountAddSuccessView =
  //     "kOtherBankAccountAddSuccessView";
  static const String kOtherBankSetupLoginDetailsView =
      "kOtherBankSetupLoginDetailsView";
  static const String kOtherBankSecurityQuestionsView =
      "kOtherBankSecurityQuestionsView";
  static const String kOtherBankProductView = "kOtherBankProductView";
  static const String kPayToMobieSucessView = "kPayToMobieSucessView";

  // static const String kPayToMobilleFailView = "kPayToMobilleFailView";
  static const String kCreateNewPasswordView = "kCreateNewPasswordView";
  static const String kSchedulesView = "kSchedulesView";
  static const String kOngoingSchedulesView = "kOngoingSchedulesView";
  static const String kFundTransferView = "kFundTransferView";
  static const String kOtherBankAccountProcessView =
      "kOtherBankAccountProcessView";
  static const String kOtherBankAccountProcessTermsView =
      "kOtherBankAccountProcessTermsView";
  static const String kSavedPayeePaymentSucessView =
      "kSavedPayeePaymentSucessView";
  static const String kSavedPayeePaymentFailView = "kSavedPayeePaymentFailView";
  static const String kUnsavedPayeePaymentSucessView =
      "kUnsavedPayeePaymentSucessView";
  static const String kSchedule2FAPasswordView = "kSchedule2FAPasswordView";
  static const String kUnsavedPayeePaymentFailView =
      "kUnsavedPayeePaymentFailView";
  static const String kSavePayeeView = "kSavePayeeView";
  static const String kShedulePaymentSuccessView = "kShedulePaymentSuccessView";
  static const String kShedulePaymentFailedView = "kShedulePaymentFailedView";
  static const String kFundTransferSchedulingView =
      "kFundTransferSchedulingView";
  static const String kEditScheduleView = "kEditScheduleView";
  static const String kFundTransferHistoryView = "kFundTransferHistoryView";
  static const String kRequestMoneyView = "kRequestMoneyView";
  static const String kRequestMoneyContactListView =
      "kRequestMoneyContactListView";
  static const String kRequestMoneySummaryView = "kRequestMoneySummaryView";
  static const String kRequestMoney2faPasswordView =
      "kRequestMoney2faPasswordView";
  static const String kRequestMoneyStatusView = "kRequestMoneyStatusView";

  // static const String kProfileBiometricSettingsView = "kProfileBiometricSettingsView";
  static const String kForgotPasswordSecurityQuestionsView =
      "kForgotPasswordSecurityQuestionsView";
  static const String kForgotPasswordSecurityQuestionsViewVerify =
      "kForgotPasswordSecurityQuestionsViewVerify";
  static const String kForgotPasswordResetUsingUserNameView =
      "kForgotPasswordResetUsingUserNameView";
  static const String kForgotPasswordResetMethodView =
      "kForgotPasswordResetMethodView";
  static const String kForgotPasswordResetUsingAccountView =
      "kForgotPasswordResetUsingAccountView";
  static const String kHomeBaseView = "kHomeBaseView";
  static const String kScheduleCategoryListView = "kScheduleCategoryListView";
  static const String kTransactionHistoryView = "kTransactionHistoryView";
  static const String kBillerAddConfirmView = "kBillPaymentConfirmView";
  static const String kCalculatorsView = "kCalculatorsView";
  static const String kPersonalLoanView = "kPersonalLoanView";
  static const String kApplyPersonalLoanView = "kApplyPersonalLoanView";
  static const String kForgotPasswordOtpView = "kForgotPasswordOtpView";
  static const String kHousingLoanCalculatorView = "kHousingLoanCalculatorView";
  static const String kApplyHousingLoanView = "kApplyHousingLoanView";
  static const String kFixedDepositView = "kFixedDepositView";
  static const String kLeasingCalculatorView = "kLeasingCalculatorView";
  static const String kApplyLeasingView = "kApplyLeasingView";
  static const String kLeasingPersonalInfoView = "kLeasingPersonalInfoView";
  static const String kPortfolioView = "kPortfolioView";
  static const String kPortfolioAccountDetailsView =
      "kPortfolioAccountDetailsView";
  static const String kPortfolioAccountStatementView =
      "kPortfolioAccountStatementView";
  static const String kPortfolioTransactionHistoryView =
      "kPortfolioTransactionHistoryView";
  static const String kPortfolioCardDetailsView = "kPortfolioCardDetailsView";
  static const String kPortfolioInvestmentDetailsView =
      "kPortfolioInvestmentDetailsView";
  static const String kPortfolioloanDetailsView = "kPortfolioloanDetailsView";
  static const String kSettingPasswordView = "kSettingPasswordView";
  static const String kPortfolioLeaseDetailsView = "kPortfolioLeaseDetailsView";
  static const String kTransactionHistoryFlowView =
      "kTransactionHistoryFlowView";
  static const String kMailBox = "kMailBox";
  static const String kTransactionHistoryStatusView =
      "kTransactionHistoryStatusView";

  // static const String kFilterTransactionView = "kFilterTransactionView";
  static const String kLanguageSelectionView = "kLanguageSelectionView";
  static const String kChangePasswordView = "kChangePasswordView";
  static const String kIntroView = "kIntroView";
  static const String kUBCustomerView = "kUBCustomerView";
  static const String kPastCardStatementsFilterView =
      "kPastCardStatementsFilterView";
  static const String kPortfolioFilterAcctStatementView =
      "PortfolioFilterAcctStatementView";

  static const String kPortfolioUnbilledTransactionView =
      "PortfolioUnbilledTransactionView";
  static const String kPortfolioPastCardStatementView =
      "PortfolioPastCardStatementView";
  static const String kPortfolioFilterPastCardView =
      "PortfolioFilterPastCardView";
  static const String kPortfoliobilledTransactionView =
      "PortfoliobilledTransactionView";
  static const String kPortfolioPastCardFilteredResultView =
      "PortfolioPastCardFilteredResultView";
  static const String kPortfolioLoanPaymentHistoryView =
      "PortfolioLoanPaymentHistoryView";
  static const String kPortfolioLeasePaymentHistoryView =
      "PortfolioLeasePaymentHistoryView";
  static const String kQuickAccessMenuView = "kQuickAccessMenuView";
  static const String kPastCardStatementsView = "kPastCardStatementsView";
  static const String kQuickAccessCarousel = "kQuickAccessCarousel";
  static const String kScheduleBillPaymentView = "kScheduleBillPaymentView";
  static const String kEditScheduleBillPaymentView =
      "kEditScheduleBillPaymentView";
  static const String kBillPaymentSummaryView = "kBillPaymentSummaryView";
  static const String kSavedNowBillPaymentSummaryView =
      "kSavedNowBillPaymentSummaryView";

  // static const String kBillPaymentPaswordAuthView =
  //     "kBillPaymentPaswordAuthView";
  static const String kScheduleBillPaymentStatusView =
      "kScheduleBillPaymentStatusView";
  static const String kScheduleBillPaymentStatusFailView =
      "kScheduleBillPaymentStatusFailView";
  static const String kJustPayOTPView = "kJustPayOTPView";
  static const String kBbcWebView = "kBbcWebView";

  static const String kOtherBankOTPView = "kOtherBankOTPView";
  static const String kRatesView = "kRatesView";
  static const String kTrainTicket = "kTrainTicket";
  static const String kNewsFeed = "kNewsFeed";
  static const String kMainOtherBankView = "kMainOtherBankView";
  static const String kEditPayeeConfirmView = "kEditPayeeConfirmView";
  static const String kPayeeDetailsView = "kPayeeDetailsView";
  static const String kEditPayeeDetailsView = "kEditPayeeDetailsView";
  static const String kPayeeManagementEditPayeeView =
      "kPayeeManagementEditPayeeView";
  static const String kEditedPayeeDetailsView = "kEditedPayeeDetailsView";
  static const String kPayBillsMenuView = "kPayBillsMenuView";
  static const String kBillPaymentProcessView = "kBillPaymentProcessView";
  static const String kBillPaymentBillerManageSummaryView =
      "kBillPaymentBillerManageSummaryView";
  static const String kBillerBillPaymentSuccessView =
      "kBillerBillPaymentSuccessView";
  static const String kSaveBillerView = "kSaveBillerView";
  static const String kSavedUnsavedBillPaymentProcessView =
      "kSavedUnsavedBillPaymentProcessView";
  static const String kSavedBillerBillPaymentSummaryView =
      "kSavedBillerBillPaymentSummaryView";
  static const String kApplyFixedDepositLoan = "kApplyFixedDepositLoan";
  static const String kFundTransferSavedPayeeNowView =
      "kFundTransferSavedPayeeNowView";
  static const String kFundTransferSavedPayeeLaterView =
      "kFundTransferSavedPayeeLaterView";
  static const String kFundTransferSummeryForUnsaved =
      "kFundTransferSummeryForUnsaved";
  static const String kFundTransferNewView = "kFundTransferNewView";
  static const String kFundTransferOwnAcctNowSummery =
      "kFundTransferOwnAcctNowSummery";
  static const String kFundTransferSavedPayeeNowSummery =
      "kFundTransferSavedPayeeNowSummery";
  static const String kFundTransferNewPayeeNowSummery =
      "kFundTransferNewPayeeNowSummery";

  // static const String kSavedPayeeNowPaymentSucessView =
  //     "kSavedPayeeNowPaymentSucessView";
  // static const String kSavedPayeeNowPaymentFailView =
  //     "kSavedPayeeNowPaymentFailView";
  // static const String kUnavedPayeeNowPaymentSucessView =
  //     "kUnavedPayeeNowPaymentSucessView";
  static const String kUnavedPayeeNowPaymentFailView =
      "kUnavedPayeeNowPaymentFailView";
  static const String kOwnAcctNowPaymentSucessView =
      "kOwnAcctNowPaymentSucessView";
  static const String kOwnAcctNowPaymentFailView = "kOwnAcctNowPaymentFailView";

  static const String kMailBoxPreview = "kMailBoxPreview";

  // static const String kMailBoxFilter = "kMailBoxFilter";
  static const String kMailBoxNewMessage = "kMailBoxNewMessage";
  static const String kMailBoxOtpView = "kMailBoxOtpView";
  static const String kMailBoxReplyMail = "kMailBoxReplyMail";
  static const String kMailBoxView = "kMailBoxView";

  // static const String kCardManagementView = "kCardManagementView";
  // static const String kCardManagementActiveStatusView =
  //     "kCardManagementActiveStatusView";
  static const String kCardManagementOTPView = "kCardManagementOTPView";
  static const String kCardManagementActivateView =
      "kCardManagementActivateView";
  static const String kCardManagementPinCreateView =
      "kCardManagementPinCreateView";
  static const String kCardManagementReasonView = "kCardManagementReasonView";
  static const String kFDsavePayeeView = "kFDsavePayeeView";
  static const String kFundTransferNewLaterSummeryView =
      "kFundTransferNewLaterSummeryView";

  // static const String kUnavedPayeeLaterPaymentSucessView =
  //     "kUnavedPayeeLaterPaymentSucessView";
  static const String kUnavedPayeeLaterPaymentFailView =
      "kUnavedPayeeLaterPaymentFailView";
  static const String kFundTransferNewReccurSummeryView =
      "kFundTransferNewReccurSummeryView";

  // static const String kUnavedPayeeRecurringPaymentSucessView =
  //     "kUnavedPayeeRecurringPaymentSucessView";
  static const String kUnavedPayeeRecurringPaymentFailView =
      "kUnavedPayeeRecurringPaymentFailView";
  static const String kFundTransferSavedLaterSummeryView =
      "kFundTransferSavedLaterSummeryView";

  // static const String kSavedPayeeLaterPaymentSucessView =
  //     "kSavedPayeeLaterPaymentSucessView";
  static const String kSavedPayeeLaterPaymentFailView =
      "kSavedPayeeLaterPaymentFailView";
  static const String kFundTransferSavedReccurSummeryView =
      "kFundTransferSavedReccurSummeryView";

  // static const String kSavedPayeeRecurringPaymentSucessView =
  //     "kSavedPayeeRecurringPaymentSucessView";
  static const String kSavedPayeeRecurringPaymentFailView =
      "kSavedPayeeRecurringPaymentFailView";
  static const String kFundTransferOwnLaterSummeryView =
      "kFundTransferOwnLaterSummeryView";

  // static const String kOwnAcctLaterPaymentSucessView =
  //     "kOwnAcctLaterPaymentSucessView";
  static const String kOwnAcctLaterPaymentFailView =
      "kOwnAcctLaterPaymentFailView";
  static const String kFundTransferOwnRecurringSummeryView =
      "kFundTransferOwnRecurringSummeryView";

  // static const String kOwnAcctrecurringPaymentSucessView =
  //     "kOwnAcctrecurringPaymentSucessView";
  static const String kOwnAcctRecurringPaymentFailView =
      "kOwnAcctRecurringPaymentFailView";
  static const String kPayBillView = "kPayBillView";
  static const String kBillerMnagementBillPaymentBillerView =
      "kBillerMnagementBillPaymentBillerView";
  static const String kEditBillerMoreDetailsView = "kEditBillerMoreDetailsView";
  static const String kEditBillerView = "kEditBillerView";
  static const String kBillPaymentStatusView = "kBillPaymentStatusView";
  static const String kEditBillerConfirmView = "kEditBillerConfirmView";
  static const String kBillPaymentHistoryView = "kBillPaymentHistoryView";
  static const String kFTBottomSheetView = "kFTBottomSheetView";
  static const String kBillPaymentSavedLaterSummeryView =
      "kBillPaymentSavedLaterSummeryView";

  // static const String kSavedBillerPaymentLaterSummaryArgs = "kSavedBillerPaymentLaterSummaryArgs";
  static const String kBillPaymentSucessView = "kBillPaymentSucessView";
  static const String kBillPayemntFailView = "kBillPayemntFailView";
  static const String kProfileSettingsView = "kProfileSettingsView";
  static const String kNotificationSettingsView = "kNotificationSettingsView";
  static const String kTransactionListView = "kTransactionListView";
  static const String kViewProfilePicView = "kViewProfilePicView";
  static const String kBillPaymentScheduleRecurringSummeryView =
      "kBillPaymentScheduleRecurringSummeryView";

  // static const String kFundTransferPasswordView = "kFundTransferPasswordView";
  // static const String kEditOngoingScheduleView = "kEditOngoingScheduleView";
  // static const String kEditOngoingScheduleBillPaymentView =
  //     "kEditOngoingScheduleBillPaymentView";
  static const String kPersonalizationSettingsView =
      "kPersonalizationSettingsView";
  static const String kManageQuickAccessMenuView = "kManageQuickAccessMenuView";
  static const String kScanQRCodeView = "kScanQRCodeView";
  static const String kQRPaymentView = "kQRPaymentView";
  static const String kQRPaymentSummary = "kQRPaymentSummary";
  static const String kQRPaymentSuccessStatusView =
      "kQRPaymentSuccessStateView";
  static const String kQRPaymentFailStatusView = "kQRPaymentFailStatusView";

  // static const String kQRPayPaswordAuthView = "kQRPayPaswordAuthView";
  static const String kProfileSettingsHomeView = "kProfileSettingsHomeView";
  static const String kBillPaymentScheduleRecurringFailView =
      "kBillPaymentScheduleRecurringFailView";
  static const String kUnSavedPayeeRecurringSucessView =
      "kUnSavedPayeeRecurringSucessView";
  static const String kFTEnterPasswordView = "kFTEnterPasswordView";

  // static const String kSavedBillPaymentProcessView = "kSavedBillPaymentProcessView";
  static const String kFDInterestRateView = "kFDInterestRateView";

  ///Manage Other Bank View
  static const String kUnionBankEditView = "kUnionBankEditView";
  static const String kManageOtherBank = "kManageOtherBank";
  static const String kManageOtherBankForm = "kManageOtherBankForm";
  static const String kManageOtherBankDetails = "kManageOtherBankDetails";
  static const String kManageOtherBankEdit = "kManageOtherBankEdit";
  static const String kPasswordExpiredChangePasswordView =
      "kPasswordExpiredChangePasswordView";
  static const String kFTOtpView = "kFTOtpView";
  static const String kSavedBillPaymentRecurringSummaryView =
      "kSavedBillPaymentRecurringSummaryView";
  static const String kProfileDetailsView = "kProfileDetailsView";
  static const String kHomeJustPayTnCView = "kHomeJustPayTnCView";
  static const String kChequeStatusView = "kChequeStatusView";
  static const String kChequeStatusSummaryView = "kChequeStatusSummaryVieww";
  static const String kFloatInquiryView = "kFloatInquiryView";
  static const String kSeviceReqCategoryView = "kSeviceReqCategoryView";
  static const String kChequeBookHistoryView = "kChequeBookHistoryView";
  static const String kRequestCallBackHistoryView =
      "kRequestCallBackHistoryView";
  static const String kChequeBookReqView = "kChequeBookReqView";
  static const String kChequeBookReqSummaryView = "kChequeBookReqSummaryView";
  static const String kServiceReqFilterView = "kServiceReqFilterView";
  static const String kRequestCallBackView = "kRequestCallBackView";
  static const String kReqCallBackSummaryView = "kReqCallBackSummaryView";
  static const String kRequestCallBackFilterView = "kRequestCallBackFilterView";
  static const String kReqCallBackHistoryDetailsView =
      "kReqCallBackHistoryDetailsView";
  static const String kChequeBookRequestView = "kChequeBookRequestView";
  static const String kChequeBookRequestDetailsView =
      "kChequeBookRequestDetailsView";
  static const String kTransactionLimitDetailsView =
      "kTransactionLimitDetailsView";
  static const String kFTSchedulingSummary = "kFTSchedulingSummary";
  static const String kBPSchedulingSummary = "kBPSchedulingSummary";
  static const String kResetPasswordTemporyView = "kResetPasswordTemporyView";
  static const String kAdminSecurityQuestionResetView =
      "kAdminSecurityQuestionResetView";
  static const String kResetPasswordCreateNewPasswordView =
      "kResetPasswordCreateNewPasswordView";
  static const String kCreditCardManagementView = "kCreditCardManagementView";
  static const String kCreditCardDetailsView = "kCreditCardDetailsView";
  static const String kSelfCareCategoryListView = "kSelfCareCategoryListView";
  static const String kEStatementView = "kEStatementView";
  static const String kNewPinRequestView = "kNewPinRequestView";

  ///Demo Tour
  static const String kDemoTourView = "kDemoTourView";
  static const String kLoyaltyManagementView = "kLoyaltyManagementView";
  static const String kRedeemPointsView = "kRedeemPointsView";
  static const String kSelectVouchersView = "kSelectVouchersView";
  static const String kRedemptionSummaryView = "kRedemptionSummaryView";
  static const String kCreditCardPaymentCategoryView =
      "kCreditCardPaymentCategoryView";
  static const String kSupplementaryCardsView = "kSupplementaryCardsView";
  static const String kReportLostOrStolenCardsView =
      "kReportLostOrStolenCardsView";
  static const String kCollectionBranchView = "kCollectBranchView";
  static const String kCreditCardPaymentView = "kCreditCardPaymentView";
  static const String kCreditCardPaymentSummaryView =
      "kCreditCardPaymentSummaryView";
  static const String kCreditCardPaymentSuccessView =
      "kCreditCardPaymentSuccessView";
  static const String kCreditCardPaymentFailedView =
      "kCreditCardPaymentFailedView";
  static const String kSelectCreditCardView = "kSelectCreditCardView";
  static const String kAddSecurityQuestionView = "kAddSecurityQuestionView";
  static const String kResetPasswordView = "kResetPasswordView";
  static const String kForceUpdateView = "kForceUpdateView";

  static const String kMigrateUserTC = "kMigrateUserTC";
  static const String kMigrateUserState = "kMigrateUserState";
  static const String kFloatInquiryDetailsView = "kFloatInquiryDetailsView";
  static const String kNoticePreview = "kNoticePreview";


  static Route<dynamic> generateRoute(RouteSettings settings) {
    final isIOS = Platform.isIOS ? true : false;
    final disableIOS = false;
    switch (settings.name) {
      case Routes.kSplashView:
        return PageTransition(
          isIos: isIOS,
          child: SplashView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSplashView),
        );
      case Routes.kLoginView:
        return PageTransition(
          isIos: isIOS,
          child: LoginView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kLoginView),
        );
      // case Routes.kLanguageSelectionView:
      //   return PageTransition(
      // isIos: isIOS,
      //     child: LanguageSelectionView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kLanguageSelectionView),
      //   );
      // case Routes.kPayToMobileView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: PayToMobileView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kPayToMobileView),
      //   );
      case Routes.kPayBillView:
        return PageTransition(
          isIos: isIOS,
          child: PayBillView(
            payBillerData: settings.arguments as PayBillerData,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kPayBillView),
        );
      case Routes.kOfferPreview:
        return PageTransition(
          isIos: isIOS,
          child: OfferPreview(
            offerArgs: settings.arguments as OfferArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kOfferPreview),
        );
      case Routes.kBillPaymentBillersView:
        return PageTransition(
          isIos: isIOS,
          child: BillPaymentBillersView(
            billPaymentBillersViewArgs:
                settings.arguments as BillPaymentBillersViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kBillPaymentBillersView),
        );

      case Routes.kEditBillerMoreDetailsView:
        return PageTransition(
          isIos: disableIOS,
          child: EditBillerMoreDetailsView(
            editBillerDetailsViewArgs:
                settings.arguments as EditBillerDetailsViewArgs,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kEditBillerMoreDetailsView),
        );

      case Routes.kEditBillerConfirmView:
        return PageTransition(
          isIos: isIOS,
          child: EditBillerConfirmView(
            editBillerConfirmViewArgs:
                settings.arguments as EditBillerConfirmViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kEditBillerConfirmView),
        );

      case Routes.kBillerMnagementBillPaymentBillerView:
        return PageTransition(
          isIos: isIOS,
          child: BillerMnagementBillPaymentBillerView(
            billerViewArgs: settings.arguments as BillerManagementViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kBillerMnagementBillPaymentBillerView),
        );
      case Routes.kBillerAddConfirmView:
        return PageTransition(
          isIos: isIOS,
          child: AddBillerConfirmView(
            addBillerArgs: settings.arguments as AddBillerArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kBillerAddConfirmView),
        );

      case Routes.kSaveBillerView:
        return PageTransition(
          isIos: isIOS,
          child: SaveBillerView(
            saveBillerArgs: settings.arguments as SaveBillerArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSaveBillerView),
        );

      case Routes.kEditBillerView:
        return PageTransition(
          isIos: disableIOS,
          child: EditBillerView(
            editBillerViewArgs: settings.arguments as EditBillerViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kEditBillerView),
        );

      case Routes.kNotificationsView:
        return PageTransition(
          isIos: disableIOS,
          child: NotificationsView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kNotificationsView),
        );

      case Routes.kResetPasswordTemporyView:
        return PageTransition(
          isIos: disableIOS,
          child: ResetPasswordTemporyView(
            username: settings.arguments as String,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kResetPasswordTemporyView),
        );
      case Routes.kAdminSecurityQuestionResetView:
        return PageTransition(
          isIos: disableIOS,
          child: AdminSecurityQuestionResetView(),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kAdminSecurityQuestionResetView),
        );

      case Routes.kResetPasswordCreateNewPasswordView:
        return PageTransition(
          isIos: disableIOS,
          child: ResetPasswordCreateNewPasswordView(
            tempPass: settings.arguments as String,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kResetPasswordCreateNewPasswordView),
        );

      case Routes.kChequeBookRequestView:
        return PageTransition(
          isIos: isIOS,
          child: chequeBookPasswordView(
              serviceReqArgs: settings.arguments as ServiceReqArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kChequeBookRequestView),
        );
      case Routes.kPreLoginMenu:
        return PageTransition(
          isIos: isIOS,
          child: const PreLoginCarousel(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kPreLoginMenu),
        );
      // case Routes.kPastCardStatementsView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child:  PastCardStatementsView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kPastCardStatementsView),
      //   );

      //case Routes.kProfileBiometricSettingsView:
      // case Routes.kPastCardStatementsView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: PastCardStatementsView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kPastCardStatementsView),
      //   );

      // case Routes.kProfileSettingsView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: ProfileBiometricSettingsView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kProfileBiometricSettingsView),
      //   );
      // case Routes.kEnableBiometricsSettingsView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: EnableBiometricsSettingsView(),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kEnableBiometricsSettingsView),
      //   );
      // case Routes.kBbcWebView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: bbcNewsDetailWebview(),
      //     type: PageTransitionType.fade,
      //     settings:
      //     const RouteSettings(name: Routes.kBbcWebView),
      //   );
      case Routes.kPastCardStatementsFilterView:
        return PageTransition(
          isIos: isIOS,
          child: PastCardStatementsFilterView(
            accountNumberArgs: settings.arguments as AccountNumberArgs,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kPastCardStatementsFilterView),
        );
      case Routes.kSettingPasswordView:
        return PageTransition(
          isIos: isIOS,
          child: SettingPasswordView(
            isFromHome: settings.arguments as bool,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSettingPasswordView),
        );
      case Routes.kPayeeManagementAddPayeeView:
        return PageTransition(
          isIos: isIOS,
          child: PayeeManagementAddPayeeView(
              isFromFundTransfer: settings.arguments as bool),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kPayeeManagementAddPayeeView),
        );
      case Routes.kAddPayDetailsConfirmView:
        final text = settings.arguments as AddPayeeDetailsConfirmView;
        return PageTransition(
          isIos: isIOS,
          child: AddPayeeDetailsConfirmView(
            payeeDetails: text.payeeDetails,
            isFromFromFundTransfer: text.isFromFromFundTransfer,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kAddPayDetailsConfirmView),
        );

      case Routes.kPayeeDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: PayeeDetailsView(
            payeeDetailsArgs: settings.arguments as SavedPayeeEntity,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kPayeeDetailsView),
        );
      case Routes.kMapLocatorView:
        return PageTransition(
          isIos: disableIOS,
          child: const MapLocator(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kMapLocatorView),
        );
      case Routes.kMainOtherBankView:
        return PageTransition(
            isIos: isIOS,
            child: MainOtherBankAccountView(),
            type: PageTransitionType.fade,
            settings: const RouteSettings(name: Routes.kMainOtherBankView));
      // case Routes.kScheduleFundTransferSummery:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: ScheduleFundTransferSummery(),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kScheduleFundTransferSummery),
      //   );
      case Routes.kChangePasswordView:
        return PageTransition(
          isIos: isIOS,
          child: ChangePasswordView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kChangePasswordView),
        );
      case Routes.kLanguageSelectionView:
        return PageTransition(
          isIos: isIOS,
          child: LanguageSelectionView(
            isInitialNavigate: settings.arguments as bool,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kLanguageSelectionView),
        );

      case Routes.kFloatInquiryView:
        return PageTransition(
          child: FloatInquiryView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kFloatInquiryView),
        );
      // case Routes.kPmSavePayeeView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: PmSavePayeeView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kPmSavePayeeView),
      //   );
      case Routes.kBillersView:
        return PageTransition(
          isIos: isIOS,
          child: BillersView(route: settings.arguments as String),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kBillersView),
        );
      case Routes.kSettingsUbView:
        return PageTransition(
          isIos: isIOS,
          child: SettingsUbView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSettingsUbView),
        );
      case Routes.kProfileSettingsHomeView:
        return PageTransition(
          isIos: isIOS,
          child: ProfileSettingsView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kProfileSettingsHomeView),
        );
      case Routes.kProfileDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: const ProfileDetailsView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kProfileDetailsView),
        );

      case Routes.kNotificationSettingsView:
        return PageTransition(
          isIos: isIOS,
          child: NotificationSettingsView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kNotificationSettingsView),
        );
      case Routes.kTransactionListView:
        return PageTransition(
          isIos: isIOS,
          child: TransactionListView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kTransactionListView),
        );
      // case Routes.kSchedule2FAPasswordView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: Schedule2FAPasswordView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kSchedule2FAPasswordView),
      //   );
      case Routes.kPayeeManagementSavedPayeeView:
        return PageTransition(
          isIos: disableIOS,
          child: PayeeManagementSavedPayeeView(
            // isFromFundTransfer: settings.arguments as bool,
            payeeManagementSavedPayeeViewArgs:
                settings.arguments as PayeeManagementSavedPayeeViewArgs,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kPayeeManagementSavedPayeeView),
        );
      // case Routes.kPayToMobileSummery:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: PayToMobileSummery(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kPayToMobileSummery),
      //   );
      case Routes.kChequeStatusView:
        return PageTransition(
          isIos: isIOS,
          child: ChequeStatusView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kChequeStatusView),
        );

      case Routes.kFDsavePayeeView:
        return PageTransition(
          isIos: isIOS,
          child: FDsavePayeeView(
            fundTransferReceiptViewArgs:
                settings.arguments as FundTransferReceiptViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kFDsavePayeeView),
        );

      // case Routes.kUnavedPayeeRecurringPaymentSucessView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: UnavedPayeeRecurringPaymentSucessView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kUnavedPayeeRecurringPaymentSucessView),
      //   );

      // case Routes.kSavedPayeeRecurringPaymentSucessView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: SavedPayeeRecurringPaymentSucessView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kSavedPayeeRecurringPaymentSucessView),
      //   );

      // case Routes.kSavedPayeeRecurringPaymentFailView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: SavedPayeeRecurringPaymentFailView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kSavedPayeeRecurringPaymentFailView),
      //   );

      // case Routes.kOwnAcctLaterPaymentSucessView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: OwnAcctLaterPaymentSucessView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kOwnAcctLaterPaymentSucessView),
      //   );

      // case Routes.kOwnAcctLaterPaymentFailView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: OwnAcctLaterPaymentFailView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kOwnAcctLaterPaymentFailView),
      //   );

      // case Routes.kOwnAcctrecurringPaymentSucessView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: OwnAcctrecurringPaymentSucessView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kOwnAcctrecurringPaymentSucessView),
      //   );

      // case Routes.kOwnAcctRecurringPaymentFailView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: OwnAcctRecurringPaymentFailView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kOwnAcctRecurringPaymentFailView),
      //   );

      // case Routes.kFundTransferNewLaterSummeryView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: FundTransferNewLaterSummeryView(
      //       fundTransferArgs: settings.arguments as FundTransferArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kFundTransferNewLaterSummeryView),
      //   );

      // case Routes.kFundTransferOwnRecurringSummeryView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: FundTransferOwnRecurringSummeryView(
      //       fundTransferArgs: settings.arguments as FundTransferArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kFundTransferOwnRecurringSummeryView),
      //   );
      //
      // case Routes.kFundTransferOwnLaterSummeryView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: FundTransferOwnLaterSummeryView(
      //       fundTransferArgs: settings.arguments as FundTransferArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kFundTransferOwnLaterSummeryView),
      //   );
      //
      // case Routes.kFundTransferSavedReccurSummeryView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: FundTransferSavedReccurSummeryView(
      //       fundTransferArgs: settings.arguments as FundTransferArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kFundTransferSavedReccurSummeryView),
      //   );

      case Routes.kFundTransferNewReccurSummeryView:
        return PageTransition(
          isIos: isIOS,
          child: FundTransferNewReccurSummeryView(
            fundTransferArgs: settings.arguments as FundTransferArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kFundTransferNewReccurSummeryView),
        );

      // case Routes.kUnavedPayeeLaterPaymentSucessView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: UnavedPayeeLaterPaymentSucessView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kUnavedPayeeLaterPaymentSucessView),
      //   );

      // case Routes.kUnavedPayeeLaterPaymentFailView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: UnavedPayeeLaterPaymentFailView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kUnavedPayeeLaterPaymentFailView),
      //   );

      // case Routes.kPayToMobile2FAPasswordView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: PayToMobile2FAPasswordView(),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kPayToMobile2FAPasswordView),
      //   );
      case Routes.kChequeBookReqSummaryView:
        return PageTransition(
          isIos: isIOS,
          child: ChequeBookReqSummaryView(
            serviceReqArgs: settings.arguments as ServiceReqArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kChequeBookReqSummaryView),
        );
      case Routes.kChequeBookRequestDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: ChequeBookRequestDetailsView(
            srHistoryDetailsArgs: settings.arguments as SrHistoryDetailsArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kChequeBookReqSummaryView),
        );
      case Routes.kChequeBookHistoryView:
        return PageTransition(
          isIos: isIOS,
          child: ChequeBookHistoryView(
            serviceReqArgs: settings.arguments as ServiceReqArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kChequeBookHistoryView),
        );
      case Routes.kRequestCallBackHistoryView:
        return PageTransition(
          isIos: isIOS,
          child: RequestCallBackHistoryView(isHome: settings.arguments as bool),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kRequestCallBackHistoryView),
        );
      case Routes.kRequestCallBackView:
        return PageTransition(
          isIos: disableIOS,
          child: RequestCallBackView(
            isHome: settings.arguments as bool,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kRequestCallBackView),
        );
      case Routes.kRequestCallBackFilterView:
        return PageTransition(
          isIos: isIOS,
          child: RequestCallBackFilterView(),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kRequestCallBackFilterView),
        );
      case Routes.kReqCallBackSummaryView:
        return PageTransition(
          isIos: isIOS,
          child: ReqCallBackSummaryView(
            reqCallBackArgs: settings.arguments as ReqCallBackArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kReqCallBackSummaryView),
        );
      case Routes.kReqCallBackHistoryDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: ReqCallBackHistoryDetailsView(
            reqCallBackArgs: settings.arguments as ReqCallBackArgs,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kReqCallBackHistoryDetailsView),
        );
      case Routes.kChequeBookReqView:
        return PageTransition(
          isIos: disableIOS,
          child: ChequeBookReqView(
            serviceReqArgs: settings.arguments as ServiceReqArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kChequeBookReqView),
        );
      case Routes.kServiceReqFilterView:
        return PageTransition(
          isIos: isIOS,
          child: ServiceReqFilterView(
            serviceReqArgs: settings.arguments as ServiceReqArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kServiceReqFilterView),
        );
      case Routes.kForgotPasswordResetUsingUserNameView:
        return PageTransition(
          isIos: isIOS,
          child: ForgotPasswordResetUsingUserNameView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kForgotPasswordResetUsingUserNameView),
        );
      case Routes.kFloatInquiryDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: FloatInquiryDetailsView(floatInqArgs: settings.arguments as FloatInqArgs,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kFloatInquiryDetailsView),
        );
      case Routes.kSeviceReqCategoryView:
        return PageTransition(
          isIos: isIOS,
          child: SeviceReqCategoryView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSeviceReqCategoryView),
        );
      case Routes.kSecuritySettingsView:
        return PageTransition(
          isIos: isIOS,
          child: SecuritySettingsView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSecuritySettingsView),
        );

      // case Routes.kFundTransfer2FAPasswordView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: FundTransfer2FAPasswordView(
      //       fundTransferPasswordArgs:
      //           settings.arguments as FundTransferPasswordArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kFundTransfer2FAPasswordView),
      //   );
      // case Routes.kPayToMobieSucessView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: PayToMobieSucessView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kPayToMobieSucessView),
      //   );
      case Routes.kPromotionsOffersView:
        return PageTransition(
          isIos: isIOS,
          child: PromotionsOffersView(
            isFromPreLogin: settings.arguments as bool,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kPromotionsOffersView),
        );
      case Routes.kForgotPasswordCreateNewPasswordView:
        return PageTransition(
          isIos: isIOS,
          child: ForgotPasswordCreateNewPasswordView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kForgotPasswordCreateNewPasswordView),
        );
      case Routes.kPasswordExpiredChangePasswordView:
        return PageTransition(
          isIos: isIOS,
          child: PasswordExpiredChangePasswordView(
            isFromPwdExpired: settings.arguments as bool,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kPasswordExpiredChangePasswordView),
        );
      case Routes.kPromotionsAndOfferDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: PromotionsAndOfferDetailsView(
            promotionAndOffersEntity: settings.arguments as PromotionList,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kPromotionsAndOfferDetailsView),
        );
      case Routes.kFAQView:
        return PageTransition(
          isIos: isIOS,
          child: FAQView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kFAQView),
        );
      // case Routes.kRequestMoneyHistoryView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: RequestMoneyHistoryView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kRequestMoneyHistoryView),
      //   );
      // case Routes.kManageOtherBank:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: ManageOtherBankAccountView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kManageOtherBank),
      //   );
      case Routes.kForgotPasswordSecurityQuestionsView:
        return PageTransition(
          isIos: isIOS,
          child: ForgotPasswordSecurityQuestionsView(
              forgotPasswordSecurityQuestionsVerifyData: settings.arguments
                  as ForgotPasswordSecurityQuestionsVerifyData),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kForgotPasswordSecurityQuestionsView),
        );
      case Routes.kForgotPasswordSecurityQuestionsViewVerify:
        return PageTransition(
          isIos: isIOS,
          child: const ForgotPasswordSecurityQuestionsVerifyView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kForgotPasswordSecurityQuestionsViewVerify),
        );
      case Routes.kJustPayUserScheduleForVerificationView:
        return PageTransition(
          isIos: isIOS,
          child: JustPayUserScheduleForVerificationView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kJustPayUserScheduleForVerificationView),
        );
      case Routes.kForgotPasswordResetUsingAccountView:
        return PageTransition(
          isIos: isIOS,
          child: ForgotPasswordResetUsingAccountView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kForgotPasswordResetUsingAccountView),
        );

      case Routes.kJustPayOtherBankDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: JustPayRegisterOtherBankDetailsView(),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kJustPayOtherBankDetailsView),
        );
      case Routes.kContactUsView:
        return PageTransition(
          isIos: isIOS,
          child: ContactUsView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kContactUsView),
        );
      case Routes.kLanguageView:
        return PageTransition(
          isIos: isIOS,
          child: LanguageView(
            isInitialNavigate: settings.arguments as bool,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kLanguageView),
        );
      case Routes.kRegistrationMethodView:
        return PageTransition(
          isIos: isIOS,
          child: RegistrationMethodView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kRegistrationMethodView),
        );
      case Routes.kTnCOtherBankView:
        return PageTransition(
          isIos: isIOS,
          child: TnCOtherBankView(termsArgs: settings.arguments as TermsArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kTnCOtherBankView),
        );
      case Routes.kTnCManageOtherBankView:
        return PageTransition(
          isIos: isIOS,
          child: TnCManageOtherBankView(
              otherTermsArgs: settings.arguments as OtherTermsArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kTnCManageOtherBankView),
        );

      case Routes.kDropDownView:
        return PageTransition(
          isIos: isIOS,
          child: DropDownView(
            dropDownViewScreenArgs:
                settings.arguments as DropDownViewScreenArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kDropDownView),
        );

      // case Routes.kAccountDropDownView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: AccountDropDownView(
      //       accountDropDownViewScreenArgs:
      //           settings.arguments as AccountDropDownViewScreenArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kAccountDropDownView),
      //   );
      case Routes.kOtpView:
        return PageTransition(
          isIos: disableIOS,
          child: OtpView(
            otpArgs: settings.arguments as OTPViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kOtpView),
        );
      case Routes.kFTOtpView:
        return PageTransition(
          isIos: isIOS,
          child: FTOtpView(
            ftOtpArgs: settings.arguments as FtOtpArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kFTOtpView),
        );
      case Routes.kEditPayeeConfirmView:
        return PageTransition(
          isIos: isIOS,
          child: EditPayeeConfirmView(
            savedPayeeEntity: settings.arguments as SavedPayeeEntity,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kEditPayeeConfirmView),
        );
      case Routes.kDocumentVerificationOtherBankView:
        return PageTransition(
          isIos: isIOS,
          child: DocumentVerificationOtherBankView(
              saveAndExist: settings.arguments as SaveAndExist),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kDocumentVerificationOtherBankView),
        );

      case Routes.kDocumentView:
        return PageTransition(
          isIos: isIOS,
          child: DocumentView(documentData: settings.arguments as DocumentData),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kDocumentView),
        );

      case Routes.kAddBiometricsView:
        return PageTransition(
          isIos: isIOS,
          child: AddBiometricsView(
              biometricsFaceIdViewArgs:
                  settings.arguments as BiometricsViewArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kAddBiometricsView),
        );
      case Routes.kFTEnterPasswordView:
        return PageTransition(
          isIos: isIOS,
          child: FTEnterPasswordView(
            title: settings.arguments as String,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kFTEnterPasswordView),
        );

      case Routes.kViewProfilePicView:
        return PageTransition(
          isIos: disableIOS,
          child: FullViewOfProfile(
            //image: settings.arguments as File,
            fullViewOfProfileArgs: settings.arguments as FullViewOfProfileArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kViewProfilePicView),
        );
      // case Routes.kRegistrationInProgressOtherBankView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: RegistrationInProgressOtherBankView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //       name: Routes.kRegistrationInProgressOtherBankView,
      //     ),
      //   );
      // case Routes.kRegistrationInUsingOtherBankAccountView:
      //   return PageTransition(
      //     child: RegistrationInUsingOtherBankAccountView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kRegistrationInUsingOtherBankAccountView),
      //   );

      case Routes.kUbRegisterDetailsView:
        return PageTransition(
          child: UbRegisterDetailsView(),
          isIos: isIOS,
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kUbRegisterDetailsView),
        );
      case Routes.kUbRegisterDebitCardDetailsView:
        return PageTransition(
          child: UbRegisterDebitCardDetailsView(),
          isIos: isIOS,
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kUbRegisterDebitCardDetailsView),
        );
      case Routes.kUBAccountTnCView:
        return PageTransition(
          isIos: isIOS,
          child: UBAccountTnCView(termsArgs: settings.arguments as TermsArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kUBAccountTnCView),
        );
      // case Routes.kUBCreateProfileView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: UBCreateProfileView(appBarTitle: settings.arguments as String,),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kUBCreateProfileView),
      //   );
      case Routes.kTransactionLimitDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: TransactionLimitDetailsView(
            transactionLimit: settings.arguments as TranLimitEntity,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kTransactionLimitDetailsView),
        );
      // case Routes.kUBCreateProfileCompleteView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: UBCreateProfileCompleteView(),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kUBCreateProfileCompleteView),
      //   );
      case Routes.kUBSetupLoginDetailsView:
        return PageTransition(
          child: UBSetupLoginDetailsView(
            appBarTitle: settings.arguments as String,
          ),
          isIos: isIOS,
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kUBSetupLoginDetailsView),
        );
      case Routes.kUBSecurityQuestionsView:
        return PageTransition(
          isIos: isIOS,
          child: UBSecurityQuestionsView(
            userData: settings.arguments as UserData,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kUBSecurityQuestionsView),
        );
      // case Routes.kUBOtherProductView:
      //   return PageTransition(
      //     child: UBOtherProductView(appBarTitle:settings.arguments as String ,),
      //     isIos: isIOS,

      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kUBOtherProductView),
      //   );
      // case Routes.kUBAccountCreationView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: UBAccountCreationView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kUBAccountCreationView),
      //   );
      case Routes.kForgotPasswordResetMethodView:
        return PageTransition(
          isIos: isIOS,
          child: ForgotPasswordResetMethodView(),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kForgotPasswordResetMethodView),
        );
      case Routes.kJustPayTnCView:
        return PageTransition(
          isIos: isIOS,
          child: JustPayTnCView(
              termsJustPayArgs: settings.arguments as TermsJustPayArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kJustPayTnCView),
        );
      // case Routes.kOtherBankAccountAddSuccessView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: OtherBankAccountAddSuccessView(),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kOtherBankAccountAddSuccessView),
      //   );
      // case Routes.kOtherBankAccountProcessView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: OtherBankAccountProcessView(),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kOtherBankAccountProcessView),
      //   );
      // case Routes.kOtherBankAccountProcessTermsView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: OtherBankAccountProcessTermsView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kOtherBankAccountProcessTermsView),
      //   );
      case Routes.kFTSchedulingSummary:
        return PageTransition(
          isIos: isIOS,
          child: FTSchedulingSummary(
            fundTransferArgs: settings.arguments as FundTransferArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kFTSchedulingSummary),
        );
      case Routes.kOtherBankSetupLoginDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: OtherBankSetupLoginDetailsView(),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kOtherBankSetupLoginDetailsView),
        );
      case Routes.kOtherBankSecurityQuestionsView:
        return PageTransition(
          isIos: isIOS,
          child: OtherBankSecurityQuestionsView(
            userData: settings.arguments as UserData,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kOtherBankSecurityQuestionsView),
        );
      // case Routes.kOtherBankProductView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: OtherBankProductView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kOtherBankProductView),
      //   );
      case Routes.kCreateNewPasswordView:
        return PageTransition(
          isIos: isIOS,
          child: CreateNewPasswordView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kCreateNewPasswordView),
        );
      case Routes.kRatesView:
        return PageTransition(
          isIos: isIOS,
          child: RatesView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kRatesView),
        );
      case Routes.kChequeStatusSummaryView:
        return PageTransition(
          child:
              ChequeStatusSummaryView(csiData: settings.arguments as CSIData),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kChequeStatusSummaryView),
        );
      case Routes.kTrainTicket:
        return PageTransition(
          isIos: isIOS,
          child: TrainScheduleView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kTrainTicket),
        );
      case Routes.kNewsFeed:
        return PageTransition(
          isIos: isIOS,
          child: NewsFeedView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kNewsFeed),
        );

      case Routes.kFundTransferNewView:
        return PageTransition(
          isIos: disableIOS,
          child: FundTransferNewView(
            requestMoneyValues: settings.arguments as RequestMoneyValues,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kFundTransferNewView),
        );

      // case Routes.kFundTransferOwnAcctNowSummery:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: FundTransferOwnAcctNowSummery(
      //       fundTransferArgs: settings.arguments as FundTransferArgs,
      //       // fundTransferOwnAcctNowSumArgs: settings.arguments as FundTransferOwnAcctNowSumArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kFundTransferOwnAcctNowSummery),
      //   );

      case Routes.kOwnAcctNowPaymentSucessView:
        return PageTransition(
          isIos: disableIOS,
          child: OwnAcctNowPaymentSucessView(
            fundTransferReceiptViewArgs:
                settings.arguments as FundTransferReceiptViewArgs,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kOwnAcctNowPaymentSucessView),
        );

      // case Routes.kFundTransferSavedPayeeNowSummery:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: FundTransferSavedPayeeNowSummery(
      //       // fundTransferSavedPayeeNowSumArgs: settings.arguments as FundTransferSavedPayeeNowSumArgs,
      //       fundTransferArgs: settings.arguments as FundTransferArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kFundTransferSavedPayeeNowSummery),
      //   );

      // case Routes.kUnavedPayeeNowPaymentSucessView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: UnavedPayeeNowPaymentSucessView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kUnavedPayeeNowPaymentSucessView),
      //   );

      // case Routes.kUnavedPayeeNowPaymentFailView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: UnavedPayeeNowPaymentFailView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kUnavedPayeeNowPaymentFailView),
      //   );

      // case Routes.kFundTransferNewPayeeNowSummery:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: FundTransferNewPayeeNowSummery(
      //       fundTransferArgs: settings.arguments as FundTransferArgs,
      //       // fundTransferNewPayeeNowSumArgs: settings.arguments as FundTransferNewPayeeNowSumArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kFundTransferNewPayeeNowSummery),
      //   );
      //
      // case Routes.kFundTransferSavedLaterSummeryView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: FundTransferSavedLaterSummeryView(
      //       fundTransferArgs: settings.arguments as FundTransferArgs,
      //       // fundTransferNewPayeeNowSumArgs: settings.arguments as FundTransferNewPayeeNowSumArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kFundTransferSavedLaterSummeryView),
      //   );

      // case Routes.kBillPaymentSavedLaterSummeryView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: BillPaymentSavedLaterSummeryView(
      //       billPaymentLaterSummeryArgs:
      //           settings.arguments as BillPaymentLaterSummeryArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kBillPaymentSavedLaterSummeryView),
      //   );

      // case Routes.kSavedBillerPaymentLaterSummaryArgs:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: SavedBillPaymentLaterSummary(
      //       savedBillerPaymentLaterSummaryArgs:
      //       settings.arguments as SavedBillerPaymentLaterSummaryArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kSavedBillerPaymentLaterSummaryArgs),
      //   );

      // case Routes.kSavedPayeeNowPaymentSucessView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: SavedPayeeNowPaymentSucessView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //       // savedPayeeNowPaymentSucessArgs: settings.arguments as SavedPayeeNowPaymentSucessArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kSavedPayeeNowPaymentSucessView),
      //   );

      // case Routes.kSavedPayeeLaterPaymentSucessView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: SavedPayeeLaterPaymentSucessView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //       // savedPayeeNowPaymentSucessArgs: settings.arguments as SavedPayeeNowPaymentSucessArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kSavedPayeeLaterPaymentSucessView),
      //   );

      case Routes.kBillPaymentSucessView:
        return PageTransition(
          isIos: disableIOS,
          child: BillPaymentSucessView(
            laterBillStatusArgs: settings.arguments as SuccessBillStatusArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kBillPaymentSucessView),
        );

      // case Routes.kUnSavedPayeeRecurringSucessView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: UnSavedPayeeRecurringSucessView(
      //       recurringBillStatusArgs: settings.arguments as RecurringBillStatusArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kUnSavedPayeeRecurringSucessView),
      //   );

      // case Routes.kSavedPayeeLaterPaymentFailView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: SavedPayeeLaterPaymentFailView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //       // savedPayeeNowPaymentSucessArgs: settings.arguments as SavedPayeeNowPaymentSucessArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kSavedPayeeLaterPaymentFailView),
      //   );

      case Routes.kBillPayemntFailView:
        return PageTransition(
          isIos: disableIOS,
          child: BillPaymentFailView(
            billStatusFailArgs: settings.arguments as BillStatusFailArgs,
            //fundTransferReceiptViewArgs: settings.arguments as FundTransferReceiptViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kBillPayemntFailView),
        );

      // case Routes.kBillPaymentScheduleRecurringFailView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: BillPaymentScheduleRecurringFailView(
      //       recurringBillPaymentFailArgs:
      //           settings.arguments as RecurringBillPaymentFailArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kBillPaymentScheduleRecurringFailView),
      //   );

      // case Routes.kSavedPayeeNowPaymentFailView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: SavedPayeeNowPaymentFailView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kSavedPayeeNowPaymentFailView),
      //   );

      case Routes.kOwnAcctNowPaymentFailView:
        return PageTransition(
          isIos: disableIOS,
          child: OwnAcctNowPaymentFailView(
            fundTransferReceiptViewArgs:
                settings.arguments as FundTransferReceiptViewArgs,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kOwnAcctNowPaymentFailView),
        );

      // case Routes.kSavedPayeeNowPaymentFailView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: SavedPayeeNowPaymentFailView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kSavedPayeeNowPaymentFailView),
      //   );

      // case Routes.kUnavedPayeeRecurringPaymentFailView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: UnavedPayeeRecurringPaymentFailView(
      //       fundTransferReceiptViewArgs:
      //           settings.arguments as FundTransferReceiptViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kUnavedPayeeRecurringPaymentFailView),
      //   );
      case Routes.kHomeBaseView:
        return PageTransition(
          isIos: isIOS,
          child: HomeBaseView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kHomeBaseView),
        );
      case Routes.kFundTransferSchedulingView:
        return PageTransition(
          isIos: isIOS,
          child: FundTransferSchedulingView(),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kFundTransferSchedulingView),
        );
      case Routes.kEditScheduleView:
        return PageTransition(
          isIos: disableIOS,
          child: EditScheduleView(
            fundTransferArgs: settings.arguments as FundTransferArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kEditScheduleView),
        );
      // case Routes.kEditOngoingScheduleView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: EditOngoingScheduleView(
      //       fundTransferArgs: settings.arguments as FundTransferArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kEditOngoingScheduleView),
      //   );
      case Routes.kFundTransferHistoryView:
        return PageTransition(
          isIos: isIOS,
          child: FundTransferHistoryView(
            fundTransferArgs: settings.arguments as FundTransferArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kFundTransferHistoryView),
        );
      case Routes.kRequestMoneyView:
        return PageTransition(
          isIos: disableIOS,
          child: RequestMoneyView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kRequestMoneyView),
        );
      case Routes.kRequestMoneyContactListView:
        return PageTransition(
          isIos: isIOS,
          child: RequestMoneyContactListView(),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kRequestMoneyContactListView),
        );
      case Routes.kRequestMoneySummaryView:
        return PageTransition(
          isIos: isIOS,
          child: RequestMoneySummaryView(
              fundTransferArgs: settings.arguments as FundTransferArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kRequestMoneySummaryView),
        );
      case Routes.kRequestMoney2faPasswordView:
        return PageTransition(
          isIos: isIOS,
          child: RequestMoney2faPasswordView(),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kRequestMoney2faPasswordView),
        );
      // case Routes.kRequestMoneyStatusView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: RequestMoneyStatusView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kRequestMoneyStatusView),
      //   );
      case Routes.kPortfolioView:
        return PageTransition(
          isIos: isIOS,
          child: PortfolioView(
            portfolioTypeArgs: settings.arguments as PortfolioTypeArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kPortfolioView),
        );
      case Routes.kPortfolioAccountDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: PortfolioAccountDetailsView(
            accountDetailsArgs: settings.arguments as AccountDetailsArgs,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kPortfolioAccountDetailsView),
        );
      case Routes.kPortfolioAccountStatementView:
        return PageTransition(
          isIos: isIOS,
          child: PortfolioAccountStatementView(
            accountStatementsArgs: settings.arguments as AccountStatementsArgs,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kPortfolioAccountStatementView),
        );

      case Routes.kPortfolioAccountTransactionHistoryView:
        return PageTransition(
          isIos: isIOS,
          child: PortfolioAccountTransactionHistoryView(
              accountTransactionHistoryArgs:
                  settings.arguments as AccountTransactionHistoryArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kPortfolioAccountTransactionHistoryView),
        );
      case Routes.kPortfolioTransactionHistoryStatusView:
        return PageTransition(
          isIos: isIOS,
          child: PortfolioTransactionHistoryStatusView(
            transactionDetailsArgs:
                settings.arguments as TransactionDetailsArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kPortfolioTransactionHistoryStatusView),
        );

      case Routes.kPortfolioCardDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: PortfolioCardDetailsView(
              cardDetailsArgs: settings.arguments as CardDetailsArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kPortfolioCardDetailsView),
        );
      case Routes.kPortfolioInvestmentDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: PortfolioInvestmentDetailsView(
            investmentDetailsArgs: settings.arguments as InvestmentDetailsArgs,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kPortfolioInvestmentDetailsView),
        );
      case Routes.kPortfolioloanDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: PortfolioloanDetailsView(
            loanDetailsArgs: settings.arguments as LoanDetailsArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kPortfolioloanDetailsView),
        );
      // case Routes.kPortfolioLeaseDetailsView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: PortfolioLeaseDetailsView(
      //       leaseDetailsArgs: settings.arguments as LeaseDetailsArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kPortfolioLeaseDetailsView),
      //   );
      case Routes.kTransactionHistoryFlowView:
        return PageTransition(
          isIos: isIOS,
          child: TransactionHistoryFlowView(
            isFromHome: settings.arguments as bool,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kTransactionHistoryFlowView),
        );
      case Routes.kMailBox:
        return PageTransition(
          isIos: isIOS,
          child: MailBoxView(
            isFromHome: settings.arguments as bool,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kMailBox),
        );
      case Routes.kTransactionHistoryStatusView:
        return PageTransition(
          isIos: isIOS,
          child: TransactionHistoryStatusView(
              tranArgs: settings.arguments as TranArgs),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kTransactionHistoryStatusView),
        );
      // case Routes.kFilterTransactionView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: FilterTransactionView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kFilterTransactionView),
      //   );

      // case Routes.kPortfolioFilterAcctStatementView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: PortfolioFilterAcctStatementView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kPortfolioFilterAcctStatementView),
      //   );

      // case Routes.kPortfolioFilterPastCardView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: PortfolioFilterPastCardView(),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kPortfolioFilterPastCardView),
      //   );
      case Routes.kPortfoliobilledTransactionView:
        return PageTransition(
          isIos: isIOS,
          child: PortfolioCardTransactionView(
            cardTransactionArgs: settings.arguments as CardTransactionArgs,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kPortfoliobilledTransactionView),
        );

      case Routes.kPortfolioLoanPaymentHistoryView:
        return PageTransition(
          isIos: isIOS,
          child: PortfolioLoanPaymentHistoryView(
            loanDetailsArgs: settings.arguments as LoanDetailsHistoryArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
              name: Routes.kPortfolioLoanPaymentHistoryView),
        );
      // case Routes.kPortfolioLeasePaymentHistoryView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: PortfolioLeasePaymentHistoryView(
      //       leaseDetailsHistoryArgs:
      //           settings.arguments as LeaseDetailsHistoryArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kPortfolioLeasePaymentHistoryView),
      //   );

      // case Routes.kFilteredResultView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: FilteredResultView(filteredResultArgs: settings.arguments as FilteredResultArgs,),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kFilteredResultView),
      //   );

      case Routes.kScheduleCategoryListView:
        return PageTransition(
          isIos: isIOS,
          child: ScheduleCategoryListView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kScheduleCategoryListView),
        );
      // case Routes.kTransactionHistoryView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: TransactionHistoryView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kTransactionHistoryView),
      //   );
      case Routes.kCalculatorsView:
        return PageTransition(
          isIos: disableIOS,
          child: CalculatorsView(isFromPreLogin: settings.arguments as bool),
          type: PageTransitionType.fade,
          settings: const RouteSettings(
            name: Routes.kCalculatorsView,
          ),
        );
      case Routes.kPersonalLoanView:
        return PageTransition(
          isIos: disableIOS,
          child: PersonalLoanCalculatorView(
              isFromPreLogin: settings.arguments as bool),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kPersonalLoanView),
        );

      case Routes.kApplyPersonalLoanView:
        return PageTransition(
          isIos: isIOS,
          child: ApplyForPersonalLoan(
            applyPersonalLoanCalculatorDataViewArgs:
                settings.arguments as ApplyPersonalLoanCalculatorDataViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kApplyPersonalLoanView),
        );

      case Routes.kHousingLoanCalculatorView:
        return PageTransition(
          isIos: disableIOS,
          child:
              HousingLoanCalculator(isFromPreLogin: settings.arguments as bool),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kHousingLoanCalculatorView),
        );
      case Routes.kApplyHousingLoanView:
        return PageTransition(
          isIos: isIOS,
          child: ApplyForHousingLoan(
            applyHousingLoanCalculatorDataViewArgs:
                settings.arguments as ApplyHousingLoanCalculatorDataViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kApplyHousingLoanView),
        );
      case Routes.kPayBillsMenuView:
        return PageTransition(
          isIos: isIOS,
          child: PayBillsMenuView(
            route: settings.arguments as String,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kPayBillsMenuView),
        );

      // case Routes.kApplyHousingLoanView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: ApplyForHousingLoan(
      //       applyHousingLoanCalculatorDataViewArgs:
      //       settings.arguments as ApplyHousingLoanCalculatorDataViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kApplyHousingLoanView),
      //   );

      case Routes.kFixedDepositView:
        return PageTransition(
          isIos: disableIOS,
          child: FixedepositCalculatorView(
              isFromPreLogin: settings.arguments as bool),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kFixedDepositView),
        );
      case Routes.kLeasingCalculatorView:
        return PageTransition(
          isIos: disableIOS,
          child:
              LeasingCalculatorView(isFromPreLogin: settings.arguments as bool),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kLeasingCalculatorView),
        );
      case Routes.kLeasingPersonalInfoView:
        return PageTransition(
          isIos: isIOS,
          child: LeasingPersonalInformationView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kLeasingPersonalInfoView),
        );

      case Routes.kApplyLeasingView:
        return PageTransition(
          isIos: isIOS,
          child: ApplyLeasingView(
              applyLeasingArgs: settings.arguments as ApplyLeasingArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kApplyLeasingView),
        );

      case Routes.kIntroView:
        return PageTransition(
          isIos: isIOS,
          child: IntroView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kIntroView),
        );
      case Routes.kUBCustomerView:
        return PageTransition(
          isIos: isIOS,
          child: UnionBankCustomerView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kUBCustomerView),
        );
      case Routes.kFDInterestRateView:
        return PageTransition(
          isIos: isIOS,
          child: FDInterestRateView(
            fdRateList: settings.arguments as List<FdRateValues>,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kFDInterestRateView),
        );
      // case Routes.kPayeeMangementCategoryView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: PayeeMangementCategoryView(),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kPayeeMangementCategoryView),
      //   );
      // case Routes.kQuickAccessMenuView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: QuickAccessMenuView1(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kQuickAccessMenuView),
      //   );
      case Routes.kQuickAccessCarousel:
        return PageTransition(
          isIos: isIOS,
          child: MainMenuCarousel(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kQuickAccessCarousel),
        );
      // case Routes.kFundTransferPasswordView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: FundTransferPasswordView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kFundTransferPasswordView),
      //   );
      case Routes.kScheduleBillPaymentView:
        return PageTransition(
          isIos: isIOS,
          child: ScheduleBillPaymentView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kScheduleBillPaymentView),
        );
      case Routes.kEditScheduleBillPaymentView:
        return PageTransition(
          isIos: disableIOS,
          child: EditScheduleBillPaymentView(
            scheduleBillPaymentArgs:
                settings.arguments as ScheduleBillPaymentArgs,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kEditScheduleBillPaymentView),
        );
      // case Routes.kEditOngoingScheduleBillPaymentView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: EditOngoingScheduleBillPaymentView(
      //       scheduleBillPaymentArgs:
      //           settings.arguments as ScheduleBillPaymentArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kEditOngoingScheduleBillPaymentView),
      //   );
      case Routes.kBillPaymentHistoryView:
        return PageTransition(
          isIos: isIOS,
          child: BillPaymentHistoryView(
            scheduleBillPaymentArgs:
                settings.arguments as ScheduleBillPaymentArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kBillPaymentHistoryView),
        );
      case Routes.kBPSchedulingSummary:
        return PageTransition(
          isIos: isIOS,
          child: BPSchedulingSummary(
            scheduleBillPaymentArgs:
                settings.arguments as ScheduleBillPaymentArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kBPSchedulingSummary),
        );
      case Routes.kBillPaymentSummaryView:
        return PageTransition(
          isIos: isIOS,
          child: BillPaymentSummaryView(
            billPaymentSummeryArgs:
                settings.arguments as BillPaymentSummeryArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kBillPaymentSummaryView),
        );

      // case Routes.kSavedNowBillPaymentSummaryView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: NowBillPaymentSummaryView(
      //       nowBillPaymentSummaryArgs:
      //       settings.arguments as NowBillPaymentSummaryArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kSavedNowBillPaymentSummaryView),
      //   );

      // case Routes.kBillPaymentPaswordAuthView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: BillPaymentPaswordAuthView(),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kBillPaymentPaswordAuthView),
      //   );
      // case Routes.kScheduleBillPaymentStatusView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: ScheduleBillPaymentStatusView(
      //       billStatusArgs: settings.arguments as BillStatusArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kScheduleBillPaymentStatusView),
      //   );
      // case Routes.kScheduleBillPaymentStatusFailView:
      //   return PageTransition(
      //     isIos: disableIOS,
      //     child: UnSavedBillPaymentStatusFailView(
      //       failBillStatusArgs: settings.arguments as FailBillStatusArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kScheduleBillPaymentStatusFailView),
      //   );
      case Routes.kJustPayOTPView:
        return PageTransition(
          isIos: isIOS,
          child: JustPayOTPView(args: settings.arguments as JustPayOTPViewArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kJustPayOTPView),
        );
      case Routes.kOtherBankOTPView:
        return PageTransition(
          isIos: isIOS,
          child: OtherBankOTPView(
              otherBankOTPViewArgs: settings.arguments as OtherBankOTPViewArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kOtherBankOTPView),
        );
      case Routes.kManageOtherBankDetails:
        return PageTransition(
          isIos: isIOS,
          child: ManageOtherBankDetailsView(
              manageOtherBankDetailArgs:
                  settings.arguments as ManageOtherBankDetailArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kManageOtherBankDetails),
        );
      // case Routes.kEditPayeeDetailsView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: EditPayeeDetailsView(
      //       payeeDetails: settings.arguments as SavedPayeeEntity,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kEditPayeeDetailsView),
      //   );
      // case Routes.kPayeeManagementEditPayeeView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: PayeeManagementEditPayeeView(
      //       savedPayeeEntity: settings.arguments as SavedPayeeEntity,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kPayeeManagementEditPayeeView),
      //   );
      // case Routes.kEditPayeeDetailsView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: EditPayeeDetailsView(
      //       payeeDetails:
      //       settings.arguments as SavedPayeeEntity,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //     const RouteSettings(name: Routes.kEditPayeeDetailsView),
      //   );
      case Routes.kPayeeManagementEditPayeeView:
        return PageTransition(
          isIos: disableIOS,
          child: EditPayeeView(
            savedPayeeEntity: settings.arguments as SavedPayeeEntity,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kPayeeManagementEditPayeeView),
        );
      case Routes.kBillPaymentProcessView:
        return PageTransition(
          isIos: disableIOS,
          child: BillPaymentProcessView(
            billPaymentViewArgs: settings.arguments as BillPaymentViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kBillPaymentProcessView),
        );

      case Routes.kAddBillerView:
        return PageTransition(
          isIos: disableIOS,
          child: AddBillerView(
            billPaymentViewArgs: settings.arguments as AddBillerViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kAddBillerView),
        );

      // case Routes.kBillPaymentProcessView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: BillPaymentProcessView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kBillPaymentProcessView),
      //   );

      // case Routes.kEditedPayeeDetailsView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: EditedPayeeDetailsView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kEditedPayeeDetailsView),
      //   );

      // case Routes.kEditedPayeeDetailsView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: EditedPayeeDetailsView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kEditedPayeeDetailsView),
      //   );

      // case Routes.kBillPaymentBillerManageSummaryView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: BillPaymentBillerManageSummaryView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kBillPaymentBillerManageSummaryView),
      //   );
      // case Routes.kBillerBillPaymentSuccessView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: BillerBillPaymentSuccessView(),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kBillerBillPaymentSuccessView),
      //   );
      // case Routes.kSavedBillerBillPaymentSummaryView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: SavedBillerBillPaymentSummaryView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kSavedBillerBillPaymentSummaryView),
      //   );
      case Routes.kApplyFixedDepositLoan:
        return PageTransition(
          isIos: isIOS,
          child: ApplyFixedDepositLoan(
            applyFixedArgs: settings.arguments as ApplyFixedArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kApplyFixedDepositLoan),
        );
      case Routes.kMailBoxView:
        return PageTransition(
          isIos: isIOS,
          child: Mailbox(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kMailBoxView),
        );
      case Routes.kMailBoxPreview:
        return PageTransition(
          isIos: disableIOS,
          child: MailBoxPreview(
            mailData: settings.arguments as MailData,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kMailBoxPreview),
        );
      // case Routes.kMailBoxFilter:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child:  MailboxFilter(mailFilter: settings.arguments as MailFilter,),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kMailBoxFilter),
      //   );
      case Routes.kMailBoxNewMessage:
        return PageTransition(
          isIos: disableIOS,
          child: MailBoxNewMessage(
            mailData: settings.arguments as MailData,
          ),
          type: PageTransitionType.bottomToTop,
          settings: const RouteSettings(name: Routes.kMailBoxNewMessage),
        );
      case Routes.kMailBoxReplyMail:
        return PageTransition(
          isIos: disableIOS,
          child: MailBoxReplyMail(
            previewMailData: settings.arguments as MailData,
          ),
          type: PageTransitionType.bottomToTop,
          settings: const RouteSettings(name: Routes.kMailBoxReplyMail),
        );
      case Routes.kMailBoxOtpView:
        return PageTransition(
          isIos: disableIOS,
          child: MailBoxOtpView(
            otpArgs: settings.arguments as MailboxOTPViewArgs,
          ),
          type: PageTransitionType.bottomToTop,
          settings: const RouteSettings(name: Routes.kMailBoxOtpView),
        );
      // case Routes.kCardManagementView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: const CardManagementView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kCardManagementView),
      //   );
      // case Routes.kCardManagementActiveStatusView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: CardManagementActiveStatusView(),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kCardManagementActiveStatusView),
      //   );
      // case Routes.kCardManagementOTPView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: CardManagementOtpView(
      //       otpArgs: settings.arguments as CardManagementOTPViewArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kCardManagementOTPView),
      //   );
      // case Routes.kCardManagementActivateView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: CardManagementActivateView(
      //       currentCardata: settings.arguments as CurrentCardData,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kCardManagementActivateView),
      //   );
      // case Routes.kCardManagementPinCreateView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: CardManagementPinCreateView(
      //       currentCardata: settings.arguments as CurrentCardData,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings:
      //         const RouteSettings(name: Routes.kCardManagementPinCreateView),
      //   );
      // case Routes.kCardManagementReasonView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: CardManagementReasonView(
      //       currentCardata: settings.arguments as CurrentCardData,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kCardManagementReasonView),
      //   );
      case Routes.kManageOtherBankForm:
        return PageTransition(
          isIos: isIOS,
          child: ManageOtherBankFormView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kManageOtherBankForm),
        );
      case Routes.kManageOtherBankEdit:
        return PageTransition(
          isIos: isIOS,
          child: ManageOtherBankEditView(
              manageOtherBankEditArgs:
                  settings.arguments as ManageOtherBankEditArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kManageOtherBankEdit),
        );
      // case Routes.kSavedUnsavedBillPaymentProcessView:
      // //   return PageTransition(
      //   isIos: isIOS,
      //     child: SavedUnsavedBillPaymentProcessView(
      //       savedUnsavedProcessArgs:
      //           settings.arguments as SavedUnsavedProcessArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kSavedUnsavedBillPaymentProcessView),
      //   );
      // case Routes.kBillPaymentScheduleRecurringSummeryView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: BillPaymentScheduleRecurringSummeryView(
      //       scheduleRecurringArgs: settings.arguments as ScheduleRecurringArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kBillPaymentScheduleRecurringSummeryView),
      //   );

      // case Routes.kSavedBillPaymentRecurringSummaryView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: SavedBillPaymentRecurringSummary(
      //       savedScheduleRecurringArgs: settings.arguments as SavedScheduleRecurringArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(
      //         name: Routes.kSavedBillPaymentRecurringSummaryView),
      //   );

      case Routes.kScanQRCodeView:
        return PageTransition(
          isIos: isIOS,
          child: ScanQRCodeView(
            route: settings.arguments as String,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kScanQRCodeView),
        );
      case Routes.kQRPaymentView:
        return PageTransition(
          isIos: disableIOS,
          child: QRPaymentView(
              qrPaymentViewArgs: settings.arguments as QRPaymentViewArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kQRPaymentView),
        );
      case Routes.kQRPaymentSummary:
        return PageTransition(
          isIos: isIOS,
          child: QRPaymentSummary(
              qrPaymentSuummaryArgs:
                  settings.arguments as QRPaymentSuummaryArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kQRPaymentSummary),
        );
      case Routes.kQRPaymentSuccessStatusView:
        return PageTransition(
          isIos: disableIOS,
          child: QRPaymentSuccessStatusView(
              qrPaymentSuccessArgs: settings.arguments as QRPaymentSuccessArgs),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kQRPaymentSuccessStatusView),
        );
      case Routes.kQRPaymentFailStatusView:
        return PageTransition(
          isIos: disableIOS,
          child: QRPaymentFailStatusView(
              qrPaymentFailArgs: settings.arguments as QRPaymentFailArgs),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kQRPaymentFailStatusView),
        );
      // case Routes.kQRPayPaswordAuthView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: QRPayPaswordAuthView(),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kQRPayPaswordAuthView),
      //   );

      case Routes.kPersonalizationSettingsView:
        return PageTransition(
          isIos: isIOS,
          child: PersonalizationSettingsView(),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kPersonalizationSettingsView),
        );
      case Routes.kManageQuickAccessMenuView:
        return PageTransition(
          isIos: disableIOS,
          child: ManageQuickAccessMenuView(),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kManageQuickAccessMenuView),
        );
      case Routes.kDemoTourView:
        return PageTransition(
          isIos: isIOS,
          child: DemoTourView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kDemoTourView),
        );
      // case Routes.kSavedBillPaymentProcessView:
      //   return PageTransition(
      //     isIos: isIOS,
      //     child: SavedBillPaymentProcessView(
      //       savedProcessArgs:
      //       settings.arguments as SavedProcessArgs,
      //     ),
      //     type: PageTransitionType.fade,
      //     settings: const RouteSettings(name: Routes.kSavedBillPaymentProcessView),
      //   );
      case Routes.kUnionBankEditView:
        return PageTransition(
          isIos: isIOS,
          child: unionBankAccountDetailsView(
            unionBankEditArgs:
                settings.arguments as unionBankAccountDetailsArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kUnionBankEditView),
        );
      case Routes.kHomeJustPayTnCView:
        return PageTransition(
          isIos: isIOS,
          child: HomeJustPayTnCView(
            termsData: settings.arguments as String,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kHomeJustPayTnCView),
        );
      case Routes.kCreditCardManagementView:
        return PageTransition(
          isIos: isIOS,
          child: CreditCardManagementCategoryListView(route: settings.arguments as String,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kCreditCardManagementView),
        );
      case Routes.kSelfCareCategoryListView:
        return PageTransition(
          isIos: isIOS,
          child: SelfCareCategoryListView(itemList: settings.arguments as List<CreditCardDetailsCard>,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSelfCareCategoryListView),
        );
      case Routes.kEStatementView:
        return PageTransition(
          isIos: isIOS,
          child: EStatementView(itemList: settings.arguments as List<CreditCardDetailsCard>,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kEStatementView),
        );
      case Routes.kCreditCardDetailsView:
        return PageTransition(
          isIos: isIOS,
          child: CreditCardDetailsView(creditCardDetailsArgs: settings.arguments as CreditCardDetailsArgs,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kCreditCardDetailsView),
        );
      case Routes.kLoyaltyManagementView:
        return PageTransition(
          isIos: isIOS,
          child: LoyaltyManagementView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kLoyaltyManagementView),
        );
      case Routes.kRedeemPointsView:
        return PageTransition(
          isIos: isIOS,
          child: RedeemPointsView(cardDetailsEntity: settings.arguments as CardDetailsEntity,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kRedeemPointsView),
        );
      case Routes.kSelectVouchersView:
        return PageTransition(
          isIos: isIOS,
          child: SelectVouchersView(selectVoucherEntity: settings.arguments as SelectVoucherEntity?,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSelectVouchersView),
        );
      case Routes.kRedemptionSummaryView:
        return PageTransition(
          isIos: isIOS,
          child: RedemptionSummaryView(
            redemptionSummaryViewArgs:  settings.arguments as RedemptionSummaryViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kRedemptionSummaryView),
        );
      case Routes.kNewPinRequestView:
        return PageTransition(
          isIos: isIOS,
          child: NewPinRequestView(itemList: settings.arguments as List<CreditCardDetailsCard>,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kNewPinRequestView),
        );
      case Routes.kCreditCardPaymentCategoryView:
        return PageTransition(
          isIos: isIOS,
          child: CreditCardPaymentCategoryView(itemList: settings.arguments as List<CreditCardDetailsCard>,),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kCreditCardPaymentCategoryView),
        );
      case Routes.kSupplementaryCardsView:
        return PageTransition(
          isIos: isIOS,
          child: SupplementaryCardsView(addOnCardList: settings.arguments as List<CardResAddonCardDetail>,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSupplementaryCardsView),
        );
      case Routes.kReportLostOrStolenCardsView:
        return PageTransition(
          isIos: isIOS,
          child: ReportLostOrStolenCardsView(maskedCardNumber: settings.arguments as String,),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kReportLostOrStolenCardsView),
        );
      case Routes.kCollectionBranchView:
        return PageTransition(
          isIos: isIOS,
          child: CollectionBranchView(lostStolenArgs: settings.arguments as LostStolenArgs,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kCollectionBranchView),
        );
      case Routes.kCreditCardPaymentView:
        return PageTransition(
          isIos: isIOS,
          child: CreditCardPaymentView(
            creditCardPaymentArgs: settings.arguments as CreditCardPaymentArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kCreditCardPaymentView),
        );
      case Routes.kCreditCardPaymentSummaryView:
        return PageTransition(
          isIos: isIOS,
          child: CreditCardPaymentSummaryView(
            creditCardPaymentArgs: settings.arguments as CreditCardPaymentArgs,
          ),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kCreditCardPaymentSummaryView),
        );
      case Routes.kCreditCardPaymentSuccessView:
        return PageTransition(
          isIos: isIOS,
          child: CreditCardPaymentSuccessView(creditCardPaymentSuccessArgs: settings.arguments as CreditCardPaymentFailedArgs,),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kCreditCardPaymentSuccessView),
        );
      case Routes.kCreditCardPaymentFailedView:
        return PageTransition(
          isIos: isIOS,
          child: CreditCardPaymentFailedView(creditCardPaymentFailedArgs: settings.arguments as CreditCardPaymentFailedArgs,),
          type: PageTransitionType.fade,
          settings:
              const RouteSettings(name: Routes.kCreditCardPaymentFailedView),
        );
      case Routes.kSelectCreditCardView:
        return PageTransition(
          isIos: isIOS,
          child: SelectCreditCardView(
            selectCreditCardViewArgs:
                settings.arguments as SelectCreditCardViewArgs,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSelectCreditCardView),
        );
      case Routes.kAddSecurityQuestionView:
        return PageTransition(
          isIos: isIOS,
          child: AddSecurityQuestionView( ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kAddSecurityQuestionView),
        );
       case Routes.kResetPasswordView:
        return PageTransition(
          isIos: isIOS,
          child: ResetPasswordView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kResetPasswordView),
        );
      case Routes.kMigrateUserTC:
        return PageTransition(
          isIos: isIOS,
          child: MigrateUserTC(termsArgs: settings.arguments as MigrateUserTCTermsArgs,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kMigrateUserTC),
        );
      case Routes.kMigrateUserState:
        return PageTransition(
          isIos: isIOS,
          child: MigrateUserState(migrateUser: settings.arguments as MigrateUser,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kMigrateUserState),
        );  
      case Routes.kForceUpdateView:
        return PageTransition(
          isIos: isIOS,
          child: ForceUpdateView(isForceUpdate: settings.arguments as bool,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kForceUpdateView),
        );
      case Routes.kNoticePreview:
        return PageTransition(
          isIos: isIOS,
          child: NoticePreview(notificationData: settings.arguments as NotificationData,),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kNoticePreview),
        );
      default:
        return PageTransition(
          isIos: isIOS,
          type: PageTransitionType.fade,
          child: const Scaffold(
            body: Center(
              child: Text("Invalid Route"),
            ),
          ),
        );
    }
  }
}
