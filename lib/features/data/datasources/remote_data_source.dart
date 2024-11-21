import 'dart:core';

import 'package:union_bank_mobile/features/data/models/common/base_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/bill_payment_excel_dwnload_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_activation_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_credit_limit_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_details_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_e_statement_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_last_statement_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_lost_stolen_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_pin_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_txn_history_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_management/card_view_statement_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/card_tran_excel_download.dart';
import 'package:union_bank_mobile/features/data/models/requests/check_user_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/compose_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/delete_mail_message_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/delete_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/float_inquiry_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_nic_account_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_security_question_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_username_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_reset_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/housing_loan_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/just_pay_tc_sign_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/key_exchanege_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_attachment_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_count_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_thread_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mark_as_read_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/password_validation_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/portfolio_user_fd_details_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/recipient_type_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_cancel_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_get_default_data_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_get_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_save_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/temporary_login_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/account_tran_excel_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/recipient_category_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/reply_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/view_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/bill_payment_excel_dwnload_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_credit_limit_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_detals_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_e_statement_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_last_statement_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_list_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_lost_stolen_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_pin_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_txn_history_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_view_statement_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/loyalty_points/loyalty_points_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/demo_tour_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/float_inquiry_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/forgot_password_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/get_payee_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/housing_loan_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/key_exchange_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_attachment_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_count_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_thread_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/password_validation_response.dart';

import 'package:union_bank_mobile/features/data/models/responses/portfolio_lease_details_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/portfolio_userfd_details_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/recipient_category_response.dart';

import 'package:union_bank_mobile/features/data/models/responses/recipient_type_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/request_callback_get_default_data_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/request_callback_get_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/temporary_login_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/view_mail_response.dart';
import 'package:union_bank_mobile/features/domain/entities/request/security_question_request_entity.dart';

import '../../domain/entities/request/terms_accept_request_entity.dart';
import '../models/common/base_response.dart';
import '../models/requests/QRPaymentPdfDownloadRequest.dart';
import '../models/requests/acc_tran_status_excel.dart';
import '../models/requests/acc_tran_status_pdf.dart';
import '../models/requests/account_inquiry_request.dart';

import '../models/requests/account_statement_pdf_download.dart';
import '../models/requests/account_statements_excel_request.dart';
import '../models/requests/account_statements_request.dart';
import '../models/requests/account_tarnsaction_history_pdf_download_request.dart';

import '../models/requests/account_tran_excel_request.dart';
import '../models/requests/account_transaction_history_request.dart';
import '../models/requests/account_verfication_request.dart';
import '../models/requests/add_justPay_instrument_request.dart';
import '../models/requests/biller_pdf_download_request.dart';
import '../models/requests/calculator_share_pdf_request.dart';
import '../models/requests/card_management/card_statement_pdf_download_request.dart';
import '../models/requests/card_taransaction_pdf.dart';
import '../models/requests/cheque_book_filter_request.dart';
import '../models/requests/cheque_book_request.dart';
import '../models/requests/common_request.dart';
import '../models/requests/create_user_request.dart';
import '../models/requests/csi_request.dart';
import '../models/requests/customer_reg_request.dart';
import '../models/requests/delete_biller_request.dart';
import '../models/requests/delete_ft_schedule_request.dart';
import '../models/requests/delete_justpay_instrument_request.dart';
import '../models/requests/delete_notification_request.dart';
import '../models/requests/document_verification_api_request.dart';
import '../models/requests/edit_ft_schedule_request.dart';
import '../models/requests/edit_nick_name_request.dart';
import '../models/requests/edit_profile_details_request.dart';
import '../models/requests/emp_detail_request.dart';
import '../models/requests/fund_transfer_excel_dwnload_request.dart';
import '../models/requests/getBranchListRequest.dart';
import '../models/requests/getTxnCategoryList_request.dart';
import '../models/requests/get_account_name_ft_request.dart';
import '../models/requests/get_all_fund_transfer_schedule_request.dart';
import '../models/requests/get_currency_list_request.dart';
import '../models/requests/get_fd_period_req.dart';
import '../models/requests/get_fd_rate_request.dart';
import '../models/requests/get_justpay_instrument_request.dart';
import '../models/requests/get_home_details_request.dart';
import '../models/requests/get_money_notification_request.dart';
import '../models/requests/get_notification_settings_request.dart';
import '../models/requests/get_terms_request.dart';
import '../models/requests/just_pay_account_onboarding_request.dart';
import '../models/requests/just_pay_challenge_id_request.dart';
import '../models/requests/just_pay_verfication_request.dart';
import '../models/requests/language_request.dart';
import '../models/requests/lease_history_excel.dart';
import '../models/requests/lease_history_pdf.dart';
import '../models/requests/loan_history_excel_request.dart';
import '../models/requests/loan_history_pdf_download.dart';
import '../models/requests/loyalty_management/card_loyalty_redeem_request.dart';
import '../models/requests/mark_as_read_notification_request.dart';
import '../models/requests/marketing_banners_request.dart';
import '../models/requests/notices_notification_request.dart';
import '../models/requests/notification_count_request.dart';
import '../models/requests/past_card_excel_download.dart';
import '../models/requests/past_card_statements_pdf_download_request.dart';
import '../models/requests/payee_favorite_request.dart';
import '../models/requests/promotion_share_request.dart';
import '../models/requests/qr_payment_request.dart';
import '../models/requests/req_money_notification_history_request.dart';
import '../models/requests/request_money_history_request.dart';
import '../models/requests/request_money_request.dart';
import '../models/requests/reset_password_request.dart';
import '../models/requests/retrieve_profile_image_request.dart';
import '../models/requests/schedule_bill_payment_request.dart';
import '../models/requests/schedule_ft_history_request.dart';
import '../models/requests/lease_payment_history_request.dart';
import '../models/requests/loan_history_request.dart';
import '../models/requests/past_card_statement_request.dart';
import '../models/requests/set_security_questions_request.dart';
import '../models/requests/settings_tran_limit_request.dart';
import '../models/requests/settings_update_txn_limit_request.dart';
import '../models/requests/sr_service_charge_request.dart';
import '../models/requests/sr_statement_history_request.dart';
import '../models/requests/sr_statement_request.dart';
import '../models/requests/transaction_filter_pdf_download.dart';
import '../models/requests/transaction_filter_request.dart';
import '../models/requests/transaction_filtered_exce_download_request.dart';
import '../models/requests/transaction_pdf_download.dart';
import '../models/requests/txn_limit_reset_request.dart';
import '../models/requests/ub_account_verfication_request.dart';
import '../models/requests/update_notification_settings_request.dart';
import '../models/requests/verify_nic_request.dart';

