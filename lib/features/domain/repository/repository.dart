import 'package:fpdart/fpdart.dart';
import 'package:union_bank_mobile/features/data/models/common/base_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/account_tran_excel_request.dart';
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
import 'package:union_bank_mobile/features/data/models/requests/delete_mail_message_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/float_inquiry_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_nic_account_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_security_question_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_check_username_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/forget_pw_reset_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/just_pay_tc_sign_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/key_exchanege_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_attachment_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_count_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mail_thread_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/password_validation_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/recipient_type_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_cancel_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_get_default_data_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_get_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/request_callback_save_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/temporary_login_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/bill_payment_excel_dwnload_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_credit_limit_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_detals_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_e_statement_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_last_statement_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_lost_stolen_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_pin_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_txn_history_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_view_statement_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_transaction_pdf.dart';
import 'package:union_bank_mobile/features/data/models/requests/common_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/compose_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/delete_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/mark_as_read_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/recipient_category_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/reply_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/requests/view_mail_request.dart';
import 'package:union_bank_mobile/features/data/models/responses/card_management/card_list_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/demo_tour_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/float_inquiry_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/forgot_password_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/housing_loan_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/key_exchange_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_attachment_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_count_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/mail_thread_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/password_validation_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/recipient_category_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/recipient_type_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/loan_history_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/past_card_excel_download.dart';
import 'package:union_bank_mobile/features/data/models/responses/request_callback_get_default_data_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/request_callback_get_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/temporary_login_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/transaction_notification_response.dart';
import 'package:union_bank_mobile/features/data/models/responses/view_mail_response.dart';
import 'package:union_bank_mobile/features/domain/entities/request/security_question_request_entity.dart';

import '../../../error/failures.dart';
import '../../data/models/common/base_response.dart';
import '../../data/models/requests/QRPaymentPdfDownloadRequest.dart';
import '../../data/models/requests/acc_tran_status_excel.dart';
import '../../data/models/requests/acc_tran_status_pdf.dart';
import '../../data/models/requests/account_inquiry_request.dart';

import '../../data/models/requests/account_statement_pdf_download.dart';
import '../../data/models/requests/account_statements_excel_request.dart';
import '../../data/models/requests/account_statements_request.dart';
import '../../data/models/requests/account_tarnsaction_history_pdf_download_request.dart';

import '../../data/models/requests/account_transaction_history_request.dart';
import '../../data/models/requests/account_verfication_request.dart';
import '../../data/models/requests/add_biller_request.dart';
import '../../data/models/requests/add_itransfer_payee_request.dart';
import '../../data/models/requests/add_justPay_instrument_request.dart';
import '../../data/models/requests/add_just_pay_instruements_request.dart';
import '../../data/models/requests/add_pay_request.dart';
import '../../data/models/requests/add_user_inst_request.dart';
import '../../data/models/requests/apply_fd_calculator_request.dart';
import '../../data/models/requests/apply_housing_loan_request.dart';
import '../../data/models/requests/apply_leasing_request.dart';
import '../../data/models/requests/apply_personal_loan_request.dart';
import '../../data/models/requests/balance_inquiry_request.dart';
import '../../data/models/requests/bill_payment_request.dart';
import '../../data/models/requests/biller_pdf_download_request.dart';
import '../../data/models/requests/biometric_enable_request.dart';
import '../../data/models/requests/biometric_login_request.dart';
import '../../data/models/requests/calculator_share_pdf_request.dart';
import '../../data/models/requests/card_management/card_statement_pdf_download_request.dart';
import '../../data/models/requests/card_taransaction_pdf.dart';
import '../../data/models/requests/card_tran_excel_download.dart';
import '../../data/models/requests/cdb_account_verfication_request.dart';
import '../../data/models/requests/change_password_request.dart';
import '../../data/models/requests/cheque_book_filter_request.dart';
import '../../data/models/requests/cheque_book_request.dart';
import '../../data/models/requests/credit_card_req_field_data_request.dart';
import '../../data/models/requests/credit_card_req_save_request.dart';
import '../../data/models/requests/csi_request.dart';
import '../../data/models/requests/debit_card_req_field_data_request.dart';
import '../../data/models/requests/debit_card_save_data_request.dart';
import '../../data/models/requests/default_payment_instrument_request.dart';
import '../../data/models/requests/delete_biller_request.dart';
import '../../data/models/requests/delete_ft_schedule_request.dart';
import '../../data/models/requests/delete_fund_transfer_payee_request.dart';
import '../../data/models/requests/delete_itransfer_payee_request.dart';
import '../../data/models/requests/delete_justpay_instrument_request.dart';
import '../../data/models/requests/delete_notification_request.dart';
import '../../data/models/requests/edit_ft_schedule_request.dart';
import '../../data/models/requests/edit_itransfer_payee_request.dart';
import '../../data/models/requests/edit_nick_name_request.dart';
import '../../data/models/requests/edit_payee_request.dart';
import '../../data/models/requests/edit_profile_details_request.dart';
import '../../data/models/requests/edit_user_biller_request.dart';
import '../../data/models/requests/faq_request.dart';
import '../../data/models/requests/favourite_biller_request.dart';
import '../../data/models/requests/fd_calculator_request.dart';
import '../../data/models/requests/fund_transfer_excel_dwnload_request.dart';
import '../../data/models/requests/fund_transfer_one_time_request.dart';
import '../../data/models/requests/fund_transfer_payee_list_request.dart';
import '../../data/models/requests/fund_transfer_pdf_download_request.dart';
import '../../data/models/requests/fund_transfer_scheduling_request.dart';
import '../../data/models/requests/getBranchListRequest.dart';
import '../../data/models/requests/getTxnCategoryList_request.dart';
import '../../data/models/requests/get_account_name_ft_request.dart';
import '../../data/models/requests/get_all_fund_transfer_schedule_request.dart';
import '../../data/models/requests/get_all_schedule_fund_transfer_request.dart';
import '../../data/models/requests/get_bank_list_request.dart';
import '../../data/models/requests/get_branch_list_request.dart';
import '../../data/models/requests/get_currency_list_request.dart';
import '../../data/models/requests/get_fd_period_req.dart';
import '../../data/models/requests/get_fd_rate_request.dart';
import '../../data/models/requests/get_home_details_request.dart';
import '../../data/models/requests/get_justpay_instrument_request.dart';
import '../../data/models/requests/get_money_notification_request.dart';
import '../../data/models/requests/get_notification_settings_request.dart';
import '../../data/models/requests/get_payee_request.dart';
import '../../data/models/requests/get_remaining_inst_request.dart';
import '../../data/models/requests/get_schedule_time_request.dart';
import '../../data/models/requests/get_user_inst_request.dart';
import '../../data/models/requests/gold_loan_details_request.dart';
import '../../data/models/requests/gold_loan_list_request.dart';
import '../../data/models/requests/gold_loan_payment_topup_request.dart';
import '../../data/models/requests/housing_loan_request.dart';
import '../../data/models/requests/image_api_request_model.dart';
import '../../data/models/requests/initiate_itransfer_request.dart';
import '../../data/models/requests/instrument_nickName_change_request.dart';
import '../../data/models/requests/instrument_status_change_request.dart';
import '../../data/models/requests/intra_fund_transfer_request.dart';
import '../../data/models/requests/itransfer_get_theme_details_request.dart';
import '../../data/models/requests/itransfer_get_theme_request.dart';
import '../../data/models/requests/itransfer_payee_list_request.dart';
import '../../data/models/requests/just_pay_account_onboarding_request.dart';
import '../../data/models/requests/just_pay_challenge_id_request.dart';
import '../../data/models/requests/just_pay_verfication_request.dart';
import '../../data/models/requests/lease_history_excel.dart';
import '../../data/models/requests/lease_history_pdf.dart';
import '../../data/models/requests/lease_payment_history_request.dart';
import '../../data/models/requests/lease_req_field_data_request.dart';
import '../../data/models/requests/lease_req_save_data_request.dart';
import '../../data/models/requests/leasing_calculator_request.dart';
import '../../data/models/requests/loan_history_excel_request.dart';
import '../../data/models/requests/loan_history_pdf_download.dart';
import '../../data/models/requests/loan_history_request.dart';
import '../../data/models/requests/loan_req_field_data_request.dart';
import '../../data/models/requests/loan_requests_field_data_request.dart';
import '../../data/models/requests/loan_requests_submit_request.dart';
import '../../data/models/requests/loyalty_management/card_loyalty_redeem_request.dart';
import '../../data/models/requests/mark_as_read_notification_request.dart';
import '../../data/models/requests/marketing_banners_request.dart';
import '../../data/models/requests/merchant_locator_request.dart';
import '../../data/models/requests/mobile_login_request.dart';
import '../../data/models/requests/notices_notification_request.dart';
import '../../data/models/requests/notification_count_request.dart';
import '../../data/models/requests/otp_request.dart';
import '../../data/models/requests/past_card_excel_download.dart';
import '../../data/models/requests/past_card_statement_request.dart';
import '../../data/models/requests/past_card_statements_pdf_download_request.dart';
import '../../data/models/requests/payee_favorite_request.dart';
import '../../data/models/requests/personal_loan_request.dart';
import '../../data/models/requests/portfolio_account_details_request.dart';
import '../../data/models/requests/portfolio_cc_details_request.dart';
import '../../data/models/requests/portfolio_loan_details_request.dart';
import '../../data/models/requests/portfolio_user_fd_details_request.dart';
import '../../data/models/requests/promotion_notification_request.dart';
import '../../data/models/requests/promotion_share_request.dart';
import '../../data/models/requests/promotions_request.dart';
import '../../data/models/requests/qr_payment_request.dart';
import '../../data/models/requests/req_money_notification_history_request.dart';
import '../../data/models/requests/request_money_history_request.dart';
import '../../data/models/requests/request_money_request.dart';
import '../../data/models/requests/reset_password_request.dart';
import '../../data/models/requests/retrieve_profile_image_request.dart';
import '../../data/models/requests/schedule_bill_payment_request.dart';
import '../../data/models/requests/schedule_ft_history_request.dart';
import '../../data/models/requests/service_req_history_request.dart';
import '../../data/models/requests/settings_tran_limit_request.dart';
import '../../data/models/requests/settings_update_txn_limit_request.dart';
import '../../data/models/requests/sr_service_charge_request.dart';
import '../../data/models/requests/sr_statement_history_request.dart';
import '../../data/models/requests/sr_statement_request.dart';
import '../../data/models/requests/submit_products_request.dart';
import '../../data/models/requests/submit_schedule_data_request.dart';
import '../../data/models/requests/transaction_categories_list_request.dart';
import '../../data/models/requests/transaction_filter_pdf_download.dart';
import '../../data/models/requests/transaction_filter_request.dart';
import '../../data/models/requests/transaction_filtered_exce_download_request.dart';
import '../../data/models/requests/transaction_history_pdf_download_request.dart';
import '../../data/models/requests/transaction_limit_add_request.dart';
import '../../data/models/requests/transaction_limit_request.dart';
import '../../data/models/requests/transaction_notification_request.dart';
import '../../data/models/requests/transaction_pdf_download.dart';
import '../../data/models/requests/transcation_details_request.dart';
import '../../data/models/requests/txn_limit_reset_request.dart';
import '../../data/models/requests/ub_account_verfication_request.dart';
import '../../data/models/requests/update_notification_settings_request.dart';
import '../../data/models/requests/update_profile_image_request.dart';
import '../../data/models/requests/view_personal_information_request.dart';
import '../../data/models/requests/wallet_onboarding_data.dart';

