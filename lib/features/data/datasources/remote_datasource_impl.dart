import 'package:union_bank_mobile/features/data/datasources/remote_data_source.dart';
import 'package:union_bank_mobile/features/data/models/common/base_request.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/account_verfication_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/apply_personal_loan_request.dart';
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
import 'package:union_bank_mobile/features/data/models/requests/card_taransaction_pdf.dart';
import 'package:union_bank_mobile/features/data/models/requests/check_user_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/cheque_book_filter_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/cheque_book_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/common_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/compose_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/customer_reg_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/delete_mail_message_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/delete_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/document_verification_api_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/edit_profile_details_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/emp_detail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/float_inquiry_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_nic_account_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_security_question_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_username_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_reset_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/get_fd_period_req.dart';
import 'package:union_bank_mobile/features/data/models/requests/get_home_details_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/get_terms_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/housing_loan_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/just_pay_account_onboarding_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/just_pay_challenge_id_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/just_pay_tc_sign_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/just_pay_verfication_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/key_exchanege_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/language_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/loyalty_management/card_loyalty_redeem_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_attachment_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_count_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_thread_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mark_as_read_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/loan_history_pdf_download.dart';
import 'package:union_bank_mobile/features/data/models/requests/payee_favorite_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/password_validation_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/personal_loan_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/promotion_notification_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/qr_payment_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/recipient_category_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/recipient_type_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/reply_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_cancel_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_get_default_data_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_save_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_get_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/retrieve_profile_image_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/set_security_questions_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/temporary_login_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/transaction_notification_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/ub_account_verfication_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/verify_nic_request.dart';
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
import 'package:union_bank_mobile/features/data/models/responses/card_management/loyalty_points/loyalty_redeem_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/cheque_book_filter_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/demo_tour_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/float_inquiry_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/forgot_password_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/get_home_details_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/housing_loan_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/account_details_response_dtos.dart';
import 'package:union_bank_mobile/features/data/models/responses/just_pay_account_onboarding_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/just_pay_challenge_id_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/key_exchange_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_attachment_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_count_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_thread_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/payee_favorite_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/password_validation_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/personal_loan_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/promotion_notification_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/recipient_category_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/qr_payment_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/recipient_type_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/request_callback_get_default_data_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/request_callback_get_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/retrieve_profile_image_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/temporary_login_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/transaction_notification_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/view_mail_response.dart';
import 'package:union_bank_mobile/features/domain/entities/request/security_question_request_entity.dart';

import '../../../core/network/api_helper.dart';
import '../../domain/entities/request/terms_accept_request_entity.dart';

import '../models/requests/QRPaymentPdfDownloadRequest.dart';
import '../models/requests/acc_tran_status_excel.dart';
import '../models/requests/acc_tran_status_pdf.dart';
import '../models/requests/account_statement_pdf_download.dart';
import '../models/requests/account_statements_excel_request.dart';
import '../models/requests/account_tarnsaction_history_pdf_download_request.dart';

import '../models/requests/account_tran_excel_request.dart';
import '../models/requests/add_justPay_instrument_request.dart';
import '../models/requests/apply_fd_calculator_request.dart';
import '../models/requests/apply_housing_loan_request.dart';
import '../models/requests/apply_leasing_request.dart';
import '../models/requests/biller_pdf_download_request.dart';
import '../models/requests/calculator_share_pdf_request.dart';
import '../models/requests/card_management/card_statement_pdf_download_request.dart';
import '../models/requests/card_tran_excel_download.dart';
import '../models/requests/csi_request.dart';
import '../models/requests/delete_biller_request.dart';
import '../models/requests/delete_ft_schedule_request.dart';
import '../models/requests/delete_justpay_instrument_request.dart';
import '../models/requests/delete_notification_request.dart';
import '../models/requests/edit_ft_schedule_request.dart';
import '../models/requests/fd_calculator_request.dart';
import '../models/requests/fund_transfer_excel_dwnload_request.dart';
import '../models/requests/getBranchListRequest.dart';
import '../models/requests/getTxnCategoryList_request.dart';
import '../models/requests/get_account_name_ft_request.dart';
import '../models/requests/get_all_fund_transfer_schedule_request.dart';
import '../models/requests/get_currency_list_request.dart';
import '../models/requests/get_fd_rate_request.dart';
import '../models/requests/get_justpay_instrument_request.dart';
import '../models/requests/get_money_notification_request.dart';
import '../models/requests/get_notification_settings_request.dart';
import '../models/requests/lease_history_excel.dart';
import '../models/requests/lease_history_pdf.dart';
import '../models/requests/leasing_calculator_request.dart';
import '../models/requests/loan_history_excel_request.dart';
import '../models/requests/mark_as_read_notification_request.dart';
import '../models/requests/marketing_banners_request.dart';
import '../models/requests/notices_notification_request.dart';
import '../models/requests/notification_count_request.dart';
import '../models/requests/past_card_excel_download.dart';
import '../models/requests/past_card_statements_pdf_download_request.dart';
import '../models/requests/promotion_share_request.dart';
import '../models/requests/req_money_notification_history_request.dart';
import '../models/requests/request_money_history_request.dart';
import '../models/requests/request_money_request.dart';
import '../models/requests/reset_password_request.dart';
import '../models/requests/schedule_bill_payment_request.dart';
import '../models/requests/schedule_ft_history_request.dart';

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
import '../models/requests/update_notification_settings_request.dart';
import '../models/responses/QrPaymentPdfDownloadResponse.dart';
import '../models/responses/acc_tran_status_excel.dart';
import '../models/responses/acc_tran_status_pdf.dart';
import '../models/responses/account_statement_pdf_download.dart';
import '../models/responses/account_statesment_xcel_download_response.dart';
import '../models/responses/account_tran_excel_response.dart';
import '../models/responses/account_transaction_history_pdf_response.dart';
import '../models/responses/apply_fd_calculator_response.dart';
import '../models/responses/apply_housing_loan_response.dart';
import '../models/responses/apply_leasing_response.dart';
import '../models/responses/apply_personal_loan_response.dart';
import '../models/responses/biller_pdf_download_response.dart';
import '../models/responses/calculator_share_pdf_response.dart';
import '../models/responses/card_management/card_statement_pdf_download_response.dart';
import '../models/responses/card_tran_excel_download.dart';
import '../models/responses/card_transaction_pdf.dart';
import '../models/responses/challenge_response.dart';
import '../models/responses/cheque_book_response.dart';
import '../models/responses/csi_response.dart';
import '../models/responses/delete_biller_response.dart';
import '../models/responses/delete_ft_schedule_response.dart';
import '../models/responses/edit_ft_schedule_response.dart';
import '../models/responses/favourite_biller_response.dart';
import '../models/responses/fd_calculator_response.dart';
import '../models/responses/fund_transfer_excel_dwnload_response.dart';
import '../models/responses/getBranchListResponse.dart';
import '../models/responses/getTxnCategoryList_response.dart';
import '../models/responses/get_account_name_ft_response.dart';
import '../models/responses/get_all_fund_transfer_schedule_response.dart';
import '../models/responses/get_currency_list_response.dart';
import '../models/responses/get_fd_period_response.dart';
import '../models/responses/get_fd_rate_response.dart';
import '../models/responses/get_justpay_instrument_response.dart';
import '../models/responses/get_money_notification_response.dart';
import '../models/responses/get_notification_settings_response.dart';
import '../models/responses/get_terms_response.dart';
import '../models/responses/lease_history_excel.dart';
import '../models/responses/lease_history_pdf.dart';
import '../models/responses/leasing_calculator_response.dart';
import '../models/responses/loan_history_excel_download.dart';
import '../models/responses/loan_history_pdf_download.dart';
import '../models/responses/marketing_banners_response.dart';
import '../models/responses/notices_notification_list.dart';
import '../models/responses/notification_count_response.dart';
import '../models/responses/past_card_excel_download.dart';
import '../models/responses/past_card_statements_pdf_response.dart';
import '../models/responses/promotion_share_response.dart';
import '../models/responses/req_money_notification_history_response.dart';
import '../models/responses/request_money_history_response.dart';
import '../models/responses/request_money_response.dart';
import '../models/responses/reset_password_response.dart';
import '../models/responses/schedule_bill_payment_response.dart';
import '../models/responses/schedule_ft_history_response.dart';
import '../models/responses/settings_tran_limit_response.dart';
import '../models/responses/splash_response.dart';