import '../models/responses/QrPaymentPdfDownloadResponse.dart';
import '../models/responses/acc_tran_status_excel.dart';
import '../models/responses/acc_tran_status_pdf.dart';
import '../models/responses/account_statement_pdf_download.dart';
import '../models/responses/account_statements_response.dart';
import '../models/responses/account_statesment_xcel_download_response.dart';
import '../models/responses/account_transaction_history_pdf_response.dart';
import '../models/responses/account_transaction_history_response.dart';
import '../models/responses/biller_pdf_download_response.dart';
import '../models/responses/calculator_share_pdf_response.dart';
import '../models/responses/card_management/card_statement_pdf_download_response.dart';
import '../models/responses/card_management/loyalty_points/loyalty_redeem_response.dart';
import '../models/responses/card_tran_excel_download.dart';
import '../models/responses/card_transaction_pdf.dart';
import '../models/responses/challenge_response.dart';
import '../models/responses/cheque_book_filter_response.dart';
import '../models/responses/cheque_book_response.dart';
import '../models/responses/create_user_response.dart';
import '../models/responses/csi_response.dart';
import '../models/responses/delete_biller_response.dart';
import '../models/responses/delete_ft_schedule_response.dart';
import '../models/responses/edit_ft_schedule_response.dart';
import '../models/responses/edit_user_biller_response.dart';
import '../models/responses/favourite_biller_response.dart';
import '../models/responses/fund_transfer_excel_dwnload_response.dart';
import '../models/responses/getBranchListResponse.dart';
import '../models/responses/getTxnCategoryList_response.dart';
import '../models/responses/get_account_name_ft_response.dart';
import '../models/responses/get_all_fund_transfer_schedule_response.dart';
import '../models/responses/get_currency_list_response.dart';
import '../models/responses/get_fd_period_response.dart';
import '../models/responses/get_fd_rate_response.dart';
import '../models/responses/get_justpay_instrument_response.dart';
import '../models/responses/get_home_details_response.dart';
import '../models/responses/get_locator_response.dart';
import '../models/responses/get_money_notification_response.dart';
import '../models/responses/get_notification_settings_response.dart';
import '../models/responses/just_pay_account_onboarding_response.dart';
import '../models/responses/just_pay_challenge_id_response.dart';

import '../models/requests/add_biller_request.dart';
import '../models/requests/add_itransfer_payee_request.dart';
import '../models/requests/add_just_pay_instruements_request.dart';
import '../models/requests/add_pay_request.dart';
import '../models/requests/add_user_inst_request.dart';
import '../models/requests/apply_fd_calculator_request.dart';
import '../models/requests/apply_housing_loan_request.dart';
import '../models/requests/apply_leasing_request.dart';
import '../models/requests/fd_calculator_request.dart';
import '../models/requests/leasing_calculator_request.dart';
import '../models/responses/apply_fd_calculator_response.dart';
import '../models/responses/apply_housing_loan_response.dart';
import '../models/responses/apply_leasing_response.dart';
import '../models/responses/fd_calculator_response.dart';

import '../models/requests/apply_personal_loan_request.dart';
import '../models/requests/delete_fund_transfer_payee_request.dart';
import '../models/requests/get_payee_request.dart';
import '../models/requests/personal_loan_request.dart';
import '../models/responses/account_details_response_dtos.dart';
import '../models/responses/delete_fund_transfer_payee_response.dart';