import '../../data/models/responses/QrPaymentPdfDownloadResponse.dart';
import '../../data/models/responses/acc_tran_status_excel.dart';
import '../../data/models/responses/acc_tran_status_pdf.dart';
import '../../data/models/responses/account_details_response_dtos.dart';
import '../../data/models/responses/account_inquiry_response.dart';
import '../../data/models/responses/account_statement_pdf_download.dart';
import '../../data/models/responses/account_statements_response.dart';
import '../../data/models/responses/account_statesment_xcel_download_response.dart';
import '../../data/models/responses/account_tran_excel_response.dart';
import '../../data/models/responses/account_transaction_history_pdf_response.dart';
import '../../data/models/responses/account_transaction_history_response.dart';
import '../../data/models/responses/add_biller_response.dart';
import '../../data/models/responses/add_itransfer_payee_response.dart';
import '../../data/models/responses/add_just_pay_instruements_response.dart';
import '../../data/models/responses/add_pay_response.dart';
import '../../data/models/responses/apply_fd_calculator_response.dart';
import '../../data/models/responses/apply_housing_loan_response.dart';
import '../../data/models/responses/apply_leasing_response.dart';
import '../../data/models/responses/balance_inquiry_response.dart';
import '../../data/models/responses/bill_payment_response.dart';
import '../../data/models/responses/biller_pdf_download_response.dart';
import '../../data/models/responses/biometric_enable_response.dart';
import '../../data/models/responses/calculator_share_pdf_response.dart';
import '../../data/models/responses/card_management/card_statement_pdf_download_response.dart';
import '../../data/models/responses/card_management/loyalty_points/loyalty_points_response.dart';
import '../../data/models/responses/card_management/loyalty_points/loyalty_redeem_response.dart';
import '../../data/models/responses/card_tran_excel_download.dart';
import '../../data/models/responses/challenge_response.dart';
import '../../data/models/responses/cheque_book_filter_response.dart';
import '../../data/models/responses/cheque_book_response.dart';
import '../../data/models/responses/city_response.dart';
import '../../data/models/responses/contact_us_response.dart';
import '../../data/models/responses/create_user_response.dart';
import '../../data/models/responses/credit_card_req_field_data_response.dart';
import '../../data/models/responses/credt_card_req_save_response.dart';
import '../../data/models/responses/csi_response.dart';
import '../../data/models/responses/debit_card_req_field_data_response.dart';
import '../../data/models/responses/debit_card_save_data_response.dart';
import '../../data/models/responses/delete_biller_response.dart';
import '../../data/models/responses/delete_ft_schedule_response.dart';
import '../../data/models/responses/delete_fund_transfer_payee_response.dart';

