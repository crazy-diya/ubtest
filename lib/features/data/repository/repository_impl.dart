import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/error/failures.dart';
import 'package:union_bank_mobile/features/data/models/common/base_request.dart';
import 'package:union_bank_mobile/features/data/models/common/base_response.dart';
import 'package:union_bank_mobile/features/data/models/requests/account_verfication_request.dart';
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
import 'package:union_bank_mobile/features/data/models/requests/check_user_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/common_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/compose_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/delete_justpay_instrument_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/delete_mail_message_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/delete_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/edit_profile_details_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/float_inquiry_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/get_justpay_instrument_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/get_home_details_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_nic_account_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_security_question_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_username_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_reset_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/housing_loan_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/apply_personal_loan_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/get_payee_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/just_pay_account_onboarding_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/just_pay_challenge_id_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/just_pay_tc_sign_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/just_pay_verfication_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/key_exchanege_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/loyalty_management/card_loyalty_redeem_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_attachment_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_count_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_thread_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mark_as_read_mail_request.dart';
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
import 'package:union_bank_mobile/features/data/models/requests/settings_tran_limit_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/temporary_login_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/transaction_notification_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/ub_account_verfication_request.dart';
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
import 'package:union_bank_mobile/features/data/models/responses/demo_tour_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/float_inquiry_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/forgot_password_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/get_justpay_instrument_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/get_home_details_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/housing_loan_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/just_pay_account_onboarding_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/just_pay_challenge_id_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/key_exchange_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/loan_history_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_attachment_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_count_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_thread_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/password_validation_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/personal_loan_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/promotion_notification_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/recipient_category_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/qr_payment_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/recipient_type_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/request_callback_get_default_data_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/request_callback_get_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/splash_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/temporary_login_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/transaction_notification_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/view_mail_response.dart';
import 'package:union_bank_mobile/features/domain/entities/request/common_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/customer_reg_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/security_question_request_entity.dart';
import 'package:union_bank_mobile/features/domain/entities/request/verify_nic_request_entity.dart';
import 'package:union_bank_mobile/features/domain/repository/repository.dart';

import '../../../core/network/network_info.dart';
import '../../../error/exceptions.dart';
import '../../domain/entities/request/challenge_request_entity.dart';
import '../../domain/entities/request/contact_us_request_entity.dart';
import '../../domain/entities/request/create_user_entity.dart';
import '../../domain/entities/request/document_verification_api_request_entity.dart';
import '../../domain/entities/request/emp_details_request_entity.dart';
import '../../domain/entities/request/get_terms_request_entity.dart';
import '../../domain/entities/request/language_entity.dart';
import '../../domain/entities/request/set_security_questions_request_entity.dart';
import '../../domain/entities/request/terms_accept_request_entity.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';

import '../models/requests/QRPaymentPdfDownloadRequest.dart';
import '../models/requests/acc_tran_status_excel.dart';
import '../models/requests/acc_tran_status_pdf.dart';
import '../models/requests/account_statement_pdf_download.dart';
import '../models/requests/account_statements_excel_request.dart';
import '../models/requests/account_statements_request.dart';
import '../models/requests/account_tarnsaction_history_pdf_download_request.dart';

import '../models/requests/account_tran_excel_request.dart';
import '../models/requests/account_transaction_history_request.dart';
import '../models/requests/add_justPay_instrument_request.dart';
import '../models/requests/biller_pdf_download_request.dart';
import '../models/requests/calculator_share_pdf_request.dart';
import '../models/requests/card_management/card_statement_pdf_download_request.dart';
import '../models/requests/card_taransaction_pdf.dart';
import '../models/requests/card_tran_excel_download.dart';
import '../models/requests/cheque_book_filter_request.dart';
import '../models/requests/cheque_book_request.dart';
import '../models/requests/csi_request.dart';
import '../models/requests/delete_biller_request.dart';
import '../models/requests/delete_ft_schedule_request.dart';
import '../models/requests/delete_notification_request.dart';
import '../models/requests/edit_ft_schedule_request.dart';
import '../models/requests/edit_nick_name_request.dart';
import '../models/requests/delete_fund_transfer_payee_request.dart';
import '../models/requests/edit_payee_request.dart';
import '../models/requests/fund_transfer_excel_dwnload_request.dart';
import '../models/requests/getBranchListRequest.dart';
import '../models/requests/getTxnCategoryList_request.dart';
import '../models/requests/get_account_name_ft_request.dart';
import '../models/requests/get_currency_list_request.dart';
import '../models/requests/get_fd_period_req.dart';
import '../models/requests/get_fd_rate_request.dart';
import '../models/requests/get_money_notification_request.dart';
import '../models/requests/get_notification_settings_request.dart';
import '../models/requests/lease_history_excel.dart';
import '../models/requests/lease_history_pdf.dart';
import '../models/requests/lease_payment_history_request.dart';
import '../models/requests/loan_history_excel_request.dart';
import '../models/requests/loan_history_pdf_download.dart';
import '../models/requests/loan_history_request.dart';
import '../models/requests/mark_as_read_notification_request.dart';
import '../models/requests/marketing_banners_request.dart';
import '../models/requests/notices_notification_request.dart';
import '../models/requests/notification_count_request.dart';
import '../models/requests/past_card_excel_download.dart';
import '../models/requests/past_card_statement_request.dart';
import '../models/requests/get_all_fund_transfer_schedule_request.dart';
import '../models/requests/past_card_statements_pdf_download_request.dart';
import '../models/requests/payee_favorite_request.dart';
import '../models/requests/promotion_share_request.dart';
import '../models/requests/req_money_notification_history_request.dart';
import '../models/requests/request_money_history_request.dart';
import '../models/requests/request_money_request.dart';
import '../models/requests/reset_password_request.dart';
import '../models/requests/retrieve_profile_image_request.dart';
import '../models/requests/schedule_bill_payment_request.dart';
import '../models/requests/schedule_ft_history_request.dart';
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
import '../models/requests/wallet_onboarding_data.dart';

import '../models/responses/QrPaymentPdfDownloadResponse.dart';
import '../models/responses/acc_tran_status_excel.dart';
import '../models/responses/acc_tran_status_pdf.dart';
import '../models/responses/account_details_response_dtos.dart';
import '../models/responses/account_statement_pdf_download.dart';
import '../models/responses/account_statesment_xcel_download_response.dart';
import '../models/responses/account_tran_excel_response.dart';
import '../models/responses/account_transaction_history_pdf_response.dart';
import '../models/responses/apply_personal_loan_response.dart';
import '../models/responses/account_statements_response.dart';
import '../models/responses/account_transaction_history_response.dart';
import '../models/responses/biller_pdf_download_response.dart';
import '../models/responses/calculator_share_pdf_response.dart';
import '../models/responses/card_management/card_statement_pdf_download_response.dart';
import '../models/responses/card_tran_excel_download.dart';
import '../models/responses/card_transaction_pdf.dart';
import '../models/responses/challenge_response.dart';
import '../models/responses/cheque_book_filter_response.dart';
import '../models/responses/cheque_book_response.dart';
import '../models/responses/city_response.dart';
import '../models/responses/create_user_response.dart';
import '../models/responses/csi_response.dart';
import '../models/responses/delete_biller_response.dart';
import '../models/responses/delete_ft_schedule_response.dart';
import '../models/responses/delete_fund_transfer_payee_response.dart';
import '../models/responses/edit_ft_schedule_response.dart';
import '../models/responses/edit_payee_response.dart';
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
import '../models/responses/get_money_notification_response.dart';
import '../models/responses/get_notification_settings_response.dart';
import '../models/responses/get_payee_response.dart';
import '../models/responses/get_terms_response.dart';