import '../models/requests/balance_inquiry_request.dart';
import '../models/requests/bill_payment_request.dart';
import '../models/requests/biometric_enable_request.dart';
import '../models/requests/biometric_login_request.dart';
import '../models/requests/cdb_account_verfication_request.dart';
import '../models/requests/challenge_request.dart';
import '../models/requests/change_password_request.dart';
import '../models/requests/contact_us_request.dart';
import '../models/requests/credit_card_req_field_data_request.dart';
import '../models/requests/credit_card_req_save_request.dart';
import '../models/requests/debit_card_req_field_data_request.dart';
import '../models/requests/debit_card_save_data_request.dart';
import '../models/requests/default_payment_instrument_request.dart';
import '../models/requests/delete_itransfer_payee_request.dart';
import '../models/requests/edit_itransfer_payee_request.dart';
import '../models/requests/edit_user_biller_request.dart';
import '../models/requests/faq_request.dart';
import '../models/requests/favourite_biller_request.dart';
import '../models/requests/fund_transfer_one_time_request.dart';
import '../models/requests/fund_transfer_payee_list_request.dart';
import '../models/requests/fund_transfer_pdf_download_request.dart';
import '../models/requests/fund_transfer_scheduling_request.dart';
import '../models/requests/get_all_schedule_fund_transfer_request.dart';
import '../models/requests/get_bank_list_request.dart';
import '../models/requests/get_branch_list_request.dart';
import '../models/requests/get_remaining_inst_request.dart';
import '../models/requests/get_schedule_time_request.dart';
import '../models/requests/get_user_inst_request.dart';
import '../models/requests/gold_loan_details_request.dart';
import '../models/requests/gold_loan_list_request.dart';
import '../models/requests/gold_loan_payment_topup_request.dart';
import '../models/requests/image_api_request_model.dart';
import '../models/requests/initiate_itransfer_request.dart';
import '../models/requests/instrument_nickName_change_request.dart';
import '../models/requests/instrument_status_change_request.dart';
import '../models/requests/intra_fund_transfer_request.dart';
import '../models/requests/itransfer_get_theme_details_request.dart';
import '../models/requests/itransfer_get_theme_request.dart';
import '../models/requests/itransfer_payee_list_request.dart';
import '../models/requests/lease_req_field_data_request.dart';
import '../models/requests/lease_req_save_data_request.dart';
import '../models/requests/loan_req_field_data_request.dart';
import '../models/requests/loan_requests_field_data_request.dart';
import '../models/requests/loan_requests_submit_request.dart';
import '../models/requests/merchant_locator_request.dart';
import '../models/requests/mobile_login_request.dart';
import '../models/requests/otp_request.dart';
import '../models/requests/portfolio_account_details_request.dart';
import '../models/requests/portfolio_cc_details_request.dart';
import '../models/requests/portfolio_loan_details_request.dart';
import '../models/requests/promotion_notification_request.dart';
import '../models/requests/promotions_request.dart';
import '../models/requests/service_req_history_request.dart';
import '../models/requests/submit_products_request.dart';
import '../models/requests/submit_schedule_data_request.dart';
import '../models/requests/transaction_categories_list_request.dart';
import '../models/requests/transaction_history_pdf_download_request.dart';
import '../models/requests/transaction_limit_add_request.dart';
import '../models/requests/transaction_limit_request.dart';
import '../models/requests/transaction_notification_request.dart';
import '../models/requests/transcation_details_request.dart';
import '../models/requests/update_profile_image_request.dart';
import '../models/requests/view_personal_information_request.dart';
import '../models/responses/account_inquiry_response.dart';
import '../models/responses/add_biller_response.dart';
import '../models/responses/add_itransfer_payee_response.dart';
import '../models/responses/add_just_pay_instruements_response.dart';
import '../models/responses/add_pay_response.dart';
import '../models/responses/apply_personal_loan_response.dart';
import '../models/responses/balance_inquiry_response.dart';
import '../models/responses/bill_payment_response.dart';
import '../models/responses/biometric_enable_response.dart';
import '../models/responses/city_response.dart';
import '../models/responses/contact_us_response.dart';
import '../models/responses/credit_card_req_field_data_response.dart';
import '../models/responses/credt_card_req_save_response.dart';
import '../models/responses/debit_card_req_field_data_response.dart';
import '../models/responses/debit_card_save_data_response.dart';
import '../models/responses/faq_response.dart';
import '../models/responses/fund_transfer_one_time_response.dart';
import '../models/responses/fund_transfer_payee_list_response.dart';
import '../models/responses/fund_transfer_pdf_download_response.dart';
import '../models/responses/fund_transfer_scheduling_response.dart';
import '../models/responses/get_all_sheduke_ft_response.dart';
import '../models/responses/get_bank_list_response.dart';
import '../models/responses/get_biller_category_list_response.dart';
import '../models/responses/get_biller_list_response.dart';
import '../models/responses/get_branch_list_response.dart';
import '../models/responses/get_other_products_response.dart';
import '../models/responses/get_remaining_inst_response.dart';
import '../models/responses/get_schedule_time_response.dart';
import '../models/responses/get_terms_response.dart';
import '../models/responses/get_user_inst_response.dart';
import '../models/responses/gold_loan_details_response.dart';
import '../models/responses/gold_loan_list_response.dart';
import '../models/responses/gold_loan_payment_top_up_response.dart';
import '../models/responses/image_api_response_model.dart';
import '../models/responses/initiate_itransfer_response.dart';
import '../models/responses/intra_fund_transfer_response.dart';
import '../models/responses/itransfer_get_theme_details_response.dart';
import '../models/responses/itransfer_get_theme_response.dart';
import '../models/responses/itransfer_payee_list_response.dart';
import '../models/responses/lease_history_excel.dart';
import '../models/responses/lease_history_pdf.dart';
import '../models/responses/lease_payment_history_response.dart';
import '../models/responses/lease_req_field_data_response.dart';
import '../models/responses/lease_req_save_data_response.dart';
import '../models/responses/leasing_calculator_response.dart';
import '../models/responses/loan_history_excel_download.dart';
import '../models/responses/loan_history_pdf_download.dart';
import '../models/responses/loan_history_response.dart';
import '../models/responses/loan_req_field_data_response.dart';
import '../models/responses/loan_request_submit_response.dart';

import '../models/responses/marketing_banners_response.dart';
import '../models/responses/notices_notification_list.dart';
import '../models/responses/notification_count_response.dart';
import '../models/responses/past_card_excel_download.dart';
import '../models/responses/past_card_statements_pdf_response.dart';

import '../models/responses/payee_favorite_response.dart';
import '../models/responses/promotion_share_response.dart';
import '../models/responses/qr_payment_response.dart';
import '../models/responses/req_money_notification_history_response.dart';
import '../models/responses/request_money_history_response.dart';
import '../models/responses/request_money_response.dart';
import '../models/responses/reset_password_response.dart';
import '../models/responses/retrieve_profile_image_response.dart';
import '../models/responses/schedule_bill_payment_response.dart';
import '../models/responses/schedule_ft_history_response.dart';
import '../models/responses/service_req_filted_list_response.dart';
import '../models/responses/settings_tran_limit_response.dart';
import '../models/responses/sr_service_charge_response.dart';
import '../models/responses/sr_statement_history_response.dart';
import '../models/responses/sr_statement_response.dart';
import '../models/responses/transaction_categories_list_response.dart';
import '../models/responses/service_req_history_response.dart';
import '../models/responses/transaction_filter_pdf_download_response.dart';
import '../models/responses/transaction_filter_response.dart';
import '../models/responses/transaction_filtered_excel_download_response.dart';
import '../models/responses/transaction_pdf_download_response.dart';
import '../models/responses/transcation_details_response.dart';
import '../models/requests/edit_payee_request.dart';
import '../models/responses/edit_payee_response.dart';
import '../models/responses/loan_requests_field_data_response.dart';

import '../models/responses/personal_loan_response.dart';
import '../models/responses/view_personal_information_response.dart';
import '../models/responses/transaction_limit_response.dart';

import '../models/responses/mobile_login_response.dart';
import '../models/responses/otp_response.dart';
import '../models/responses/past_card_statement_response.dart';
import '../models/responses/portfolio_cc_details_response.dart';
import '../models/responses/portfolio_loan_details_response.dart';
import '../models/responses/promotion_notification_response.dart';
import '../models/responses/promotions_response.dart';
import '../models/responses/schedule_date_response.dart';
import '../models/responses/sec_question_response.dart';
import '../models/responses/submit_other_products_response.dart';
import '../models/responses/transaction_notification_response.dart';
import '../models/responses/update_profile_image_response.dart';

abstract class RemoteDataSource {
  Future<BaseResponse> getSplash(CommonRequest splashRequest);

  Future<BaseResponse<GetTermsResponse>> getTerms(
      GetTermsRequest getTermsRequest);

  Future<BaseResponse> verifyNIC(VerifyNicRequest verifyNicRequest);