import '../../data/models/responses/edit_ft_schedule_response.dart';
import '../../data/models/responses/edit_payee_response.dart';
import '../../data/models/responses/edit_user_biller_response.dart';
import '../../data/models/responses/faq_response.dart';
import '../../data/models/responses/favourite_biller_response.dart';
import '../../data/models/responses/fd_calculator_response.dart';
import '../../data/models/responses/fund_transfer_excel_dwnload_response.dart';
import '../../data/models/responses/fund_transfer_one_time_response.dart';
import '../../data/models/responses/fund_transfer_payee_list_response.dart';
import '../../data/models/responses/fund_transfer_pdf_download_response.dart';
import '../../data/models/responses/fund_transfer_scheduling_response.dart';
import '../../data/models/responses/getBranchListResponse.dart';
import '../../data/models/responses/getTxnCategoryList_response.dart';
import '../../data/models/responses/get_account_name_ft_response.dart';
import '../../data/models/responses/get_all_fund_transfer_schedule_response.dart';
import '../../data/models/responses/get_all_sheduke_ft_response.dart';
import '../../data/models/responses/get_bank_list_response.dart';
import '../../data/models/responses/get_biller_category_list_response.dart';
import '../../data/models/responses/get_biller_list_response.dart';
import '../../data/models/responses/get_branch_list_response.dart';
import '../../data/models/responses/get_currency_list_response.dart';
import '../../data/models/responses/get_fd_period_response.dart';
import '../../data/models/responses/get_fd_rate_response.dart';
import '../../data/models/responses/get_justpay_instrument_response.dart';
import '../../data/models/responses/get_home_details_response.dart';
import '../../data/models/responses/get_locator_response.dart';
import '../../data/models/responses/get_money_notification_response.dart';
import '../../data/models/responses/get_notification_settings_response.dart';
import '../../data/models/responses/get_other_products_response.dart';
import '../../data/models/responses/get_payee_response.dart';
import '../../data/models/responses/get_remaining_inst_response.dart';
import '../../data/models/responses/get_schedule_time_response.dart';
import '../../data/models/responses/get_user_inst_response.dart';
import '../../data/models/responses/gold_loan_details_response.dart';
import '../../data/models/responses/gold_loan_list_response.dart';
import '../../data/models/responses/gold_loan_payment_top_up_response.dart';
import '../../data/models/responses/image_api_response_model.dart';
import '../../data/models/responses/initiate_itransfer_response.dart';
import '../../data/models/responses/intra_fund_transfer_response.dart';
import '../../data/models/responses/itransfer_get_theme_details_response.dart';
import '../../data/models/responses/itransfer_get_theme_response.dart';
import '../../data/models/responses/itransfer_payee_list_response.dart';
import '../../data/models/responses/just_pay_account_onboarding_response.dart';
import '../../data/models/responses/just_pay_challenge_id_response.dart';
import '../../data/models/responses/lease_history_excel.dart';
import '../../data/models/responses/lease_history_pdf.dart';
import '../../data/models/responses/lease_payment_history_response.dart';
import '../../data/models/responses/lease_req_field_data_response.dart';
import '../../data/models/responses/lease_req_save_data_response.dart';
import '../../data/models/responses/leasing_calculator_response.dart';
import '../../data/models/responses/loan_history_excel_download.dart';
import '../../data/models/responses/loan_history_pdf_download.dart';
import '../../data/models/responses/loan_req_field_data_response.dart';
import '../../data/models/responses/loan_request_submit_response.dart';
import '../../data/models/responses/loan_requests_field_data_response.dart';
import '../../data/models/responses/marketing_banners_response.dart';
import '../../data/models/responses/mobile_login_response.dart';
import '../../data/models/responses/notices_notification_list.dart';
import '../../data/models/responses/notification_count_response.dart';
import '../../data/models/responses/otp_response.dart';
import '../../data/models/responses/past_card_statement_response.dart';
import '../../data/models/responses/past_card_statements_pdf_response.dart';
import '../../data/models/responses/payee_favorite_response.dart';
import '../../data/models/responses/personal_loan_response.dart';
import '../../data/models/responses/portfolio_cc_details_response.dart';
import '../../data/models/responses/portfolio_lease_details_response.dart';
import '../../data/models/responses/portfolio_loan_details_response.dart';
import '../../data/models/responses/portfolio_userfd_details_response.dart';
import '../../data/models/responses/promotion_notification_response.dart';
import '../../data/models/responses/promotion_share_response.dart';
import '../../data/models/responses/promotions_response.dart';
import '../../data/models/responses/qr_payment_response.dart';
import '../../data/models/responses/req_money_notification_history_response.dart';
import '../../data/models/responses/request_money_history_response.dart';
import '../../data/models/responses/request_money_response.dart';
import '../../data/models/responses/reset_password_response.dart';
import '../../data/models/responses/retrieve_profile_image_response.dart';
import '../../data/models/responses/schedule_bill_payment_response.dart';
import '../../data/models/responses/schedule_date_response.dart';
import '../../data/models/responses/schedule_ft_history_response.dart';
import '../../data/models/responses/sec_question_response.dart';
import '../../data/models/responses/service_req_filted_list_response.dart';
import '../../data/models/responses/service_req_history_response.dart';
import '../../data/models/responses/settings_tran_limit_response.dart';
import '../../data/models/responses/splash_response.dart';
import '../../data/models/responses/sr_service_charge_response.dart';
import '../../data/models/responses/sr_statement_history_response.dart';
import '../../data/models/responses/sr_statement_response.dart';
import '../../data/models/responses/submit_other_products_response.dart';
import '../../data/models/responses/transaction_categories_list_response.dart';
import '../../data/models/responses/transaction_filter_pdf_download_response.dart';
import '../../data/models/responses/transaction_filter_response.dart';
import '../../data/models/responses/transaction_filtered_excel_download_response.dart';
import '../../data/models/responses/transaction_history_pdf_download_respose.dart';
import '../../data/models/responses/transaction_limit_response.dart';
import '../../data/models/responses/transaction_pdf_download_response.dart';
import '../../data/models/responses/transcation_details_response.dart';
import '../../data/models/responses/update_profile_image_response.dart';
import '../../data/models/responses/view_personal_information_response.dart';
import '../entities/request/challenge_request_entity.dart';
import '../entities/request/common_request_entity.dart';
import '../entities/request/contact_us_request_entity.dart';
import '../entities/request/create_user_entity.dart';
import '../entities/request/customer_reg_request_entity.dart';
import '../entities/request/document_verification_api_request_entity.dart';
import '../entities/request/emp_details_request_entity.dart';
import '../entities/request/get_terms_request_entity.dart';
import '../entities/request/language_entity.dart';
import '../entities/request/set_security_questions_request_entity.dart';
import '../entities/request/terms_accept_request_entity.dart';
import '../entities/request/verify_nic_request_entity.dart';

abstract class Repository {
  Future<Either<Failure, BaseResponse<SplashResponse>>> getSplash(
      CommonRequestEntity params);

  Future<Either<Failure, WalletOnBoardingData?>> getWalletOnBoardingData();

  Future<Either<Failure, bool>> storeWalletOnBoardingData(
      WalletOnBoardingData walletOnBoardingData);

  Future<Either<Failure, BaseResponse>> verifyNIC(
      VerifyNICRequestEntity params);

  Future<Either<Failure, BaseResponse>> registerCustomer(
      CustomerRegistrationRequestEntity params);

  Future<Either<Failure, BaseResponse>> ubAccountVerification(
      UBAccountVerificationRequest ubAccountVerificationRequest);

