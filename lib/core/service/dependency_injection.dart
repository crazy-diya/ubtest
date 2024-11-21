import 'package:app_links/app_links.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_bank_mobile/core/encryption/encryptor.dart';
import 'package:union_bank_mobile/core/service/cloud_service/cloud_services.dart';
import 'package:union_bank_mobile/core/service/cloud_service/cloud_services_impl.dart';
import 'package:union_bank_mobile/core/service/deep_linking_services.dart';
import 'package:union_bank_mobile/features/domain/usecases/Manage_Other_Bank/delete_other_bank_instrument.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_activation.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_credit_limit.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_details.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_e_statement.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_last_statement.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_list.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_lost_stolen.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_pin.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_txn_history.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/card_view_statement.dart';
import 'package:union_bank_mobile/features/domain/usecases/card_management/loyalty_points/card_loyalty.dart';
import 'package:union_bank_mobile/features/domain/usecases/check_user/check_user.dart';
import 'package:union_bank_mobile/features/domain/usecases/contact_us/contact_us.dart';
import 'package:union_bank_mobile/features/domain/usecases/demo_tour/demo_tour.dart';
import 'package:union_bank_mobile/features/domain/usecases/drop_down/mail_box/get_recipient_category.dart';
import 'package:union_bank_mobile/features/domain/usecases/float_inquiry/float_inquiry.dart';
import 'package:union_bank_mobile/features/domain/usecases/forget_password/forget_pw_check_nic_account.dart';
import 'package:union_bank_mobile/features/domain/usecases/forget_password/forget_pw_check_security_question.dart';
import 'package:union_bank_mobile/features/domain/usecases/forget_password/forget_pw_check_username.dart';
import 'package:union_bank_mobile/features/domain/usecases/forget_password/forget_pw_reset.dart';
import 'package:union_bank_mobile/features/domain/usecases/home/get_mail_count.dart';
import 'package:union_bank_mobile/features/domain/usecases/justpay/just_pay_tc_sign.dart';
import 'package:union_bank_mobile/features/domain/usecases/key_exchange/key_exchange.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/compose_mail.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/delete_mail.dart';
import 'package:union_bank_mobile/features/domain/usecases/drop_down/mail_box/get_recipient_types.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/delete_mail_attachment.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/delete_mail_message.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/get_mail_attachment.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/get_mail_thread.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/get_view_mails.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/mark_as_read_mail.dart';
import 'package:union_bank_mobile/features/domain/usecases/mailbox/reply_mail.dart';
import 'package:union_bank_mobile/features/domain/usecases/news/get_bbc.dart';
import 'package:union_bank_mobile/features/domain/usecases/news/get_cnn.dart';
import 'package:union_bank_mobile/features/domain/usecases/password_validation/password_validation.dart';
import 'package:union_bank_mobile/features/domain/usecases/portfolio/edit_nick_name.dart';
import 'package:union_bank_mobile/features/domain/usecases/portfolio/fd_details.dart';
import 'package:union_bank_mobile/features/domain/usecases/promotion_notification/promotion_notification.dart';
import 'package:union_bank_mobile/features/domain/usecases/request_callback/cancel_request_callback.dart';
import 'package:union_bank_mobile/features/domain/usecases/request_callback/get_request_callback.dart';
import 'package:union_bank_mobile/features/domain/usecases/request_callback/get_request_callback_default_data.dart';
import 'package:union_bank_mobile/features/domain/usecases/request_callback/save_request_callback.dart';
import 'package:union_bank_mobile/features/domain/usecases/reset_password/temporary_login.dart';
import 'package:union_bank_mobile/features/domain/usecases/splash/get_marketing_banners.dart';
import 'package:union_bank_mobile/features/domain/usecases/transaction_notification/transaction_notification.dart';
import 'package:union_bank_mobile/features/presentation/bloc/demo_tour/demo_tour_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/float_inquiry/float_inquiry_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/mailbox/mailbox_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/news/news_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/notifications/notifications_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/quick_access/quick_access_bloc.dart';
import 'package:union_bank_mobile/features/presentation/bloc/request_callback/request_callback_bloc.dart';
import 'package:union_bank_mobile/utils/biometric_helper.dart';

import '../../features/data/datasources/local_data_source.dart';
import '../../features/data/datasources/remote_data_source.dart';
import '../../features/data/datasources/remote_datasource_impl.dart';
import '../../features/data/datasources/secure_storage.dart';
import '../../features/data/repository/repository_impl.dart';
import '../../features/domain/repository/repository.dart';
import '../../features/domain/usecases/Manage_Other_Bank/get_justpay_instrument_list.dart';
import '../../features/domain/usecases/Manage_Other_Bank/manage_other_bank.dart';
import '../../features/domain/usecases/Notices_notifications/notices_notifications.dart';
import '../../features/domain/usecases/account_verification/account_verification.dart';
import '../../features/domain/usecases/biller_management/add_biller.dart';
import '../../features/domain/usecases/biller_management/bill_payment.dart';
import '../../features/domain/usecases/biller_management/biller_excel_download.dart';
import '../../features/domain/usecases/biller_management/biller_pdf_download.dart';
import '../../features/domain/usecases/biller_management/delete_biller.dart';
import '../../features/domain/usecases/biller_management/edit_biller.dart';
import '../../features/domain/usecases/biller_management/favourite_biller.dart';
import '../../features/domain/usecases/biller_management/get_biller_categories.dart';
import '../../features/domain/usecases/biller_management/saved_billers.dart';
import '../../features/domain/usecases/biller_management/scheduling_bill_payment.dart';
import '../../features/domain/usecases/biometric/biometric_login.dart';
import '../../features/domain/usecases/biometric/enable_biometric.dart';
import '../../features/domain/usecases/calculators/apply_fd_calculator.dart';
import '../../features/domain/usecases/calculators/apply_housing_loan_calculator.dart';
import '../../features/domain/usecases/calculators/apply_leasing_calculator.dart';
import '../../features/domain/usecases/calculators/apply_personal_loan_calculator.dart';
import '../../features/domain/usecases/calculators/calculator_pdf.dart';
import '../../features/domain/usecases/calculators/fd_calculator.dart';
import '../../features/domain/usecases/calculators/get_currency_list.dart';
import '../../features/domain/usecases/calculators/get_fd_period.dart';
import '../../features/domain/usecases/calculators/get_fd_rate.dart';
import '../../features/domain/usecases/calculators/housing_loan_calculator.dart';
import '../../features/domain/usecases/calculators/leasing_calculator.dart';
import '../../features/domain/usecases/calculators/personal_loan_calculator.dart';
import '../../features/domain/usecases/card_management/loyalty_points/loyalty_redeem.dart';
import '../../features/domain/usecases/cdb_account_verification/cdb_account_verification.dart';
import '../../features/domain/usecases/change_password/change_password.dart';
import '../../features/domain/usecases/cheque_status_inquary/cheque_status_inquary.dart';
import '../../features/domain/usecases/create_user/create_user.dart';
import '../../features/domain/usecases/customer_registration/customer_registration.dart';
import '../../features/domain/usecases/default_payment_instrument/default_payment_instrument.dart';
import '../../features/domain/usecases/default_payment_instrument/instrument_nik_name_change.dart';
import '../../features/domain/usecases/default_payment_instrument/instrument_status_change.dart';
import '../../features/domain/usecases/document_verification/document_verification.dart';
import '../../features/domain/usecases/drop_down/banks/bank_list.dart';
import '../../features/domain/usecases/drop_down/banks/branch_list.dart';
import '../../features/domain/usecases/drop_down/city/get_city_data.dart';
import '../../features/domain/usecases/drop_down/designation/get_designation_data.dart';
import '../../features/domain/usecases/drop_down/schedule/schedule_get_dates.dart';
import '../../features/domain/usecases/drop_down/schedule/schedule_get_time.dart';
import '../../features/domain/usecases/drop_down/transactioncategories/transaction_categories_list.dart';
import '../../features/domain/usecases/edit_profile/get_profile_image.dart';
import '../../features/domain/usecases/edit_profile/update_profile_details.dart';
import '../../features/domain/usecases/emp_details/emp_details.dart';
import '../../features/domain/usecases/epicuser_id/save_epicuser_id.dart';