import '../models/responses/get_locator_response.dart';

import '../models/requests/account_inquiry_request.dart';
import '../models/requests/add_biller_request.dart';
import '../models/requests/add_itransfer_payee_request.dart';
import '../models/requests/apply_fd_calculator_request.dart';
import '../models/requests/apply_housing_loan_request.dart';
import '../models/requests/apply_leasing_request.dart';
import '../models/requests/fd_calculator_request.dart';
import '../models/requests/leasing_calculator_request.dart';
import '../models/responses/apply_fd_calculator_response.dart';
import '../models/responses/apply_housing_loan_response.dart';
import '../models/responses/apply_leasing_response.dart';
import '../models/responses/fd_calculator_response.dart';

import '../models/requests/add_just_pay_instruements_request.dart';
import '../models/requests/add_pay_request.dart';
import '../models/requests/add_user_inst_request.dart';
import '../models/requests/balance_inquiry_request.dart';
import '../models/requests/bill_payment_request.dart';
import '../models/requests/biometric_enable_request.dart';
import '../models/requests/biometric_login_request.dart';
import '../models/requests/cdb_account_verfication_request.dart';
import '../models/requests/change_password_request.dart';
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
import '../models/requests/update_profile_image_request.dart';
import '../models/requests/view_personal_information_request.dart';
import '../models/responses/account_inquiry_response.dart';
import '../models/responses/add_biller_response.dart';
import '../models/responses/add_itransfer_payee_response.dart';
import '../models/responses/add_just_pay_instruements_response.dart';
import '../models/responses/add_pay_response.dart';
import '../models/responses/balance_inquiry_response.dart';
import '../models/responses/bill_payment_response.dart';
import '../models/responses/biometric_enable_response.dart';
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
import '../models/responses/loan_req_field_data_response.dart';
import '../models/responses/loan_request_submit_response.dart';
import '../models/responses/loan_requests_field_data_response.dart';

import '../models/responses/marketing_banners_response.dart';
import '../models/responses/mobile_login_response.dart';
import '../models/responses/notices_notification_list.dart';
import '../models/responses/notification_count_response.dart';
import '../models/responses/otp_response.dart';
import '../models/responses/past_card_excel_download.dart';
import '../models/responses/past_card_statement_response.dart';
import '../models/responses/past_card_statements_pdf_response.dart';
import '../models/responses/payee_favorite_response.dart';
import '../models/responses/portfolio_cc_details_response.dart';
import '../models/responses/portfolio_lease_details_response.dart';
import '../models/responses/portfolio_loan_details_response.dart';
import '../models/responses/portfolio_userfd_details_response.dart';
import '../models/responses/promotion_share_response.dart';
import '../models/responses/promotions_response.dart';
import '../models/responses/req_money_notification_history_response.dart';
import '../models/responses/request_money_history_response.dart';
import '../models/responses/request_money_response.dart';
import '../models/responses/reset_password_response.dart';
import '../models/responses/retrieve_profile_image_response.dart';
import '../models/responses/schedule_bill_payment_response.dart';
import '../models/responses/schedule_date_response.dart';
import '../models/responses/schedule_ft_history_response.dart';
import '../models/responses/sec_question_response.dart';
import '../models/responses/service_req_filted_list_response.dart';
import '../models/responses/service_req_history_response.dart';
import '../models/responses/settings_tran_limit_response.dart';
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

class RepositoryImpl implements Repository {
  final RemoteDataSource? remoteDataSource;
  final NetworkInfo? networkInfo;
  final LocalDataSource? localDataSource;

  RepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, BaseResponse<SplashResponse>>> getSplash(
      CommonRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getSplash(params);
        return Right(parameters as BaseResponse<SplashResponse>);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Get On Boarding Wallet Data From Local Storage
  @override
  Future<Either<Failure, WalletOnBoardingData?>>
      getWalletOnBoardingData() async {
    try {
      final WalletOnBoardingData? walletOnBoardingData =
          await localDataSource!.getAppWalletOnBoardingData();
      return Right(walletOnBoardingData);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  /// Store On Boarding Wallet Data into Local Storage
  @override
  Future<Either<Failure, bool>> storeWalletOnBoardingData(
      WalletOnBoardingData walletOnBoardingData) async {
    try {
      final bool isDataStored = await localDataSource!
          .storeAppWalletOnBoardingData(walletOnBoardingData);
      return Right(isDataStored);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  /// Register Customer
  @override
  Future<Either<Failure, BaseResponse<Serializable>>> registerCustomer(
      CustomerRegistrationRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.registerCustomer(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Verify NIC
  @override
  Future<Either<Failure, BaseResponse<Serializable>>> verifyNIC(
      VerifyNICRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.verifyNIC(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> accountVerification(
      AccountVerificationRequest accountVerificationRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .accountVerification(accountVerificationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<JustPayAccountOnboardingResponse>>>
      justPayAcoountOnboarding(
          JustPayAccountOnboardingRequest
              justPayAccountOnboardingRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .justPayOnboarding(justPayAccountOnboardingRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }  on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<JustPayChallengeIdResponse>>>
      justPayChallengeId(
          JustPayChallengeIdRequest justPayChallengeIdRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .justPayChallengeId(justPayChallengeIdRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }  on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> justPayTCSign(JustpayTCSignRequest justpayTCSignRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.justPayTCSign(justpayTCSignRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }  on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> justPayVerification(
      JustPayVerificationRequest justPayVerificationRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .justPayVerification(justPayVerificationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>>
      updateNotificationSettings(
          UpdateNotificationSettingsRequest
              updateNotificationSettingsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .updateNotificationSettings(updateNotificationSettingsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> ubAccountVerification(
      UBAccountVerificationRequest ubAccountVerificationRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .ubAccountVerification(ubAccountVerificationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Get Terms and Conditions
  @override
  Future<Either<Failure, BaseResponse<GetTermsResponse>>> getTerms(
      GetTermsRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getTerms(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Accept Terms and Conditions
  @override
  Future<Either<Failure, BaseResponse>> acceptTerms(
      TermsAcceptRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.acceptTerms(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CreateUserResponse>>> createUser(
      CreateUserEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.createUser(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

   @override
  Future<Either<Failure, BaseResponse<Serializable>>> checkUser(CheckUserRequest params) async{
      if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.checkUser(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Get City Detail
  @override
  Future<Either<Failure, BaseResponse<CityDetailResponse>>> cityRequest(
      CommonRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getCityData(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Get On Boarding Wallet Data From Local Storage
  // @override
  // Future<Either<Failure, WalletOnBoardingData?>>
  //     getWalletOnBoardingData() async {
  //   try {
  //     final WalletOnBoardingData? walletOnBoardingData =
  //         await localDataSource!.getAppWalletOnBoardingData();
  //     return Right(walletOnBoardingData);
  //   } on Exception {
  //     return Left(CacheFailure());
  //   }
  // }

  // /// Store On Boarding Wallet Data into Local Storage
  // @override
  // Future<Either<Failure, bool>> storeWalletOnBoardingData(
  //     WalletOnBoardingData walletOnBoardingData) async {
  //   try {
  //     final bool isDataStored = await localDataSource!
  //         .storeAppWalletOnBoardingData(walletOnBoardingData);
  //     return Right(isDataStored);
  //   } on Exception {
  //     return Left(CacheFailure());
  //   }
  // }

  @override
  Future<Either<Failure, BaseResponse<ScheduleDateResponse>>> getScheduleDates(
      CommonRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getScheduleDates(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetOtherProductsResponse>>>
      getOtherProducts(CommonRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getOtherProducts(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Get Designation Data
  @override
  Future<Either<Failure, BaseResponse<CityDetailResponse>>> designationRequest(
      CommonRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getDesignationData(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<SubmitProductsResponse>>>
      submitOtherProducts(SubmitProductsRequest params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.submitOtherProducts(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<RequestMoneyResponse>>>
  requestMoney(RequestMoneyRequest params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.requestMoney(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  // /// Register Customer
  // @override
  // Future<Either<Failure, BaseResponse<Serializable>>> registerCustomer(
  //     CustomerRegistrationRequestEntity params) async {
  //   if (await networkInfo!.isConnected) {
  //     try {
  //       final parameters = await remoteDataSource!.registerCustomer(params);
  //       return Right(parameters);
  //     } on ServerException catch (e) {
  //       return Left(ServerFailure(e.errorResponseModel));
  //     }
  //   } else {
  //     return Left(ConnectionFailure());
  //   }
  // }

  /// Submit Emp Details
  @override
  Future<Either<Failure, BaseResponse<Serializable>>> submitEmpDetails(
      EmpDetailsRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.submitEmpDetails(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<SecurityQuestionResponse>>>
      getSecurityQuestions(SecurityQuestionRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getSecurityQuestions(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> setSecurityQuestions(
      SetSecurityQuestionsEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.setSecurityQuestions(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  // @override
  // Future<Either<Failure, BaseResponse<Serializable>>> otpVerification(
  //     ChallengeRequestEntity params) async {
  //   if (await networkInfo!.isConnected) {
  //     try {
  //       final parameters = await remoteDataSource!.otpVerification(params);
  //       return Right(parameters);
  //     } on ServerException catch (e) {
  //       return Left(ServerFailure(e.errorResponseModel));
  //     }
  //   } else {
  //     return Left(ConnectionFailure());
  //   }
  // }


  @override
  Future<Either<Failure, BaseResponse<ChallengeResponse>>>
  otpVerification(ChallengeRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.otpVerification(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


  @override
  Future<Either<Failure, BaseResponse<Serializable>>> documentVerification(
      DocumentVerificationApiRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.documentVerification(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> setPreferredLanguage(
      LanguageEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.setPreferredLanguage(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getEpicUserID() async {
    try {
      return Right(localDataSource!.getEpicUserId());
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setEpicUserID(String epicUserID) async {
    try {
      localDataSource!.setEpicUserId(epicUserID);
      return const Right(true);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetScheduleTimeResponse>>>
      getScheduleTimeSlot(GetScheduleTimeRequest params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getScheduleTimeSlots(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> submitScheduleData(
      SubmitScheduleDataRequest params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.submitScheduleData(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<MobileLoginResponse>>> mobileLogin(
      MobileLoginRequest params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.mobileLogin(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> changePassword(
      ChangePasswordRequest params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.changePassword(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<BiometricEnableResponse>>>
      enableBiometric(BiometricEnableRequest params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.biometricEnable(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<OtpResponse>>> otpRequest(
      OtpRequest otpRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.otpRequest(otpRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  ///Contact Us
  @override
  Future<Either<Failure, BaseResponse<ContactUsResponseModel>>> getContactUs(
      ContactUsRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getContactUs(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> savePreferredLanguage() async {
    try {
      localDataSource!.setLanguageState();
      return const Right(true);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<MobileLoginResponse>>> biometricLogin(
      BiometricLoginRequest params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.biometricLogin(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<SrStatementHistoryResponse>>> statementHistory(
      SrStatementHistoryRequest params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.statementHistory(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<SrStatementResponse>>> srStatement(
      SrStatementRequest params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.srStatement(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<RequestMoneyHistoryResponse>>> reqMoneyHistory(
      RequestMoneyHistoryRequest params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.reqMoneyHistory(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CsiResponse>>> csiData(
      CsiRequest params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.csiData(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetSavedBillersResponse>>>
      getSavedBillerList(CommonRequestEntity params) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getSavedBillers(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AddBillerResponse>>> addBiller(
      AddBillerRequest addBillerRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.addBiller(addBillerRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PastCardStatementsresponse>>>
      pastCardStatements(
          PastCardStatementsrequest pastCardStatementsrequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .pastCardStatements(pastCardStatementsrequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ReqMoneyNotificationHistoryResponse>>>
  reqMoneyNotificationHistory(
      ReqMoneyNotificationHistoryRequest reqMoneyNotificationHistoryRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .reqMoneyNotificationHistory(reqMoneyNotificationHistoryRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetMoneyNotificationResponse>>>
  getMoneyNotification(GetMoneyNotificationRequest getMoneyNotificationRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getMoneyNotification(getMoneyNotificationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AccountTransactionHistoryresponse>>>
      accountTransactions(
          AccountTransactionHistorysrequest
              accountTransactionHistorysrequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .accountTransactions(accountTransactionHistorysrequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<LoanHistoryresponse>>> loanHistory(
      LoanHistoryrequest loanHistoryrequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.loanHistory(loanHistoryrequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetFdRateResponse>>> getFDRate(
      GetFdRateRequest getFdRateRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getFDRate(getFdRateRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<SrServiceChargeResponse>>> srServiceCharge(
      SrServiceChargeRequest srServiceChargeRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.srServiceCharge(srServiceChargeRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<LeaseHistoryresponse>>> leaseHistory(
      LeaseHistoryrequest leaseHistoryrequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.leaseHistory(leaseHistoryrequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AccountStatementsresponse>>>
      accountStatements(
          AccountStatementsrequest accountStatementsrequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.accountStatements(accountStatementsrequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardTransactionExcelResponse>>>
      cardTranExcelDownload(
          CardTransactionExcelRequest cardTransactionExcelRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .cardTranExcelDownload(cardTransactionExcelRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardTransactionPdfResponse>>>
      cardTranPdfDownload(
          CardTransactionPdfRequest cardTransactionPdfRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .cardTranPdfDownload(cardTransactionPdfRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AccountStatementPdfDownloadResponse>>>
      accStatementsPdfDownload(
          AccountStatementPdfDownloadRequest
              accountStatementPdfDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .accStatementsPdfDownload(accountStatementPdfDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


  @override
  Future<Either<Failure, BaseResponse<QrPaymentPdfDownloadResponse>>>
  qrPaymentPdfDownload(
      QrPaymentPdfDownloadRequest
      qrPaymentPdfDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .qrPaymentPdfDownload(qrPaymentPdfDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }



  @override
  Future<Either<Failure, BaseResponse<TransactionStatusPdfResponse>>>
      transactionStatusPdfDownload(
          TransactionStatusPdfRequest transactionStatusPdfRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .transactionStatusPdfDownload(transactionStatusPdfRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }



  @override
  Future<Either<Failure, BaseResponse<TransactionFilteredPdfDownloadResponse>>>
  transactionFilterPdfDownload(
      TransactionFilteredPdfDownloadRequest
      transactionFilteredPdfDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .transactionFilterPdfDownload(transactionFilteredPdfDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }



  @override
  Future<Either<Failure, BaseResponse<TransactionFilteredExcelDownloadResponse>>>
  transactionFilterExcelDownload(
      TransactionFilteredExcelDownloadRequest
      transactionFilteredExcelDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .transactionFilterExcelDownload(transactionFilteredExcelDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PromotionShareResponse>>>
      promotionsPdfShare(PromotionShareRequest promotionShareRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.promotionsPdfShare(promotionShareRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


  @override
  Future<Either<Failure, BaseResponse<LeaseHistoryExcelResponse>>>
      leaseHistoryExcelDownload(
          LeaseHistoryExcelRequest leaseHistoryExcelRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .leaseHistoryExcelDownload(leaseHistoryExcelRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<LeaseHistoryPdfResponse>>>
      leaseHistoryPdfDownload(
          LeaseHistoryPdfRequest leaseHistoryPdfRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .leaseHistoryPdfDownload(leaseHistoryPdfRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<LoanHistoryExcelResponse>>>
      loanHistoryExcelDownload(
          LoanHistoryExcelRequest loanHistoryExcelRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .loanHistoryExcelDownload(loanHistoryExcelRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AccountTransactionExcelResponse>>>
      accTransactionExcelDownload(
          AccountTransactionExcelRequest accountTransactionExcelRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .accTransactionExcelDownload(accountTransactionExcelRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetNotificationSettingsResponse>>>
      getNotificationSettings(
          GetNotificationSettingsRequest getNotificationSettingsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .getNotificationSettings(getNotificationSettingsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AccTranStatusExcelDownloadResponse>>>
      accTranStatusExcelDownload(
          AccTranStatusExcelDownloadRequest
              accTranStatusExcelDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .accTranStatusExcelDownload(accTranStatusExcelDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AccountTransactionsPdfDownloadResponse>>>
      accTransactionsPdfDownload(
          AccountTransactionsPdfDownloadRequest
              accountTransactionsPdfDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .accTransactionsPdfDownload(accountTransactionsPdfDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AccTranStatusPdfDownloadResponse>>>
      accTransactionsStatusPdfDownload(
          AccTranStatusPdfDownloadRequest
              accTranStatusPdfDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .accTransactionsStatusPdfDownload(accTranStatusPdfDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AccountSatementsXcelDownloadResponse>>>
      accStatementsXcelDownload(
          AccountSatementsXcelDownloadRequest
              accountSatementsXcelDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .accStatementsXcelDownload(accountSatementsXcelDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<LoanHistoryPdfResponse>>>
      loanHistoryPdfDownload(
          LoanHistoryPdfRequest loanHistoryPdfRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .loanHistoryPdfDownload(loanHistoryPdfRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PastCardExcelDownloadResponse>>>
      pastCardExcelDownload(
          PastCardExcelDownloadRequest pastCardExcelDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .pastCardExcelDownload(pastCardExcelDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardStatementPdfResponse>>>
  cardStatementPdfDownload(
      CardStateentPdfDownloadRequest cardStateentPdfDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .cardStatementPdfDownload(cardStateentPdfDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PastcardStatementstPdfDownloadResponse>>>
      pastCardStatementsPdfDownload(
          PastcardStatementstPdfDownloadRequest
              pastcardStatementstPdfDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .pastCardStatementsPdfDownload(
                pastcardStatementstPdfDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetBillerCategoryListResponse>>>
      getBillerCategoryList(CommonRequestEntity commonRequestEntity) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getBillerCategoryList(commonRequestEntity);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetAllFundTransferScheduleResponse>>>
      getAllFTScheduleList(
          GetAllFundTransferScheduleRequest
              getAllFundTransferScheduleRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .getAllFTScheduleList(getAllFundTransferScheduleRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<DeleteFtScheduleResponse>>>
      deleteFTScedule(DeleteFtScheduleRequest deleteFtScheduleRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.deleteFTScedule(deleteFtScheduleRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ScheduleFtHistoryResponse>>>
      scheduleFTHistory(ScheduleFtHistoryReq scheduleFtHistoryReq) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.scheduleFTHistory(scheduleFtHistoryReq);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<EditUserBillerResponse>>> editBiller(
      EditUserBillerRequest editUserBillerRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.editBiller(editUserBillerRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<DeleteBillerResponse>>> deleteBiller(
      DeleteBillerRequest deleteBillerRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.deleteBiller(deleteBillerRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  // @override
  // Future<Either<Failure, BaseResponse<Serializable>>> unFavoriteBiller(
  //     UnFavoriteBillerRequest unFavoriteBillerRequest) async {
  //   if (await networkInfo!.isConnected) {
  //     try {
  //       final parameters =
  //       await remoteDataSource!.unFavoriteBiller(unFavoriteBillerRequest);
  //       return Right(parameters);
  //     } on ServerException catch (e) {
  //       return Left(ServerFailure(e.errorResponseModel));
  //     } on UnAuthorizedException catch (e) {
  //       return Left(AuthorizedFailure(e.errorResponseModel));
  //     }
  //   } else {
  //     return Left(ConnectionFailure());
  //   }
  // }

  @override
  Future<Either<Failure, BaseResponse<AccountInquiryResponse>>> accountInquiry(
      AccountInquiryRequest accountInquiryRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.accountInquiry(accountInquiryRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetAcctNameFtResponse>>> acctNameForFt(
      GetAcctNameFtRequest getAcctNameFtRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.acctNameForFt(getAcctNameFtRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<BalanceInquiryResponse>>> balanceInquiry(
      BalanceInquiryRequest balanceInquiryRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.balanceInquiry(balanceInquiryRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<NotificationCountResponse>>>
      notificationCount(
          NotificationCountRequest notificationCountRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.notificationCount(notificationCountRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<FundTransferPayeeListResponse>>>
      fundTransferPayeeList(
          FundTransferPayeeListRequest fundTransferPayeeListRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .fundTransferPayeeList(fundTransferPayeeListRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<HousingLoanResponseModel>>>
      housingLoanList(HousingLoanRequestModel housingLoanRequestModel) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.housingLoanList(housingLoanRequestModel);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<EditFtScheduleResponse>>> editFTSchedule(
      EditFtScheduleRequest editFtScheduleRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.editFTSchedule(editFtScheduleRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ApplyHousingLoanResponse>>>
      applyHousingLoanList(
          ApplyHousingLoanRequest applyHousingLoanRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .applyHousingLoanList(applyHousingLoanRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<LeasingCalculatorResponse>>>
      leasingCalculatorList(
          LeasingCalculatorRequest leasingCalculatorRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .leasingCalculatorList(leasingCalculatorRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetCurrencyListResponse>>>
      getCurrencyList(GetCurrencyListRequest getCurrencyListRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getCurrencyList(getCurrencyListRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetBankBranchListResponse>>>
      getBankBranchList(
          GetBankBranchListRequest getBankBranchListRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getBankBranchList(getBankBranchListRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetTxnCategoryResponse>>>
  getTxnCategoryList(
      GetTxnCategoryRequest getTxnCategoryRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
        await remoteDataSource!.getTxnCtegoryList(getTxnCategoryRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetFdPeriodResponse>>> getFDPeriodList(
      GetFdPeriodRequest getFdPeriodRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getFDPeriodList(getFdPeriodRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ApplyLeasingCalculatorResponse>>>
      applyLeasingList(
          ApplyLeasingCalculatorRequest applyLeasingCalculatorRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .applyLeasingList(applyLeasingCalculatorRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<FdCalculatorResponse>>> fdCalculatorList(
      FdCalculatorRequest fdCalculatorRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.fdCalculatorList(fdCalculatorRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ApplyFdCalculatorResponse>>>
      applyFDCalculatorList(
          ApplyFdCalculatorRequest applyFdCalculatorRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .applyFDCalculatorList(applyFdCalculatorRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<DeleteFundTransferPayeeResponse>>>
      deleteFundTransferPayee(
          DeleteFundTransferPayeeRequest deleteFundTransferPayeeRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .deleteFundTransferPayee(deleteFundTransferPayeeRequest);

        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AddPayResponse>>> payManagementAddPay(
      AddPayRequest addPayRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.payManagementAddPay(addPayRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetBankListResponse>>> getBankList(
      GetBankListRequest getBankListRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getBankList(getBankListRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<EditPayeeResponse>>> editPayee(
      EditPayeeRequest editPayeeRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.editPayee(editPayeeRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetBranchListResponse>>> getBranchList(
      GetBranchListRequest getBranchListRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getBranchList(getBranchListRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<FaqResponse>>> preLoginFaq(
      FaqRequest faqRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.preLoginFaq(faqRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  // @override
  // Future<Either<Failure, BaseResponse<Serializable>>> accountVerification(
  //     AccountVerificationRequest accountVerificationRequest) async {
  //   if (await networkInfo!.isConnected) {
  //     try {
  //       final parameters = await remoteDataSource!
  //           .accountVerification(accountVerificationRequest);
  //       return Right(parameters);
  //     } on ServerException catch (e) {
  //       return Left(ServerFailure(e.errorResponseModel));
  //     } on UnAuthorizedException catch (e) {
  //       return Left(AuthorizedFailure(e.errorResponseModel));
  //     }
  //   } else {
  //     return Left(ConnectionFailure());
  //   }
  // }

  @override
  Future<Either<Failure, BaseResponse<ImageApiResponseModel>>> getImage(
      ImageApiRequestModel imageApiRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getImage(imageApiRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PromotionsResponse>>> getPromotions(
      PromotionsRequest promotionsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getPromotions(promotionsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  ///Fund Transfer
  @override
  Future<Either<Failure, BaseResponse<IntraFundTransferResponse>>>
      getIntraFundTransfer(
          IntraFundTransferRequest intraFundTransferRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .getIntraFundTransfer(intraFundTransferRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GoldLoanDetailsResponse>>>
      requestGoldLoanDetails(
          GoldLoanDetailsRequest goldLoanDetailsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.goldLoanDetails(goldLoanDetailsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GoldLoanListResponse>>>
      requestGoldLoanList(GoldLoanListRequest goldLoanListRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.goldLoanList(goldLoanListRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GoldLoanPaymentTopUpResponse>>>
      requestGoldLoanPaymentTopUp(
          GoldLoanPaymentTopUpRequest goldLoanPaymentTopUpRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .goldLoanPaymentTopUp(goldLoanPaymentTopUpRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<TransactionCategoriesListResponse>>>
      transactionCategoriesList(
          TransactionCategoriesListRequest
              transactionCategoriesListRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .transactionCategoriesList(transactionCategoriesListRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> cdbAccountVerification(
      CdbAccountVerificationRequest cdbAccountVerificationRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .cdbAccountVerification(cdbAccountVerificationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AddItransferPayeeResponse>>>
      addItransferPayee(
          AddItransferPayeeRequest addItransferPayeeRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.addItransferPayee(addItransferPayeeRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ItransferPayeeListResponse>>>
      itransferPayeeList(
          ItransferPayeeListRequest itransferPayeeListRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .itransferPayeeList(itransferPayeeListRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> editItransferPayee(
      EditItransferPayeeRequest editItransferPayeeRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .editItransferPayee(editItransferPayeeRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> deleteItransferPayee(
      DeleteItransferPayeeRequest deleteItransferPayeeRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .deleteItransferPayee(deleteItransferPayeeRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
  @override
  Future<Either<Failure, BaseResponse<Serializable>>> txnLimitReset(
      TxnLimitResetRequest txnLimitResetRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .txnLimitReset(txnLimitResetRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<MerchantLocatorResponse>>>
      merchantLocator(MerchantLocatorRequest merchantLocatorRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.merchantLocator(merchantLocatorRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  // @override
  // Future<Either<Failure, BaseResponse<Serializable>>> justPayVerification(
  //     JustPayVerificationRequest justPayVerificationRequest) async {
  //   if (await networkInfo!.isConnected) {
  //     try {
  //       final parameters = await remoteDataSource!
  //           .justPayVerification(justPayVerificationRequest);
  //       return Right(parameters);
  //     } on ServerException catch (e) {
  //       return Left(ServerFailure(e.errorResponseModel));
  //     } on UnAuthorizedException catch (e) {
  //       return Left(AuthorizedFailure(e.errorResponseModel));
  //     }
  //   } else {
  //     return Left(ConnectionFailure());
  //   }
  // }

  @override
  Future<Either<Failure, BaseResponse<GetUserInstResponse>>> getUserInstruments(
      GetUserInstRequest getUserInstRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getUserInstruments(getUserInstRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetRemainingInstResponse>>>
      getRemainingInstruments(
          GetRemainingInstRequest getRemainingInstRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .getRemainingInstruments(getRemainingInstRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> addUserInstrument(
      AddUserInstRequest addUserInstRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.addUserInstrument(addUserInstRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  // @override
  // Future<Either<Failure, BaseResponse<JustPayAccountOnboardingResponse>>>
  //     justPayAcoountOnboarding(
  //         JustPayAccountOnboardingRequest
  //             justPayAccountOnboardingRequest) async {
  //   if (await networkInfo!.isConnected) {
  //     try {
  //       final parameters = await remoteDataSource!
  //           .justPayOnboarding(justPayAccountOnboardingRequest);
  //       return Right(parameters);
  //     } on ServerException catch (e) {
  //       return Left(ServerFailure(e.errorResponseModel));
  //     } on UnAuthorizedException catch (e) {
  //       return Left(AuthorizedFailure(e.errorResponseModel));
  //     }
  //   } else {
  //     return Left(ConnectionFailure());
  //   }
  // }

  @override
  Future<Either<Failure, BaseResponse<LoanRequestFieldDataResponse>>>
      loanRequestsFieldData(
          LoanRequestsFieldDataRequest loanRequestsFieldDataRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .loanRequestsFieldData(loanRequestsFieldDataRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  // @override
  // Future<Either<Failure, BaseResponse<JustPayChallengeIdResponse>>>
  //     JustPayChallengeId(
  //         JustPayChallengeIdRequest justPayChallengeIdRequest) async {
  //   if (await networkInfo!.isConnected) {
  //     try {
  //       final parameters = await remoteDataSource!.JustPayChallengeId(
  //           justPayChallengeIdRequest);
  //       return Right(parameters);
  //     } on ServerException catch (e) {
  //       return Left(ServerFailure(e.errorResponseModel));
  //     } on UnAuthorizedException catch (e) {
  //       return Left(AuthorizedFailure(e.errorResponseModel));
  //     }
  //   } else {
  //     return Left(ConnectionFailure());
  //   }
  // }

  @override
  Future<Either<Failure, BaseResponse<TransactionDetailsResponse>>>
      getTransactionDetails(
          TransactionDetailsRequest transactionDetailsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .getTransactionDetails(transactionDetailsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<SettingsTranLimitResponse>>>
      settingsTranLimit(
          SettingsTranLimitRequest settingsTranLimitRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.settingsTranLimit(settingsTranLimitRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CalculatorPdfResponse>>> calculatorPDF(
      CalculatorPdfRequest calculatorPdfRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.calculatorPDF(calculatorPdfRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<LoanRequestsSubmitResponse>>>
      loanReqSaveData(
          LoanRequestsSubmitRequest loanRequestsSubmitRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.loanReqSaveData(loanRequestsSubmitRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CreditCardReqFieldDataResponse>>>
      creditCardReqFieldData(
          CreditCardReqFieldDataRequest creditCardReqFieldDataRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .creditCardReqFieldData(creditCardReqFieldDataRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CreditCardReqSaveResponse>>>
      creditCardReqSave(
          CreditCardReqSaveRequest creditCardReqSaveRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.creditCardReqSave(creditCardReqSaveRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<LeaseReqFieldDataResponse>>>
      leaseReqFieldData(
          LeaseReqFieldDataRequest leaseReqFieldDataRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.leaseReqFieldData(leaseReqFieldDataRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


  @override
  Future<Either<Failure, BaseResponse<ChequeBookResponse>>>
  checkBookReq(
      ChequeBookRequest chequeBookRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
        await remoteDataSource!.chequeBookFieldData(chequeBookRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<LeaseReqSaveDataResponse>>>
      leaseReqSaveData(LeaseReqSaveDataRequest leaseReqSaveDataRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.leaseReqSaveData(leaseReqSaveDataRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ServiceReqHistoryResponse>>>
      serviceReqHistory(
          ServiceReqHistoryRequest serviceReqHistoryRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.serviceReqHistory(serviceReqHistoryRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<LoanReqFieldDataResponse>>> loanReq(
      LoanReqFieldDataRequest loanReqFieldDataRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.loanReq(loanReqFieldDataRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> justPayInstrument(
      JustPayInstruementsReques justPayInstruementsReques) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .justPayInstruements(justPayInstruementsReques);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AddJustPayInstrumentsResponse>>>
      addJustPayInstrument(
          AddJustPayInstrumentsRequest addJustPayInstrumentsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .addJustPayInstruements(addJustPayInstrumentsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<OneTimeFundTransferResponse>>>
      oneTimeFundTransfer(
          OneTimeFundTransferRequest oneTimeFundTransferRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .oneTimeFundTransfer(oneTimeFundTransferRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<SchedulingFundTransferResponse>>>
      schedulingFundTransfer(
          SchedulingFundTransferRequest schedulingFundTransferRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .schedulingFundTransfer(schedulingFundTransferRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ScheduleBillPaymentResponse>>>
      schedulingBillPayment(
          ScheduleBillPaymentRequest scheduleBillPaymentRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .schedulingBillPayment(scheduleBillPaymentRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> defaultPaymentInstrument(
      DefaultPaymentInstrumentRequest defaultPaymentInstrumentRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .defaultPaymentInstrument(defaultPaymentInstrumentRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> instrumentStatusChange(
      InstrumentStatusChangeRequest instrumentStatusChangeRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .instrumentStatusChange(instrumentStatusChangeRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> instrumentNickNameChange(
      InstrumentNickNameChangeRequest instrumentNickNameChangeRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .instrumentNickNameChange(instrumentNickNameChangeRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> editNickName(
      EditNickNamerequest editNickNamerequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.editNickName(editNickNamerequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<TransactionLimitResponse>>>
      transactionLimit(TransactionLimitRequest transactionLimitRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.transactionLimit(transactionLimitRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> transactionLimitAdd(
      TransactionLimitAddRequest transactionLimitAddRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .transactionLimitAdd(transactionLimitAddRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ServiceReqFilteredListResponse>>>
      serviceReqFilteredList(
          ServiceReqHistoryRequest serviceReqHistoryRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .serviceReqFilteredList(serviceReqHistoryRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<UpdateProfileImageResponse>>>
      updateProfileImage(
          UpdateProfileImageRequest updateProfileImageRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .updateProfileImage(updateProfileImageRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ViewPersonalInformationResponse>>>
      viewPersonalInformation(
          ViewPersonalInformationRequest viewPersonalInformationRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .viewPersonalInformation(viewPersonalInformationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<TransactionHistoryPdfDownloadResponse>>>
      transactionHistoryPdfDownload(
          TransactionHistoryPdfDownloadRequest
              transactionHistoryPdfDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .transactionHistoryPdfDownload(
                transactionHistoryPdfDownloadRequest);
        return Right(
            parameters as BaseResponse<TransactionHistoryPdfDownloadResponse>);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ItransferGetThemeResponse>>>
      itransferGetTheme(
          ItransferGetThemeRequest itransferGetThemeRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.itransferGetTheme(itransferGetThemeRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ItransferGetThemeDetailsResponse>>>
      itransferGetThemeDetails(
          ItransferGetThemeDetailsRequest
              itransferGetThemeDetailsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .itransferGetThemeDetails(itransferGetThemeDetailsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<BillPaymentResponse>>> billPayment(
      BillPaymentRequest billPaymentRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.billPayment(billPaymentRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<FundTransferPdfDownloadResponse>>>
      fundTransferPdfDownload(
          FundTransferPdfDownloadRequest fundTransferPdfDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .fundTransferPdfDownload(fundTransferPdfDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<FundTransferExcelDownloadResponse>>>
      fundTransferExcelDownload(
          FundTransferExcelDownloadRequest
              fundTransferExcelDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .fundTransferExcelDownload(fundTransferExcelDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetAllScheduleFtResponse>>>
      getAllScheduleFT(GetAllScheduleFtRequest getAllScheduleFtRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getAllScheduleFT(getAllScheduleFtRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<InitiateItransfertResponse>>>
      initiateItransfer(
          InitiateItransfertRequest initiateItransfertRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .initiateItransfer(initiateItransfertRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<DebitCardReqFieldDataResponse>>>
      debitCardReqFieldData(
          DebitCardReqFieldDataRequest debitCardReqFieldDataRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .debitCardReqFieldData(debitCardReqFieldDataRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<DebitCardSaveDataResponse>>>
      debitCardReqSaveData(
          DebitCardSaveDataRequest debitCardSaveDataRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .debitCardReqSaveData(debitCardSaveDataRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AccountDetailsResponseDtos>>>
      portfolioAccDetails(
          PortfolioAccDetailsRequest portfolioAccDetailsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .portfolioAccDetails(portfolioAccDetailsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ResetPasswordResponse>>> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.resetPassword(resetPasswordRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<TransactionFilterResponse>>>
      transactionFilter(
          TransactionFilterRequest transactionFilterRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.transactionFilter(transactionFilterRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PersonalLoanResponse>>>
      personalLoanCalculator(PersonalLoanRequest personalLoanRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.personalLoanCal(personalLoanRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ApplyPersonalLoanResponse>>>
      applyPersonalLoan(
          ApplyPersonalLoanRequest applyPersonalLoanRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.applyPersonalLoan(applyPersonalLoanRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  // @override
  // Future<Either<Failure, BaseResponse<Serializable>>>
  // applyPersonalLoan(
  //     ApplyPersonalLoanRequest applyPersonalLoanRequest) async {
  //   if (await networkInfo!.isConnected) {
  //     try {
  //       final parameters =
  //           await remoteDataSource!.applyPersonalLoan(applyPersonalLoanRequest);
  //       return Right(parameters);
  //     } on ServerException catch (e) {
  //       return Left(ServerFailure(e.errorResponseModel));
  //     }
  //   } else {
  //     return Left(ConnectionFailure());
  //   }
  // }

  @override
  Future<Either<Failure, BaseResponse<GetPayeeResponse>>> getPayeeList(
      GetPayeeRequest getPayeeRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getPayeeList(getPayeeRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, BaseResponse<PortfolioCcDetailsResponse>>>
      portfolioCCDetails(
          PortfolioCcDetailsRequest portfolioCcDetailsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .portfolioCCDetails(portfolioCcDetailsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PortfolioLoanDetailsResponse>>>
      portfolioLoanDetails(
          PortfolioLoanDetailsRequest portfolioLoanDetailsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .portfolioLoanDetails(portfolioLoanDetailsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PortfolioLeaseDetailsResponse>>>
      portfolioLeaseDetails(
          PortfolioLoanDetailsRequest portfolioLoanDetailsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .portfolioLeaseDetails(portfolioLoanDetailsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PortfolioUserFdDetailsResponse>>>
      portfolioFDDetails(
          PortfolioUserFdDetailsRequest portfolioUserFdDetailsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .portfolioFDDetails(portfolioUserFdDetailsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<TransactionNotificationResponse>>>
      getTranNotifications(
          TransactionNotificationRequest transactionNotificationRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .getTranNotifications(transactionNotificationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PromotionNotificationResponse>>>
      getPromoNotifications(
          PromotionNotificationRequest promotionNotificationRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .getPromoNotifications(promotionNotificationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<NoticesNotificationResponse>>>
      getNoticesNotifications(
          NoticesNotificationRequest noticesNotificationRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .getNoticesNotifications(noticesNotificationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> composeMail(
      ComposeMailRequest composeMailRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.composeMail(composeMailRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<RecipientTypeResponse>>> getRecipientType(
      RecipientTypeRequest recipientTypeRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getRecipientType(recipientTypeRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  
  @override
  Future<Either<Failure, BaseResponse<RecipientCategoryResponse>>> getRecipientCategory(
      RecipientCategoryRequest recipientCategoryRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getRecipientCategory(recipientCategoryRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ViewMailResponse>>> getViewMail(
      ViewMailRequest viewMailRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getViewMail(viewMailRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

    @override
  Future<Either<Failure, BaseResponse<MailThreadResponse>>> getMailThread(MailThreadRequest mailThreadRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getMailThread(mailThreadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
  
  @override
  Future<Either<Failure, BaseResponse<MailAttachmentResponse>>> getMailAttachment(MailAttachmentRequest mailAttachmentRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getMailAttachment(mailAttachmentRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

    @override
  Future<Either<Failure, BaseResponse<Serializable>>> deleteMailAttachment(MailAttachmentRequest mailAttachmentRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.deleteMailAttachment(mailAttachmentRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> deleteMail(
      DeleteMailRequest deleteMailRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.deleteMail(deleteMailRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> markAsReadMail(
      MarkAsReadMailRequest markAsReadMailRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.markAsReadMail(markAsReadMailRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> markAsReadNotification(
      MarkAsReadNotificationRequest markAsReadNotificationRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .markAsReadNotification(markAsReadNotificationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> deleteNotification(
      DeleteNotificationRequest deleteNotificationRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .deleteNotification(deleteNotificationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> replyMail(
      ReplyMailRequest replyMailRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.replyMail(replyMailRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<BillerPdfDownloadResponse>>>
      billerPdfDownload(
          BillerPdfDownloadRequest billerPdfDownloadRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.billerPdfDownload(billerPdfDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> updateTxnLimit(
      UpdateTxnLimitRequest updateTxnLimitRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.updateTxnLimit(updateTxnLimitRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> AddPaymentInstrument(
      JustPayInstruementsReques justPayInstruementsReques) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .justPayInstruements(justPayInstruementsReques);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>>
      DeleteInstrumentPaymentInstrument(
          DeleteJustPayInstrumentRequest deleteJustPayInstrumentRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .DeleteJustPayInstruements(deleteJustPayInstrumentRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetJustPayInstrumentResponse>>>
      GetPaymentInstrument(
          GetJustPayInstrumentRequest getJustPayInstrumentRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .getJustPayInstrumentList(getJustPayInstrumentRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ForgetPasswordResponse>>>
      forgetPwCheckNicAccount(
          ForgetPwCheckNicAccountRequest forgetPwCheckNicAccountRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .forgetPwCheckNicAccount(forgetPwCheckNicAccountRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ForgetPasswordResponse>>>
      forgetPwCheckUsername(
          ForgetPwCheckUsernameRequest forgetPwCheckUsernameRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .forgetPwCheckUsername(forgetPwCheckUsernameRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ForgetPasswordResponse>>>
      forgetPwCheckSecurityQuestion(
          ForgetPwCheckSecurityQuestionRequest
              forgetPwCheckSecurityQuestionRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .forgetPwCheckSecurityQuestion(
                forgetPwCheckSecurityQuestionRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> forgetPwReset(
      ForgetPwResetRequest forgetPwResetRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.forgetPwReset(forgetPwResetRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> updateProfile(
      UpdateProfileDetailsRequest updateProfileDetailsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .updateProfileDetails(updateProfileDetailsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetHomeDetailsResponse>>> getHomeDetails(
      GetHomeDetailsRequest getHomeDetailsRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getHomeDetails(getHomeDetailsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<RetrieveProfileImageResponse>>>
      getProfileImage(
          RetrieveProfileImageRequest retrieveProfileImageRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .getProfileImage(retrieveProfileImageRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<DemoTourListResponse>>> getDemoTour(
      CommonRequest commonRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getDemoTour(commonRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<MarketingBannersResponse>>>
      getMarketingBanners(
          MarketingBannersRequest marketingBannersRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getMarketingBanner(marketingBannersRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<MailCountResponse>>> getMailCount(
      MailCountRequest mailCountRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getMailCount(mailCountRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PayeeFavoriteResponse>>> payeeFavorite(
      PayeeFavoriteRequest payeeFavoriteRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.favoritePayee(payeeFavoriteRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<FavoriteBillerResponse>>> favouriteBiller(
      FavouriteBillerRequest favouriteBillerRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.favouriteBiller(favouriteBillerRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<PasswordValidationResponse>>>
      passwordValidation(
          PasswordValidationRequest passwordValidationRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!
            .passwordValidation(passwordValidationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<QrPaymentResponse>>>
  qrPayment(QrPaymentRequest qrPaymentRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
        await remoteDataSource!.qrPayment(qrPaymentRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ChequeBookFilterResponse>>> checkBookFilter
      (ChequeBookFilterRequest chequeBookFilterRequest) async{

      if (await networkInfo!.isConnected) {
        try {
          final parameters =
          await remoteDataSource!.chequeBookFilter(chequeBookFilterRequest);
          return Right(parameters);
        } on ServerException catch (e) {
          return Left(ServerFailure(e.errorResponseModel));
        } on UnAuthorizedException catch (e) {
          return Left(AuthorizedFailure(e.errorResponseModel));
        } on SessionExpireException catch (e) {
          return Left(SessionExpire(e.errorResponseModel));
        }
      } else {
        return Left(ConnectionFailure());
      }


  }

  @override
  Future<Either<Failure, BaseResponse<RequestCallBackGetResponse>>> getRequestCall(RequestCallBackGetRequest requestCallBackGetRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getRequestCall(requestCallBackGetRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<RequestCallBackGetDefaultDataResponse>>> getRequestCallDefaultData(RequestCallBackGetDefaultDataRequest requestCallBackGetDefaultDataRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getRequestCallDefaultData(requestCallBackGetDefaultDataRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> saveRequestCall(RequestCallBackSaveRequest requestCallBackSaveRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.saveRequestCall(requestCallBackSaveRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> cancelRequestCall(RequestCallBackCancelRequest requestCallBackCancelRequest) async{
     if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.cancelRequestCall(requestCallBackCancelRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<FloatInquiryResponse>>> floatInquiryRequest(FloatInquiryRequest floatInquiryRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.floatInquiryRequest(floatInquiryRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> deleteMailMessage(DeleteMailMessageRequest deleteMailMessageRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.deleteMailMessage(deleteMailMessageRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<KeyExchangeResponse>>> keyExchange(KeyExchangeRequest keyExchangeRequest) async{
     if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.keyExchange(keyExchangeRequest);
           return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
  
  @override
  
  Future<Either<Failure, BaseResponse<BillPaymentExcelDownloadResponse>>> billerExcelDownload(BillPaymentExcelDownloadRequest billPaymentExcelDownloadRequest) async{
   if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.billerExcelDownload(billPaymentExcelDownloadRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> getBbc(BaseRequest baseRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getCnn(baseRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> getCnn(BaseRequest baseRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters =
            await remoteDataSource!.getBbc(baseRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<TemporaryLoginResponse>>> temporaryLogin(TemporaryLoginRequest params)async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.temporaryLogin(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


 /* ----------------------------- Card Mangement ----------------------------- */

  @override
  Future<Either<Failure, BaseResponse<CardListResponse>>> cardList(
      CommonRequest cardListRequest) async {
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getCardList(cardListRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> cardActivation(CardActivationRequest cardActivationRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.cardActivation(cardActivationRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardCreditLimitResponse>>> cardCreditLimit(CardCreditLimitRequest cardCreditLimitRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.cardCreditLimit(cardCreditLimitRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardDetailsResponse>>> cardDetails(CardDetailsRequest cardDetailsRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.cardDetails(cardDetailsRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardEStatementResponse>>> cardEStatement(CardEStatementRequest cardEStatementRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.cardEStatement(cardEStatementRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardLastStatementResponse>>> cardLastStatement(CardLastStatementRequest cardLastStatementRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.cardLastStatement(cardLastStatementRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardLostStolenResponse>>> cardLostStolen(CardLostStolenRequest cardLostStolenRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.cardLostStolen(cardLostStolenRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardPinResponse>>> cardPinRequest(CardPinRequest cardPinRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.cardPinRequest(cardPinRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardTxnHistoryResponse>>> cardTxnHistory(CardTxnHistoryRequest cardTxnHistoryRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.cardTxnHistory(cardTxnHistoryRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardViewStatementResponse>>> cardViewStatement(CardViewStatementRequest cardViewStatementRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.cardViewStatement(cardViewStatementRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardLoyaltyVouchersResponse>>> cardLoyaltyVouchers(CommonRequest cardLoyaltyVouchersRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.getCardLoyaltyVouchers(cardLoyaltyVouchersRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CardLoyaltyRedeemResponse>>> cardLoyaltyRedeem(CardLoyaltyRedeemRequest cardLoyaltyRedeemRequest) async{
    if (await networkInfo!.isConnected) {
      try {
        final parameters = await remoteDataSource!.cardLoyaltyRedeem(cardLoyaltyRedeemRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      } on SessionExpireException catch (e) {
        return Left(SessionExpire(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
  
/* ------------------------------------ . ----------------------------------- */

  }