  Future<Either<Failure, BaseResponse>> updateNotificationSettings(
      UpdateNotificationSettingsRequest updateNotificationSettingsRequest);

  Future<Either<Failure, BaseResponse>> accountVerification(
      AccountVerificationRequest accountVerificationRequest);

  Future<Either<Failure, BaseResponse<JustPayAccountOnboardingResponse>>>
      justPayAcoountOnboarding(JustPayAccountOnboardingRequest params);

  Future<Either<Failure, BaseResponse>> justPayVerification(
      JustPayVerificationRequest justPayVerificationRequest);

  Future<Either<Failure, BaseResponse>> AddPaymentInstrument(
      JustPayInstruementsReques justPayInstruementsReques);

  Future<Either<Failure, BaseResponse<GetJustPayInstrumentResponse>>>
      GetPaymentInstrument(
          GetJustPayInstrumentRequest getJustPayInstrumentRequest);

  Future<Either<Failure, BaseResponse>> DeleteInstrumentPaymentInstrument(
      DeleteJustPayInstrumentRequest deleteJustPayInstrumentRequest);

  Future<Either<Failure, BaseResponse<JustPayChallengeIdResponse>>>
      justPayChallengeId(JustPayChallengeIdRequest justPayChallengeIdRequest);

  Future<Either<Failure, BaseResponse>> justPayTCSign(JustpayTCSignRequest justpayTCSignRequest);

  Future<Either<Failure, BaseResponse>> getTerms(GetTermsRequestEntity params);

  Future<Either<Failure, BaseResponse>> acceptTerms(
      TermsAcceptRequestEntity params);

  Future<Either<Failure, BaseResponse<CreateUserResponse>>> createUser(
      CreateUserEntity params);
  Future<Either<Failure, BaseResponse>> checkUser(
      CheckUserRequest params);

  Future<Either<Failure, BaseResponse<CityDetailResponse>>> cityRequest(
      CommonRequestEntity params);

  Future<Either<Failure, BaseResponse<CityDetailResponse>>> designationRequest(
      CommonRequestEntity params);

  Future<Either<Failure, BaseResponse<ScheduleDateResponse>>> getScheduleDates(
      CommonRequestEntity params);

  Future<Either<Failure, BaseResponse<GetOtherProductsResponse>>>
      getOtherProducts(CommonRequestEntity params);

  Future<Either<Failure, BaseResponse<SubmitProductsResponse>>>
      submitOtherProducts(SubmitProductsRequest params);

  Future<Either<Failure, BaseResponse>> submitEmpDetails(
      EmpDetailsRequestEntity params);

  Future<Either<Failure, BaseResponse<ChallengeResponse>>>
  otpVerification(ChallengeRequestEntity params);

  Future<Either<Failure, BaseResponse<SecurityQuestionResponse>>>
      getSecurityQuestions(SecurityQuestionRequestEntity params);

  Future<Either<Failure, BaseResponse>> setSecurityQuestions(
      SetSecurityQuestionsEntity params);

  // Future<Either<Failure, BaseResponse>> otpVerification(
  //     ChallengeRequestEntity params);

  Future<Either<Failure, BaseResponse>> documentVerification(
      DocumentVerificationApiRequestEntity params);

  Future<Either<Failure, BaseResponse<MobileLoginResponse>>> mobileLogin(
      MobileLoginRequest params);
  
  Future<Either<Failure, BaseResponse<TemporaryLoginResponse>>> temporaryLogin(
      TemporaryLoginRequest params);

  Future<Either<Failure, BaseResponse>> changePassword(
      ChangePasswordRequest params);

  Future<Either<Failure, BaseResponse>> setPreferredLanguage(
      LanguageEntity params);

  Future<Either<Failure, String?>> getEpicUserID();

  Future<Either<Failure, bool>> setEpicUserID(String epicUserID);

  Future<Either<Failure, BaseResponse<GetScheduleTimeResponse>>>
      getScheduleTimeSlot(GetScheduleTimeRequest params);

  Future<Either<Failure, BaseResponse>> submitScheduleData(
      SubmitScheduleDataRequest params);

  Future<Either<Failure, BaseResponse<BiometricEnableResponse>>>
      enableBiometric(BiometricEnableRequest params);

  Future<Either<Failure, BaseResponse<OtpResponse>>> otpRequest(
      OtpRequest otpRequest);

  Future<Either<Failure, BaseResponse<ContactUsResponseModel>>> getContactUs(
      ContactUsRequestEntity params);

  Future<Either<Failure, bool>> savePreferredLanguage();

  Future<Either<Failure, BaseResponse<MobileLoginResponse>>> biometricLogin(
      BiometricLoginRequest params);

  Future<Either<Failure, BaseResponse<GetSavedBillersResponse>>>
      getSavedBillerList(CommonRequestEntity params);

  Future<Either<Failure, BaseResponse<AddBillerResponse>>> addBiller(
      AddBillerRequest addBillerRequest);

  Future<Either<Failure, BaseResponse<GetBillerCategoryListResponse>>>
      getBillerCategoryList(CommonRequestEntity commonRequestEntity);

  Future<Either<Failure, BaseResponse<GetAllFundTransferScheduleResponse>>>
      getAllFTScheduleList(
          GetAllFundTransferScheduleRequest getAllFundTransferScheduleRequest);

  Future<Either<Failure, BaseResponse<DeleteFtScheduleResponse>>>
      deleteFTScedule(DeleteFtScheduleRequest deleteFtScheduleRequest);

  Future<Either<Failure, BaseResponse<GetNotificationSettingsResponse>>>
      getNotificationSettings(
          GetNotificationSettingsRequest getNotificationSettingsRequest);

  Future<Either<Failure, BaseResponse<NotificationCountResponse>>>
      notificationCount(NotificationCountRequest notificationCountRequest);

  Future<Either<Failure, BaseResponse<ScheduleFtHistoryResponse>>>
      scheduleFTHistory(ScheduleFtHistoryReq scheduleFtHistoryReq);

  // Future<Either<Failure, BaseResponse>> deleteBiller(
  //     DeleteBillerEntity deleteBillerEntity);
  Future<Either<Failure, BaseResponse<DeleteBillerResponse>>> deleteBiller(
      DeleteBillerRequest deleteBillerRequest);

  Future<Either<Failure, BaseResponse<SrStatementResponse>>> srStatement(
      SrStatementRequest srStatementRequest);

  Future<Either<Failure, BaseResponse<SrStatementHistoryResponse>>> statementHistory(
      SrStatementHistoryRequest srStatementHistoryRequest);

  Future<Either<Failure, BaseResponse<EditUserBillerResponse>>> editBiller(
      EditUserBillerRequest editUserBillerRequest);

  // Future<Either<Failure, BaseResponse>> unFavoriteBiller(
  //     UnFavoriteBillerEntity unFavoriteBillerEntity);

  Future<Either<Failure, BaseResponse<AccountInquiryResponse>>> accountInquiry(
      AccountInquiryRequest accountInquiryRequest);

  Future<Either<Failure, BaseResponse<BalanceInquiryResponse>>> balanceInquiry(
      BalanceInquiryRequest balanceInquiryRequest);

  Future<Either<Failure, BaseResponse<GetBankListResponse>>> getBankList(
      GetBankListRequest getBankListRequest);

  Future<Either<Failure, BaseResponse<GetBranchListResponse>>> getBranchList(
      GetBranchListRequest getBranchListRequest);