  Future<BaseResponse> registerCustomer(
      CustomerRegistrationRequest customerRegistrationRequest);

  Future<BaseResponse> submitEmpDetails(EmpDetailRequest empDetailRequest);

  Future<BaseResponse> setSecurityQuestions(
      SetSecurityQuestionsRequest commonRequest);

  Future<BaseResponse> documentVerification(
      DocumentVerificationApiRequest documentVerificationApiRequest);

  Future<BaseResponse> setPreferredLanguage(LanguageRequest params);

  Future<BaseResponse> accountVerification(
      AccountVerificationRequest accountVerificationRequest);

  Future<BaseResponse<JustPayAccountOnboardingResponse>> justPayOnboarding(
      JustPayAccountOnboardingRequest justPayAccountOnboardingRequest);

  Future<BaseResponse<JustPayChallengeIdResponse>> justPayChallengeId(
      JustPayChallengeIdRequest justPayChallengeIdRequest);

  Future<BaseResponse> justPayTCSign(JustpayTCSignRequest justpayTCSignRequest);

  Future<BaseResponse> ubAccountVerification(
      UBAccountVerificationRequest ubAccountVerificationRequest);

  Future<BaseResponse> justPayVerification(
      JustPayVerificationRequest justPayVerificationRequest);

  Future<BaseResponse> acceptTerms(
      TermsAcceptRequestEntity termsAcceptRequestEntity);

  Future<BaseResponse<CreateUserResponse>> createUser(
      CreateUserRequest createUserRequest);

  Future<BaseResponse> checkUser(
      CheckUserRequest checkUserRequest);

  Future<BaseResponse<ScheduleDateResponse>> getScheduleDates(
      CommonRequest scheduleDateRequest);

  Future<BaseResponse<GetOtherProductsResponse>> getOtherProducts(
      CommonRequest otherProductsRequest);

  Future<BaseResponse<SubmitProductsResponse>> submitOtherProducts(
      SubmitProductsRequest submitProductsRequest);

  Future<BaseResponse<CityDetailResponse>> getCityData(
      CommonRequest commonRequest);

  Future<BaseResponse<CityDetailResponse>> getDesignationData(
      CommonRequest commonRequest);

  Future<BaseResponse<SecurityQuestionResponse>> getSecurityQuestions(
      SecurityQuestionRequestEntity commonRequest);

  Future<BaseResponse<ChallengeResponse>> otpVerification(
      ChallengeRequest challengeRequest);

  // Future<BaseResponse> otpVerification(ChallengeRequest challengeRequest);

  Future<BaseResponse<GetScheduleTimeResponse>> getScheduleTimeSlots(
      GetScheduleTimeRequest scheduleTimeRequest);

  Future<BaseResponse<GetNotificationSettingsResponse>> getNotificationSettings(
      GetNotificationSettingsRequest getNotificationSettingsRequest);

  Future<BaseResponse> submitScheduleData(SubmitScheduleDataRequest request);

  Future<BaseResponse<MobileLoginResponse>> mobileLogin(
      MobileLoginRequest mobileLoginRequest);
  
  Future<BaseResponse<TemporaryLoginResponse>> temporaryLogin(
      TemporaryLoginRequest temporaryLoginRequest);

  Future<BaseResponse> changePassword(
      ChangePasswordRequest changePasswordRequest);

  Future<BaseResponse> updateNotificationSettings(
      UpdateNotificationSettingsRequest updateNotificationSettingsRequest);

  Future<BaseResponse<BiometricEnableResponse>> biometricEnable(
      BiometricEnableRequest biometricEnableRequest);

  Future<BaseResponse<OtpResponse>> otpRequest(OtpRequest otpRequest);

  Future<BaseResponse<ContactUsResponseModel>> getContactUs(
      ContactUsRequestModel contactUsRequestModel);

  Future<BaseResponse<MobileLoginResponse>> biometricLogin(
      BiometricLoginRequest biometricLoginRequest);

  Future<BaseResponse<GetSavedBillersResponse>> getSavedBillers(
      CommonRequest commonRequest);

  Future<BaseResponse<AddBillerResponse>> addBiller(
      AddBillerRequest addBillerRequest);

  Future<BaseResponse<GetBillerCategoryListResponse>> getBillerCategoryList(
      CommonRequest commonRequest);

  Future<BaseResponse<GetAllFundTransferScheduleResponse>> getAllFTScheduleList(
      GetAllFundTransferScheduleRequest getAllFundTransferScheduleRequest);

  Future<BaseResponse<AccountStatementPdfDownloadResponse>>
      accStatementsPdfDownload(
          AccountStatementPdfDownloadRequest
              accountStatementPdfDownloadRequest);

  Future<BaseResponse<QrPaymentPdfDownloadResponse>> qrPaymentPdfDownload(
      QrPaymentPdfDownloadRequest qrPaymentPdfDownloadRequest);

  Future<BaseResponse<TransactionStatusPdfResponse>>
      transactionStatusPdfDownload(
          TransactionStatusPdfRequest transactionStatusPdfRequest);

  Future<BaseResponse<TransactionFilteredPdfDownloadResponse>>
      transactionFilterPdfDownload(
          TransactionFilteredPdfDownloadRequest
              transactionFilteredPdfDownloadRequest);

  Future<BaseResponse<TransactionFilteredExcelDownloadResponse>>
      transactionFilterExcelDownload(
      TransactionFilteredExcelDownloadRequest
              transactionFilteredExcelDownloadRequest);

  Future<BaseResponse<PromotionShareResponse>> promotionsPdfShare(
      PromotionShareRequest promotionsPdfShareRequest);

  Future<BaseResponse<ChequeBookFilterResponse>> chequeBookFilter(
      ChequeBookFilterRequest chequeBookFilterRequest);

  Future<BaseResponse<LeaseHistoryExcelResponse>> leaseHistoryExcelDownload(
      LeaseHistoryExcelRequest leaseHistoryExcelRequest);

  Future<BaseResponse<LeaseHistoryPdfResponse>> leaseHistoryPdfDownload(
      LeaseHistoryPdfRequest leaseHistoryPdfRequest);

  Future<BaseResponse<AccountTransactionExcelResponse>>
      accTransactionExcelDownload(
          AccountTransactionExcelRequest accountTransactionExcelRequest);

  Future<BaseResponse<LoanHistoryExcelResponse>> loanHistoryExcelDownload(
      LoanHistoryExcelRequest loanHistoryExcelRequest);