import '../../features/domain/usecases/excel_download/acc_tran_status_excel.dart';

import '../../features/domain/usecases/excel_download/account_statement_excel_download.dart';
import '../../features/domain/usecases/excel_download/past_card_excel_download.dart';

import '../../features/domain/usecases/excel_download/account_transaction_excel.dart';
import '../../features/domain/usecases/excel_download/card_transaction_excel.dart';
import '../../features/domain/usecases/excel_download/lease_history_excel_download.dart';
import '../../features/domain/usecases/excel_download/loan_history_excelDownload.dart';
import '../../features/domain/usecases/excel_download/transaction_filter_excel_download.dart';
import '../../features/domain/usecases/faq/faq.dart';
import '../../features/domain/usecases/fund_transfer/delete_schedule_ft.dart';
import '../../features/domain/usecases/fund_transfer/edit_scheduling_fund_transfer.dart';
import '../../features/domain/usecases/fund_transfer/fund__transfer_excel_download.dart';
import '../../features/domain/usecases/fund_transfer/fund_transfer_receipt_download.dart';
import '../../features/domain/usecases/fund_transfer/get_account_name_for_ft.dart';
import '../../features/domain/usecases/fund_transfer/get_all_fund_transfer_schedule.dart';
import '../../features/domain/usecases/fund_transfer/get_all_schedule_ft.dart';
import '../../features/domain/usecases/fund_transfer/get_txn_category.dart';
import '../../features/domain/usecases/fund_transfer/intra_fund_transfer.dart';
import '../../features/domain/usecases/fund_transfer/one_time_fund_transfer.dart';
import '../../features/domain/usecases/fund_transfer/schedule_ft_history.dart';
import '../../features/domain/usecases/fund_transfer/scheduling_fund_transfer.dart';
import '../../features/domain/usecases/get_image/get_image.dart';
import '../../features/domain/usecases/gold_loan/gold_loan_details.dart';
import '../../features/domain/usecases/gold_loan/gold_loan_list.dart';
import '../../features/domain/usecases/gold_loan/gold_loan_payment_topup.dart';
import '../../features/domain/usecases/home/account_inquiry.dart';
import '../../features/domain/usecases/justpay/add_just_pay_instrument.dart';
import '../../features/domain/usecases/home/add_user_instrument.dart';
import '../../features/domain/usecases/home/balance_inquiry.dart';
import '../../features/domain/usecases/home/get_remaining_instrument.dart';
import '../../features/domain/usecases/home/get_user_instrument.dart';
import '../../features/domain/usecases/justpay/just_pay_instrument.dart';
import '../../features/domain/usecases/itransfer/initiate_itransfer.dart';
import '../../features/domain/usecases/itransfer/itransfer_get_theme.dart';
import '../../features/domain/usecases/itransfer/itransfer_get_theme_details.dart';
import '../../features/domain/usecases/justpay/just_pay_account_onboarding.dart';
import '../../features/domain/usecases/justpay/just_pay_challenge_id.dart';
import '../../features/domain/usecases/justpay/justPay_verification.dart';
import '../../features/domain/usecases/language/save_language.dart';
import '../../features/domain/usecases/language/set_language.dart';
import '../../features/domain/usecases/locator/merchant_locator.dart';
import '../../features/domain/usecases/login/mobile_login.dart';
import '../../features/domain/usecases/notifications/delete_notifications.dart';
import '../../features/domain/usecases/notifications/mark_as_read_notifications.dart';
import '../../features/domain/usecases/notifications/money_request_notification.dart';
import '../../features/domain/usecases/notifications/notification_count.dart';
import '../../features/domain/usecases/notifications/req_money_notification_status.dart';
import '../../features/domain/usecases/other_products/get_other_products.dart';
import '../../features/domain/usecases/other_products/submit_other_products.dart';
import '../../features/domain/usecases/otp/request_otp.dart';
import '../../features/domain/usecases/otp/verify_otp.dart';
import '../../features/domain/usecases/pay_management/add_payee.dart';
import '../../features/domain/usecases/payee_management/fund_transfer/fund_transfer_payee_list.dart';
import '../../features/domain/usecases/pay_management/edit_payee.dart';
import '../../features/domain/usecases/payee_management/fund_transfer/delete_fund_transfer_payee.dart';
import '../../features/domain/usecases/payee_management/fund_transfer/payee_favorite.dart';
import '../../features/domain/usecases/payee_management/get_bank_branch_list.dart';
import '../../features/domain/usecases/payee_management/itransfer/add_itransfer_payee.dart';
import '../../features/domain/usecases/payee_management/itransfer/delete_itransfer_payee.dart';
import '../../features/domain/usecases/payee_management/itransfer/edit_itransfer_payee.dart';
import '../../features/domain/usecases/payee_management/itransfer/itransfer_payee_list.dart';
import '../../features/domain/usecases/pdf_download/acc_transaction_pdf_download.dart';
import '../../features/domain/usecases/pdf_download/acc_transaction_status_pdf.dart';
import '../../features/domain/usecases/pdf_download/account_statements_pdf_download.dart';
import '../../features/domain/usecases/pdf_download/loan_history_pdf_download.dart';
import '../../features/domain/usecases/pdf_download/past_card_statements_pdf_download.dart';
import '../../features/domain/usecases/pdf_download/card_transaction_pdf.dart';
import '../../features/domain/usecases/pdf_download/lease_history_pdf.dart';
import '../../features/domain/usecases/pdf_download/transaction_filter_pdf_download.dart';
import '../../features/domain/usecases/pdf_download/transaction_status_pdf_download.dart';
import '../../features/domain/usecases/portfolio/accont_details.dart';
import '../../features/domain/usecases/portfolio/account_statements.dart';
import '../../features/domain/usecases/portfolio/account_transactions.dart';
import '../../features/domain/usecases/portfolio/card_statement_pdf_download.dart';
import '../../features/domain/usecases/portfolio/cc_details.dart';
import '../../features/domain/usecases/portfolio/lease_details.dart';
import '../../features/domain/usecases/portfolio/lease_payment_history.dart';
import '../../features/domain/usecases/portfolio/loan_details.dart';
import '../../features/domain/usecases/portfolio/loan_history.dart';
import '../../features/domain/usecases/portfolio/past_card_statements.dart';
import '../../features/domain/usecases/promotion/get_promotions.dart';
import '../../features/domain/usecases/promotion/promotion_share.dart';
import '../../features/domain/usecases/request_money/request_money.dart';
import '../../features/domain/usecases/qr_payment/qr_payment.dart';
import '../../features/domain/usecases/qr_payment/qr_payment_pdf_download.dart';
import '../../features/domain/usecases/request_money/request_money_history.dart';
import '../../features/domain/usecases/reset_password/reset_password.dart';
import '../../features/domain/usecases/schedule/submit_schedule_data.dart';
import '../../features/domain/usecases/security_questions/get_security_questions.dart';
import '../../features/domain/usecases/security_questions/set_security_questions.dart';
import '../../features/domain/usecases/service_requests/cheque_book_field.dart';
import '../../features/domain/usecases/service_requests/credit_card_req_field_data.dart';
import '../../features/domain/usecases/service_requests/credit_card_req_save.dart';
import '../../features/domain/usecases/service_requests/debit_card_req_field_data.dart';
import '../../features/domain/usecases/service_requests/debit_card_save_field_data.dart';
import '../../features/domain/usecases/service_requests/filtered_list_cheque_book.dart';
import '../../features/domain/usecases/service_requests/history.dart';
import '../../features/domain/usecases/service_requests/lease_req_field_data.dart';
import '../../features/domain/usecases/service_requests/lease_req_save_data.dart';
import '../../features/domain/usecases/service_requests/loan_req_f.dart';
import '../../features/domain/usecases/service_requests/loan_req_field_data.dart';
import '../../features/domain/usecases/service_requests/loan_req_save_data.dart';
import '../../features/domain/usecases/service_requests/sr_service_charge.dart';
import '../../features/domain/usecases/service_requests/sr_statement.dart';
import '../../features/domain/usecases/service_requests/statement_history.dart';
import '../../features/domain/usecases/settings/get_notification_settings.dart';
import '../../features/domain/usecases/settings/reset_txn_limit.dart';
import '../../features/domain/usecases/settings/transaction_limit.dart';
import '../../features/domain/usecases/settings/get_home_details.dart';
import '../../features/domain/usecases/settings/update_notification_settings.dart';
import '../../features/domain/usecases/settings/update_profile_image.dart';
import '../../features/domain/usecases/settings/update_txn_limit.dart';
import '../../features/domain/usecases/settings/view_personal_information.dart';
import '../../features/domain/usecases/splash/get_splash_data.dart';
import '../../features/domain/usecases/terms/accept_terms_data.dart';
import '../../features/domain/usecases/terms/get_terms_data.dart';
import '../../features/domain/usecases/transaction_details/transaction_details.dart';
import '../../features/domain/usecases/transaction_details/transaction_limit.dart';
import '../../features/domain/usecases/transaction_details/transaction_limit_add.dart';
import '../../features/domain/usecases/transaction_history/filter_transaction_history.dart';
import '../../features/domain/usecases/transaction_history/transaction_history_pdf.dart';
import '../../features/domain/usecases/verify_nic/verify_nic.dart';
import '../../features/domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../features/domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../features/presentation/bloc/account/account_bloc.dart';
import '../../features/presentation/bloc/biller_management/biller_management_bloc.dart';
import '../../features/presentation/bloc/calculators/apply_personal_loan/apply_personal_loan_bloc.dart';
import '../../features/presentation/bloc/calculators/personal_loan_calculator/personal_loan_calculator_bloc.dart';
import '../../features/presentation/bloc/calculators/apply_fd_calculator/apply_fd_calculator_bloc.dart';
import '../../features/presentation/bloc/calculators/apply_housing_loan/apply_housing_loan_bloc.dart';
import '../../features/presentation/bloc/calculators/apply_leasing_calculator/apply_leasing_calculator_bloc.dart';
import '../../features/presentation/bloc/calculators/fd_calculator/fd_calculator_bloc.dart';
import '../../features/presentation/bloc/calculators/housing_loan_calculator/housing_loan_calculator_bloc.dart';
import '../../features/presentation/bloc/calculators/leasing_calculator/leasing_calculator_bloc.dart';
import '../../features/presentation/bloc/cheque_status_inquary/csi_bloc.dart';
import '../../features/presentation/bloc/credit_card_management/credit_card_management_bloc.dart';
import '../../features/presentation/bloc/drop_down/drop_down_bloc.dart';
import '../../features/presentation/bloc/fund_transfer/fund_transfer_bloc.dart';
import '../../features/presentation/bloc/fund_transfer_view_scheduling/ft_view_scheduling_bloc.dart';
import '../../features/presentation/bloc/language/language_bloc.dart';
import '../../features/presentation/bloc/locator_bloc/locator_bloc.dart';
import '../../features/presentation/bloc/on_boarding/biometric/biometric_bloc.dart';
import '../../features/presentation/bloc/on_boarding/contact_information/contact_information_bloc.dart';
import '../../features/presentation/bloc/on_boarding/create_user/create_user_bloc.dart';
import '../../features/presentation/bloc/on_boarding/document_verification/document_verification_bloc.dart';
import '../../features/presentation/bloc/on_boarding/other_products/other_products_bloc.dart';
import '../../features/presentation/bloc/on_boarding/security_questions/security_questions_bloc.dart';
import '../../features/presentation/bloc/on_boarding/tnc/tnc_bloc.dart';
import '../../features/presentation/bloc/otp/otp_bloc.dart';
import '../../features/presentation/bloc/payee_management/payee_management_bloc.dart';
import '../../features/presentation/bloc/payment_instrument/payment_instrument_bloc.dart';
import '../../features/presentation/bloc/portfolio/portfolio_bloc.dart';
import '../../features/presentation/bloc/pre_login/contact_us/contact_us_bloc.dart';
import '../../features/presentation/bloc/pre_login/faq/faq_bloc.dart';
import '../../features/presentation/bloc/promotion/promotion_bloc.dart';
import '../../features/presentation/bloc/request_money/request_money_bloc.dart';
import '../../features/presentation/bloc/reset_password/reset_password_bloc.dart';
import '../../features/presentation/bloc/service_requests/service_requests_bloc.dart';
import '../../features/presentation/bloc/settings/settings_bloc.dart';
import '../../features/presentation/bloc/splash/splash_bloc.dart';
import '../../features/presentation/bloc/transaction/transaction_bloc.dart';
import '../../features/presentation/bloc/user_login/login_bloc.dart';
import '../../utils/app_sync_data.dart';
import '../../utils/app_validator.dart';
import '../../utils/device_data.dart';
import '../network/api_helper.dart';
import '../network/network_info.dart';

