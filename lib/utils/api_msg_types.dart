/// Define all API message types here

const kMessageTypeSplashReq = 'splashReq';
const kMessageTypeTermsAndConditionsGetReq = 'tNcGetReq';
const kMessageTypeTermsAndConditionsAcceptReq = 'tNcAccReq';
const kMessageTypeCityDetailReq = 'cityDetailReq';
const kMessageTypeCusRegistrationReq = 'customerRegReq';
const kMessageTypeEmpDetailReq = 'empDetailReq';
const kMessageTypeAnswerSecurityQuestionReq = 'answerSecurityQuestionReq';
const kMessageTypeAnswerSecurityQuestionForgotPwdReq = 'seQesAnsCheckReq';
const kNICVerifyRequestType = 'nicVerifyReq';
const kScheduleDatesRequestType = 'scheduleDateReq';
const kScheduleTimeRequestType = 'scheduleTimeReq';
const kSubmitOtherProductsRequestType = 'interestedProductSaveReq';
const kGetCityRequestType = 'cityReq';
const kGetDesignationRequestType = 'designationReq';
const kCreateUserRequestType = 'userCreateReq';
const kDocumentVerificationRequestType = 'imgUploadReq';
const kMobileLoginRequestType = 'mobileLoginReq';
const kLanguageRequestType = 'langReq';
const kScheduleDataSubmitRequestType = 'scheduleDetailReq';
const kOTPRequestType = 'otpReq';
const kContactUsRequestType = 'contactUsReq';
const kAccountVerificationRequestType = 'accountVerifyReq';
const kAccountOnboardReq = 'accountOnboardReq';
const kJustPayVerifyRequestType = 'accountOnboardReq';
const kOtpMessageTypeAccountOnboardingReq = 'accountOnboardReq';
const kMessageTypeJustPayChallengeIdReq = 'challengeReq';
const kOtpMessageTypeInactiveDevice = 'inactiveDevice';
const kOtpMessageAdminPasswordReset = 'adminpasswordreset';

const kOtpMessageTypeNewDevice = 'newDevice';

/// Define all API message types here

const kMessageTypeChallengeReq = 'challengeReq';
const kMessageExistingCustomerReg = 'existingCustomerReg';
const kMessageTypeSecurityQuestionReq = 'secQuestionReq';
const kMessageTypeGetBankBranches = 'getBankBranches';
const kGetTxnDetailsReq = 'txnDetailsReq';
const kMessageTypeInterestedProductReq = 'interestedProductReq';
const kMessageTypeInterestedProductAddReq = 'productIntrestReq';

const kChangePasswordRequestType = 'changePasswordReq';
const kBiometricLoginRequestType = 'biometricLoginReq';
const kEnableBiometricRequestType = 'enableBiometricReq';
const kPasswordValidationRequestType = 'passwordVerification';
const kForgotPasswordUserNameRequestType = 'usernameIdentityReq';
const kGetSavedBillersRequestType = 'getUserBillerReq';
const kAddBillerRequestType = 'addUserBillerReq';
const kFavouriteBillerRequestType = 'billerFavoritesReq';
const kDeleteBillerRequestType = 'deleteUserBillerReq';
const kGetBillerCategoryListRequestType = 'getBspCategoryReq';
const kEditBillerRequestType = 'editUserBillerReq';
const kDeleteUserBillerReqType = 'deleteUserBillerReq';
const kUnFavoriteBillerRequestType = 'billerUnFavoritesReq';
const kForgotPwCreateNewPasswordRequestType = 'forgotPassResetReq';
const kForgotPwUsingAccNumberRequestType = 'nicIdentityReq';
const kAccountInquiryRequestType = 'splashReq';
const kGetBankDataRequestType = 'bankReq';
const kGetBankBranchRequestType = 'bankBranchReq';
const kFundTransferPayeeManagement = 'payeeReq';
const kAddPayeeRequestType = 'payeeReq';
const kEditPayeeRequestType = 'payeeReq';
const kPayeeReq = 'payeeReq';
const kBillerFavReq = 'billerFavoritesReq';
const kBillerUnFavReq = 'billerUnFavoritesReq';
const kFaqRequestType = 'mobileFaqReq';
const kGetPromotionsRequestType = 'mobilePromoReq';
const kViewImageReq = 'viewImageReq';
const kFundTransferRequestType = 'fundTranReq';
const kGoldLoanListRequestType = 'payeeReq';
const kGoldLoanPaymentTopUpRequestType = 'goldLoanReq';
const kGetTransactionCategoriesListRequestType = 'txnCategoryReq';
const KAccountOnboardReq = 'accountOnboardReq';
const kItransferPayeeListRequestType = 'getITransferPayees';
const kAddItransferPayeeRequestType = 'addITransferPayee';
const kDeleteItransferPayeeRequestType = 'deleteITransferPayees';
const kEditItransferPayeeRequestType = 'editITransferPayee';
const kMerchantLocatorRequestType = "merchantLocatorReq";
const kLoanRequestFieldDataRequestType = 'loanRequestFieldRequest';
const kTransactionDetailsRequestType = 'txnDetailsReq';
const kTransactionDetailsDownloadRequestType = 'txnHistoryDownload';
const kLeasePaymentHistoryXLSheetDownload =
    'leasePaymentHistoryXLSheetDownload';