  Future<BaseResponse<CsiResponse>> csiData(
      CsiRequest csiRequest);

  Future<BaseResponse<CardTransactionExcelResponse>> cardTranExcelDownload(
      CardTransactionExcelRequest cardTranExcelRequest);

  Future<BaseResponse<CardTransactionPdfResponse>> cardTranPdfDownload(
      CardTransactionPdfRequest cardTransactionPdfRequest);

  Future<BaseResponse<GetMoneyNotificationResponse>> getMoneyNotification(
      GetMoneyNotificationRequest getMoneyNotificationRequest);

  Future<BaseResponse<AccTranStatusExcelDownloadResponse>>
      accTranStatusExcelDownload(
          AccTranStatusExcelDownloadRequest accTranStatusExcelDownloadRequest);

  Future<BaseResponse<AccountTransactionsPdfDownloadResponse>>
      accTransactionsPdfDownload(
          AccountTransactionsPdfDownloadRequest
              accountTransactionsPdfDownloadRequest);

  Future<BaseResponse<AccTranStatusPdfDownloadResponse>>
      accTransactionsStatusPdfDownload(
          AccTranStatusPdfDownloadRequest accTranStatusPdfDownloadRequest);

  Future<BaseResponse<AccountSatementsXcelDownloadResponse>>
      accStatementsXcelDownload(
          AccountSatementsXcelDownloadRequest
              accountSatementsXcelDownloadRequest);

  Future<BaseResponse<LoanHistoryPdfResponse>> loanHistoryPdfDownload(
      LoanHistoryPdfRequest loanHistoryPdfRequest);

  Future<BaseResponse<PastCardExcelDownloadResponse>> pastCardExcelDownload(
      PastCardExcelDownloadRequest pastCardExcelDownloadRequest);

  Future<BaseResponse<CardStatementPdfResponse>> cardStatementPdfDownload(
      CardStateentPdfDownloadRequest cardStateentPdfDownloadRequest);

  Future<BaseResponse<PastcardStatementstPdfDownloadResponse>>
      pastCardStatementsPdfDownload(
          PastcardStatementstPdfDownloadRequest
              pastcardStatementstPdfDownloadRequest);

  Future<BaseResponse<DeleteFtScheduleResponse>> deleteFTScedule(
      DeleteFtScheduleRequest deleteFtScheduleRequest);

  Future<BaseResponse<ScheduleFtHistoryResponse>> scheduleFTHistory(
      ScheduleFtHistoryReq scheduleFtHistoryReq);

  // Future<BaseResponse> deleteBiller(FavouriteBillerRequest deleteBillerRequest);
  Future<BaseResponse<DeleteBillerResponse>> deleteBiller(
      DeleteBillerRequest deleteBillerRequest);

  Future<BaseResponse<EditUserBillerResponse>> editBiller(EditUserBillerRequest editUserBillerRequest);

  // Future<BaseResponse> unFavoriteBiller(
  //     UnFavoriteBillerRequest unFavoriteBillerRequest);

  Future<BaseResponse<MerchantLocatorResponse>> merchantLocator(
      MerchantLocatorRequest merchantLocatorRequest);

  Future<BaseResponse<AccountInquiryResponse>> accountInquiry(
      AccountInquiryRequest accountInquiryRequest);

  Future<BaseResponse<SrStatementHistoryResponse>> statementHistory(
      SrStatementHistoryRequest srStatementHistoryRequest);

  Future<BaseResponse<SrStatementResponse>> srStatement(
      SrStatementRequest srStatementRequest);

  Future<BaseResponse<SrServiceChargeResponse>> srServiceCharge(
      SrServiceChargeRequest serviceChargeRequest);

  Future<BaseResponse<BalanceInquiryResponse>> balanceInquiry(
      BalanceInquiryRequest balanceInquiryRequest);

  Future<BaseResponse<GetBankListResponse>> getBankList(
      GetBankListRequest getBankListRequest);

  Future<BaseResponse<GetBranchListResponse>> getBranchList(
      GetBranchListRequest getBranchListRequest);

  Future<BaseResponse<AddPayResponse>> payManagementAddPay(
      AddPayRequest addPayRequest);

  Future<BaseResponse<EditPayeeResponse>> editPayee(
      EditPayeeRequest editPayeeRequest);

  Future<BaseResponse<FundTransferPayeeListResponse>> fundTransferPayeeList(
      FundTransferPayeeListRequest fundTransferPayeeListRequest);

  Future<BaseResponse<NotificationCountResponse>> notificationCount(
      NotificationCountRequest notificationCountRequest);

  Future<BaseResponse<DeleteFundTransferPayeeResponse>> deleteFundTransferPayee(
      DeleteFundTransferPayeeRequest deleteFundTransferPayeeRequest);

  Future<BaseResponse<HousingLoanResponseModel>> housingLoanList(
      HousingLoanRequestModel housingLoanRequestModel);

  Future<BaseResponse<ApplyHousingLoanResponse>> applyHousingLoanList(
      ApplyHousingLoanRequest applyHousingLoanRequest);

  Future<BaseResponse<LeasingCalculatorResponse>> leasingCalculatorList(
      LeasingCalculatorRequest leasingCalculatorRequest);

  Future<BaseResponse<ApplyLeasingCalculatorResponse>> applyLeasingList(
      ApplyLeasingCalculatorRequest applyLeasingCalculatorRequest);

  Future<BaseResponse<FdCalculatorResponse>> fdCalculatorList(
      FdCalculatorRequest fdCalculatorRequest);

  Future<BaseResponse<ApplyFdCalculatorResponse>> applyFDCalculatorList(
      ApplyFdCalculatorRequest applyFdCalculatorRequest);

  Future<BaseResponse<EditFtScheduleResponse>> editFTSchedule(
      EditFtScheduleRequest editFtScheduleRequest);

  Future<BaseResponse<SettingsTranLimitResponse>> settingsTranLimit(
      SettingsTranLimitRequest settingsTranLimitRequest);

  // Future<BaseResponse<DeleteFundTransferPayeeResponse>> deleteFundTransferPayee(
  //     DeleteFundTransferPayeeRequest deleteFundTransferPayeeRequest);

  Future<BaseResponse<FaqResponse>> preLoginFaq(FaqRequest faqRequest);

  Future<BaseResponse<ImageApiResponseModel>> getImage(
      ImageApiRequestModel imageApiRequest);