final injection = GetIt.instance;

Future<void> setupLocator() async {
  final _sharedPreferences = await SharedPreferences.getInstance();
  final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
  const _flutterSecureStorage = FlutterSecureStorage();
  var _secureStorage = SecureStorage(_flutterSecureStorage);

  injection.registerSingleton(DeviceInfoPlugin());
  injection.registerSingleton(LocalAuthentication());
  injection.registerSingleton(AppLinks());

  injection.registerLazySingleton(() => _sharedPreferences);
  injection.registerLazySingleton(() => _flutterSecureStorage);
  injection.registerLazySingleton(() => _secureStorage);
  injection.registerLazySingleton(() => _packageInfo);
  injection.registerSingleton(LocalDataSource(
    securePreferences: injection(),
    sharedPreferences: injection(),
  ));
  injection.registerSingleton(DeepLinkHandler(
    appLinks: injection(),
  ));
  injection.registerSingleton(DeviceData(
    deviceInfo: injection(),
    packageInfo: injection(),
    sharedData: injection(),
  ));
  injection.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      apiHelper: injection(),
    ),
  );

  injection
      .registerLazySingleton(() => AppSyncData(localDataSource: injection()));

  injection.registerSingleton(BiometricHelper(
    localAuthentication: injection(),
  ));

  /// Utils
  injection.registerLazySingleton(() => AppValidator());

  /// Cloud Service
  injection.registerSingleton(CloudServicesImpl(
    injection(),
  ));
  injection.registerSingleton(CloudServices(injection()));

  injection.registerSingleton(Dio());
  injection.registerLazySingleton<APIHelper>(() => APIHelper(
        localDataSource: injection(),
        dio: injection(),
        // tokenDio: injection(),
        deviceData: injection(),
        appSyncData: injection(),
        encrypt: injection(),
      ));
  injection.registerLazySingleton(() => Connectivity());
  injection.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        injection(),
      ));

  /// Repository
  injection.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      remoteDataSource: injection(),
      localDataSource: injection(),
      networkInfo: injection(),
    ),
  );
  injection.registerLazySingleton<Encrypt>(() => Encrypt());

  ///USeCases
  injection.registerLazySingleton(() => GetSplashData(repository: injection()));
  injection.registerLazySingleton(
      () => TransactionFilterPdfDownload(repository: injection()));
  injection.registerLazySingleton(
      () => AccountStatementsPdfDownload(repository: injection()));
  injection
      .registerLazySingleton(() => GetNotification(repository: injection()));
  injection.registerLazySingleton(
      () => NoticesNotification(repository: injection()));
  injection.registerLazySingleton(
      () => UpdateNotificationSettings(repository: injection()));
  injection.registerLazySingleton(
      () => LeaseHistoryPdfDownload(repository: injection()));
  injection.registerLazySingleton(
      () => LeaseHistoryExcelDownload(repository: injection()));
  injection.registerLazySingleton(
      () => LoanHistoryExcelDownloadDownload(repository: injection()));
  injection.registerLazySingleton(
      () => TransactionHistoryFilter(repository: injection()));

  injection.registerLazySingleton(
      () => AccountTransactionExcelDownload(repository: injection()));
  injection.registerLazySingleton(
      () => CardTransactionExcelDownload(repository: injection()));
  injection.registerLazySingleton(
      () => CardTransactionPdfDownload(repository: injection()));
  injection.registerLazySingleton(
      () => AccountTranStatusExcelDownload(repository: injection()));
  injection.registerLazySingleton(
      () => AccountTransactionStatusPdfDownload(repository: injection()));
  injection.registerLazySingleton(
      () => AccountTransactionsPdfDownload(repository: injection()));
  injection.registerLazySingleton(
      () => AccountSatementsXcelDownload(repository: injection()));
  injection.registerLazySingleton(
      () => TransactionStatusPdfDownload(repository: injection()));

  injection
      .registerLazySingleton(() => BillerPdfDownload(repository: injection()));
  // () => AccountSatementsXcelDownload(repository: injection());
  // injection
  //     .registerLazySingleton(() => BillerPdfDownload(repository: injection()));
  injection.registerLazySingleton(
      () => BillerExcelDownload(repository: injection()));
  injection.registerLazySingleton(
      () => LoanHistoryPdfDownload(repository: injection()));
  injection.registerLazySingleton(
      () => PastCardExcelDownload(repository: injection()));

  injection.registerLazySingleton(
      () => PastCardStatemntsPdfDownload(repository: injection()));
  injection.registerLazySingleton(
      () => AccountTransactions(repository: injection()));
  injection.registerLazySingleton(() => EditNickName(repository: injection()));
  injection.registerLazySingleton(
      () => PastCardStatesments(repository: injection()));
  injection.registerLazySingleton(() => LoanHistory(repository: injection()));
  injection.registerLazySingleton(() => LeaseHistory(repository: injection()));
  injection
      .registerLazySingleton(() => AccountStatements(repository: injection()));
  injection.registerLazySingleton(() => AddPayee(repository: injection()));
  injection.registerLazySingleton(() => VerifyNIC(repository: injection()));
  injection.registerLazySingleton(
      () => GetWalletOnBoardingData(repository: injection()));
  injection.registerLazySingleton(
      () => StoreWalletOnBoardingData(repository: injection()));
  injection.registerLazySingleton(() => GetCityData(repository: injection()));
  injection
      .registerLazySingleton(() => GetDesignationData(repository: injection()));
  injection
      .registerLazySingleton(() => GetScheduleDates(repository: injection()));
  injection
      .registerLazySingleton(() => GetOtherProducts(repository: injection()));
  injection.registerLazySingleton(
      () => SubmitOtherProducts(repository: injection()));
  injection.registerLazySingleton(
      () => CustomerRegistration(repository: injection()));
  injection.registerLazySingleton(() => CreateUser(repository: injection()));
  injection.registerLazySingleton(() => CheckUser(repository: injection()));

  injection
      .registerLazySingleton(() => AcceptTermsData(repository: injection()));
  injection.registerLazySingleton(() => GetTermsData(repository: injection()));

  injection.registerLazySingleton(() => EmpDetails(repository: injection()));

  injection.registerLazySingleton(
      () => GetSecurityQuestions(repository: injection()));
  injection.registerLazySingleton(
      () => SetSecurityQuestions(repository: injection()));
  injection.registerLazySingleton(() => VerifyOTP(repository: injection()));
  injection.registerLazySingleton(
      () => SetPreferredLanguage(repository: injection()));
  injection.registerLazySingleton(
      () => DocumentVerification(repository: injection()));
  injection
      .registerLazySingleton(() => GetScheduleTime(repository: injection()));
  injection
      .registerLazySingleton(() => SubmitScheduleData(repository: injection()));
  injection.registerLazySingleton(() => SetEpicUserID(repository: injection()));
  injection.registerLazySingleton(() => MobileLogin(repository: injection()));
  injection.registerLazySingleton(() => TemporaryLogin(repository: injection()));
  injection
      .registerLazySingleton(() => EnableBiometric(repository: injection()));
  injection.registerLazySingleton(() => RequestOTP(repository: injection()));
  injection.registerLazySingleton(() => ContactUs(repository: injection()));
  injection
      .registerLazySingleton(() => BiometricLogin(repository: injection()));

  injection.registerLazySingleton(
      () => SavePreferredLanguage(repository: injection()));

  injection
      .registerLazySingleton(() => GetSavedBillers(repository: injection()));
  injection.registerLazySingleton(() => AddBiller(repository: injection()));
  injection
      .registerLazySingleton(() => FavouriteBiller(repository: injection()));
  injection.registerLazySingleton(
      () => GetBillerCategoryList(repository: injection()));
  //
  injection
      .registerLazySingleton(() => EditUserBiller(repository: injection()));
  // injection.registerLazySingleton(
  //         () => ForgotPwCreateNewPassword(repository: injection()));
  injection.registerLazySingleton(() => DeleteBiller(repository: injection()));
  // injection.registerLazySingleton(() => UnFavoriteBiller(repository: injection()));
  injection
      .registerLazySingleton(() => ChangePassword(repository: injection()));
  injection
      .registerLazySingleton(() => ResetPassword(repository: injection()));

  injection
      .registerLazySingleton(() => AccountInquiry(repository: injection()));
  injection
      .registerLazySingleton(() => BalanceInquiry(repository: injection()));
  // injection.registerLazySingleton(() => AddPayee(repository: injection()));
  injection.registerLazySingleton(() => EditPayee(repository: injection()));
  // injection
  //     .registerLazySingleton(() => FundTransferPayeeList(repository: injection()));
  injection.registerLazySingleton(
      () => DeleteFundTransferPayee(repository: injection()));
  injection.registerLazySingleton(() => GetBankData(repository: injection()));
  injection.registerLazySingleton(() => GetBranchData(repository: injection()));
  injection.registerLazySingleton(() => Faq(repository: injection()));
  injection.registerLazySingleton(
      () => AccountVerification(repository: injection()));
  injection.registerLazySingleton(() => GetPromotions(repository: injection()));
  injection.registerLazySingleton(() => GetImage(repository: injection()));
  injection.registerLazySingleton(() => GoldLoanList(repository: injection()));
  injection
      .registerLazySingleton(() => GoldLoanDetails(repository: injection()));
  injection.registerLazySingleton(
      () => GoldLoanPaymentTopUp(repository: injection()));
  injection.registerLazySingleton(() => FundTransfer(repository: injection()));
  injection.registerLazySingleton(
      () => GetTransactionCategoriesList(repository: injection()));
  injection
      .registerLazySingleton(() => AddItransferPayee(repository: injection()));
  injection
      .registerLazySingleton(() => ItransferPayeeList(repository: injection()));
  injection
      .registerLazySingleton(() => EditItransferPayee(repository: injection()));
  injection.registerLazySingleton(
      () => JustPayVerification(repository: injection()));
  injection.registerLazySingleton(
      () => CDBAccountVerification(repository: injection()));
  injection
      .registerLazySingleton(() => MerchantLocator(repository: injection()));
  injection.registerLazySingleton(
      () => JustPayAccountOnboarding(repository: injection()));
  injection.registerLazySingleton(
      () => DeleteItransferPayee(repository: injection()));
  injection
      .registerLazySingleton(() => GetUserInstruments(repository: injection()));
  injection.registerLazySingleton(
      () => GetRemainingInstruments(repository: injection()));
  injection
      .registerLazySingleton(() => AddUserInstrument(repository: injection()));
  injection
      .registerLazySingleton(() => JustPayChallengeId(repository: injection()));
  injection
      .registerLazySingleton(() => JustPayTCSign(repository: injection()));
  injection
      .registerLazySingleton(() => TransactionDetails(repository: injection()));

  injection.registerLazySingleton(
      () => LoanRequestsFieldData(repository: injection()));
  injection.registerLazySingleton(
      () => LoanRequestsSaveData(repository: injection()));
  injection.registerLazySingleton(
      () => CreditCardReqFieldData(repository: injection()));
  injection
      .registerLazySingleton(() => CreditCardReqSave(repository: injection()));
  injection
      .registerLazySingleton(() => LeaseReqFieldData(repository: injection()));
  injection
      .registerLazySingleton(() => LeaseReqSaveData(repository: injection()));
  injection
      .registerLazySingleton(() => JustPayInstrument(repository: injection()));
  injection
      .registerLazySingleton(() => ServiceReqHistory(repository: injection()));
  injection.registerLazySingleton(() => LoanReqField(repository: injection()));
  injection.registerLazySingleton(
      () => DefaultPaymentInstrument(repository: injection()));
  injection.registerLazySingleton(
      () => AddJustPayInstrument(repository: injection()));
  injection.registerLazySingleton(
      () => InstrumentStatusChange(repository: injection()));
  injection.registerLazySingleton(
      () => InstrumentNickNameChange(repository: injection()));
  injection.registerLazySingleton(
      () => OneTimeFundTransfer(repository: injection()));
  injection
      .registerLazySingleton(() => TransactionLimit(repository: injection()));
  injection.registerLazySingleton(
      () => TransactionLimitAdd(repository: injection()));
  injection.registerLazySingleton(
      () => TransactionHistoryPdfDownload(repository: injection()));
  injection.registerLazySingleton(
      () => SchedulingFundTransfer(repository: injection()));
  injection
      .registerLazySingleton(() => UpdateProfileImage(repository: injection()));
  injection.registerLazySingleton(
      () => ViewPersonalInformation(repository: injection()));
  injection
      .registerLazySingleton(() => ItransferGetTheme(repository: injection()));
  injection.registerLazySingleton(
      () => ItransferGetThemeDetails(repository: injection()));
  injection.registerLazySingleton(
      () => PromotionNotification(repository: injection()));

  injection.registerLazySingleton(() => BillPayment(repository: injection()));
  injection.registerLazySingleton(
      () => HousingLoanCalculatorData(repository: injection()));
  injection.registerLazySingleton(
      () => ApplyHousingLoanCalculatorData(repository: injection()));
  injection.registerLazySingleton(
      () => ApplyLeasingCalculatorData(repository: injection()));
  injection.registerLazySingleton(
      () => LeasingCalculatorData(repository: injection()));
  injection
      .registerLazySingleton(() => FDCalculatorData(repository: injection()));
  injection.registerLazySingleton(
      () => ApplyFDCalculatorData(repository: injection()));
  injection.registerLazySingleton(
      () => TransactionNotification(repository: injection()));

  injection.registerLazySingleton(() => ComposeMail(repository: injection()));
  injection
      .registerLazySingleton(() => GetRecipientTypes(repository: injection()));
  injection.registerLazySingleton(
      () => GetRecipientCategory(repository: injection()));
  injection.registerLazySingleton(() => GetViewMails(repository: injection()));
  injection.registerLazySingleton(() => GetMailThread(repository: injection()));
  injection
      .registerLazySingleton(() => GetMailAttcahment(repository: injection()));
  injection.registerLazySingleton(
      () => DeleteMailAttcahment(repository: injection()));
  injection.registerLazySingleton(() => GetMailCount(repository: injection()));
  injection.registerLazySingleton(() => DeleteMail(repository: injection()));
  injection.registerLazySingleton(() => DeleteMailMessage(repository: injection()));
  injection
      .registerLazySingleton(() => MarkAsReadMail(repository: injection()));
  injection.registerLazySingleton(() => ReplyMail(repository: injection()));


  injection
      .registerLazySingleton(() => GetCurrencyList(repository: injection()));
  injection.registerLazySingleton(() => GetFDPeriod(repository: injection()));
  injection.registerLazySingleton(
      () => ForgetPwCheckNicAccount(repository: injection()));
  injection.registerLazySingleton(
      () => ForgetPwCheckSecurityQuestion(repository: injection()));
  injection.registerLazySingleton(
      () => ForgetPwCheckUsername(repository: injection()));
  injection.registerLazySingleton(() => ForgetPwReset(repository: injection()));
  injection.registerLazySingleton(() => DemoTour(repository: injection()));
  injection.registerLazySingleton(() => GetTranLimits(repository: injection()));
  injection.registerLazySingleton(() => CalculatorPDF(repository: injection()));
  injection
      .registerLazySingleton(() => UpdateTXNLimit(repository: injection()));
  injection.registerLazySingleton(
      () => MarkAsReadNotification(repository: injection()));
  injection.registerLazySingleton(
      () => DeleteNotifications(repository: injection()));
  injection
      .registerLazySingleton(() => PasswordValidation(repository: injection()));
  injection.registerLazySingleton(() => RequestMoney(repository: injection()));
  injection.registerLazySingleton(
      () => MoneyRequestNotification(repository: injection()));

  injection
      .registerLazySingleton(() => CountNotification(repository: injection()));
  injection
      .registerLazySingleton(() => GetAcctNameForFT(repository: injection()));
  injection.registerLazySingleton(() => QRPayment(repository: injection()));
  injection.registerLazySingleton(
      () => QRPaymentPdfDownload(repository: injection()));

  injection.registerLazySingleton(
      () => GetMarketingBanners(repository: injection()));
  injection.registerLazySingleton(() => GetFDRate(repository: injection()));
  injection.registerLazySingleton(() => ResetTxnLimit(repository: injection()));
  injection.registerLazySingleton(() => RequestMoneyHistory(repository: injection()));
  injection.registerLazySingleton(() => ReqMoneyNotificationStatus(repository: injection()));

  injection.registerLazySingleton(() => GetRequestCallBack(repository: injection()));
  injection.registerLazySingleton(() => GetRequestCallBackDefaultData(repository: injection()));
  injection.registerLazySingleton(() => SaveRequestCallBack(repository: injection()));
  injection.registerLazySingleton(() => CancelRequestCallBack(repository: injection()));
  injection.registerLazySingleton(() => FilteredListChequeBook(repository: injection()));
  injection.registerLazySingleton(() => ChequeBookField(repository: injection()));
  injection.registerLazySingleton(() => FloatInquiry(repository: injection()));
  injection.registerLazySingleton(() => ChequeStatusInquiry(repository: injection()));
  injection.registerLazySingleton(() => SrStatementHistory(repository: injection()));
  injection.registerLazySingleton(() => SrStatement(repository: injection()));
  injection.registerLazySingleton(() => SrServiceCharge(repository: injection()));
  injection.registerLazySingleton(() => CardStatementPDFDownload(repository: injection()));