const kTransactionHistoryXLSheetDownload = 'transactionHistoryXLSheetDownload';
const kAccountStatementXLSheetHistoryDownload =
    'accountStatementXLSheetHistoryDownload';
const kcardTransactionHistory = 'cardTransactionHistory';
const kAccountTransactionsExcelDownloadRequest =
    'AccountTransactionsExcelDownloadRequest';
const kTxnDetailsReq = 'txnDetailsReq';
const kPastCardStatementXLSheetDownload = 'pastCardStatementXLSheetDownload';
const kLoanPaymentHistoryDownload = 'loanPaymentHistoryDownload';
const kPastCardStatementHistoryDownload = 'pastCardStatementHistoryDownload';
const kFundTransferReceiptDownloadRequestType = 'splashReq';
const kTransactionStatus = 'transactionStatus';
const kTransactionStatusXLSheetDownload = 'transactionStatusXLSheetDownload';
const kGetUserInstrumentRequestType = "userInstrumentReq";
const kGetRemainingInstrumentRequestType = "userInstrumentReq";
const kAddUserInstrumentRequestType = "userInstrumentReq";
const kLoanReqSaveRequestType = "loanRequestSaveReq";
const kCreditCardReqSaveRequestType = "creditCardFieldRequest";
const kCreditCardRequestSaveRequestType = "creditCardFieldReq";
const kLeaseRequestFieldRequestType = "leaseRequestFieldRequest";
const kLeaseRequestSaveRequestType = "leaseRequestSaveRequest";
const kFundTranRequestType = "fundTranReq";
const kServiceReqHistoryRequestType = "serviceRequestHistory";
const kDefaultPaymentInstrumentRequestType = "userInstrumentReq";
const KGetJustPayInstrumentType = "tempUserInstruments";
const kEditNickName = "instrumentNicknameChange";
const kProfileImgUpdateRequestType = "profileImgUpdate";
const kGetPersonalInfoRequestType = "getPersonalInfo";
const kNotificationSettingsUpdate = "notificationSettingsUpdate";
const kGetNotificationSettings = "getNotificationSettings";
const kTxnDetailsRequestType = "txnDetailsReq";
const kChannelType = "MB";
const kAddPaymentInstrument = "userInstrumentReq";
const kDeletePaymentInstrument = "splashReq";
const kItransfreGetThemeRequestType = "getITransferThemes";
const kItransfreGetThemeDetailRequestType = "getITransferThemeDetails";
const kBillPaymentReqType = "billPaymentReq";
const kScheduleFtReqType = "scheduleFtReq";
const kGetAllScheduleFtReqType = "scheduleFtReq";
const kGetInitIransferReqType = "initiateItransfer";
const kDebitCardReqFieldDataRequestType = "creditCardFieldRequest";
const kDebitCardReqFieldDataSaveRequestType = "debitCardReques";
const kAccDetailsRequestType = 'splashReq';
const kaccountInqReqType = 'accountInqReq';
const kPortfolioRequest = 'portfolioRequest';
const kBillerPdfDownloadRequestType = "accountStatementHistoryDownload";
const kaccountStatementHistoryDownload = "accountStatementHistoryDownload";
const kcardTransactionHistoryXLSheet = "cardTransactionHistoryXLSheet";
const kloanPaymentHistoryXLSheetDownload = "loanPaymentHistoryXLSheetDownload";
const kleasePaymentHistoryDownload = "leasePaymentHistoryDownload";
const kQRPayment = "qrPayment";
const kGetHomeDetails = "accountInqReq";

//Card Management

const kcardSummaryReq = "cardSummaryReq";
const kcardDetailsReq = "cardDetailsReq";
const kcardPinGenReq = "cardPinGenReq";
const kcardActReq = "cardActReq";
const kcardTxnHistoryReq = "cardTxnHistoryReq";
const kcardStModeReq = "cardStModeReq";
const kcardAddOnLimitReq = "cardAddOnLimitReq";
const kcardViewStatementReq = "cardViewStatementReq";
const kcardLastStatementReq = "cardLastStatementReq";
const kcardLostOrStolenReq = "cardLostOrStolenReq";
const kcardLoyaltyRedeemnReq = "cardLoyaltyRedeemReq";


//Forget Password

const knicIdentityReq = "nicIdentityReq";
const kusernameReq = "usernameIdentityReq";
const kseQesAnsCheckReq = "seQesAnsCheckReq";
const kforgotPassResetReq = "forgotPassResetReq";
const kforgotPasswordOtp = "forgotPassword";

/// Update profile details
const kUpdateProfileDetails = "accountInqReq";
const kGetProfilePic = "viewImageReq";

/// Demo Tour
const kDemoTour = "demoTour";