  Future<BaseResponse<PromotionsResponse>> getPromotions(
      PromotionsRequest promotionsRequest);

  Future<BaseResponse<IntraFundTransferResponse>> getIntraFundTransfer(
      IntraFundTransferRequest intraFundTransferRequest);

  Future<BaseResponse<GoldLoanListResponse>> goldLoanList(
      GoldLoanListRequest goldLoanListRequest);

  Future<BaseResponse<GetCurrencyListResponse>> getCurrencyList(
      GetCurrencyListRequest getCurrencyListRequest);

  Future<BaseResponse<GetBankBranchListResponse>> getBankBranchList(
      GetBankBranchListRequest getBankBranchListRequest);

  Future<BaseResponse<GetTxnCategoryResponse>> getTxnCtegoryList(
      GetTxnCategoryRequest getTxnCategoryRequest);

  Future<BaseResponse<CalculatorPdfResponse>> calculatorPDF(
      CalculatorPdfRequest calculatorPdfRequest);

  Future<BaseResponse<GetFdPeriodResponse>> getFDPeriodList(
      GetFdPeriodRequest getFdPeriodRequest);

  Future<BaseResponse<GoldLoanDetailsResponse>> goldLoanDetails(
      GoldLoanDetailsRequest goldLoanDetailsRequest);

  Future<BaseResponse<GoldLoanPaymentTopUpResponse>> goldLoanPaymentTopUp(
      GoldLoanPaymentTopUpRequest goldLoanPaymentTopUpRequest);

  Future<BaseResponse<AddItransferPayeeResponse>> addItransferPayee(
      AddItransferPayeeRequest addItransferPayeeRequest);

  Future<BaseResponse<ItransferPayeeListResponse>> itransferPayeeList(
      ItransferPayeeListRequest itransferPayeeListRequest);

  Future<BaseResponse> editItransferPayee(
      EditItransferPayeeRequest editItransferPayeeRequest);

  Future<BaseResponse> deleteItransferPayee(
      DeleteItransferPayeeRequest deleteItransferPayeeRequest);

  Future<BaseResponse> txnLimitReset(
      TxnLimitResetRequest txnLimitResetRequest);

  Future<BaseResponse> cdbAccountVerification(
      CdbAccountVerificationRequest cdbAccountVerificationRequest);

  Future<BaseResponse<LoanRequestFieldDataResponse>> loanRequestsFieldData(
      LoanRequestsFieldDataRequest loanRequestsFieldDataRequest);

  Future<BaseResponse<GetUserInstResponse>> getUserInstruments(
      GetUserInstRequest getUserInstRequest);

  Future<BaseResponse<GetRemainingInstResponse>> getRemainingInstruments(
      GetRemainingInstRequest getRemainingInstRequest);

  Future<BaseResponse<TransactionDetailsResponse>> getTransactionDetails(
      TransactionDetailsRequest transactionDetailsRequest);

  Future<BaseResponse> addUserInstrument(AddUserInstRequest addUserInstRequest);

  Future<BaseResponse<LoanRequestsSubmitResponse>> loanReqSaveData(
      LoanRequestsSubmitRequest loanRequestsSubmitRequest);

  Future<BaseResponse<CreditCardReqFieldDataResponse>> creditCardReqFieldData(
      CreditCardReqFieldDataRequest creditCardReqFieldDataRequest);

  Future<BaseResponse<CreditCardReqSaveResponse>> creditCardReqSave(
      CreditCardReqSaveRequest creditCardReqSaveRequest);

  Future<BaseResponse<LeaseReqFieldDataResponse>> leaseReqFieldData(
      LeaseReqFieldDataRequest leaseReqFieldDataRequest);

  Future<BaseResponse<ChequeBookResponse>> chequeBookFieldData(
      ChequeBookRequest chequeBookRequest);

  // Future<BaseResponse> chequeBookFieldData(
  //     ChequeBookRequest chequeBookRequest);

  Future<BaseResponse<LeaseReqSaveDataResponse>> leaseReqSaveData(
      LeaseReqSaveDataRequest leaseReqSaveDataRequest);

  Future<BaseResponse<JustPayChallengeIdResponse>> JustPayChallengeId(
      JustPayChallengeIdRequest justPayChallengeIdRequest);

  Future<BaseResponse<TransactionCategoriesListResponse>>
      transactionCategoriesList(
          TransactionCategoriesListRequest transactionCategoriesListRequest);

  Future<BaseResponse<ServiceReqHistoryResponse>> serviceReqHistory(
      ServiceReqHistoryRequest serviceReqHistoryRequest);

  Future<BaseResponse<RequestMoneyHistoryResponse>> reqMoneyHistory(
      RequestMoneyHistoryRequest requestMoneyHistoryRequest);

  Future<BaseResponse<ReqMoneyNotificationHistoryResponse>> reqMoneyNotificationHistory(
      ReqMoneyNotificationHistoryRequest reqMoneyNotificationHistoryRequest);

  Future<BaseResponse<LoanReqFieldDataResponse>> loanReq(
      LoanReqFieldDataRequest loanReqFieldDataRequest);

  Future<BaseResponse> justPayInstruements(
      JustPayInstruementsReques justPayInstruementsReques);

  Future<BaseResponse<AddJustPayInstrumentsResponse>> addJustPayInstruements(
      AddJustPayInstrumentsRequest addJustPayInstrumentsRequest);

  Future<BaseResponse> DeleteJustPayInstruements(
      DeleteJustPayInstrumentRequest deleteJustPayInstrumentRequest);

  Future<BaseResponse> defaultPaymentInstrument(
      DefaultPaymentInstrumentRequest defaultPaymentInstrumentRequest);

  Future<BaseResponse> instrumentStatusChange(
      InstrumentStatusChangeRequest instrumentStatusChangeRequest);

  Future<BaseResponse> instrumentNickNameChange(
      InstrumentNickNameChangeRequest instrumentNickNameChangeRequest);

  Future<BaseResponse> editNickName(EditNickNamerequest editNickNameRequest);

  Future<BaseResponse<OneTimeFundTransferResponse>> oneTimeFundTransfer(
      OneTimeFundTransferRequest oneTimeFundTransferRequest);

  Future<BaseResponse<SchedulingFundTransferResponse>> schedulingFundTransfer(
      SchedulingFundTransferRequest schedulingFundTransferRequest);