/* ----------------------------- Card Mangement ----------------------------- */

  injection.registerLazySingleton(() => CardList(repository: injection()));
  injection.registerLazySingleton(() => CardActivation(repository: injection()));
  injection.registerLazySingleton(() => CardCreditLimit(repository: injection()));
  injection.registerLazySingleton(() => CardDetails(repository: injection()));
  injection.registerLazySingleton(() => CardEStatement(repository: injection()));
  injection.registerLazySingleton(() => CardLastStatement(repository: injection()));
  injection.registerLazySingleton(() => CardLostStolen(repository: injection()));
  injection.registerLazySingleton(() => CardPin(repository: injection()));
  injection.registerLazySingleton(() => CardTxnHistory(repository: injection()));
  injection.registerLazySingleton(() => CardViewStatement(repository: injection()));

/* ------------------------------------ . ----------------------------------- */

  /// Utils

  injection.registerLazySingleton(
      () => FundTransferPdfDownload(repository: injection()));
  injection
      .registerLazySingleton(() => GetAllScheduleFT(repository: injection()));
  injection
      .registerLazySingleton(() => InitiateItransfer(repository: injection()));
  injection.registerLazySingleton(
      () => DebitCardSaveFieldData(repository: injection()));
  injection.registerLazySingleton(
      () => FundTransferExcelDownload(repository: injection()));

  injection.registerLazySingleton(
      () => PortfolioAccountDetails(repository: injection()));
  injection.registerLazySingleton(
      () => DebitCardCardReqFieldData(repository: injection()));
  injection.registerLazySingleton(
      () => PersonalLoanCalculator(repository: injection()));
  injection.registerLazySingleton(
      () => ApplyPersonalLoanCalculator(repository: injection()));
  injection.registerLazySingleton(
      () => FundTransferPayeeList(repository: injection()));
  injection
      .registerLazySingleton(() => PortfolioCCDetails(repository: injection()));
  injection.registerLazySingleton(
      () => PortfolioLeaseDetails(repository: injection()));
  injection
      .registerLazySingleton(() => PortfolioFDDetails(repository: injection()));
  injection.registerLazySingleton(
      () => PortfolioLoanDetails(repository: injection()));
  injection
      .registerLazySingleton(() => GetAllFTSchedule(repository: injection()));
  injection
      .registerLazySingleton(() => EditSchedulingFT(repository: injection()));
  injection
      .registerLazySingleton(() => DeleteSchedulingFT(repository: injection()));
  injection.registerLazySingleton(
      () => SchedulingFTHistory(repository: injection()));
  injection.registerLazySingleton(
          () => AddPaymentInstrument(repository: injection()));
  injection.registerLazySingleton(
          () => DeletePaymentInstrument(repository: injection()));
  injection.registerLazySingleton(() => GetHomeDetails(repository: injection()));

  injection.registerLazySingleton(
          () => GetJustpayPaymentInstrument(repository: injection()));

  injection
      .registerLazySingleton(() => PromotionPdfShare(repository: injection()));

  injection.registerLazySingleton(() => UdateProfile(repository: injection()));

  injection
      .registerLazySingleton(() => GetProfileImage(repository: injection()));

  injection.registerLazySingleton(
      () => SchedulingBillPayment(repository: injection()));

  injection
      .registerLazySingleton(() => GetBankBranchList(repository: injection()));

  injection
      .registerLazySingleton(() => GetTxnCategoryList(repository: injection()));

  injection.registerLazySingleton(
      () => PayeeFavoriteUnFavorite(repository: injection()));

  injection.registerLazySingleton(
      () => TransactionFilterExcelDownload(repository: injection()));
  injection.registerLazySingleton(
    () => KeyExchange(repository: injection()));

  injection.registerLazySingleton(
      () => GetCnn(repository: injection()));
  injection.registerLazySingleton(
    () => GetBbc(repository: injection()));
  injection.registerLazySingleton(
          () => CardLoyaltyVouchers(repository: injection()));
  injection.registerLazySingleton(
          () => CardDLoyaltyRedeem(repository: injection()));

  ///Blocs
  injection.registerFactory(() => SplashBloc(
      appSharedData: injection(),
      useCaseSplashData: injection(),
      getWalletOnBoardingData: injection(),
      cloudServices: injection(), getMarketingBanners: injection(),
      networkInfo: injection(), encrypt: injection(), keyExchange: injection(),
      ));

  injection.registerFactory(
    () => TransactionBloc(
      transactionStatusPdfDownload:injection(),
      transactionHistoryFilter:injection(),
      transactionDetails: injection(),
      transactionHistoryPdfDownload: injection(),
      transactionFilterPdfDownload: injection(),
        transactionFilterExcelDownload: injection(), getUserInstruments: injection(),
    ),
  );

  injection.registerFactory(
    () => PersonalLoanCalculatorBloc(
      personalLoanCalculator: injection(),
      calculatorPDF: injection()
    ),
  );

  injection.registerFactory(
    () => ApplyPersonalLoanBloc(
      applyPersonalLoanCalculator: injection(),
    ),
  );

  injection.registerFactory(
    () => PayeeManagementBloc(
        addPayee: injection(),
        defaultPaymentInstrument: injection(),
        fundTransferPayeeList: injection(),
        deleteFundTransferPayee: injection(),
        editPayee: injection(),
      payeeFavoriteUnFavorite: injection(), getBankBranchList: injection()
    ),
  );
  injection.registerFactory(
    () => FaqBloc(
      faq: injection(),
    ),
  );


  injection.registerFactory(
    () => FundTransferBloc(
      transactionLimitAdd: injection(),
      transactionLimit: injection(),
      fundTransfer: injection(),
      oneTimeFundTransfer: injection(),
      schedulingFundTransfer: injection(),
      fundTransferPdfDownload: injection(),
      getAllScheduleFT: injection(),
      fundTransferExcelDownload: injection(),
      schedulingBillPayment: injection(),
      reqMoneyNotificationStatus: injection(),

    ),
  );

  injection.registerFactory(
    () => HousingLoanCalculatorBloc(
      housingLoanCalculator: injection(),
      calculatorPDF: injection(),
    ),
  );

  injection.registerFactory(
    () => ApplyHousingLoanBloc(
      applyHousingLoanCalculator: injection(),
    ),
  );

  injection.registerFactory(
    () => LeasingCalculatorBloc(
      leasingCalculatorData: injection(),
      calculatorPDF: injection()
    ),
  );

  injection.registerFactory(
    () => ApplyLeasingCalculatorBloc(
      applyLeasingCalculatorData: injection(),
    ),
  );

  injection.registerFactory(
    () => FDCalculatorBloc(
      fdCalculatorData: injection(),
      calculatorPDF: injection(),
        getFDRate: injection(),
      getCurrencyList: injection(),
      getFDPeriod: injection(),
    ),
  );

  injection.registerFactory(
    () => ApplyFDCalculatorBloc(
      applyFDCalculatorData: injection(),
    ),
  );

  injection.registerFactory(
    () => FTViewSchedulingBloc(
        getAllFTSchedule: injection(),
        editSchedulingFT: injection(),
        deleteSchedulingFT: injection(),
        schedulingFTHistory: injection()),
  );

  injection.registerFactory(
        () => SettingsBloc(
          viewPersonalInformation: injection(),
      updateProfileImage: injection(),
      getNotification: injection(),
      udateProfile: injection(),
      getHomeDetails: injection(),
      getTranLimits: injection(),
      updateTXNLimit: injection(),
      localDataSource: injection(),
      updateNotificationSettings: injection(),
          resetTxnLimit: injection()
    ),
  );
  //       appSharedData: injection(),
  //       getWalletOnBoardingData: injection(),
  //       storeWalletOnBoardingData: injection(),
  //       verifyNIC: injection(),
  //       customerRegistration: injection(),
  //       appValidator: injection(),
  //     ));

  injection.registerFactory(
    () => PromotionBloc(
        getPromotions: injection(), promotionPdfShare: injection()),
  );
  injection.registerFactory(
    () => ServiceRequestsBloc(
      loanReqField: injection(),
      loanRequestsFieldData: injection(),
      loanRequestsSaveData: injection(),
      creditCardReqFieldData: injection(),
      creditCardReqSave: injection(),
      leaseReqFieldData: injection(),
      leaseReqSaveData: injection(),
      serviceReqHistory: injection(),
      debitCardCardReqFieldData: injection(),
      debitCardSaveFieldData: injection(),
      checkBookField: injection(),
      filteredListChequeBook: injection(),
      srStatementHistory: injection(),
      serviceCharge: injection(),
    ),
  );

  // injection.registerFactory(
  //   () => DropDownBloc(),
  // );
  //     cloudMessagingServices: injection()));
  //
  // injection.registerFactory(() => PersonalInformationBloc(
  //       appSharedData: injection(),
  //       getWalletOnBoardingData: injection(),
  //       storeWalletOnBoardingData: injection(),
  //       verifyNIC: injection(),
  //       customerRegistration: injection(),
  //       appValidator: injection(),
  //     ));
  //
  injection.registerFactory(
    () => DropDownBloc(
      getRecipientCategory: injection(),
      getUserInstruments: injection(),
      useCaseGetQuestions: injection(),
      getRecipientTypes: injection(),
      localDataSource: injection(),
      // getCurrencyList: injection(),
      // getFDPeriod: injection(),
      getBankBranchList: injection(),
      // getTxnCategoryList: injection(),
    ),
  );

  injection.registerFactory(
    () => SecurityQuestionsBloc(
      
      getWalletOnBoardingData: injection(),
      storeWalletOnBoardingData: injection(),
      useCaseSetQuestions: injection(), useCaseGetQuestions: injection(),
    ),
  );
  injection.registerFactory(
    () => ContactInformationBloc(
      justPayChallengeId: injection(),
      appSharedData: injection(),
      getWalletOnBoardingData: injection(),
      storeWalletOnBoardingData: injection(),
      customerRegistration: injection(),
      appValidator: injection(),
      accountVerification: injection(),
      cdbAccountVerification: injection(),
      justPayVerification: injection(),
      justPayAcoountOnboarding: injection(),
      justPayTCSign: injection(),
      useCaseGetTerms: injection(),
      useCaseAcceptTerms: injection(),
    ),
  );
  injection.registerFactory(() => DocumentVerificationBloc(
      appSharedData: injection(),
      getWalletOnBoardingData: injection(),
      storeWalletOnBoardingData: injection(),
      useCaseDocumentVerification: injection()));
  injection.registerFactory(() => TnCBloc(
      getWalletOnBoardingData: injection(),
      storeWalletOnBoardingData: injection(),
      useCaseAcceptTerms: injection(),
      useCaseGetTerms: injection()));

  injection.registerFactory(() => CreateUserBloc(
      appSharedData: injection(),
      createUser: injection(),
      setEpicUserID: injection(),
      storeWalletOnBoardingData: injection(),
      checkUser: injection(),
      getWalletOnBoardingData: injection()));
  injection.registerFactory(() => OTPBloc(
      verifyOTP: injection(),
      requestOTP: injection(),
      addJustPayInstrument: injection()));
  injection.registerFactory(() => LoginBloc(
        mobileLogin: injection(),
        biometricLogin: injection(),
        localDataSource: injection(),
        setEpicUserID: injection(),
        getWalletOnBoardingData: injection(),
        // getImage: injection()
      ));
  injection.registerFactory(
    () => LanguageBloc(
      setPreferredLanguage: injection(),
      savePreferredLanguage: injection(),
    ),
  );
  injection.registerFactory(
    () => OtherProductsBloc(
      storeWalletOnBoardingData: injection(),
      getOtherProducts: injection(),
      getWalletOnBoardingData: injection(),
      submitOtherProducts: injection(),
    ),
  );
  injection.registerFactory(() => BiometricBloc(
      appSharedData: injection(),
      enableBiometric: injection(),
      storeWalletOnBoardingData: injection(),
      getWalletOnBoardingData: injection(),
      passwordValidation: injection(),
    checkBookField: injection(),
      srStatement: injection()
  ));

  injection.registerFactory(
    () => BillerManagementBloc(
      billPayment: injection(),
      getSavedBillers: injection(),
      addBiller: injection(),
      favouriteBiller: injection(),
      getBillerCategoryList: injection(),
      editUserBiller: injection(),
      deleteBiller: injection(),
      billerPdfDownload: injection(),
      billerExcelDownload: injection(), schedulingBillPayment: injection(),
      //unFavoriteBiller: inject(),
    ),
  );

  // injection.registerFactory(
  //       () => ForgotPwResetSecQuestionsBloc(
  //     useCaseForgotPwResetSecQuestions: injection(),
  //     localDataSource: injection(),
  //   ),
  // );
  // injection.registerFactory(
  //       () => ForgotPasswordUserNameBloc(
  //     useCaseForgotPasswordUserName: injection(),
  //     localDataSource: injection(),
  //     forgotPwUsingAccountNumber: injection(),
  //   ),
  // );
  // injection.registerFactory(
  //       () => ForgotPwCreateNewPasswordBloc(
  //     localDataSource: injection(),
  //     forgotPwCreateNewPassword: injection(),
  //     setEpicUserID: injection(),
  //   ),
  // );
  // injection.registerFactory(
  //       () => ChangePasswordBloc(
  //     changePassword: injection(),
  //   ),
  // );
  // injection.registerFactory(
  //       () => PayeeManagementBloc(
  //     defaultPaymentInstrument: injection(),
  //     fundTransferPayeeList: injection(),
  //     deleteFundTransferPayee: injection(),
  //     addPayee: injection(),
  //     editPayee: injection(),
  //   ),
  // );
  // injection.registerFactory(
  //       () => ItransferPayeeBloc(
  //     addItransferPayee: injection(),
  //     itransferPayeeList: injection(),
  //     editItransferPayee: injection(),
  //     deleteItransferPayee: injection(),
  //   ),
  // );
  // injection.registerFactory(
  //       () => HomeAccountBloc(
  //     addJustPayInstrument: injection(),
  //     justPayInstrument: injection(),
  //     justPayChallengeId: injection(),
  //     useCaseGetTerms: injection(),
  //     addUserInstrument: injection(),
  //     getRemainingInstruments: injection(),
  //     getUserInstruments: injection(),
  //     accountInquiry: injection(),
  //     balanceInquiry: injection(),
  //     getPromotions: injection(),
  //   ),
  // );
  injection.registerFactory(
    () => AccountBloc(
      portfolioAccountDetails: injection(),
      getTranLimits: injection(),
      accountInquiry: injection(),
      balanceInquiry: injection(),
      getUserInstruments: injection(),
      localDataSource: injection(),
      getAcctNameForFT: injection(),
      qrPayment: injection(),
      biometricLogin: injection(),
      qrPaymentPdfDownload: injection(),
      getTxnCategoryList: injection(),
      fundTransferPayeeList: injection(),
      getBankBranchList: injection(),
    ),
  );

  injection.registerFactory(
    () => ResetPasswordBloc(
      resetPassword: injection(),
      temporaryLogin: injection(),
    ),
  );
  injection.registerFactory(
    () => RequestMoneyBloc(
        requestMoney: injection(), requestMoneyHistory: injection()),
  );
  // injection.registerFactory(
  //       () => FaqBloc(
  //     faq: injection(),
  //   ),
  // );
  // injection.registerFactory(
  //       () => LocatorBloc(
  //     merchantLocator: injection(),
  //   ),
  // );
  // injection.registerFactory(
  //       () => PromotionBloc(getPromotions: inject()),
  // );
  // injection.registerFactory(() => GoldLoanBloc(
  //   transactionHistoryPdfDownload: injection(),
  //   goldLoanList: injection(),
  //   goldLoanDetails: injection(),
  //   goldLoanPaymentTopUp: injection(),
  // ));
  // injection.registerFactory(
  //       () => FundTransferBloc(
  //     transactionLimitAdd: injection(),
  //     transactionLimit: injection(),
  //     fundTransfer: injection(),
  //     oneTimeFundTransfer: injection(),
  //     schedulingFundTransfer: injection(),
  //     fundTransferReceiptDownload: injection(),
  //     getAllScheduleFT: injection(),
  //     dailyTransactionLimit: injection(),
  //     saveSecondaryVerificationLimit: injection(),
  //     getSecondaryVerificationLimit: injection(),
  //   ),
  // );
  //
  // injection.registerFactory(
  //       () => TransactionBloc(
  //     transactionDetails: injection(),
  //     transactionHistoryPdfDownload: injection(),
  //   ),
  // );
  //
  injection.registerFactory(
    () => PaymentInstrumentBloc(
      addPaymentInstrument: injection(),
      deletePaymetInstrument: injection(),
      getJustpayPaymentInstrument: injection(),
      instrumentStatusChange: injection(),
      defaultPaymentInstrument: injection(),
      instrumentNickNameChange: injection(),
      portfolioAccountDetails: injection(),
    ),
  );
  //
  // injection.registerFactory(
  //       () => SettingsBloc(
  //     viewPersonalInformation: injection(),
  //     updateProfileImage: injection(),
  //   ),
  // );
  // injection.registerFactory(
  //       () => InitiateItransferBloc(
  //     itransferGetTheme: injection(),
  //     itransferGetThemeDetails: injection(),
  //     getUserInstruments: injection(),
  //     initiateItransfer: injection(),
  //   ),
  // );
  //
  injection.registerFactory(
    () => PortfolioBloc(
      portfolioAccountDetails: injection(),
      portfolioCCDetails: injection(),
      portfolioFDDetails: injection(),
      portfolioLoanDetails: injection(),
      transactionDetails: injection(),
      portfolioLeaseDetails: injection(),
      getPromotions: injection(),
      editNickName: injection(),
      pastCardStatements: injection(),
      loanHistory: injection(),
      leaseHistory: injection(),
      accountStatements: injection(),
      accountTransactions: injection(),
      accountStatementsPdfDownload: injection(),
      pastCardStatemntsPdfDownload: injection(),
      loanHistoryPdfDownload: injection(),
      pastCardExcelDownload: injection(),
      accountSatementsXcelDownload: injection(),
      accountTransactionsPdfDownload: injection(),
      accountTransactionStatusPdfDownload: injection(),
      accountTranStatusExcelDownload: injection(),
      cardtransactionPdfDownload: injection(),
      cardTransactionExcelDownload: injection(),
      accountTransactionExcelDownload: injection(),
      loanHistoryExcelDownloadDownload: injection(),
      leaseHistoryExcelDownload: injection(),
      leaseHistoryPdfDownload: injection(),
      getProfileImage: injection(),
      getMailCount: injection(),
      countNotification: injection(),
      getJustpayPaymentInstrument: injection(),
      useCaseGetTerms: injection(),
      useCaseAcceptTerms: injection(),
      getUserInstruments: injection(),
      appSharedData: injection(),
      justPayChallengeId: injection(),
      justPayTCSign: injection(),
      cardList: injection(),
      cardStatementPDFDownload: injection(),
    ),
  );

  injection.registerFactory(
    () => NotificationsBloc(
        countNotification: injection(),
        deleteNotifications: injection(),
        localDataSource: injection(),
        markAsReadNotification: injection(),
        getTranNotification: injection(),
        getPromoNotification: injection(),
        getNoticesNotifications: injection(),
        moneyRequestNotification: injection(),
        reqMoneyNotificationStatus: injection()),
  );

  // injection.registerFactory(
  //       () => ForgotUsernameBloc(
  //     forgotUsernameGetSecQuestion: injection(),
  //     forgotUsernameUsingAccNumber: injection(),
  //     sendEmail: injection(),
  //     forgotGetSecQuestion: injection(),
  //
  //   ),
  // );
  injection.registerFactory(() => LocatorBloc(
        merchantLocator: injection(),
      ));
  injection.registerFactory(() => ContactUsBloc(
        contactUs: injection(),
      ));
  injection.registerFactory(() => MailBoxBloc(
        replyMail: injection(),
        markAsReadMail: injection(),
        composeMail: injection(),
        localDataSource: injection(),
        getViewMails: injection(),
        getMailThread: injection(),
        getMailAttcahment: injection(),
        deleteMailAttcahment: injection(),
        deleteMail: injection(),
        deleteMailMessage: injection(),
        getRecipientTypes: injection(),
        getRecipientCategory: injection(),
      ));


  injection.registerFactory(
    () => ForgetPasswordBloc(
        forgetPwCheckNicAccount: injection(),
        forgetPwCheckSecurityQuestion: injection(),
        forgetPwCheckUsername: injection(),
        forgetPwReset: injection(),
        localDataSource: injection()),
  );

  injection.registerFactory(() => QuickAccessBloc(
        localDataSource: injection(),
      ));

  injection.registerFactory(() => CSIBloc(
        chequeStatusInquiry: injection(),
      ));

  injection.registerFactory(() => DemoTourBloc(
      demoTour: injection(),));

  injection.registerFactory(() => RequestCallBackBloc(
      saveRequestCallBack: injection(),
      getRequestCallBack: injection(),
      getRequestCallBackDefaultData: injection(),
      cancelRequestCallBack: injection(),
      localDataSource: injection()));


  injection.registerFactory(() => FloatInquiryBloc(
      floatInquiry: injection(),
      localDataSource: injection()));


  injection.registerFactory(() => NewsBloc(getCnn: injection(), getBbc: injection()));
  injection.registerFactory(() => CreditCardManagementBloc(
        portfolioAccountDetails: injection(),
        cardList: injection(),
        cardActivation: injection(),
        cardCreditLimit: injection(),
        cardDetails: injection(),
        cardEStatement: injection(),
        cardLastStatement: injection(),
        cardLostStolen: injection(),
        cardPin: injection(),
        cardTxnHistory: injection(),
        cardViewStatement: injection(),
    getBankBranchList: injection(),
    cardLoyaltyVouchers: injection(),
    cardDLoyaltyRedeem: injection(),
    getTranLimits: injection(),
    localDataSource: injection(),
    biometricLogin: injection(),
    getUserInstruments: injection(),
    cardtransactionPdfDownload: injection(),
    cardTransactionExcelDownload: injection(),
      ));
}