import '../models/requests/add_just_pay_instruements_request.dart';
import '../models/requests/add_user_inst_request.dart';
import '../models/requests/bill_payment_request.dart';
import '../models/requests/cdb_account_verfication_request.dart';
import '../models/requests/account_inquiry_request.dart';
import '../models/requests/account_statements_request.dart';
import '../models/requests/account_transaction_history_request.dart';
import '../models/requests/add_biller_request.dart';
import '../models/requests/add_itransfer_payee_request.dart';
import '../models/requests/add_pay_request.dart';
import '../models/requests/balance_inquiry_request.dart';
import '../models/requests/biometric_enable_request.dart';
import '../models/requests/biometric_login_request.dart';
import '../models/requests/challenge_request.dart';
import '../models/requests/change_password_request.dart';
import '../models/requests/contact_us_request.dart';
import '../models/requests/create_user_request.dart';
import '../models/requests/credit_card_req_field_data_request.dart';
import '../models/requests/credit_card_req_save_request.dart';
import '../models/requests/debit_card_req_field_data_request.dart';
import '../models/requests/debit_card_save_data_request.dart';
import '../models/requests/default_payment_instrument_request.dart';
import '../models/requests/delete_fund_transfer_payee_request.dart';
import '../models/requests/delete_itransfer_payee_request.dart';
import '../models/requests/edit_itransfer_payee_request.dart';
import '../models/requests/edit_nick_name_request.dart';
import '../models/requests/edit_payee_request.dart';
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
import '../models/requests/get_payee_request.dart';
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
import '../models/requests/lease_payment_history_request.dart';
import '../models/requests/lease_req_field_data_request.dart';
import '../models/requests/lease_req_save_data_request.dart';
import '../models/requests/loan_history_request.dart';
import '../models/requests/loan_req_field_data_request.dart';
import '../models/requests/loan_requests_field_data_request.dart';
import '../models/requests/loan_requests_submit_request.dart';
import '../models/requests/merchant_locator_request.dart';
import '../models/requests/mobile_login_request.dart';
import '../models/requests/otp_request.dart';
import '../models/requests/past_card_statement_request.dart';
import '../models/requests/portfolio_account_details_request.dart';
import '../models/requests/portfolio_cc_details_request.dart';
import '../models/requests/portfolio_loan_details_request.dart';
import '../models/requests/portfolio_user_fd_details_request.dart';
import '../models/requests/promotions_request.dart';
import '../models/requests/service_req_history_request.dart';
import '../models/requests/submit_products_request.dart';
import '../models/requests/submit_schedule_data_request.dart';
import '../models/requests/transaction_categories_list_request.dart';
import '../models/requests/transaction_history_pdf_download_request.dart';
import '../models/requests/transaction_limit_add_request.dart';
import '../models/requests/transaction_limit_request.dart';
import '../models/requests/transcation_details_request.dart';
import '../models/requests/un_favorite_biller_request.dart';
import '../models/requests/update_profile_image_request.dart';
import '../models/requests/view_personal_information_request.dart';
import '../models/responses/account_inquiry_response.dart';
import '../models/responses/account_statements_response.dart';
import '../models/responses/account_transaction_history_response.dart';
import '../models/responses/add_biller_response.dart';
import '../models/responses/add_itransfer_payee_response.dart';
import '../models/responses/add_just_pay_instruements_response.dart';
import '../models/responses/add_pay_response.dart';
import '../models/responses/balance_inquiry_response.dart';
import '../models/responses/bill_payment_response.dart';
import '../models/responses/biometric_enable_response.dart';
import '../models/responses/city_response.dart';
import '../models/responses/contact_us_response.dart';
import '../models/responses/create_user_response.dart';
import '../models/responses/credit_card_req_field_data_response.dart';
import '../models/responses/credt_card_req_save_response.dart';
import '../models/responses/debit_card_req_field_data_response.dart';
import '../models/responses/debit_card_save_data_response.dart';
import '../models/responses/delete_fund_transfer_payee_response.dart';
import '../models/responses/edit_payee_response.dart';
import '../models/responses/edit_user_biller_response.dart';
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
import '../models/responses/get_locator_response.dart';
import '../models/responses/get_other_products_response.dart';
import '../models/responses/get_payee_response.dart';
import '../models/responses/get_remaining_inst_response.dart';
import '../models/responses/get_schedule_time_response.dart';
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
import '../models/responses/lease_payment_history_response.dart';
import '../models/responses/lease_req_field_data_response.dart';
import '../models/responses/lease_req_save_data_response.dart';
import '../models/responses/loan_history_response.dart';
import '../models/responses/loan_req_field_data_response.dart';
import '../models/responses/loan_request_submit_response.dart';
import '../models/responses/loan_requests_field_data_response.dart';
import '../models/responses/mobile_login_response.dart';
import '../models/responses/otp_response.dart';
import '../models/responses/past_card_statement_response.dart';
import '../models/responses/portfolio_cc_details_response.dart';
import '../models/responses/portfolio_lease_details_response.dart';
import '../models/responses/portfolio_loan_details_response.dart';
import '../models/responses/portfolio_userfd_details_response.dart';
import '../models/responses/promotions_response.dart';
import '../models/responses/schedule_date_response.dart';
import '../models/responses/sec_question_response.dart';
import '../models/responses/service_req_filted_list_response.dart';
import '../models/responses/service_req_history_response.dart';
import '../models/responses/sr_service_charge_response.dart';
import '../models/responses/sr_statement_history_response.dart';
import '../models/responses/sr_statement_response.dart';
import '../models/responses/submit_other_products_response.dart';
import '../models/responses/transaction_categories_list_response.dart';
import '../models/responses/transaction_filter_pdf_download_response.dart';
import '../models/responses/transaction_filter_response.dart';
import '../models/responses/transaction_filtered_excel_download_response.dart';
import '../models/responses/transaction_history_pdf_download_respose.dart';
import '../models/responses/transaction_limit_response.dart';
import '../models/responses/transaction_pdf_download_response.dart';
import '../models/responses/transcation_details_response.dart';
import '../models/responses/update_profile_image_response.dart';
import '../models/responses/view_personal_information_response.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final APIHelper? apiHelper;

  RemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<BaseResponse<SplashResponse>> getSplash(
      CommonRequest splashRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/splash/",
        body: splashRequest.toJson(),
      );
      return BaseResponse<SplashResponse>.fromJson(
          response, (data) => SplashResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> verifyNIC(
      VerifyNicRequest verifyNicRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/customerNicVerify/",
        body: verifyNicRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  /// Get Terms and Conditions
  @override
  Future<BaseResponse<GetTermsResponse>> getTerms(
      GetTermsRequest getTermsRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/tnc/",
        body: getTermsRequest.toJson(),
      );
      return BaseResponse.fromJson(
          response, (data) => GetTermsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> registerCustomer(
      CustomerRegistrationRequest customerRegistrationRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/customerReg/",
        body: customerRegistrationRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> submitEmpDetails(
      EmpDetailRequest empDetailRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/employeeDetail/",
        body: empDetailRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> setSecurityQuestions(
      SetSecurityQuestionsRequest securityQuestionsRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/answerSecurityQuestion/",
        body: securityQuestionsRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> documentVerification(
      DocumentVerificationApiRequest documentVerificationApiRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/imgUpload/",
        body: documentVerificationApiRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> setPreferredLanguage(
      LanguageRequest params) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/language/",
        body: params.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> accountVerification(
      AccountVerificationRequest accountVerificationRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/customerAccountVerify/",
        body: accountVerificationRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  /// JustPay Challenge Id
  @override
  Future<BaseResponse<JustPayChallengeIdResponse>> justPayChallengeId(
      JustPayChallengeIdRequest justPayChallengeIdRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/justPayChallengeId/",
        body: justPayChallengeIdRequest.toJson(),
      );
      return BaseResponse<JustPayChallengeIdResponse>.fromJson(
          response, (data) => JustPayChallengeIdResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  ///Justpay T&C Sign
    @override
  Future<BaseResponse<Serializable>> justPayTCSign(JustpayTCSignRequest justpayTCSignRequest) async{
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/signedTermAndCondition/",
        body: justpayTCSignRequest.toJson(),
      );
       return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  ///JustPayAccountOnboarding
  @override
  Future<BaseResponse<JustPayAccountOnboardingResponse>> justPayOnboarding(
      JustPayAccountOnboardingRequest justPayAccountOnboardingRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/justPayCustomerReg/",
        body: justPayAccountOnboardingRequest.toJson(),
      );
      return BaseResponse<JustPayAccountOnboardingResponse>.fromJson(
          response, (data) => JustPayAccountOnboardingResponse.fromJson(data??{}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AccountStatementPdfDownloadResponse>>
      accStatementsPdfDownload(
          AccountStatementPdfDownloadRequest
              accountStatementPdfDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadAccountStatementsReport/",
        body: accountStatementPdfDownloadRequest.toJson(),
      );
      return BaseResponse<AccountStatementPdfDownloadResponse>.fromJson(
          response,
          (data) => AccountStatementPdfDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }


  @override
  Future<BaseResponse<QrPaymentPdfDownloadResponse>>
  qrPaymentPdfDownload(
      QrPaymentPdfDownloadRequest
      qrPaymentPdfDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/qrMerchantPaymentReceipt/",
        body: qrPaymentPdfDownloadRequest.toJson(),
      );
      return BaseResponse<QrPaymentPdfDownloadResponse>.fromJson(response,
          (data) => QrPaymentPdfDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }



  @override
  Future<BaseResponse<TransactionStatusPdfResponse>>
      transactionStatusPdfDownload(
          TransactionStatusPdfRequest transactionStatusPdfRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadTxnHistory/",
        body: transactionStatusPdfRequest.toJson(),
      );
      return BaseResponse<TransactionStatusPdfResponse>.fromJson(response,
          (data) => TransactionStatusPdfResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<TransactionFilteredPdfDownloadResponse>>
  transactionFilterPdfDownload(
      TransactionFilteredPdfDownloadRequest
      transactionFilteredPdfDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadTxnDetailsFiltered/",
        body: transactionFilteredPdfDownloadRequest.toJson(),
      );
      return BaseResponse<TransactionFilteredPdfDownloadResponse>.fromJson(
          response,
          (data) =>
              TransactionFilteredPdfDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<TransactionFilteredExcelDownloadResponse>>
  transactionFilterExcelDownload(
      TransactionFilteredExcelDownloadRequest
      transactionFilteredExcelDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadTxnDetailsFilteredExcel/",
        body: transactionFilteredExcelDownloadRequest.toJson(),
      );
      return BaseResponse<TransactionFilteredExcelDownloadResponse>.fromJson(
          response,
          (data) =>
              TransactionFilteredExcelDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<PromotionShareResponse>> promotionsPdfShare(
      PromotionShareRequest promotionShareRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/promotionItemPdf",
        body: promotionShareRequest.toJson(),
      );
      return BaseResponse<PromotionShareResponse>.fromJson(
          response, (data) => PromotionShareResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetNotificationSettingsResponse>> getNotificationSettings(
      GetNotificationSettingsRequest getNotificationSettingsRequest) async {
    try {
      final response = await apiHelper!.post(
        "notification/api/v1/getNotificationSetting/",
        body: getNotificationSettingsRequest.toJson(),
      );
      return BaseResponse<GetNotificationSettingsResponse>.fromJson(
          response, (data) => GetNotificationSettingsResponse.fromJson(data!));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<LeaseHistoryExcelResponse>> leaseHistoryExcelDownload(
      LeaseHistoryExcelRequest leaseHistoryExcelRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadLeasePaymentHistoryXLReport/",
        body: leaseHistoryExcelRequest.toJson(),
      );
      return BaseResponse<LeaseHistoryExcelResponse>.fromJson(
          response, (data) => LeaseHistoryExcelResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<LeaseHistoryPdfResponse>> leaseHistoryPdfDownload(
      LeaseHistoryPdfRequest leaseHistoryPdfRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadLeasePaymentHistoryReport/",
        body: leaseHistoryPdfRequest.toJson(),
      );
      return BaseResponse<LeaseHistoryPdfResponse>.fromJson(
          response, (data) => LeaseHistoryPdfResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CsiResponse>> csiData(
      CsiRequest csiRequest) async {
    try {
      final response = await apiHelper!.post(
        "account/api/chequeStatusInquiry",
        body: csiRequest.toJson(),
      );
      return BaseResponse<CsiResponse>.fromJson(
          response, (data) => CsiResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  // @override
  // Future<BaseResponse<TransactionFilterResponse>> transactionFilter(
  //     TransactionFilterRequest transactionFilterRequest) async {
  //   try {
  //     final response = await apiHelper!.post(
  //       "txn/api/v1/getTxnDetailsFiltered/",
  //       body: transactionFilterRequest.toJson(),
  //     );
  //     return BaseResponse<TransactionFilterResponse>.fromJson(
  //         response, (data) => TransactionFilterResponse.fromJson(data!));
  //   } on Exception {
  //     rethrow;
  //   }
  // }



  @override
  Future<BaseResponse<TransactionFilterResponse>> transactionFilter(
      TransactionFilterRequest transactionFilterRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/getTxnDetailsFiltered/",
        body: transactionFilterRequest.toJson(),
      );
      return BaseResponse<TransactionFilterResponse>.fromJson(response, (data) {
        if (data == null) {
          return TransactionFilterResponse();
        } else {
          return TransactionFilterResponse.fromJson(data);
        }
      });
    } on Exception {
      rethrow;
    }
  }




  @override
  Future<BaseResponse<LoanHistoryExcelResponse>> loanHistoryExcelDownload(
      LoanHistoryExcelRequest loanHistoryExcelRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadLoanPaymentHistoryXLReport/",
        body: loanHistoryExcelRequest.toJson(),
      );
      return BaseResponse<LoanHistoryExcelResponse>.fromJson(
          response, (data) => LoanHistoryExcelResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AccountTransactionExcelResponse>>
      accTransactionExcelDownload(
          AccountTransactionExcelRequest accountTransactionExcelRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadViewRecentTransactionHistoryXLReport/",
        body: accountTransactionExcelRequest.toJson(),
      );
      return BaseResponse<AccountTransactionExcelResponse>.fromJson(response,
          (data) => AccountTransactionExcelResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardTransactionExcelResponse>> cardTranExcelDownload(
      CardTransactionExcelRequest cardTransactionExcelRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/cardTransactionHistoryXLReport/",
        body: cardTransactionExcelRequest.toJson(),
      );
      return BaseResponse<CardTransactionExcelResponse>.fromJson(response,
          (data) => CardTransactionExcelResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }
  @override
  Future<BaseResponse<GetMoneyNotificationResponse>> getMoneyNotification(
      GetMoneyNotificationRequest getMoneyNotificationRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/getRequestMoney/",
        body: getMoneyNotificationRequest.toJson(),
      );
      return BaseResponse<GetMoneyNotificationResponse>.fromJson(response,
          (data) => GetMoneyNotificationResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardTransactionPdfResponse>> cardTranPdfDownload(
      CardTransactionPdfRequest cardTransactionPdfRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/cardTransactionHistoryPDFReport/",
        body: cardTransactionPdfRequest.toJson(),
      );
      return BaseResponse<CardTransactionPdfResponse>.fromJson(
          response, (data) => CardTransactionPdfResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AccTranStatusExcelDownloadResponse>>
      accTranStatusExcelDownload(
          AccTranStatusExcelDownloadRequest
              accTranStatusExcelDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/transactionStatusXLReport/",
        body: accTranStatusExcelDownloadRequest.toJson(),
      );
      return BaseResponse<AccTranStatusExcelDownloadResponse>.fromJson(response,
          (data) => AccTranStatusExcelDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<NotificationCountResponse>>
  notificationCount(
      NotificationCountRequest
              notificationCountRequest) async {
    try {
      final response = await apiHelper!.post(
        "notification/api/v1/getNotificationsCounts/",
        body: notificationCountRequest.toJson(),
      );
      return BaseResponse<NotificationCountResponse>.fromJson(
          response, (data) => NotificationCountResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AccountTransactionsPdfDownloadResponse>>
      accTransactionsPdfDownload(
          AccountTransactionsPdfDownloadRequest
              accountTransactionsPdfDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadViewRecentTransactionHistoryReport/",
        body: accountTransactionsPdfDownloadRequest.toJson(),
      );
      return BaseResponse<AccountTransactionsPdfDownloadResponse>.fromJson(
          response,
          (data) =>
              AccountTransactionsPdfDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AccTranStatusPdfDownloadResponse>>
      accTransactionsStatusPdfDownload(
          AccTranStatusPdfDownloadRequest
              accTranStatusPdfDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/transactionStatusReport/",
        body: accTranStatusPdfDownloadRequest.toJson(),
      );
      return BaseResponse<AccTranStatusPdfDownloadResponse>.fromJson(response,
          (data) => AccTranStatusPdfDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AccountSatementsXcelDownloadResponse>>
      accStatementsXcelDownload(
          AccountSatementsXcelDownloadRequest
              accountSatementsXcelDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadAccountStatementsXLReport/",
        body: accountSatementsXcelDownloadRequest.toJson(),
      );
      return BaseResponse<AccountSatementsXcelDownloadResponse>.fromJson(
          response,
          (data) => AccountSatementsXcelDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<LoanHistoryPdfResponse>> loanHistoryPdfDownload(
      LoanHistoryPdfRequest loanHistoryPdfRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadLoanPaymentHistoryReport/",
        body: loanHistoryPdfRequest.toJson(),
      );
      return BaseResponse<LoanHistoryPdfResponse>.fromJson(
          response, (data) => LoanHistoryPdfResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<PastCardExcelDownloadResponse>> pastCardExcelDownload(
      PastCardExcelDownloadRequest pastCardExcelDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadPastCardStatementsXLReport/",
        body: pastCardExcelDownloadRequest.toJson(),
      );
      return BaseResponse<PastCardExcelDownloadResponse>.fromJson(response,
          (data) => PastCardExcelDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardStatementPdfResponse>> cardStatementPdfDownload(
      CardStateentPdfDownloadRequest cardStateentPdfDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadPastCardStatementsReport/",
        body: cardStateentPdfDownloadRequest.toJson(),
      );
      return BaseResponse<CardStatementPdfResponse>.fromJson(response,
          (data) => CardStatementPdfResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<PastcardStatementstPdfDownloadResponse>>
      pastCardStatementsPdfDownload(
          PastcardStatementstPdfDownloadRequest
              pastcardStatementstPdfDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/downloadAccountStatementsReport/",
        body: pastcardStatementstPdfDownloadRequest.toJson(),
      );
      return BaseResponse<PastcardStatementstPdfDownloadResponse>.fromJson(
          response,
          (data) =>
              PastcardStatementstPdfDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> justPayVerification(
      JustPayVerificationRequest justPayVerificationRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/justPayVerify/",
        body: justPayVerificationRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> updateNotificationSettings(
      UpdateNotificationSettingsRequest
          updateNotificationSettingsRequest) async {
    try {
      final response = await apiHelper!.post(
        "notification/api/v1/notificationSettingUpdate/",
        body: updateNotificationSettingsRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> ubAccountVerification(
      UBAccountVerificationRequest ubAccountVerificationRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/existingCustomerReg/",
        body: ubAccountVerificationRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  /// Accept Terms and Conditions
  @override
  Future<BaseResponse> acceptTerms(
      TermsAcceptRequestEntity termsAcceptRequestEntity) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/tnc-acceptance/",
        body: termsAcceptRequestEntity.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  /// Get City
  @override
  Future<BaseResponse<CityDetailResponse>> getCityData(
      CommonRequest commonRequest) async {
    try {
      final response = await apiHelper!
          .post("api/v1/cityDetail/", body: commonRequest.toJson());
      return BaseResponse<CityDetailResponse>.fromJson(
          response, (data) => CityDetailResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CreateUserResponse>> createUser(
      CreateUserRequest createUserRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/userCreation/",
        body: createUserRequest.toJson(),
      );
      return BaseResponse<CreateUserResponse>.fromJson(response, (data) {
        if (data == null) {
          return CreateUserResponse();
        } else {
          return CreateUserResponse.fromJson(data);
        }
      });
    } on Exception {
      rethrow;
    }
  }

    @override
  Future<BaseResponse<Serializable>> checkUser(CheckUserRequest checkUserRequest) async{
        try {
      final response = await apiHelper!.post(
        "auth/api/v1/verifyUserName/",
        body: checkUserRequest.toJson(),
      );
     return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }
  @override
  Future<BaseResponse<RequestMoneyResponse>> requestMoney(
      RequestMoneyRequest requestMoneyRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/requestMoney/",
        body: requestMoneyRequest.toJson(),
      );
      return BaseResponse<RequestMoneyResponse>.fromJson(response, (data) {
        if (data == null) {
          return RequestMoneyResponse();
        } else {
          return RequestMoneyResponse.fromJson(data);
        }
      });
    } on Exception {
      rethrow;
    }
  }

  ///Get Schedule Dates
  @override
  Future<BaseResponse<ScheduleDateResponse>> getScheduleDates(
      CommonRequest scheduleDateRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/customerConfSchDate/",
        body: scheduleDateRequest.toJson(),
      );
      return BaseResponse<ScheduleDateResponse>.fromJson(
          response, (data) => ScheduleDateResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetOtherProductsResponse>> getOtherProducts(
      CommonRequest otherProductsRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/insProductList/",
        body: otherProductsRequest.toJson(),
      );
      return BaseResponse<GetOtherProductsResponse>.fromJson(
          response, (data) => GetOtherProductsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<SubmitProductsResponse>> submitOtherProducts(
      SubmitProductsRequest submitProductsRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/saveInsProduct/",
        body: submitProductsRequest.toJson(),
      );
      return BaseResponse<SubmitProductsResponse>.fromJson(
          response, (data) => SubmitProductsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  /// Get Designation
  @override
  Future<BaseResponse<CityDetailResponse>> getDesignationData(
      CommonRequest commonRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/designationDetail/",
        body: commonRequest.toJson(),
      );
      return BaseResponse<CityDetailResponse>.fromJson(
          response, (data) => CityDetailResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<SecurityQuestionResponse>> getSecurityQuestions(
      SecurityQuestionRequestEntity commonRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/securityQuestionList/",
        body: commonRequest.toJson(),
      );
      return BaseResponse<SecurityQuestionResponse>.fromJson(
          response, (data) => SecurityQuestionResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ChallengeResponse>> otpVerification(
      ChallengeRequest challengeRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/challengeReq/",
        body: challengeRequest.toJson(),
      );
      return BaseResponse<ChallengeResponse>.fromJson(
          response, (data) => ChallengeResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  // @override
  // Future<BaseResponse<Serializable>> otpVerification(
  //     ChallengeRequest challengeRequest) async {
  //   try {
  //     final response = await apiHelper!.post(
  //       "auth/api/v1/challengeReq/",
  //       body: challengeRequest.toJson(),
  //     );
  //     return BaseResponse.fromJson(response, (_) {});
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  @override
  Future<BaseResponse<MobileLoginResponse>> mobileLogin(
      MobileLoginRequest mobileLoginRequest) async {
    try {
      final response = await apiHelper!.post(
        "login/api/v1/mobile",
        // "login/mobile",
        body: mobileLoginRequest.toJson(),
      );
      return BaseResponse<MobileLoginResponse>.fromJson(
          response, (data) => MobileLoginResponse.fromJson(data??{}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/changePassword/",
        body: changePasswordRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetScheduleTimeResponse>> getScheduleTimeSlots(
      GetScheduleTimeRequest scheduleTimeRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/customerConfSchTime/",
        body: scheduleTimeRequest.toJson(),
      );
      return BaseResponse<GetScheduleTimeResponse>.fromJson(
          response, (data) => GetScheduleTimeResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> submitScheduleData(
      SubmitScheduleDataRequest request) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/customerConfSchDetail/",
        body: request.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<BiometricEnableResponse>> biometricEnable(
      BiometricEnableRequest biometricEnableRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/enableBiometric",
        body: biometricEnableRequest.toJson(),
      );
      return BaseResponse<BiometricEnableResponse>.fromJson(
          response, (data) => BiometricEnableResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  ///Contact Us
  @override
  Future<BaseResponse<ContactUsResponseModel>> getContactUs(
      ContactUsRequestModel contactUsRequestModel) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/contactUs",
        body: contactUsRequestModel.toJson(),
      );
      return BaseResponse<ContactUsResponseModel>.fromJson(
          response, (data) => ContactUsResponseModel.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<MobileLoginResponse>> biometricLogin(
      BiometricLoginRequest biometricLoginRequest) async {
    try {
      final response = await apiHelper!.post(
        // "biometric/login",
        "login/api/v1/biometric",
        body: biometricLoginRequest.toJson(),
      );
      return BaseResponse<MobileLoginResponse>.fromJson(
          response, (data) => MobileLoginResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  /// Edit Biller
  @override
  Future<BaseResponse<EditUserBillerResponse>> editBiller(
      EditUserBillerRequest editUserBillerRequest) async {
    try {
      final response = await apiHelper!.put(
        "fundtransfer/api/v1/userBiller/",
        body: editUserBillerRequest.toJson(),
      );
      // return BaseResponse.fromJson(response, (_) {});
      return BaseResponse<EditUserBillerResponse>.fromJson(
          response, (data) => EditUserBillerResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetSavedBillersResponse>> getSavedBillers(
      CommonRequest commonRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/userBillerList/",
        body: commonRequest.toJson(),
      );
      return BaseResponse<GetSavedBillersResponse>.fromJson(
          response, (data) => GetSavedBillersResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AddBillerResponse>> addBiller(
      AddBillerRequest addBillerRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/userBiller/",
        body: addBillerRequest.toJson(),
      );
      return BaseResponse<AddBillerResponse>.fromJson(
          response, (data) => AddBillerResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetBillerCategoryListResponse>> getBillerCategoryList(
      CommonRequest commonRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/bspCategoryList/",
        body: commonRequest.toJson(),
      );
      return BaseResponse<GetBillerCategoryListResponse>.fromJson(response,
          (data) => GetBillerCategoryListResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetAllFundTransferScheduleResponse>> getAllFTScheduleList(
      GetAllFundTransferScheduleRequest
          getAllFundTransferScheduleRequest) async {
    try {
      final response = await apiHelper!.post(
        "schfund/api/v1/scheduledTransaction/getScheduledTransactionByEpicUserId/",
        body: getAllFundTransferScheduleRequest.toJson(),
      );
      return BaseResponse<GetAllFundTransferScheduleResponse>.fromJson(response,
          (data) => GetAllFundTransferScheduleResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<DeleteFtScheduleResponse>> deleteFTScedule(
      DeleteFtScheduleRequest deleteFtScheduleRequest) async {
    try {
      final response = await apiHelper!.post(
        "/schfund/api/v1/scheduledTransaction/cancel",
        body: deleteFtScheduleRequest.toJson(),
      );
      return BaseResponse<DeleteFtScheduleResponse>.fromJson(
          response, (data) => DeleteFtScheduleResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<PastCardStatementsresponse>> pastCardStatements(
      PastCardStatementsrequest pastCardStatementsrequest) async {
    try {
      final response = await apiHelper!.post(
        // "account/api/v1/getCreditCardPastStatement/",
        "card-communicator/api/v1/viewSt",
        body: pastCardStatementsrequest.toJson(),
      );
      return BaseResponse<PastCardStatementsresponse>.fromJson(
          response, (data) => PastCardStatementsresponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }


  @override
  Future<BaseResponse<AccountTransactionHistoryresponse>> accountTransactions(
      AccountTransactionHistorysrequest
          accountTransactionHistorysrequest) async {
    try {
      final response = await apiHelper!.post(
        "account/api/v1/getUserAccountRecentTransactions/",
        body: accountTransactionHistorysrequest.toJson(),
      );
      return BaseResponse<AccountTransactionHistoryresponse>.fromJson(response,
          (data) => AccountTransactionHistoryresponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<LoanHistoryresponse>> loanHistory(
      LoanHistoryrequest loanHistoryrequest) async {
    try {
      final response = await apiHelper!.post(
        "account/api/v1/userLoanPaymentHistory/",
        body: loanHistoryrequest.toJson(),
      );
      return BaseResponse<LoanHistoryresponse>.fromJson(
          response, (data) => LoanHistoryresponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<LeaseHistoryresponse>> leaseHistory(
      LeaseHistoryrequest leaseHistoryrequest) async {
    try {
      final response = await apiHelper!.post(
        "account/api/v1/userLeasePaymentHistory/",
        body: leaseHistoryrequest.toJson(),
      );
      return BaseResponse<LeaseHistoryresponse>.fromJson(
          response, (data) => LeaseHistoryresponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AccountStatementsresponse>> accountStatements(
      AccountStatementsrequest accountStatementsrequest) async {
    try {
      final response = await apiHelper!.post(
        "account/api/v1/getUserAccountStatement/",
        body: accountStatementsrequest.toJson(),
      );
      return BaseResponse<AccountStatementsresponse>.fromJson(
          response, (data) => AccountStatementsresponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  ///Delete Biller
  @override
  Future<BaseResponse<DeleteBillerResponse>> deleteBiller(
      DeleteBillerRequest deleteBillerRequest) async {
    try {
      final response = await apiHelper!.delete(
        "fundtransfer/api/v1/userBiller/",
        body: deleteBillerRequest.toJson(),
      );
      return BaseResponse<DeleteBillerResponse>.fromJson(
          response, (data) => DeleteBillerResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  ///Service req Statement
  @override
  Future<BaseResponse<SrStatementResponse>> srStatement(
      SrStatementRequest srStatementRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/addStatementRequest",
        body: srStatementRequest.toJson(),
      );
      return BaseResponse<SrStatementResponse>.fromJson(
          response, (data) => SrStatementResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  ///UnFavorite Biller
  @override
  Future<BaseResponse<Serializable>> unFavoriteBiller(
      UnFavoriteBillerRequest unFavoriteBillerRequest) async {
    try {
      final response = await apiHelper!.put(
        "api/v1/billerFavorites/",
        body: unFavoriteBillerRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<MerchantLocatorResponse>> merchantLocator(
      MerchantLocatorRequest merchantLocatorRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/getLocationsDetails",
        body: merchantLocatorRequest.toJson(),
      );
      return BaseResponse<MerchantLocatorResponse>.fromJson(
          response, (data) => MerchantLocatorResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<SrServiceChargeResponse>> srServiceCharge(
      SrServiceChargeRequest srServiceChargeRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/getServiceRequestCharges",
        body: srServiceChargeRequest.toJson(),
      );
      return BaseResponse<SrServiceChargeResponse>.fromJson(
          response, (data) => SrServiceChargeResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AccountInquiryResponse>> accountInquiry(
      AccountInquiryRequest accountInquiryRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/accounts/",
        body: accountInquiryRequest.toJson(),
      );
      return BaseResponse<AccountInquiryResponse>.fromJson(
          response, (data) => AccountInquiryResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<BalanceInquiryResponse>> balanceInquiry(
      BalanceInquiryRequest balanceInquiryRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/balance/",
        body: balanceInquiryRequest.toJson(),
      );
      return BaseResponse<BalanceInquiryResponse>.fromJson(
          response, (data) => BalanceInquiryResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetBankListResponse>> getBankList(
      GetBankListRequest getBankListRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/bankList",
        body: getBankListRequest.toJson(),
      );
      return BaseResponse<GetBankListResponse>.fromJson(
          response, (data) => GetBankListResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AddPayResponse>> payManagementAddPay(
      AddPayRequest addPayRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/payee",
        body: addPayRequest.toJson(),
      );
      return BaseResponse<AddPayResponse>.fromJson(
          response, (data) => AddPayResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<EditPayeeResponse>> editPayee(
      EditPayeeRequest editPayeeRequest) async {
    try {
      final response = await apiHelper!.put(
        "fundtransfer/api/v1/payee",
        body: editPayeeRequest.toJson(),
      );
      return BaseResponse<EditPayeeResponse>.fromJson(
          response, (data) => EditPayeeResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<FundTransferPayeeListResponse>> fundTransferPayeeList(
      FundTransferPayeeListRequest fundTransferPayeeListRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/payeeList",
        body: fundTransferPayeeListRequest.toJson(),
      );
      return BaseResponse<FundTransferPayeeListResponse>.fromJson(response,
          (data) => FundTransferPayeeListResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetPayeeResponse>> getPayeeList(
      GetPayeeRequest getPayeeRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/payeeList",
        body: getPayeeRequest.toJson(),
      );
      return BaseResponse<GetPayeeResponse>.fromJson(
          response, (data) => GetPayeeResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<DeleteFundTransferPayeeResponse>> deleteFundTransferPayee(
      DeleteFundTransferPayeeRequest deleteFundTransferPayeeRequest) async {
    try {
      final response = await apiHelper!.delete(
        "fundtransfer/api/v1/payee",
        body: deleteFundTransferPayeeRequest.toJson(),
      );
      return BaseResponse<DeleteFundTransferPayeeResponse>.fromJson(response,
          (data) => DeleteFundTransferPayeeResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<HousingLoanResponseModel>> housingLoanList(
      HousingLoanRequestModel housingLoanRequestModel) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/housingLoanCalculator",
        body: housingLoanRequestModel.toJson(),
      );
      return BaseResponse<HousingLoanResponseModel>.fromJson(
          response, (data) => HousingLoanResponseModel.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ApplyHousingLoanResponse>> applyHousingLoanList(
      ApplyHousingLoanRequest applyHousingLoanRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/applyHousingLoan",
        body: applyHousingLoanRequest.toJson(),
      );
      return BaseResponse<ApplyHousingLoanResponse>.fromJson(response, (data) {
        if (data == null) {
          return ApplyHousingLoanResponse();
        } else {
          return ApplyHousingLoanResponse.fromJson(data);
        }
      });
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<LeasingCalculatorResponse>> leasingCalculatorList(
      LeasingCalculatorRequest leasingCalculatorRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/leasingCalculator",
        body: leasingCalculatorRequest.toJson(),
      );
      return BaseResponse<LeasingCalculatorResponse>.fromJson(
          response, (data) => LeasingCalculatorResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ApplyLeasingCalculatorResponse>> applyLeasingList(
      ApplyLeasingCalculatorRequest applyLeasingCalculatorRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/applyLeasing",
        body: applyLeasingCalculatorRequest.toJson(),
      );
      return BaseResponse<ApplyLeasingCalculatorResponse>.fromJson(response,
          (data) {
        if (data == null) {
          return ApplyLeasingCalculatorResponse();
        } else {
          return ApplyLeasingCalculatorResponse.fromJson(data);
        }
      });
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<FdCalculatorResponse>> fdCalculatorList(
      FdCalculatorRequest fdCalculatorRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/fixedDepositeCalculator",
        body: fdCalculatorRequest.toJson(),
      );
      return BaseResponse<FdCalculatorResponse>.fromJson(
          response, (data) => FdCalculatorResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ApplyFdCalculatorResponse>> applyFDCalculatorList(
      ApplyFdCalculatorRequest applyFdCalculatorRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/applyFD",
        body: applyFdCalculatorRequest.toJson(),
      );
      return BaseResponse<ApplyFdCalculatorResponse>.fromJson(response, (data) {
        if (data == null) {
          return ApplyFdCalculatorResponse();
        } else {
          return ApplyFdCalculatorResponse.fromJson(data);
        }
      });
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<EditFtScheduleResponse>> editFTSchedule(
      EditFtScheduleRequest editFtScheduleRequest) async {
    try {
      final response = await apiHelper!.post(
        "/schfund/api/v1/updateScheduledTransaction",
        body: editFtScheduleRequest.toJson(),
      );
      return BaseResponse<EditFtScheduleResponse>.fromJson(
          response, (data) => EditFtScheduleResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  // @override
  // Future<BaseResponse<EditFtScheduleResponse>> editFTSchedule(
  //     EditFtScheduleRequest editFtScheduleRequest) async {
  //   try {
  //     final response = await apiHelper!.post(
  //       "/schfund/api/v1/updateScheduledTransaction",
  //       body: editFtScheduleRequest.toJson(),
  //     );
  //     return BaseResponse<EditFtScheduleResponse>.fromJson(response, (data) {
  //       if (data == null) {
  //         return ApplyPersonalLoanResponse();
  //       } else {
  //         return ApplyFdCalculatorResponse.fromJson(data);
  //       }
  //     });
  //   } on Exception {
  //     rethrow;
  //   }
  // }
  // @override
  // Future<BaseResponse<DeleteFundTransferPayeeResponse>> deleteFundTransferPayee(
  //     DeleteFundTransferPayeeRequest deleteFundTransferPayeeRequest) async {
  //   try {
  //     final response = await apiHelper!.delete(
  //       "payee",
  //       body: deleteFundTransferPayeeRequest.toJson(),
  //     );
  //     return BaseResponse<DeleteFundTransferPayeeResponse>.fromJson(
  //         response, (data) => DeleteFundTransferPayeeResponse.fromJson(data!));
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  @override
  Future<BaseResponse<GetBranchListResponse>> getBranchList(
      GetBranchListRequest getBranchListRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/bankAndBranchList",
        body: getBranchListRequest.toJson(),
      );
      return BaseResponse<GetBranchListResponse>.fromJson(
          response, (data) => GetBranchListResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<FaqResponse>> preLoginFaq(FaqRequest faqRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/faqList",
        body: faqRequest.toJson(),
      );
      return BaseResponse<FaqResponse>.fromJson(
          response, (data) => FaqResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ImageApiResponseModel>> getImage(
      ImageApiRequestModel imageApiRequest) async {
    try {
      final response = await apiHelper!.post(
        "login/api/v1/profileImage/",
        body: imageApiRequest.toJson(),
      );
      return BaseResponse<ImageApiResponseModel>.fromJson(
        response,
        (data) => ImageApiResponseModel.fromJson(data ?? {}),
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<PromotionsResponse>> getPromotions(
      PromotionsRequest promotionsRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/promotionList",
        body: promotionsRequest.toJson(),
      );
      return BaseResponse<PromotionsResponse>.fromJson(
          response, (data) => PromotionsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GoldLoanListResponse>> goldLoanList(
      GoldLoanListRequest goldLoanListRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/goldLoanList",
        body: goldLoanListRequest.toJson(),
      );
      return BaseResponse<GoldLoanListResponse>.fromJson(
          response, (data) => GoldLoanListResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GoldLoanDetailsResponse>> goldLoanDetails(
      GoldLoanDetailsRequest goldLoanDetailsRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/goldLoanDetails",
        body: goldLoanDetailsRequest.toJson(),
      );
      return BaseResponse<GoldLoanDetailsResponse>.fromJson(
          response, (data) => GoldLoanDetailsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GoldLoanPaymentTopUpResponse>> goldLoanPaymentTopUp(
      GoldLoanPaymentTopUpRequest goldLoanPaymentTopUpRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/goldLoanTopUp",
        body: goldLoanPaymentTopUpRequest.toJson(),
      );
      return BaseResponse<GoldLoanPaymentTopUpResponse>.fromJson(response,
          (data) => GoldLoanPaymentTopUpResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  ///Intra Fund Transfer
  @override
  Future<BaseResponse<IntraFundTransferResponse>> getIntraFundTransfer(
      IntraFundTransferRequest intraFundTransferRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/fundTransfer",
        body: intraFundTransferRequest.toJson(),
      );
      return BaseResponse<IntraFundTransferResponse>.fromJson(
          response, (data) => IntraFundTransferResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<TransactionCategoriesListResponse>>
      transactionCategoriesList(
          TransactionCategoriesListRequest
              transactionCategoriesListRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/fundTransferTxnCategory",
        body: transactionCategoriesListRequest.toJson(),
      );
      return BaseResponse<TransactionCategoriesListResponse>.fromJson(response,
          (data) => TransactionCategoriesListResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AddItransferPayeeResponse>> addItransferPayee(
      AddItransferPayeeRequest addItransferPayeeRequest) async {
    try {
      final response = await apiHelper!.post(
        "iTransfer/api/v1/addPayee",
        body: addItransferPayeeRequest.toJson(),
      );
      return BaseResponse<AddItransferPayeeResponse>.fromJson(
          response, (data) => AddItransferPayeeResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ItransferPayeeListResponse>> itransferPayeeList(
      ItransferPayeeListRequest itransferPayeeListRequest) async {
    try {
      final response = await apiHelper!.post(
        "iTransfer/api/v1/getPayees",
        body: itransferPayeeListRequest.toJson(),
      );
      return BaseResponse<ItransferPayeeListResponse>.fromJson(
          response, (data) => ItransferPayeeListResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> editItransferPayee(
      EditItransferPayeeRequest editItransferPayeeRequest) async {
    try {
      final response = await apiHelper!.post(
        "iTransfer/api/v1/editPayee",
        body: editItransferPayeeRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> deleteItransferPayee(
      DeleteItransferPayeeRequest deleteItransferPayeeRequest) async {
    try {
      final response = await apiHelper!.post(
        "iTransfer/api/v1/deletePayees",
        body: deleteItransferPayeeRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }
  @override
  Future<BaseResponse<Serializable>> txnLimitReset(
      TxnLimitResetRequest txnLimitResetRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/resetTxnLimit/",
        body: txnLimitResetRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> cdbAccountVerification(
      CdbAccountVerificationRequest cdbAccountVerificationRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/existingCustomerReg/",
        body: cdbAccountVerificationRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  ///OTP
  @override
  Future<BaseResponse<OtpResponse>> otpRequest(OtpRequest otpRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/otpSend",
        body: otpRequest.toJson(),
      );
      return BaseResponse<OtpResponse>.fromJson(
          response, (data) => OtpResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<LoanRequestFieldDataResponse>> loanRequestsFieldData(
      LoanRequestsFieldDataRequest loanRequestsFieldDataRequest) async {
    try {
      final response = await apiHelper!.post(
        "loanRequest/api/v1/fieldData",
        body: loanRequestsFieldDataRequest.toJson(),
      );
      return BaseResponse<LoanRequestFieldDataResponse>.fromJson(response,
          (data) => LoanRequestFieldDataResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetUserInstResponse>> getUserInstruments(
      GetUserInstRequest getUserInstRequest) async {
    try {
      final response = await apiHelper!.post(
        "account/api/v1/userInstruments/",
        body: getUserInstRequest.toJson(),
      );
      return BaseResponse<GetUserInstResponse>.fromJson(
          response, (data) => GetUserInstResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ScheduleFtHistoryResponse>> scheduleFTHistory(
      ScheduleFtHistoryReq scheduleFtHistoryReq) async {
    try {
      final response = await apiHelper!.post(
        "/schfund/api/v1/getSchTxnHistory",
        body: scheduleFtHistoryReq.toJson(),
      );
      return BaseResponse<ScheduleFtHistoryResponse>.fromJson(
          response, (data) => ScheduleFtHistoryResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetRemainingInstResponse>> getRemainingInstruments(
      GetRemainingInstRequest getRemainingInstRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/remainingInstruments/",
        body: getRemainingInstRequest.toJson(),
      );
      return BaseResponse<GetRemainingInstResponse>.fromJson(
          response, (data) => GetRemainingInstResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> addUserInstrument(
      AddUserInstRequest addUserInstRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/addCdbInstrument/",
        body: addUserInstRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<LoanRequestsSubmitResponse>> loanReqSaveData(
      LoanRequestsSubmitRequest loanRequestsSubmitRequest) async {
    try {
      final response = await apiHelper!.post(
        "loanRequest/api/v1/send",
        body: loanRequestsSubmitRequest.toJson(),
      );
      return BaseResponse<LoanRequestsSubmitResponse>.fromJson(
          response, (data) => LoanRequestsSubmitResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CreditCardReqFieldDataResponse>> creditCardReqFieldData(
      CreditCardReqFieldDataRequest creditCardReqFieldDataRequest) async {
    try {
      final response = await apiHelper!.post(
        "creditCardRequest/api/v1/fieldData",
        body: creditCardReqFieldDataRequest.toJson(),
      );
      return BaseResponse<CreditCardReqFieldDataResponse>.fromJson(response,
          (data) => CreditCardReqFieldDataResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CreditCardReqSaveResponse>> creditCardReqSave(
      CreditCardReqSaveRequest creditCardReqSaveRequest) async {
    try {
      final response = await apiHelper!.post(
        "creditCardRequest/api/v1/send",
        body: creditCardReqSaveRequest.toJson(),
      );
      return BaseResponse<CreditCardReqSaveResponse>.fromJson(
          response, (data) => CreditCardReqSaveResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<LeaseReqFieldDataResponse>> leaseReqFieldData(
      LeaseReqFieldDataRequest leaseReqFieldDataRequest) async {
    try {
      final response = await apiHelper!.post(
        "leaseRequest/api/v1/fieldData",
        body: leaseReqFieldDataRequest.toJson(),
      );
      return BaseResponse<LeaseReqFieldDataResponse>.fromJson(
          response, (data) => LeaseReqFieldDataResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<LeaseReqSaveDataResponse>> leaseReqSaveData(
      LeaseReqSaveDataRequest leaseReqSaveDataRequest) async {
    try {
      final response = await apiHelper!.post(
        "leaseRequest/api/v1/send",
        body: leaseReqSaveDataRequest.toJson(),
      );
      return BaseResponse<LeaseReqSaveDataResponse>.fromJson(
          response, (data) => LeaseReqSaveDataResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  /// JustPay Challenge Id
  @override
  Future<BaseResponse<JustPayChallengeIdResponse>> JustPayChallengeId(
      JustPayChallengeIdRequest justPayChallengeIdRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/justPayChallengeId/",
        body: justPayChallengeIdRequest.toJson(),
      );
      return BaseResponse<JustPayChallengeIdResponse>.fromJson(
          response, (data) => JustPayChallengeIdResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  ///Settings tran Limit
  @override
  Future<BaseResponse<SettingsTranLimitResponse>> settingsTranLimit(
      SettingsTranLimitRequest settingsTranLimitRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/txnLimit/",
        body: settingsTranLimitRequest.toJson(),
      );
      return BaseResponse<SettingsTranLimitResponse>.fromJson(
          response, (data) => SettingsTranLimitResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  ///Calculator PDF
  @override
  Future<BaseResponse<CalculatorPdfResponse>> calculatorPDF(
      CalculatorPdfRequest calculatorPdfRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/calculatorPdf",
        body: calculatorPdfRequest.toJson(),
      );
      return BaseResponse<CalculatorPdfResponse>.fromJson(
          response, (data) => CalculatorPdfResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<TransactionDetailsResponse>> getTransactionDetails(
      TransactionDetailsRequest transactionDetailsRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/getTxnDetails/",
        body: transactionDetailsRequest.toJson(),
      );
      return BaseResponse<TransactionDetailsResponse>.fromJson(response, (data) {
        if (data == null) {
          return TransactionDetailsResponse();
        } else {
          return TransactionDetailsResponse.fromJson(data);
        }
      });
    } on Exception {
      rethrow;
    }
  }

  // /// Transaction Details
  // @override
  // Future<BaseResponse<TransactionDetailsResponse>> getTransactionDetails(
  //     TransactionDetailsRequest transactionDetailsRequest) async {
  //   try {
  //     final response = await apiHelper!.post(
  //       "txn/api/v1/getTxnDetails/",
  //       body: transactionDetailsRequest.toJson(),
  //     );
  //     return BaseResponse<TransactionDetailsResponse>.fromJson(
  //         response, (data) => TransactionDetailsResponse.fromJson(data!));
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  @override
  Future<BaseResponse<Serializable>> justPayInstruements(
      JustPayInstruementsReques justPayInstruementsReques) async {
    try {
      final response = await apiHelper!.post(
        "account/api/v1/justPayInstrumentRequest/",
        body: justPayInstruementsReques.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ServiceReqHistoryResponse>> serviceReqHistory(
      ServiceReqHistoryRequest serviceReqHistoryRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/serviceRequest/history",
        body: serviceReqHistoryRequest.toJson(),
      );
      return BaseResponse<ServiceReqHistoryResponse>.fromJson(
          response, (data) => ServiceReqHistoryResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<LoanReqFieldDataResponse>> loanReq(
      LoanReqFieldDataRequest loanReqFieldDataRequest) async {
    try {
      final response = await apiHelper!.post(
        "loanRequest/api/v1/fieldData",
        body: loanReqFieldDataRequest.toJson(),
      );
      return BaseResponse<LoanReqFieldDataResponse>.fromJson(
          response, (data) => LoanReqFieldDataResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AddJustPayInstrumentsResponse>> addJustPayInstruements(
      AddJustPayInstrumentsRequest addJustPayInstrumentsRequest) async {
    try {
      final response = await apiHelper!.post(
        "account/api/v1/addJustPayInstrument/",
        body: addJustPayInstrumentsRequest.toJson(),
      );
      return BaseResponse<AddJustPayInstrumentsResponse>.fromJson(response,
          (data) => AddJustPayInstrumentsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  /// Default Instrument
  @override
  Future<BaseResponse<Serializable>> defaultPaymentInstrument(
      DefaultPaymentInstrumentRequest defaultPaymentInstrumentRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/selectDefaultInstrument/",
        body: defaultPaymentInstrumentRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  /// Instrument Status Change
  @override
  Future<BaseResponse<Serializable>> instrumentStatusChange(
      InstrumentStatusChangeRequest instrumentStatusChangeRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/instrumentStatusChange/",
        body: instrumentStatusChangeRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> instrumentNickNameChange(
      InstrumentNickNameChangeRequest instrumentNickNameChangeRequest) async {
    try {
      final response = await apiHelper!.post(
        "account/api/v1/instrumentNicknameChange/",
        body: instrumentNickNameChangeRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> editNickName(
      EditNickNamerequest editNickNamerequest) async {
    try {
      final response = await apiHelper!.post(
        "account/api/v1/instrumentNicknameChange/",
        body: editNickNamerequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  /// One Time Fund Transfer
  @override
  Future<BaseResponse<OneTimeFundTransferResponse>> oneTimeFundTransfer(
      OneTimeFundTransferRequest oneTimeFundTransferRequest) async {
    try {
      final response = await apiHelper!.post(
        "/",
        body: oneTimeFundTransferRequest.toJson(),
      );
      return BaseResponse<OneTimeFundTransferResponse>.fromJson(
          response, (data) => OneTimeFundTransferResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  /// scheduling Fund Transfer
  @override
  Future<BaseResponse<SchedulingFundTransferResponse>> schedulingFundTransfer(
      SchedulingFundTransferRequest schedulingFundTransferRequest) async {
    try {
      final response = await apiHelper!.post(
        "schfund/api/v1/scheduledTransaction/",
        body: schedulingFundTransferRequest.toJson(),
      );
      return BaseResponse<SchedulingFundTransferResponse>.fromJson(response,
          (data) => SchedulingFundTransferResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  /// scheduling Bill Payment
  @override
  Future<BaseResponse<ScheduleBillPaymentResponse>> schedulingBillPayment(
      ScheduleBillPaymentRequest scheduleBillPaymentRequest) async {
    try {
      final response = await apiHelper!.post(
        "schfund/api/v1/scheduledTransaction/",
        body: scheduleBillPaymentRequest.toJson(),
      );
      return BaseResponse<ScheduleBillPaymentResponse>.fromJson(
          response, (data) => ScheduleBillPaymentResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }



  @override
  Future<BaseResponse<UpdateProfileImageResponse>> updateProfileImage(
      UpdateProfileImageRequest updateProfileImageRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/updateprofile/updateProfileImage",
        body: updateProfileImageRequest.toJson(),
      );
      return BaseResponse<UpdateProfileImageResponse>.fromJson(
          response, (data) => UpdateProfileImageResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }


  @override
  Future<BaseResponse<RequestMoneyHistoryResponse>> reqMoneyHistory(
      RequestMoneyHistoryRequest requestMoneyHistoryRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/requestMoneyListView/",
        body: requestMoneyHistoryRequest.toJson(),
      );
      return BaseResponse<RequestMoneyHistoryResponse>.fromJson(
          response, (data) => RequestMoneyHistoryResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ReqMoneyNotificationHistoryResponse>> reqMoneyNotificationHistory(
      ReqMoneyNotificationHistoryRequest reqMoneyNotificationHistoryRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/updateRequestMoneyStatus/",
        body: reqMoneyNotificationHistoryRequest.toJson(),
      );
      return BaseResponse<ReqMoneyNotificationHistoryResponse>.fromJson(
          response, (data) => ReqMoneyNotificationHistoryResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  /// get PersonalInfo profile
  @override
  Future<BaseResponse<ViewPersonalInformationResponse>> viewPersonalInformation(
      ViewPersonalInformationRequest viewPersonalInformationRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/getPersonalInfo",
        body: viewPersonalInformationRequest.toJson(),
      );
      return BaseResponse<ViewPersonalInformationResponse>.fromJson(response,
          (data) => ViewPersonalInformationResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<TransactionLimitResponse>> transactionLimit(
      TransactionLimitRequest transactionLimitRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/txnLimit/",
        body: transactionLimitRequest.toJson(),
      );
      return BaseResponse<TransactionLimitResponse>.fromJson(
          response, (data) => TransactionLimitResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetCurrencyListResponse>> getCurrencyList(
      GetCurrencyListRequest getCurrencyListRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/getCurrency/",
        body: getCurrencyListRequest.toJson(),
      );
      return BaseResponse<GetCurrencyListResponse>.fromJson(
          response, (data) => GetCurrencyListResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetBankBranchListResponse>> getBankBranchList(
      GetBankBranchListRequest getBankBranchListRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/getBankBranches",
        body: getBankBranchListRequest.toJson(),
      );
      return BaseResponse<GetBankBranchListResponse>.fromJson(
          response, (data) => GetBankBranchListResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetTxnCategoryResponse>> getTxnCtegoryList(
      GetTxnCategoryRequest getTxnCategoryRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/getTxnCategories/",
        body: getTxnCategoryRequest.toJson(),
      );
      return BaseResponse<GetTxnCategoryResponse>.fromJson(
          response, (data) => GetTxnCategoryResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetFdPeriodResponse>> getFDPeriodList(
      GetFdPeriodRequest getFdPeriodRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/fdInterestPeriod",
        body: getFdPeriodRequest.toJson(),
      );
      return BaseResponse<GetFdPeriodResponse>.fromJson(
          response, (data) => GetFdPeriodResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> transactionLimitAdd(
      TransactionLimitAddRequest transactionLimitAddRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/addTxnLimit/",
        body: transactionLimitAddRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ServiceReqFilteredListResponse>> serviceReqFilteredList(
      ServiceReqHistoryRequest serviceReqHistoryRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/serviceRequest/history",
        body: serviceReqHistoryRequest.toJson(),
      );
      return BaseResponse<ServiceReqFilteredListResponse>.fromJson(response,
          (data) => ServiceReqFilteredListResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<TransactionHistoryPdfDownloadResponse>>
      transactionHistoryPdfDownload(
          TransactionHistoryPdfDownloadRequest
              transactionHistoryPdfDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "api/v1/downloadTxnHistory/",
        body: transactionHistoryPdfDownloadRequest.toJson(),
      );
      return BaseResponse<TransactionHistoryPdfDownloadResponse>.fromJson(
          response,
          (data) => TransactionHistoryPdfDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  /// Bill Payment
  @override
  Future<BaseResponse<BillPaymentResponse>> billPayment(
      BillPaymentRequest billPaymentRequest) async {
    try {
      final response = await apiHelper!.post(
        "utility/api/v1/billPayment/",
        body: billPaymentRequest.toJson(),
      );
      return BaseResponse<BillPaymentResponse>.fromJson(
          response, (data) => BillPaymentResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<FundTransferPdfDownloadResponse>> fundTransferPdfDownload(
      FundTransferPdfDownloadRequest fundTransferPdfDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/fundTransferStatusAndBillPaymentStatusPdfReport/",
        body: fundTransferPdfDownloadRequest.toJson(),
      );
      return BaseResponse<FundTransferPdfDownloadResponse>.fromJson(response,
          (data) => FundTransferPdfDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<FundTransferExcelDownloadResponse>>
      fundTransferExcelDownload(
          FundTransferExcelDownloadRequest
              fundTransferExcelDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/fundTransferStatusAndBillPaymentStatusXLReport/",
        body: fundTransferExcelDownloadRequest.toJson(),
      );
      return BaseResponse<FundTransferExcelDownloadResponse>.fromJson(response,
          (data) => FundTransferExcelDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetAllScheduleFtResponse>> getAllScheduleFT(
      GetAllScheduleFtRequest getAllScheduleFtRequest) async {
    try {
      final response = await apiHelper!.post(
        "scheduledTransaction/users/{epicUserId}",
        body: getAllScheduleFtRequest.toJson(),
      );
      return BaseResponse<GetAllScheduleFtResponse>.fromJson(
          response, (data) => GetAllScheduleFtResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ItransferGetThemeResponse>> itransferGetTheme(
      ItransferGetThemeRequest itransferGetThemeRequest) async {
    try {
      final response = await apiHelper!.post(
        "iTransfer/api/v1/getThemes",
        body: itransferGetThemeRequest.toJson(),
      );
      return BaseResponse<ItransferGetThemeResponse>.fromJson(
          response, (data) => ItransferGetThemeResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ItransferGetThemeDetailsResponse>>
      itransferGetThemeDetails(
          ItransferGetThemeDetailsRequest
              itransferGetThemeDetailsRequest) async {
    try {
      final response = await apiHelper!.post(
        "iTransfer/api/v1/getThemeDetails",
        body: itransferGetThemeDetailsRequest.toJson(),
      );
      return BaseResponse<ItransferGetThemeDetailsResponse>.fromJson(response,
          (data) => ItransferGetThemeDetailsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<InitiateItransfertResponse>> initiateItransfer(
      InitiateItransfertRequest initiateItransfertRequest) async {
    try {
      final response = await apiHelper!.post(
        "iTransfer/api/v1/initiateITransfer",
        body: initiateItransfertRequest.toJson(),
      );
      return BaseResponse<InitiateItransfertResponse>.fromJson(
          response, (data) => InitiateItransfertResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<DebitCardReqFieldDataResponse>> debitCardReqFieldData(
      DebitCardReqFieldDataRequest debitCardReqFieldDataRequest) async {
    try {
      final response = await apiHelper!.post(
        "debitCardRequest/api/v1/fieldData",
        body: debitCardReqFieldDataRequest.toJson(),
      );
      return BaseResponse<DebitCardReqFieldDataResponse>.fromJson(response,
          (data) => DebitCardReqFieldDataResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<DebitCardSaveDataResponse>> debitCardReqSaveData(
      DebitCardSaveDataRequest debitCardSaveDataRequest) async {
    try {
      final response = await apiHelper!.post(
        "debitCardRequest/api/v1/send",
        body: debitCardSaveDataRequest.toJson(),
      );
      return BaseResponse<DebitCardSaveDataResponse>.fromJson(
          response, (data) => DebitCardSaveDataResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AccountDetailsResponseDtos>> portfolioAccDetails(
      PortfolioAccDetailsRequest portfolioAccDetailsRequest) async {
    try {
      final response = await apiHelper!.post(
        "account/api/v1/userAccountDetails/",
        body: portfolioAccDetailsRequest.toJson(),
      );
      return BaseResponse<AccountDetailsResponseDtos>.fromJson(
          response, (data) => AccountDetailsResponseDtos.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetFdRateResponse>> getFDRate(
      GetFdRateRequest getFdRateRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/getFDRate",
        body: getFdRateRequest.toJson(),
      );
      return BaseResponse<GetFdRateResponse>.fromJson(
          response, (data) => GetFdRateResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  // @override
  // Future<BaseResponse<ResetPasswordResponse>> resetPassword(
  //     ResetPasswordRequest resetPasswordRequest) async {
  //   try {
  //     final response = await apiHelper!.post(
  //       "auth/api/v1/changePassword/",
  //       body: resetPasswordRequest.toJson(),
  //     );
  //     return BaseResponse<ResetPasswordResponse>.fromJson(
  //         response, (data) => ResetPasswordResponse.fromJson(data!));
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  @override
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/changePassword/",
        body: resetPasswordRequest.toJson(),
      );
      return BaseResponse<ResetPasswordResponse>.fromJson(response, (data) {
        if (data == null) {
          return ResetPasswordResponse();
        } else {
          return ResetPasswordResponse.fromJson(data);
        }
      });
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<PersonalLoanResponse>> personalLoanCal(
      PersonalLoanRequest personalLoanRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/personalCalculator",
        body: personalLoanRequest.toJson(),
      );
      return BaseResponse<PersonalLoanResponse>.fromJson(
          response, (data) => PersonalLoanResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  // @override
  // Future<BaseResponse<ApplyPersonalLoanResponse>> applyPersonalLoan(
  //     ApplyPersonalLoanRequest applyPersonalLoanRequest) async {
  //   try {
  //     final response = await apiHelper!.post(
  //       "auth/savePersonalLoanReq",
  //       body: applyPersonalLoanRequest.toJson(),
  //     );
  //     return BaseResponse<ApplyPersonalLoanResponse>.fromJson(
  //         response, (data) => ApplyPersonalLoanResponse.fromJson(data!));
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  @override
  Future<BaseResponse<ApplyPersonalLoanResponse>> applyPersonalLoan(
      ApplyPersonalLoanRequest applyPersonalLoanRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/savePersonalLoanReq",
        body: applyPersonalLoanRequest.toJson(),
      );
      return BaseResponse<ApplyPersonalLoanResponse>.fromJson(response, (data) {
        if (data == null) {
          return ApplyPersonalLoanResponse();
        } else {
          return ApplyFdCalculatorResponse.fromJson(data);
        }
      });
    } on Exception {
      rethrow;
    }
  }

  // @override
  // Future<BaseResponse<Serializable>> applyPersonalLoan(
  //     ApplyPersonalLoanRequest applyPersonalLoanRequest) async {
  //   try {
  //     final response = await apiHelper!.post(
  //       "savePersonalLoanReq/",
  //       body: applyPersonalLoanRequest.toJson(),
  //     );
  //     return BaseResponse.fromJson(response, (_) {});
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  @override
  Future<BaseResponse<PortfolioCcDetailsResponse>> portfolioCCDetails(
      PortfolioCcDetailsRequest portfolioCcDetailsRequest) async {
    try {
      final response = await apiHelper?.post(
        "account/api/v1/userCreditCardDetails/",
        body: portfolioCcDetailsRequest.toJson(),
      );
      return BaseResponse<PortfolioCcDetailsResponse>.fromJson(
          response, (data) => PortfolioCcDetailsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<PortfolioLoanDetailsResponse>> portfolioLoanDetails(
      PortfolioLoanDetailsRequest portfolioLoanDetailsRequest) async {
    try {
      final response = await apiHelper?.post(
        "account/api/v1/userLoanAccountDetails/",
        body: portfolioLoanDetailsRequest.toJson(),
      );
      return BaseResponse<PortfolioLoanDetailsResponse>.fromJson(response,
          (data) => PortfolioLoanDetailsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<PortfolioUserFdDetailsResponse>> portfolioFDDetails(
      PortfolioUserFdDetailsRequest portfolioUserFdDetailsRequest) async {
    try {
      final response = await apiHelper?.post(
        "account/api/v1/userFDDetails/",
        body: portfolioUserFdDetailsRequest.toJson(),
      );
      return BaseResponse<PortfolioUserFdDetailsResponse>.fromJson(response,
          (data) => PortfolioUserFdDetailsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<PortfolioLeaseDetailsResponse>> portfolioLeaseDetails(
      PortfolioLoanDetailsRequest portfolioLoanDetailsRequest) async {
    try {
      final response = await apiHelper?.post(
        "account/api/v1/getLeaseDetails/",
        body: portfolioLoanDetailsRequest.toJson(),
      );
      return BaseResponse<PortfolioLeaseDetailsResponse>.fromJson(response,
          (data) => PortfolioLeaseDetailsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<TransactionNotificationResponse>> getTranNotifications(
      TransactionNotificationRequest transactionNotificationRequest) async {
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/getTranNotificationList/",
        body: transactionNotificationRequest.toJson(),
      );
      return BaseResponse<TransactionNotificationResponse>.fromJson(response,
          (data) => TransactionNotificationResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<PromotionNotificationResponse>> getPromoNotifications(
      PromotionNotificationRequest promotionNotificationRequest) async {
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/getPromoNotificationList/",
        body: promotionNotificationRequest.toJson(),
      );
      return BaseResponse<PromotionNotificationResponse>.fromJson(response,
          (data) => PromotionNotificationResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<NoticesNotificationResponse>> getNoticesNotifications(
      NoticesNotificationRequest noticesNotificationRequest) async {
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/getNotices/",
        body: noticesNotificationRequest.toJson(),
      );
      return BaseResponse<NoticesNotificationResponse>.fromJson(
          response, (data) => NoticesNotificationResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> composeMail(
      ComposeMailRequest composeMailRequest) async {
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/compose/",
        body: composeMailRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<RecipientTypeResponse>> getRecipientType(
      RecipientTypeRequest recipientTypeRequest) async {
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/getRecipientTypeList/",
        body: recipientTypeRequest.toJson(),
      );
      return BaseResponse<RecipientTypeResponse>.fromJson(
          response, (data) => RecipientTypeResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

   @override
  Future<BaseResponse<RecipientCategoryResponse>> getRecipientCategory(RecipientCategoryRequest recipientCategoryRequest) async {
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/getRecipientCategoryList/",
        body: recipientCategoryRequest.toJson(),
      );
      return BaseResponse<RecipientCategoryResponse>.fromJson(
          response, (data) => RecipientCategoryResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ViewMailResponse>> getViewMail(
      ViewMailRequest viewMailRequest) async {
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/viewMails/",
        body: viewMailRequest.toJson(),
      );
      return BaseResponse<ViewMailResponse>.fromJson(
          response, (data) => ViewMailResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

    @override
  Future<BaseResponse<MailThreadResponse>> getMailThread(MailThreadRequest mailThreadRequest) async{
      try {
      final response = await apiHelper?.post(
        "notification/api/v1/viewMailThread/",
        body: mailThreadRequest.toJson(),
      );
      return BaseResponse<MailThreadResponse>.fromJson(
          response, (data) => MailThreadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<MailAttachmentResponse>> getMailAttachment(MailAttachmentRequest mailAttachmentRequest) async{
        try {
      final response = await apiHelper?.post(
        "notification/api/v1/getAttachment/",
        body: mailAttachmentRequest.toJson(),
      );
      return BaseResponse<MailAttachmentResponse>.fromJson(
          response, (data) => MailAttachmentResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> deleteMailAttachment(MailAttachmentRequest mailAttachmentRequest) async{
        try {
      final response = await apiHelper?.post(
        "notification/api/v1/deleteAttachment/",
        body: mailAttachmentRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> deleteMail(
      DeleteMailRequest deleteMailRequest) async {
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/deleteMailInboxes/",
        body: deleteMailRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> markAsReadMail(
      MarkAsReadMailRequest markAsReadMailRequest) async {
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/markAsReadMailInboxes/",
        body: markAsReadMailRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

   @override
  Future<BaseResponse<MailCountResponse>> getMailCount(MailCountRequest mailCountRequest) async{
  try {
      final response = await apiHelper?.post(
        "notification/api/v1/viewMailsCount/",
        body: mailCountRequest.toJson(),
      );
      return BaseResponse<MailCountResponse>.fromJson(
          response, (data) => MailCountResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> markAsReadNotification(
      MarkAsReadNotificationRequest markAsReadNotificationRequest) async {
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/notificationMarkAsRead/",
        body: markAsReadNotificationRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> deleteNotification(
      DeleteNotificationRequest deleteNotificationRequest) async {
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/notificationDelete/",
        body: deleteNotificationRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> replyMail(
      ReplyMailRequest replyMailRequest) async {
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/reply/",
        body: replyMailRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<BillerPdfDownloadResponse>> billerPdfDownload(
      BillerPdfDownloadRequest billerPdfDownloadRequest) async {
    try {
      final response = await apiHelper?.post(
        "txn/api/v1/fundTransferStatusAndBillPaymentStatusPdfReport/",
        body: billerPdfDownloadRequest.toJson(),
      );
      return BaseResponse<BillerPdfDownloadResponse>.fromJson(
          response, (data) => BillerPdfDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<BillPaymentExcelDownloadResponse>>
      billerExcelDownload(
          BillPaymentExcelDownloadRequest
              billPaymentExcelDownloadRequest) async {
    try {
      final response = await apiHelper!.post(
        "txn/api/v1/fundTransferStatusAndBillPaymentStatusXLReport/",
        body: billPaymentExcelDownloadRequest.toJson(),
      );
      return BaseResponse<BillPaymentExcelDownloadResponse>.fromJson(response,
          (data) => BillPaymentExcelDownloadResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }


  @override
  Future<BaseResponse<Serializable>> updateTxnLimit(
      UpdateTxnLimitRequest updateTxnLimitRequest) async {
    try {
      final response = await apiHelper?.post(
        "txn/api/v1/addTxnLimit/",
        body: updateTxnLimitRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetHomeDetailsResponse>> getHomeDetails(
      GetHomeDetailsRequest getHomeDetailsRequest) async {
    try {
      final response = await apiHelper?.post(
        "account/api/v1/getHomeDetails/",
        body: getHomeDetailsRequest.toJson(),
      );

      return BaseResponse<GetHomeDetailsResponse>.fromJson(
          response, (data) => GetHomeDetailsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPwCheckNicAccount(
      ForgetPwCheckNicAccountRequest forgetPwCheckNicAccountRequest) async {
    try {
      final response = await apiHelper?.post(
        "login/api/v1/checkNicIdentity",
        body: forgetPwCheckNicAccountRequest.toJson(),
      );
      return BaseResponse<ForgetPasswordResponse>.fromJson(
          response, (data) => ForgetPasswordResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetAcctNameFtResponse>> acctNameForFt(
      GetAcctNameFtRequest getAcctNameFtRequest) async {
    try {
      final response = await apiHelper?.post(
        "fundtransfer/api/v1/payee/getUbAccountName",
        body: getAcctNameFtRequest.toJson(),
      );
      return BaseResponse<GetAcctNameFtResponse>.fromJson(
          response, (data) => GetAcctNameFtResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPwCheckUsername(
      ForgetPwCheckUsernameRequest forgetPwCheckUsernameRequest) async {
    try {
      final response = await apiHelper?.post(
        "login/api/v1/checkUsernameIdentity",
        body: forgetPwCheckUsernameRequest.toJson(),
      );
      return BaseResponse<ForgetPasswordResponse>.fromJson(
          response, (data) => ForgetPasswordResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ForgetPasswordResponse>> forgetPwCheckSecurityQuestion(
      ForgetPwCheckSecurityQuestionRequest
          forgetPwCheckSecurityQuestionRequest) async {
    try {
      final response = await apiHelper?.post(
        "login/api/v1/checkSQAnswer",
        body: forgetPwCheckSecurityQuestionRequest.toJson(),
      );
      return BaseResponse<ForgetPasswordResponse>.fromJson(
          response, (data) => ForgetPasswordResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse> forgetPwReset(
      ForgetPwResetRequest forgetPwResetRequest) async {
    try {
      final response = await apiHelper?.post(
        "login/api/v1/forgotPasswordReset",
        body: forgetPwResetRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> DeleteJustPayInstruements(
      DeleteJustPayInstrumentRequest deleteJustPayInstrumentRequest) async {
    try {
      final response = await apiHelper?.post(
        "/account/api/v1/deleteInstrument/",
        body: deleteJustPayInstrumentRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetJustPayInstrumentResponse>> getJustPayInstrumentList(
      GetJustPayInstrumentRequest getJustPayInstrumentRequest) async {
    try {
      final response = await apiHelper?.post(
        "/account/api/v1/tempUserInstruments/",
        body: getJustPayInstrumentRequest.toJson(),
      );
      return BaseResponse<GetJustPayInstrumentResponse>.fromJson(response,
          (data) => GetJustPayInstrumentResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> updateProfileDetails(
      UpdateProfileDetailsRequest updateProfileDetailsRequest) async {
    try {
      final response = await apiHelper?.post(
        "account/api/v1/editProfileDetails",
        body: updateProfileDetailsRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<RetrieveProfileImageResponse>> getProfileImage(
      RetrieveProfileImageRequest retrieveProfileImageRequest) async {
    try {
      final response = await apiHelper?.post(
        "auth/api/v1/profileImage/",
        body: retrieveProfileImageRequest.toJson(),
      );
      return BaseResponse<RetrieveProfileImageResponse>.fromJson(response,
          (data) => RetrieveProfileImageResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<DemoTourListResponse>> getDemoTour(
      CommonRequest commonRequest) async {
    try {
      final response = await apiHelper?.post(
        "auth/api/v1/videoList/",
        body: commonRequest.toJson(),
      );
      return BaseResponse<DemoTourListResponse>.fromJson(
          response, (data) => DemoTourListResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<MarketingBannersResponse>> getMarketingBanner(
      MarketingBannersRequest marketingBannersRequest) async {
    try {
      final response = await apiHelper?.post(
        "auth/api/v1/marketingBanners",
        body: marketingBannersRequest.toJson(),
      );
      return BaseResponse<MarketingBannersResponse>.fromJson(
          response, (data) => MarketingBannersResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<PayeeFavoriteResponse>> favoritePayee(
      PayeeFavoriteRequest payeeFavoriteRequest) async {
    try{
      final response = await apiHelper?.put(
          "fundtransfer/api/v1/payee/favorite",
          body: payeeFavoriteRequest.toJson(),
      );
      return BaseResponse<PayeeFavoriteResponse>.fromJson(
          response, (data) => PayeeFavoriteResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<FavoriteBillerResponse>> favouriteBiller(
      FavouriteBillerRequest favouriteBillerRequest) async {
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/billerFavorites/",
        body: favouriteBillerRequest.toJson(),
      );
      return BaseResponse<FavoriteBillerResponse>.fromJson(
          response, (data) => FavoriteBillerResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<SrStatementHistoryResponse>> statementHistory(
      SrStatementHistoryRequest srStatementHistoryRequest) async {
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/findStatementRequest",
        body: srStatementHistoryRequest.toJson(),
      );
      return BaseResponse<SrStatementHistoryResponse>.fromJson(
          response, (data) => SrStatementHistoryResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }


  @override
  Future<BaseResponse<PasswordValidationResponse>> passwordValidation(
      PasswordValidationRequest passwordValidationRequest) async{
    try {
      final response = await apiHelper?.post(
        "login/api/v1/passwordValidate/",
        body: passwordValidationRequest.toJson(),
      );
      return BaseResponse<PasswordValidationResponse>.fromJson(
          response, (data) => PasswordValidationResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<QrPaymentResponse>> qrPayment(
      QrPaymentRequest qrPaymentRequest) async{
    try {
      final response = await apiHelper!.post(
        "fundtransfer/api/v1/qrMerchantPayment/",
        body: qrPaymentRequest.toJson(),
      );
      return BaseResponse<QrPaymentResponse>.fromJson(
          response, (data) => QrPaymentResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }


  @override
  Future<BaseResponse<ChequeBookResponse>> chequeBookFieldData(
      ChequeBookRequest chequeBookRequest) async{
    try {
      final response = await apiHelper?.post(
        "auth/api/v1/addChequeBookRequest/",
        body: chequeBookRequest.toJson(),
      );
      return BaseResponse<ChequeBookResponse>.fromJson(
          response, (data) => ChequeBookResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  // @override
  // Future<BaseResponse> chequeBookFieldData(ChequeBookRequest chequeBookRequest) async{
  //   try {
  //     final response = await apiHelper!.post(
  //       "auth/api/v1/addChequeBookRequest/",
  //       body: chequeBookRequest.toJson(),
  //     );
  //     return BaseResponse.fromJson(response, (_) {});
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<BaseResponse<ChequeBookFilterResponse>> chequeBookFilter(ChequeBookFilterRequest chequeBookFilterRequest) async{
  //   try {
  //     final response = await apiHelper!.post(
  //       "auth/api/v1/findChequeBookRequest/",
  //       body: chequeBookFilterRequest.toJson(),
  //     );
  //     return BaseResponse.fromJson(response, (_) {});
  //   } on Exception {
  //     rethrow;
  //   }
  // }

  @override
  Future<BaseResponse<ChequeBookFilterResponse>> chequeBookFilter(ChequeBookFilterRequest chequeBookFilterRequest) async{
     try {
      final response = await apiHelper!.post(
        "auth/api/v1/findChequeBookRequest/",
        body: chequeBookFilterRequest.toJson(),
      );
      return BaseResponse<ChequeBookFilterResponse>.fromJson(
          response, (data) => ChequeBookFilterResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<RequestCallBackGetResponse>> getRequestCall(RequestCallBackGetRequest requestCallBackGetRequest) async{
     try {
      final response = await apiHelper!.post(
        "auth/api/v1/getRequestCall",
        body: requestCallBackGetRequest.toJson(),
      );
      return BaseResponse<RequestCallBackGetResponse>.fromJson(
          response, (data) => RequestCallBackGetResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

    @override
  Future<BaseResponse<RequestCallBackGetDefaultDataResponse>> getRequestCallDefaultData(RequestCallBackGetDefaultDataRequest requestCallBackGetDefaultDataRequest) async{
      try {
      final response = await apiHelper!.post(
        "auth/api/v1/getRequestCallDefaultData",
        body: requestCallBackGetDefaultDataRequest.toJson(),
      );
      return BaseResponse<RequestCallBackGetDefaultDataResponse>.fromJson(
          response, (data) => RequestCallBackGetDefaultDataResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> saveRequestCall(RequestCallBackSaveRequest requestCallBackSaveRequest) async{
     try {
      final response = await apiHelper!.post(
        "auth/api/v1/saveRequestCall",
        body: requestCallBackSaveRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> cancelRequestCall(RequestCallBackCancelRequest requestCallBackCancelRequest) async{
    try {
      final response = await apiHelper!.post(
        "auth/api/v1/cancelRequestCall",
        body: requestCallBackCancelRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<FloatInquiryResponse>> floatInquiryRequest(FloatInquiryRequest floatInquiryRequest) async{
    try {
      final response = await apiHelper!.post(
        "account/api/v1/floatInquiry/",
        body: floatInquiryRequest.toJson(),
      );
      return BaseResponse<FloatInquiryResponse>.fromJson(
          response, (data) => FloatInquiryResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> deleteMailMessage(DeleteMailMessageRequest deleteMailMessageRequest) async{
    try {
      final response = await apiHelper?.post(
        "notification/api/v1/deleteInboxMessage/",
        body: deleteMailMessageRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<KeyExchangeResponse>> keyExchange
      (KeyExchangeRequest keyExchangeRequest) async {
    try {
      final response = await apiHelper!.post(
        "security/api/v1/keyExchange/",
        body: keyExchangeRequest.toJson(),
      );
      return BaseResponse<KeyExchangeResponse>.fromJson(
          response, (data) => KeyExchangeResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }



  @override
  Future<BaseResponse<Serializable>> getCnn(BaseRequest baseRequest) async{
    try {
      final response = await apiHelper?.post(
        "auth/api/v1/getBbc",
        body: baseRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }


    @override
  Future<BaseResponse<Serializable>> getBbc(BaseRequest baseRequest) async{
    try {
      final response = await apiHelper?.post(
        "auth/api/v1/getCnn",
        body: baseRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<TemporaryLoginResponse>> temporaryLogin(TemporaryLoginRequest temporaryLoginRequest)async {
    try {
      final response = await apiHelper!.post(
        "login/api/v1/adminPasswordReset",
        body: temporaryLoginRequest.toJson(),
      );
      return BaseResponse<TemporaryLoginResponse>.fromJson(
          response, (data) => TemporaryLoginResponse.fromJson(data??{}));
    } on Exception {
      rethrow;
    }
  }


   /* ----------------------------- Card Mangement ----------------------------- */

     @override
  Future<BaseResponse<CardListResponse>> getCardList(
      CommonRequest cardListRequest) async {
    try {
      final response = await apiHelper?.post(
        "card-communicator/api/v1/custSummary",
        body: cardListRequest.toJson(),
      );
      return BaseResponse<CardListResponse>.fromJson(
          response, (data) => CardListResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> cardActivation(CardActivationRequest cardActivationRequest) async{
       try {
      final response = await apiHelper?.post(
        "card-communicator/api/v1/cardActivation",
        body: cardActivationRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardCreditLimitResponse>> cardCreditLimit(CardCreditLimitRequest cardCreditLimitRequest) async{
      try {
      final response = await apiHelper?.post(
        "card-communicator/api/v1/adCrlt",
        body: cardCreditLimitRequest.toJson(),
      );
      return BaseResponse<CardCreditLimitResponse>.fromJson(
          response, (data) => CardCreditLimitResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardDetailsResponse>> cardDetails(CardDetailsRequest cardDetailsRequest) async{
      try {
      final response = await apiHelper?.post(
        "card-communicator/api/v1/custDetails",
        body: cardDetailsRequest.toJson(),
      );
      return BaseResponse<CardDetailsResponse>.fromJson(
          response, (data) => CardDetailsResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardEStatementResponse>> cardEStatement(CardEStatementRequest cardEStatementRequest) async{
      try {
      final response = await apiHelper?.post(
        "card-communicator/api/v1/stMode",
        body: cardEStatementRequest.toJson(),
      );
      return BaseResponse<CardEStatementResponse>.fromJson(
          response, (data) => CardEStatementResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardLastStatementResponse>> cardLastStatement(CardLastStatementRequest cardLastStatementRequest) async{
      try {
      final response = await apiHelper?.post(
        "card-communicator/api/v1/lastSt",
        body: cardLastStatementRequest.toJson(),
      );
      return BaseResponse<CardLastStatementResponse>.fromJson(
          response, (data) => CardLastStatementResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardLostStolenResponse>> cardLostStolen(CardLostStolenRequest cardLostStolenRequest) async{
      try {
      final response = await apiHelper?.post(
        "card-communicator/api/v1/lstStn",
        body: cardLostStolenRequest.toJson(),
      );
      return BaseResponse<CardLostStolenResponse>.fromJson(
          response, (data) => CardLostStolenResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardPinResponse>> cardPinRequest(CardPinRequest cardPinRequest) async{
      try {
      final response = await apiHelper?.post(
        "card-communicator/api/v1/pinGen",
        body: cardPinRequest.toJson(),
      );
      return BaseResponse<CardPinResponse>.fromJson(
          response, (data) => CardPinResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardTxnHistoryResponse>> cardTxnHistory(CardTxnHistoryRequest cardTxnHistoryRequest) async{
      try {
      final response = await apiHelper?.post(
        "card-communicator/api/v1/txHist",
        body: cardTxnHistoryRequest.toJson(),
      );
      return BaseResponse<CardTxnHistoryResponse>.fromJson(
          response, (data) => CardTxnHistoryResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardViewStatementResponse>> cardViewStatement(CardViewStatementRequest cardViewStatementRequest) async{
      try {
      final response = await apiHelper?.post(
        "card-communicator/api/v1/viewSt",
        body: cardViewStatementRequest.toJson(),
      );
      return BaseResponse<CardViewStatementResponse>.fromJson(
          response, (data) => CardViewStatementResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardLoyaltyVouchersResponse>> getCardLoyaltyVouchers(CommonRequest cardLoyaltyVouchersRequest) async{
    try {
      final response = await apiHelper?.post(
        "card-communicator/api/v1/getCardLoyalty",
        body: cardLoyaltyVouchersRequest.toJson(),
      );
      return BaseResponse<CardLoyaltyVouchersResponse>.fromJson(
          response, (data) => CardLoyaltyVouchersResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CardLoyaltyRedeemResponse>> cardLoyaltyRedeem(CardLoyaltyRedeemRequest cardLoyaltyRedeemRequest)async {
    try {
      final response = await apiHelper?.post(
        "card-communicator/api/v1/loyRem",
        body: cardLoyaltyRedeemRequest.toJson(),
      );
      return BaseResponse<CardLoyaltyRedeemResponse>.fromJson(
          response, (data) => CardLoyaltyRedeemResponse.fromJson(data ?? {}));
    } on Exception {
      rethrow;
    }
  }

  /* ------------------------------------ . ----------------------------------- */

}