  Future<BaseResponse<ScheduleBillPaymentResponse>> schedulingBillPayment(
      ScheduleBillPaymentRequest scheduleBillPaymentRequest);

  Future<BaseResponse> transactionHistoryPdfDownload(
      TransactionHistoryPdfDownloadRequest
          transactionHistoryPdfDownloadRequest);

  Future<BaseResponse<ServiceReqFilteredListResponse>> serviceReqFilteredList(
      ServiceReqHistoryRequest serviceReqHistoryRequest);

  Future<BaseResponse<UpdateProfileImageResponse>> updateProfileImage(
      UpdateProfileImageRequest updateProfileImageRequest);

  Future<BaseResponse<ViewPersonalInformationResponse>> viewPersonalInformation(
      ViewPersonalInformationRequest viewPersonalInformationRequest);

  Future<BaseResponse<TransactionLimitResponse>> transactionLimit(
      TransactionLimitRequest transactionLimitRequest);

  Future<BaseResponse> transactionLimitAdd(
      TransactionLimitAddRequest transactionLimitAddRequest);

  Future<BaseResponse<ItransferGetThemeResponse>> itransferGetTheme(
      ItransferGetThemeRequest itransferGetThemeRequest);

  Future<BaseResponse<RequestMoneyResponse>> requestMoney(
      RequestMoneyRequest requestMoneyRequest);

  Future<BaseResponse<ItransferGetThemeDetailsResponse>>
      itransferGetThemeDetails(
          ItransferGetThemeDetailsRequest itransferGetThemeDetailsRequest);

  Future<BaseResponse<BillPaymentResponse>> billPayment(
      BillPaymentRequest billPaymentRequest);

  Future<BaseResponse<FundTransferPdfDownloadResponse>> fundTransferPdfDownload(
      FundTransferPdfDownloadRequest fundTransferPdfDownloadRequest);

  Future<BaseResponse<FundTransferExcelDownloadResponse>>
      fundTransferExcelDownload(
          FundTransferExcelDownloadRequest fundTransferExcelDownloadRequest);

  Future<BaseResponse<GetAllScheduleFtResponse>> getAllScheduleFT(
      GetAllScheduleFtRequest getAllScheduleFtRequest);

  Future<BaseResponse<InitiateItransfertResponse>> initiateItransfer(
      InitiateItransfertRequest initiateItransfertRequest);

  Future<BaseResponse<DebitCardReqFieldDataResponse>> debitCardReqFieldData(
      DebitCardReqFieldDataRequest debitCardReqFieldDataRequest);

  Future<BaseResponse<DebitCardSaveDataResponse>> debitCardReqSaveData(
      DebitCardSaveDataRequest debitCardSaveDataRequest);

  Future<BaseResponse<AccountDetailsResponseDtos>> portfolioAccDetails(
      PortfolioAccDetailsRequest portfolioAccDetailsRequest);

  Future<BaseResponse<PersonalLoanResponse>> personalLoanCal(
      PersonalLoanRequest personalLoanRequest);

  Future<BaseResponse<ApplyPersonalLoanResponse>> applyPersonalLoan(
      ApplyPersonalLoanRequest applyPersonalLoanRequest);

  // Future<BaseResponse> applyPersonalLoan(
  //     ApplyPersonalLoanRequest applyPersonalLoanRequest);

  Future<BaseResponse<GetPayeeResponse>> getPayeeList(
      GetPayeeRequest getPayeeRequest);

  Future<BaseResponse<GetJustPayInstrumentResponse>> getJustPayInstrumentList(
      GetJustPayInstrumentRequest getJustPayInstrumentRequest);

  Future<BaseResponse<PortfolioCcDetailsResponse>> portfolioCCDetails(
      PortfolioCcDetailsRequest portfolioCcDetailsRequest);

  Future<BaseResponse<PortfolioLoanDetailsResponse>> portfolioLoanDetails(
      PortfolioLoanDetailsRequest portfolioLoanDetailsRequest);

  Future<BaseResponse<PortfolioUserFdDetailsResponse>> portfolioFDDetails(
      PortfolioUserFdDetailsRequest portfolioUserFdDetailsRequest);

  Future<BaseResponse<PortfolioLeaseDetailsResponse>> portfolioLeaseDetails(
      PortfolioLoanDetailsRequest portfolioLoanDetailsRequest);

  Future<BaseResponse<TransactionNotificationResponse>> getTranNotifications(
      TransactionNotificationRequest transactionNotificationRequest);

  Future<BaseResponse<PromotionNotificationResponse>> getPromoNotifications(
      PromotionNotificationRequest promotionNotificationRequest);

  Future<BaseResponse<NoticesNotificationResponse>> getNoticesNotifications(
      NoticesNotificationRequest noticesNotificationRequest);

  Future<BaseResponse<PastCardStatementsresponse>> pastCardStatements(
      PastCardStatementsrequest promotionNotificationRequest);

  Future<BaseResponse<AccountTransactionHistoryresponse>> accountTransactions(
      AccountTransactionHistorysrequest accountTransactionHistorysrequest);

  Future<BaseResponse<LoanHistoryresponse>> loanHistory(
      LoanHistoryrequest loanHistoryrequest);

  Future<BaseResponse<TransactionFilterResponse>> transactionFilter(
      TransactionFilterRequest transactionFilterRequest);

  Future<BaseResponse<LeaseHistoryresponse>> leaseHistory(
      LeaseHistoryrequest leaseHistoryrequest);

  Future<BaseResponse<AccountStatementsresponse>> accountStatements(
      AccountStatementsrequest accountStatementsrequest);

  Future<BaseResponse<BillerPdfDownloadResponse>> billerPdfDownload(
      BillerPdfDownloadRequest billerPdfDownloadRequest);

  Future<BaseResponse<BillPaymentExcelDownloadResponse>> billerExcelDownload(
      BillPaymentExcelDownloadRequest billPaymentExcelDownloadRequest);

  Future<BaseResponse> composeMail(ComposeMailRequest composeMailRequest);

  Future<BaseResponse<RecipientTypeResponse>> getRecipientType(
      RecipientTypeRequest recipientTypeRequest);

  Future<BaseResponse<RecipientCategoryResponse>> getRecipientCategory(
      RecipientCategoryRequest recipientCategoryRequest);

  Future<BaseResponse<ViewMailResponse>> getViewMail(
      ViewMailRequest viewMailRequest);