  Future<Either<Failure, BaseResponse<RequestMoneyHistoryResponse>>> reqMoneyHistory(
      RequestMoneyHistoryRequest requestMoneyHistoryRequest);

  Future<Either<Failure, BaseResponse<ReqMoneyNotificationHistoryResponse>>> reqMoneyNotificationHistory(
      ReqMoneyNotificationHistoryRequest reqMoneyNotificationHistoryRequest);

  Future<Either<Failure, BaseResponse<AddPayResponse>>> payManagementAddPay(
      AddPayRequest addPayRequest);

  Future<Either<Failure, BaseResponse<EditPayeeResponse>>> editPayee(
      EditPayeeRequest editPayeeRequest);

  Future<Either<Failure, BaseResponse<FundTransferPayeeListResponse>>>
      fundTransferPayeeList(
          FundTransferPayeeListRequest fundTransferPayeeListRequest);

  Future<Either<Failure, BaseResponse<HousingLoanResponseModel>>>
      housingLoanList(HousingLoanRequestModel housingLoanRequestModel);

  Future<Either<Failure, BaseResponse<GetFdRateResponse>>>
  getFDRate(GetFdRateRequest getFdRateRequest);

  Future<Either<Failure, BaseResponse<ApplyHousingLoanResponse>>>
      applyHousingLoanList(ApplyHousingLoanRequest applyHousingLoanRequest);

  Future<Either<Failure, BaseResponse<LeasingCalculatorResponse>>>
      leasingCalculatorList(LeasingCalculatorRequest leasingCalculatorRequest);

  Future<Either<Failure, BaseResponse<ApplyLeasingCalculatorResponse>>>
      applyLeasingList(
          ApplyLeasingCalculatorRequest applyLeasingCalculatorRequest);

  Future<Either<Failure, BaseResponse<FdCalculatorResponse>>> fdCalculatorList(
      FdCalculatorRequest fdCalculatorRequest);

  Future<Either<Failure, BaseResponse<GetCurrencyListResponse>>>
      getCurrencyList(GetCurrencyListRequest getCurrencyListRequest);

  Future<Either<Failure, BaseResponse<GetBankBranchListResponse>>>
  getBankBranchList(GetBankBranchListRequest getBankBranchListRequest);

  Future<Either<Failure, BaseResponse<GetTxnCategoryResponse>>>
  getTxnCategoryList(GetTxnCategoryRequest getTxnCategoryRequest);

  Future<Either<Failure, BaseResponse<GetFdPeriodResponse>>> getFDPeriodList(
      GetFdPeriodRequest getFdPeriodRequest);

  Future<Either<Failure, BaseResponse<ApplyFdCalculatorResponse>>>
      applyFDCalculatorList(ApplyFdCalculatorRequest applyFdCalculatorRequest);

  Future<Either<Failure, BaseResponse<EditFtScheduleResponse>>> editFTSchedule(
      EditFtScheduleRequest editFtScheduleRequest);

  Future<Either<Failure, BaseResponse<DeleteFundTransferPayeeResponse>>>
      deleteFundTransferPayee(
          DeleteFundTransferPayeeRequest deleteFundTransferPayeeRequest);

  Future<Either<Failure, BaseResponse<FaqResponse>>> preLoginFaq(
      FaqRequest faqRequest);

  // Future<Either<Failure, BaseResponse>> accountVerification(
  //     AccountVerificationRequest accountVerificationRequest);

  Future<Either<Failure, BaseResponse<ImageApiResponseModel>>> getImage(
      ImageApiRequestModel imageApiRequest);

  Future<Either<Failure, BaseResponse<ResetPasswordResponse>>> resetPassword(
      ResetPasswordRequest resetPasswordRequest);

  Future<Either<Failure, BaseResponse<RequestMoneyResponse>>> requestMoney(
      RequestMoneyRequest requestMoneyRequest);

  Future<Either<Failure, BaseResponse<PromotionsResponse>>> getPromotions(
      PromotionsRequest promotionsRequest);

  Future<Either<Failure, BaseResponse<GoldLoanListResponse>>>
      requestGoldLoanList(GoldLoanListRequest goldLoanListRequest);

  Future<Either<Failure, BaseResponse<GoldLoanDetailsResponse>>>
      requestGoldLoanDetails(GoldLoanDetailsRequest goldLoanDetailsRequest);

  Future<Either<Failure, BaseResponse<GoldLoanPaymentTopUpResponse>>>
      requestGoldLoanPaymentTopUp(
          GoldLoanPaymentTopUpRequest goldLoanPaymentTopUpRequest);

  Future<Either<Failure, BaseResponse<AddItransferPayeeResponse>>>
      addItransferPayee(AddItransferPayeeRequest addItransferPayeeRequest);

  Future<Either<Failure, BaseResponse<ItransferPayeeListResponse>>>
      itransferPayeeList(ItransferPayeeListRequest itransferPayeeListRequest);

  Future<Either<Failure, BaseResponse>> editItransferPayee(
      EditItransferPayeeRequest editItransferPayeeRequest);

  Future<Either<Failure, BaseResponse>> deleteItransferPayee(
      DeleteItransferPayeeRequest deleteItransferPayeeRequest);

  Future<Either<Failure, BaseResponse>> txnLimitReset(
      TxnLimitResetRequest txnLimitResetRequest);

  Future<Either<Failure, BaseResponse<MerchantLocatorResponse>>>
      merchantLocator(MerchantLocatorRequest merchantLocatorRequest);

  Future<Either<Failure, BaseResponse>> cdbAccountVerification(
      CdbAccountVerificationRequest cdbAccountVerificationRequest);

  // Future<Either<Failure, BaseResponse>> justPayVerification(
  //     JustPayVerificationRequest justPayVerificationRequest);

  // Future<Either<Failure, BaseResponse<JustPayAccountOnboardingResponse>>>
  //     justPayAcoountOnboarding(JustPayAccountOnboardingRequest params);

  Future<Either<Failure, BaseResponse<GetUserInstResponse>>> getUserInstruments(
      GetUserInstRequest getUserInstRequest);

  Future<Either<Failure, BaseResponse<GetRemainingInstResponse>>>
      getRemainingInstruments(GetRemainingInstRequest getRemainingInstRequest);

  Future<Either<Failure, BaseResponse>> addUserInstrument(
      AddUserInstRequest addUserInstRequest);

  Future<Either<Failure, BaseResponse<TransactionDetailsResponse>>>
      getTransactionDetails(
          TransactionDetailsRequest transactionDetailsRequest);

  Future<Either<Failure, BaseResponse<SrServiceChargeResponse>>>
  srServiceCharge(
      SrServiceChargeRequest srServiceChargeRequest);

  // Future<Either<Failure, BaseResponse<JustPayChallengeIdResponse>>>
  //     JustPayChallengeId(JustPayChallengeIdRequest justPayChallengeIdRequest);

  Future<Either<Failure, BaseResponse<LoanRequestFieldDataResponse>>>
      loanRequestsFieldData(
          LoanRequestsFieldDataRequest loanRequestsFieldDataRequest);

  Future<Either<Failure, BaseResponse<LoanRequestsSubmitResponse>>>
      loanReqSaveData(LoanRequestsSubmitRequest loanRequestsSubmitRequest);