  Future<BaseResponse<MailThreadResponse>> getMailThread(
      MailThreadRequest mailThreadRequest);

  Future<BaseResponse<MailAttachmentResponse>> getMailAttachment(
      MailAttachmentRequest mailAttachmentRequest);

  Future<BaseResponse> deleteMailAttachment(
      MailAttachmentRequest mailAttachmentRequest);

  Future<BaseResponse<MailCountResponse>> getMailCount(
      MailCountRequest mailCountRequest);

  Future<BaseResponse> deleteMail(DeleteMailRequest deleteMailRequest);

  Future<BaseResponse> deleteMailMessage(DeleteMailMessageRequest deleteMailMessageRequest);

  Future<BaseResponse> markAsReadMail(
      MarkAsReadMailRequest markAsReadMailRequest);

  Future<BaseResponse> markAsReadNotification(
      MarkAsReadNotificationRequest markAsReadNotificationRequest);

  Future<BaseResponse> deleteNotification(
      DeleteNotificationRequest deleteNotificationRequest);

  Future<BaseResponse> replyMail(ReplyMailRequest replyMailRequest);


  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest resetPasswordRequest);


  Future<BaseResponse> updateTxnLimit(
      UpdateTxnLimitRequest updateTxnLimitRequest);

  Future<BaseResponse<ForgetPasswordResponse>> forgetPwCheckNicAccount(
      ForgetPwCheckNicAccountRequest forgetPwCheckNicAccountRequest);

  Future<BaseResponse<ForgetPasswordResponse>> forgetPwCheckUsername(
      ForgetPwCheckUsernameRequest forgetPwCheckUsernameRequest);

  Future<BaseResponse<ForgetPasswordResponse>> forgetPwCheckSecurityQuestion(
      ForgetPwCheckSecurityQuestionRequest
          forgetPwCheckSecurityQuestionRequest);

  Future<BaseResponse> forgetPwReset(ForgetPwResetRequest forgetPwResetRequest);

  Future<BaseResponse<GetHomeDetailsResponse>> getHomeDetails(
      GetHomeDetailsRequest getHomeDetailsRequest);

  Future<BaseResponse> updateProfileDetails(
      UpdateProfileDetailsRequest updateProfileDetailsRequest);

  Future<BaseResponse<RetrieveProfileImageResponse>> getProfileImage(
      RetrieveProfileImageRequest retrieveProfileImageRequest);

  Future<BaseResponse<GetFdRateResponse>> getFDRate(
      GetFdRateRequest getFdRateRequest);

  Future<BaseResponse<DemoTourListResponse>> getDemoTour(
      CommonRequest commonRequest);

  Future<BaseResponse<MarketingBannersResponse>> getMarketingBanner(
      MarketingBannersRequest marketingBannersRequest);

  Future<BaseResponse<PayeeFavoriteResponse>> favoritePayee(
      PayeeFavoriteRequest payeeFavoriteRequest);

  Future<BaseResponse<FavoriteBillerResponse>> favouriteBiller(
      FavouriteBillerRequest favouriteBillerRequest);

  Future<BaseResponse<PasswordValidationResponse>> passwordValidation(
      PasswordValidationRequest passwordValidationRequest);

  Future<BaseResponse<QrPaymentResponse>> qrPayment(
      QrPaymentRequest qrPaymentRequest);

  Future<BaseResponse<GetAcctNameFtResponse>> acctNameForFt(
      GetAcctNameFtRequest getAcctNameFtRequest);
 
  Future<BaseResponse> saveRequestCall(
      RequestCallBackSaveRequest requestCallBackSaveRequest);

  Future<BaseResponse<RequestCallBackGetResponse>> getRequestCall(
      RequestCallBackGetRequest requestCallBackGetRequest);
  
  Future<BaseResponse<RequestCallBackGetDefaultDataResponse>> getRequestCallDefaultData(
      RequestCallBackGetDefaultDataRequest requestCallBackGetDefaultDataRequest);
      
  Future<BaseResponse> cancelRequestCall(
      RequestCallBackCancelRequest requestCallBackCancelRequest);

  Future<BaseResponse<FloatInquiryResponse>> floatInquiryRequest(
      FloatInquiryRequest floatInquiryRequest);
      
  Future<BaseResponse<KeyExchangeResponse>> keyExchange(
      KeyExchangeRequest keyExchangeRequest);

  Future<BaseResponse> getCnn(
      BaseRequest cnnRequest);
      
  Future<BaseResponse> getBbc(
      BaseRequest bbcRequest);

  
  /* ----------------------------- Card Mangement ----------------------------- */

    Future<BaseResponse<CardListResponse>> getCardList(
      CommonRequest cardListRequest);

  Future<BaseResponse<CardDetailsResponse>> cardDetails(
      CardDetailsRequest cardDetailsRequest);
  
  Future<BaseResponse<CardPinResponse>> cardPinRequest(
      CardPinRequest cardPinRequest);
  
  Future<BaseResponse> cardActivation(
      CardActivationRequest cardActivationRequest);
  
  Future<BaseResponse<CardTxnHistoryResponse>> cardTxnHistory(
      CardTxnHistoryRequest cardTxnHistoryRequest);
  
  Future<BaseResponse<CardEStatementResponse>> cardEStatement(
      CardEStatementRequest cardEStatementRequest);
  
  Future<BaseResponse<CardCreditLimitResponse>> cardCreditLimit(
      CardCreditLimitRequest cardCreditLimitRequest);
  
  Future<BaseResponse<CardViewStatementResponse>> cardViewStatement(
      CardViewStatementRequest cardViewStatementRequest);
  
  Future<BaseResponse<CardLastStatementResponse>> cardLastStatement(
      CardLastStatementRequest cardLastStatementRequest);
  
  Future<BaseResponse<CardLostStolenResponse>> cardLostStolen(
      CardLostStolenRequest cardLostStolenRequest);

  ///Card Loyalty Points
  Future<BaseResponse<CardLoyaltyVouchersResponse>> getCardLoyaltyVouchers(
      CommonRequest cardLoyaltyVouchersRequest);

  Future<BaseResponse<CardLoyaltyRedeemResponse>> cardLoyaltyRedeem(
      CardLoyaltyRedeemRequest cardLoyaltyRedeemRequest);

  
  /* ------------------------------------ . ----------------------------------- */
}