  Future<Either<Failure, BaseResponse<CreditCardReqFieldDataResponse>>>
      creditCardReqFieldData(
          CreditCardReqFieldDataRequest creditCardReqFieldDataRequest);

  Future<Either<Failure, BaseResponse<CreditCardReqSaveResponse>>>
      creditCardReqSave(CreditCardReqSaveRequest creditCardReqSaveRequest);

  Future<Either<Failure, BaseResponse<ChequeBookResponse>>>
  checkBookReq(ChequeBookRequest chequeBookRequest);

  // Future<Either<Failure, BaseResponse>>
  // checkBookReq(ChequeBookRequest chequeBookRequest);

  Future<Either<Failure, BaseResponse<ChequeBookFilterResponse>>>
  checkBookFilter(ChequeBookFilterRequest chequeBookFilterRequest);

  Future<Either<Failure, BaseResponse<LeaseReqFieldDataResponse>>>
      leaseReqFieldData(LeaseReqFieldDataRequest leaseReqFieldDataRequest);

  Future<Either<Failure, BaseResponse<LeaseReqSaveDataResponse>>>
      leaseReqSaveData(LeaseReqSaveDataRequest leaseReqSaveDataRequest);

  Future<Either<Failure, BaseResponse<IntraFundTransferResponse>>>
      getIntraFundTransfer(IntraFundTransferRequest intraFundTransferRequest);

  Future<Either<Failure, BaseResponse<TransactionCategoriesListResponse>>>
      transactionCategoriesList(
          TransactionCategoriesListRequest transactionCategoriesListRequest);

  Future<Either<Failure, BaseResponse<ServiceReqHistoryResponse>>>
      serviceReqHistory(ServiceReqHistoryRequest serviceReqHistoryRequest);

  Future<Either<Failure, BaseResponse<LoanReqFieldDataResponse>>> loanReq(
      LoanReqFieldDataRequest loanReqFieldDataRequest);

  Future<Either<Failure, BaseResponse>> justPayInstrument(
      JustPayInstruementsReques justPayInstruementsReques);

  Future<Either<Failure, BaseResponse<AddJustPayInstrumentsResponse>>>
      addJustPayInstrument(
          AddJustPayInstrumentsRequest addJustPayInstrumentsRequest);

  Future<Either<Failure, BaseResponse>> defaultPaymentInstrument(
      DefaultPaymentInstrumentRequest defaultPaymentInstrumentRequest);

  Future<Either<Failure, BaseResponse>> instrumentStatusChange(
      InstrumentStatusChangeRequest instrumentStatusChangeRequest);

  Future<Either<Failure, BaseResponse>> instrumentNickNameChange(
      InstrumentNickNameChangeRequest instrumentNickNameChangeRequest);

  Future<Either<Failure, BaseResponse<OneTimeFundTransferResponse>>>
      oneTimeFundTransfer(
          OneTimeFundTransferRequest oneTimeFundTransferRequest);

  Future<Either<Failure, BaseResponse<SchedulingFundTransferResponse>>>
      schedulingFundTransfer(
          SchedulingFundTransferRequest schedulingFundTransferRequest);

  Future<Either<Failure, BaseResponse<ScheduleBillPaymentResponse>>>
  schedulingBillPayment(
      ScheduleBillPaymentRequest scheduleBillPaymentRequest);

  Future<Either<Failure, BaseResponse<TransactionHistoryPdfDownloadResponse>>>
      transactionHistoryPdfDownload(
          TransactionHistoryPdfDownloadRequest
              transactionHistoryPdfDownloadRequest);

  Future<Either<Failure, BaseResponse<TransactionLimitResponse>>>
      transactionLimit(TransactionLimitRequest transactionLimitRequest);

  Future<Either<Failure, BaseResponse>> transactionLimitAdd(
      TransactionLimitAddRequest transactionLimitAddRequest);

  Future<Either<Failure, BaseResponse<UpdateProfileImageResponse>>>
      updateProfileImage(UpdateProfileImageRequest updateProfileImageRequest);

  Future<Either<Failure, BaseResponse<ViewPersonalInformationResponse>>>
      viewPersonalInformation(
          ViewPersonalInformationRequest viewPersonalInformationRequest);

  Future<Either<Failure, BaseResponse<ServiceReqFilteredListResponse>>>
      serviceReqFilteredList(ServiceReqHistoryRequest serviceReqHistoryRequest);

  Future<Either<Failure, BaseResponse<BillPaymentResponse>>> billPayment(
      BillPaymentRequest billPaymentRequest);

  Future<Either<Failure, BaseResponse<ItransferGetThemeResponse>>>
      itransferGetTheme(ItransferGetThemeRequest itransferGetThemeRequest);

  Future<Either<Failure, BaseResponse<ItransferGetThemeDetailsResponse>>>
      itransferGetThemeDetails(
          ItransferGetThemeDetailsRequest itransferGetThemeDetailsRequest);

  Future<Either<Failure, BaseResponse<FundTransferPdfDownloadResponse>>>
      fundTransferPdfDownload(
          FundTransferPdfDownloadRequest fundTransferPdfDownloadRequest);

  Future<Either<Failure, BaseResponse<FundTransferExcelDownloadResponse>>>
      fundTransferExcelDownload(
          FundTransferExcelDownloadRequest fundTransferExcelDownloadRequest);

  Future<Either<Failure, BaseResponse<GetAllScheduleFtResponse>>>
      getAllScheduleFT(GetAllScheduleFtRequest getAllScheduleFtRequest);

  Future<Either<Failure, BaseResponse<InitiateItransfertResponse>>>
      initiateItransfer(InitiateItransfertRequest initiateItransfertRequest);

  Future<Either<Failure, BaseResponse<CsiResponse>>>
  csiData(CsiRequest csiRequest);

  Future<Either<Failure, BaseResponse<DebitCardReqFieldDataResponse>>>
      debitCardReqFieldData(
          DebitCardReqFieldDataRequest debitCardReqFieldDataRequest);

  Future<Either<Failure, BaseResponse<DebitCardSaveDataResponse>>>
      debitCardReqSaveData(DebitCardSaveDataRequest debitCardSaveDataRequest);

  Future<Either<Failure, BaseResponse<AccountDetailsResponseDtos>>>
      portfolioAccDetails(
          PortfolioAccDetailsRequest portfolioAccDetailsRequest);

  Future<Either<Failure, BaseResponse<PortfolioCcDetailsResponse>>>
      portfolioCCDetails(PortfolioCcDetailsRequest portfolioCcDetailsRequest);

  Future<Either<Failure, BaseResponse<PortfolioLoanDetailsResponse>>>
      portfolioLoanDetails(
          PortfolioLoanDetailsRequest portfolioLoanDetailsRequest);

  Future<Either<Failure, BaseResponse<TransactionFilterResponse>>>
      transactionFilter(TransactionFilterRequest transactionFilterRequest);

  Future<Either<Failure, BaseResponse<PortfolioLeaseDetailsResponse>>>
      portfolioLeaseDetails(
          PortfolioLoanDetailsRequest portfolioLoanDetailsRequest);

  Future<Either<Failure, BaseResponse<PortfolioUserFdDetailsResponse>>>
      portfolioFDDetails(
          PortfolioUserFdDetailsRequest portfolioUserFdDetailsRequest);

  Future<Either<Failure, BaseResponse<PersonalLoanResponse>>>
      personalLoanCalculator(PersonalLoanRequest personalLoanRequest);

  Future<Either<Failure, BaseResponse<SettingsTranLimitResponse>>>
      settingsTranLimit(SettingsTranLimitRequest settingsTranLimitRequest);

  Future<Either<Failure, BaseResponse<PastCardStatementsresponse>>>
      pastCardStatements(PastCardStatementsrequest pastCardStatementsrequest);

  Future<Either<Failure, BaseResponse<AccountStatementPdfDownloadResponse>>>
      accStatementsPdfDownload(
          AccountStatementPdfDownloadRequest
              accountStatementPdfDownloadRequest);

  Future<Either<Failure, BaseResponse<QrPaymentPdfDownloadResponse>>>
  qrPaymentPdfDownload(QrPaymentPdfDownloadRequest qrPaymentPdfDownloadRequest);

  Future<Either<Failure, BaseResponse<TransactionStatusPdfResponse>>>
      transactionStatusPdfDownload(
          TransactionStatusPdfRequest transactionStatusPdfRequest);

  Future<Either<Failure, BaseResponse<TransactionFilteredPdfDownloadResponse>>>
  transactionFilterPdfDownload(
      TransactionFilteredPdfDownloadRequest
      transactionFilteredPdfDownloadRequest);

  Future<Either<Failure, BaseResponse<TransactionFilteredExcelDownloadResponse>>>
  transactionFilterExcelDownload(
      TransactionFilteredExcelDownloadRequest
      transactionFilteredExcelDownloadRequest);

  Future<Either<Failure, BaseResponse<PromotionShareResponse>>>
      promotionsPdfShare(PromotionShareRequest promotionShareRequest);

  Future<Either<Failure, BaseResponse<LeaseHistoryExcelResponse>>>
      leaseHistoryExcelDownload(
          LeaseHistoryExcelRequest leaseHistoryExcelRequest);

  Future<Either<Failure, BaseResponse<LeaseHistoryPdfResponse>>>
      leaseHistoryPdfDownload(LeaseHistoryPdfRequest leaseHistoryPdfRequest);

  Future<Either<Failure, BaseResponse<LoanHistoryExcelResponse>>>
      loanHistoryExcelDownload(LoanHistoryExcelRequest loanHistoryExcelRequest);

  Future<Either<Failure, BaseResponse<AccountTransactionExcelResponse>>>
      accTransactionExcelDownload(
          AccountTransactionExcelRequest accountTransactionExcelRequest);

  Future<Either<Failure, BaseResponse<CardTransactionExcelResponse>>>
      cardTranExcelDownload(CardTransactionExcelRequest cardTranExcelRequest);

  Future<Either<Failure, BaseResponse<CardTransactionPdfResponse>>>
      cardTranPdfDownload(CardTransactionPdfRequest cardTransactionPdfRequest);

  Future<Either<Failure, BaseResponse<AccTranStatusExcelDownloadResponse>>>
      accTranStatusExcelDownload(
          AccTranStatusExcelDownloadRequest accTranStatusExcelDownloadRequest);

  Future<Either<Failure, BaseResponse<AccountTransactionsPdfDownloadResponse>>>
      accTransactionsPdfDownload(
          AccountTransactionsPdfDownloadRequest
              accountTransactionsPdfDownloadRequest);

  Future<Either<Failure, BaseResponse<AccTranStatusPdfDownloadResponse>>>
      accTransactionsStatusPdfDownload(
          AccTranStatusPdfDownloadRequest accTranStatusPdfDownloadRequest);

  Future<Either<Failure, BaseResponse<AccountSatementsXcelDownloadResponse>>>
      accStatementsXcelDownload(
          AccountSatementsXcelDownloadRequest
              accountSatementsXcelDownloadRequest);

  Future<Either<Failure, BaseResponse<LoanHistoryPdfResponse>>>
      loanHistoryPdfDownload(LoanHistoryPdfRequest loanHistoryPdfRequest);

  Future<Either<Failure, BaseResponse<PastCardExcelDownloadResponse>>>
      pastCardExcelDownload(
          PastCardExcelDownloadRequest pastCardExcelDownloadRequest);

  Future<Either<Failure, BaseResponse<CardStatementPdfResponse>>>
  cardStatementPdfDownload(CardStateentPdfDownloadRequest cardStateentPdfDownloadRequest);

  Future<Either<Failure, BaseResponse<AccountTransactionHistoryresponse>>>
      accountTransactions(
          AccountTransactionHistorysrequest accountTransactionHistorysrequest);

  Future<Either<Failure, BaseResponse<PastcardStatementstPdfDownloadResponse>>>
      pastCardStatementsPdfDownload(
          PastcardStatementstPdfDownloadRequest
              pastcardStatementstPdfDownloadRequest);

  Future<Either<Failure, BaseResponse<LoanHistoryresponse>>> loanHistory(
      LoanHistoryrequest loanHistoryrequest);

  Future<Either<Failure, BaseResponse<LeaseHistoryresponse>>> leaseHistory(
      LeaseHistoryrequest leaseHistoryrequest);

  Future<Either<Failure, BaseResponse<AccountStatementsresponse>>>
      accountStatements(AccountStatementsrequest accountStatementsrequest);

  Future<Either<Failure, BaseResponse>> editNickName(
      EditNickNamerequest editNickNamerequest);

  Future<Either<Failure, BaseResponse>> applyPersonalLoan(
      ApplyPersonalLoanRequest applyPersonalLoanRequest);

  Future<Either<Failure, BaseResponse<GetPayeeResponse>>> getPayeeList(
      GetPayeeRequest getPayeeRequest);

  Future<Either<Failure, BaseResponse<CalculatorPdfResponse>>> calculatorPDF(
      CalculatorPdfRequest calculatorPdfRequest);

  Future<Either<Failure, BaseResponse<TransactionNotificationResponse>>>
      getTranNotifications(
          TransactionNotificationRequest transactionNotificationRequest);

  Future<Either<Failure, BaseResponse<GetMoneyNotificationResponse>>>
  getMoneyNotification(
      GetMoneyNotificationRequest getMoneyNotificationRequest);

  Future<Either<Failure, BaseResponse<PromotionNotificationResponse>>>
      getPromoNotifications(
          PromotionNotificationRequest promotionNotificationRequest);

  Future<Either<Failure, BaseResponse<NoticesNotificationResponse>>>
      getNoticesNotifications(
          NoticesNotificationRequest noticesNotificationRequest);

  Future<Either<Failure, BaseResponse<BillerPdfDownloadResponse>>>
      billerPdfDownload(BillerPdfDownloadRequest billerPdfDownloadRequest);

        Future<Either<Failure, BaseResponse<BillPaymentExcelDownloadResponse>>> billerExcelDownload(
      BillPaymentExcelDownloadRequest billPaymentExcelDownloadRequest);

  Future<Either<Failure, BaseResponse>> composeMail(
      ComposeMailRequest composeMailRequest);

  Future<Either<Failure, BaseResponse<RecipientCategoryResponse>>> getRecipientCategory(
      RecipientCategoryRequest recipientCategoryRequest);

  Future<Either<Failure, BaseResponse<RecipientTypeResponse>>> getRecipientType(
      RecipientTypeRequest recipientTypeRequest);

  Future<Either<Failure, BaseResponse<ViewMailResponse>>> getViewMail(
      ViewMailRequest viewMailRequest);

  Future<Either<Failure, BaseResponse<MailThreadResponse>>> getMailThread(
      MailThreadRequest mailThreadRequest);

Future<Either<Failure, BaseResponse<MailAttachmentResponse>>> getMailAttachment(
      MailAttachmentRequest mailAttachmentRequest);

Future<Either<Failure, BaseResponse>> deleteMailAttachment(
      MailAttachmentRequest mailAttachmentRequest);

  Future<Either<Failure, BaseResponse<MailCountResponse>>> getMailCount(
      MailCountRequest mailCountRequest);

  Future<Either<Failure, BaseResponse>> deleteMail(
      DeleteMailRequest deleteMailRequest);
  
  Future<Either<Failure, BaseResponse>> deleteMailMessage(
      DeleteMailMessageRequest deleteMailMessageRequest);

  Future<Either<Failure, BaseResponse>> markAsReadMail(
      MarkAsReadMailRequest markAsReadMailRequest);

  Future<Either<Failure, BaseResponse>> markAsReadNotification(
      MarkAsReadNotificationRequest markAsReadNotificationRequest);

  Future<Either<Failure, BaseResponse>> deleteNotification(
      DeleteNotificationRequest deleteNotificationRequest);

  Future<Either<Failure, BaseResponse>> replyMail(
      ReplyMailRequest replyMailRequest);

  // Future<Either<Failure, BaseResponse<BillerPdfDownloadResponse>>> billerPdfDownload(BillerPdfDownloadRequest billerPdfDownloadRequest);

  Future<Either<Failure, BaseResponse>> updateTxnLimit(
      UpdateTxnLimitRequest updateTxnLimitRequest);

  Future<Either<Failure, BaseResponse<ForgetPasswordResponse>>>
      forgetPwCheckNicAccount(
          ForgetPwCheckNicAccountRequest forgetPwCheckNicAccountRequest);

  Future<Either<Failure, BaseResponse<ForgetPasswordResponse>>>
      forgetPwCheckUsername(
          ForgetPwCheckUsernameRequest forgetPwCheckUsernameRequest);

  Future<Either<Failure, BaseResponse<ForgetPasswordResponse>>>
      forgetPwCheckSecurityQuestion(
          ForgetPwCheckSecurityQuestionRequest
              forgetPwCheckSecurityQuestionRequest);

  Future<Either<Failure, BaseResponse>> forgetPwReset(
      ForgetPwResetRequest forgetPwResetRequest);

  Future<Either<Failure, BaseResponse<GetHomeDetailsResponse>>> getHomeDetails(
      GetHomeDetailsRequest getHomeDetailsRequest);

  Future<Either<Failure, BaseResponse>> updateProfile(
      UpdateProfileDetailsRequest updateProfileDetailsRequest);

  Future<Either<Failure, BaseResponse<RetrieveProfileImageResponse>>>
      getProfileImage(RetrieveProfileImageRequest retrieveProfileImageRequest);

  Future<Either<Failure, BaseResponse<DemoTourListResponse>>> getDemoTour(
      CommonRequest commonRequest);

  Future<Either<Failure, BaseResponse<MarketingBannersResponse>>>
  getMarketingBanners(MarketingBannersRequest marketingBannersRequest);

  Future<Either<Failure, BaseResponse<PayeeFavoriteResponse>>>
  payeeFavorite(PayeeFavoriteRequest payeeFavoriteRequest);

  Future<Either<Failure, BaseResponse<FavoriteBillerResponse>>> favouriteBiller(
      FavouriteBillerRequest favouriteBillerRequest);

  Future<Either<Failure, BaseResponse<PasswordValidationResponse>>>
      passwordValidation(PasswordValidationRequest passwordValidationRequest);

  Future<Either<Failure, BaseResponse<QrPaymentResponse>>> qrPayment(
      QrPaymentRequest qrPaymentRequest);



  Future<Either<Failure, BaseResponse<GetAcctNameFtResponse>>>
  acctNameForFt(GetAcctNameFtRequest getAcctNameFtRequest);

  Future<Either<Failure, BaseResponse>> saveRequestCall(
      RequestCallBackSaveRequest requestCallBackSaveRequest);

  Future<Either<Failure, BaseResponse<RequestCallBackGetResponse>>>
      getRequestCall(RequestCallBackGetRequest requestCallBackGetRequest);

  Future<Either<Failure, BaseResponse<RequestCallBackGetDefaultDataResponse>>>
      getRequestCallDefaultData(RequestCallBackGetDefaultDataRequest requestCallBackGetDefaultDataRequest);

  Future<Either<Failure, BaseResponse>> cancelRequestCall(
      RequestCallBackCancelRequest requestCallBackCancelRequest);

  Future<Either<Failure, BaseResponse<FloatInquiryResponse>>>
      floatInquiryRequest(FloatInquiryRequest floatInquiryRequest);

  Future<Either<Failure, BaseResponse<KeyExchangeResponse>>> keyExchange(
      KeyExchangeRequest keyExchangeRequest);

  Future<Either<Failure, BaseResponse>> getBbc(BaseRequest baseRequest);

  Future<Either<Failure, BaseResponse>> getCnn(BaseRequest baseRequest);

  /* ----------------------------- Card Mangement ----------------------------- */

  Future<Either<Failure, BaseResponse<CardListResponse>>> cardList(
      CommonRequest cardListRequest);

  Future<Either<Failure, BaseResponse<CardDetailsResponse>>> cardDetails(
      CardDetailsRequest cardDetailsRequest);
  
  Future<Either<Failure, BaseResponse<CardPinResponse>>> cardPinRequest(
      CardPinRequest cardPinRequest);
  
  Future<Either<Failure, BaseResponse>> cardActivation(
      CardActivationRequest cardActivationRequest);
  
  Future<Either<Failure, BaseResponse<CardTxnHistoryResponse>>> cardTxnHistory(
      CardTxnHistoryRequest cardTxnHistoryRequest);
  
  Future<Either<Failure, BaseResponse<CardEStatementResponse>>> cardEStatement(
      CardEStatementRequest cardEStatementRequest);
  
  Future<Either<Failure, BaseResponse<CardCreditLimitResponse>>> cardCreditLimit(
      CardCreditLimitRequest cardCreditLimitRequest);
  
  Future<Either<Failure, BaseResponse<CardViewStatementResponse>>> cardViewStatement(
      CardViewStatementRequest cardViewStatementRequest);
  
  Future<Either<Failure, BaseResponse<CardLastStatementResponse>>> cardLastStatement(
      CardLastStatementRequest cardLastStatementRequest);
  
  Future<Either<Failure, BaseResponse<CardLostStolenResponse>>> cardLostStolen(
      CardLostStolenRequest cardLostStolenRequest);

  Future<Either<Failure, BaseResponse<CardLoyaltyVouchersResponse>>> cardLoyaltyVouchers(
      CommonRequest cardLoyaltyVouchersRequest);

  Future<Either<Failure, BaseResponse<CardLoyaltyRedeemResponse>>> cardLoyaltyRedeem(
      CardLoyaltyRedeemRequest cardLoyaltyRedeemRequest);
  /* ------------------------------------ . ----------------------------------- */
}

