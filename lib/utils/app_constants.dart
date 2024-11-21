import 'dart:async';

import 'package:union_bank_mobile/features/presentation/views/portfolio/Data/card_txn_details.dart';
import 'package:union_bank_mobile/utils/app_assets.dart';
import 'package:union_bank_mobile/utils/model/bank_icons.dart';

import '../features/data/models/responses/account_details_response_dtos.dart';
import '../features/data/models/responses/city_response.dart';
import '../features/data/models/responses/mobile_login_response.dart';
import '../features/data/models/responses/portfolio_lease_details_response.dart';
import '../features/data/models/responses/portfolio_loan_details_response.dart';
import '../features/data/models/responses/portfolio_userfd_details_response.dart';
import '../features/data/models/responses/splash_response.dart';
import '../features/domain/entities/response/account_entity.dart';
import '../features/domain/entities/response/profile_data.dart';
import '../features/presentation/views/notifications/data/request_money_data.dart';

const kAppMaxTimeout = "05";
const kReferenceNumber = "EPIC_DBP_SDK_DBP_020100_00007";
const kDeviceChannel = "01";
const kMessageVersion = "2.2";
const kChannelType = "MB";

List<ObTypes>? obTypes;

int termIdAll = 0;

///bankDataList
List<BankDataList>? bankDataList;

/// App UI Constants
final List<CommonDropDownResponse> kTitleList = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "Mr", key: 'mr'),
    CommonDropDownResponse(id: 2, description: "Mrs", key: 'mrs'),
    CommonDropDownResponse(id: 3, description: "Ms", key: 'ms'),
    CommonDropDownResponse(id: 4, description: "Dr", key: "dr"),
    CommonDropDownResponse(id: 5, description: "Rev", key: 'rev'),
  ],
);
final List<CommonDropDownResponse> kTransactionMode = List.unmodifiable([
  CommonDropDownResponse(id: 1, description: "Bill Payments"),
  CommonDropDownResponse(id: 2, description: "QR Payments"),
  CommonDropDownResponse(id: 3, description: "Fund Transfer"),
  // CommonDropDownResponse(id: 4, description: "P2P Payments"),
]);
final List<CommonDropDownResponse> kFieldOfEmployment = List.unmodifiable([
  CommonDropDownResponse(
      id: 1, description: "Agricultural", key: "Agricultural"),
  CommonDropDownResponse(
      id: 2,
      description: "Agriculture, Forestry And Fishing",
      key: "AgricultureAndForestryAndFishing"),
  CommonDropDownResponse(
      id: 3,
      description: "Arts, Entertainment And Recreation",
      key: " ArtsAndEntertainmentAndRecreation"),
  CommonDropDownResponse(id: 4, description: "Commercial", key: "Commercial"),
  CommonDropDownResponse(
      id: 5,
      description: "Construction And Infrastructure Development",
      key: "ConstructionAndInfrastructureDevelopment"),
  CommonDropDownResponse(id: 6, description: "Consumption", key: "Consumption"),
  CommonDropDownResponse(id: 7, description: "Education", key: "Education"),
  CommonDropDownResponse(id: 8, description: "Financial", key: "Financial"),
  CommonDropDownResponse(
      id: 9, description: "Financial Services", key: "FinancialServices"),
  CommonDropDownResponse(id: 10, description: "Guarantor", key: "Guarantor"),
  CommonDropDownResponse(
      id: 11,
      description: "Health Care, Social Services And Support Services",
      key: "HealthCareAndSocialServicesAndSupportServices"),
  CommonDropDownResponse(
      id: 12,
      description: "Housing And Property Development",
      key: "HousingAndPropertyDevelopment"),
  CommonDropDownResponse(id: 13, description: "Industrial", key: "Industrial"),
  CommonDropDownResponse(
      id: 14,
      description: "Information Technology And Communication",
      key: "InformationTechnologyAndCommunication"),
  CommonDropDownResponse(
      id: 15, description: "Manufacturing", key: "Manufacturing"),
  CommonDropDownResponse(id: 16, description: "Others", key: "Others"),
  CommonDropDownResponse(
      id: 17,
      description: "Professional, Scientific And Technical Activities",
      key: "ProfessionalAndScientificAndTechnicalActivities"),
  CommonDropDownResponse(id: 18, description: "Services", key: "Services"),
  CommonDropDownResponse(id: 19, description: "Tourism", key: "Tourism"),
  CommonDropDownResponse(
      id: 20,
      description: "Transportation And Storage",
      key: "TransportationAndStorage"),
  CommonDropDownResponse(
      id: 21,
      description: "Wholesale And Retail Trade",
      key: "WholesaleAndRetailTrade"),
]);
final List<CommonDropDownResponse> kCustomerType = List.unmodifiable([
  CommonDropDownResponse(id: 1, description: "Employed", key: "Employed"),
  CommonDropDownResponse(
      id: 2, description: "Self Employed", key: "SelfEmployed"),
  CommonDropDownResponse(id: 3, description: "Not Employed", key: "Unemployed"),
]);
final List<CommonDropDownResponse> kSourceOfFunds = List.unmodifiable([
  CommonDropDownResponse(
      id: 1, description: "Savings Income", key: "SavingsIncome"),
  CommonDropDownResponse(id: 2, description: "Savings", key: "Savings"),
  CommonDropDownResponse(
      id: 3, description: "Business Profit", key: "BusinessProfit"),
  CommonDropDownResponse(id: 4, description: "Remittances", key: "Remittances"),
  CommonDropDownResponse(
      id: 5, description: "Donation/ Charity", key: "DonationCharity"),
  CommonDropDownResponse(
      id: 6, description: "Commission Income", key: "CommissionIncome"),
  CommonDropDownResponse(
      id: 7,
      description: "Interest/ Income from Investments",
      key: "EmploymentIncome"),
  CommonDropDownResponse(
      id: 8, description: "Sales of Assets", key: "SalesOfAssets"),
  CommonDropDownResponse(id: 9, description: "Others", key: "Others")
]);
final List<CommonDropDownResponse> kMonthlyIncome = List.unmodifiable([
  CommonDropDownResponse(
      id: 1, description: "Less than Rs 120,000", key: "Income1"),
  CommonDropDownResponse(
      id: 2, description: "Rs 121,000 - Rs 240,000", key: "Income2"),
  CommonDropDownResponse(
      id: 3, description: "Rs 240,001 to Rs 360,000", key: "Income3"),
  CommonDropDownResponse(
      id: 4, description: "Rs 360,001 to Rs 600,000", key: "Income4"),
  CommonDropDownResponse(
      id: 5, description: "Rs 600,001 to Rs 1,200,000", key: "Income5"),
  CommonDropDownResponse(
      id: 6, description: "Above Rs 1,200,000", key: "Income6"),
]);
final List<CommonDropDownResponse> kAccountPurpose = List.unmodifiable([
  CommonDropDownResponse(
      id: 1, description: "Business Transactions", key: "BusinessTransactions"),
  CommonDropDownResponse(
      id: 2, description: "Investment purpose", key: "InvestmentPurpos"),
  CommonDropDownResponse(id: 3, description: "Savings", key: "Savings"),
  CommonDropDownResponse(
      id: 4,
      description: "Employment/Professional Income",
      key: "EmploymentIncome"),
  CommonDropDownResponse(
      id: 5,
      description: "Social and Charity work",
      key: "SocialAndCharityWork"),
  CommonDropDownResponse(id: 6, description: "Other", key: "Other"),
]);

final List<CommonDropDownResponse> kPurposeOfAccountOpeningList =
    List.unmodifiable(
  [
    CommonDropDownResponse(
        id: 1, description: "Construstion Services", key: 'purpose_1'),
    CommonDropDownResponse(
        id: 2, description: "Educational Expences", key: 'purpose_2'),
    CommonDropDownResponse(
        id: 3, description: "Credit Card Settlements", key: 'purpose_3'),
    CommonDropDownResponse(
        id: 4, description: "Telecommunication Services", key: "purpose_4"),
    CommonDropDownResponse(
        id: 5, description: "Employee Salaries", key: 'purpose_5'),
  ],
);

final List<CommonDropDownResponse> kTransactionModeList = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "Cheque", key: 'ch'),
    CommonDropDownResponse(id: 2, description: "Cash", key: 'ca'),
    CommonDropDownResponse(id: 3, description: "Online Payments", key: 'on'),
    CommonDropDownResponse(id: 4, description: "Debit Card", key: 'de'),
    CommonDropDownResponse(id: 5, description: "Credit Card", key: 'cr'),
  ],
);
final List<CommonDropDownResponse> kCityList = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "Negombo", key: 'ne'),
    CommonDropDownResponse(id: 2, description: "Colombo", key: 'co'),
    CommonDropDownResponse(id: 3, description: "Monaragala", key: 'mo'),
    CommonDropDownResponse(id: 4, description: "Galle", key: "ga"),
    CommonDropDownResponse(id: 5, description: "Jaffna", key: 'ja'),
  ],
);
final List<CommonDropDownResponse> kEmployementTypeList = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "Regular", key: 're'),
    CommonDropDownResponse(
        id: 2, description: "Full-time Employees", key: 'full'),
    CommonDropDownResponse(
        id: 3, description: "Part-time Employees", key: 'part'),
    CommonDropDownResponse(
        id: 4, description: "Temporary Employees", key: "temp"),
    CommonDropDownResponse(
        id: 5, description: "Independent Contractors", key: 'indep'),
  ],
);
final List<CommonDropDownResponse> kEmployementFieldList = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "Engineering", key: 'en'),
    CommonDropDownResponse(
        id: 2, description: "Information Technology", key: 'it'),
    CommonDropDownResponse(
        id: 3, description: "Healthcare and Medical", key: 'he'),
    CommonDropDownResponse(
        id: 4, description: "Finance and Accounting", key: "fi"),
    CommonDropDownResponse(
        id: 5, description: "Education and Academia", key: 'edu'),
    CommonDropDownResponse(
        id: 5, description: "Business and Management", key: 'bu'),
    CommonDropDownResponse(
        id: 5, description: "Media and Communication", key: 'me'),
    CommonDropDownResponse(
        id: 5, description: "Arts and Entertainment", key: 'art'),
    CommonDropDownResponse(id: 5, description: "Legal Services", key: 'le'),
  ],
);
final List<CommonDropDownResponse> kDesignationList = List.unmodifiable(
  [
    CommonDropDownResponse(
        id: 1, description: "Chief Executive Officer", key: 'ceo'),
    CommonDropDownResponse(
        id: 2, description: "Chief Financial Officer", key: 'cfo'),
    CommonDropDownResponse(
        id: 3, description: "Chief Operating Officer", key: 'coo'),
    CommonDropDownResponse(
        id: 4, description: "Chief Technology Officer", key: "cto"),
    CommonDropDownResponse(id: 5, description: "Manager", key: 'ma'),
  ],
);
final List<CommonDropDownResponse> kAnnualIncomenList = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "0-25000", key: '1'),
    CommonDropDownResponse(id: 2, description: "25000-50000", key: '2'),
    CommonDropDownResponse(id: 3, description: "50000-75000", key: '3'),
    CommonDropDownResponse(id: 4, description: "75000-100000", key: "4"),
    CommonDropDownResponse(id: 5, description: "100000 <", key: '5'),
  ],
);
final List<CommonDropDownResponse> kLanguageList = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "English", key: 'en'),
    CommonDropDownResponse(id: 2, description: "Sinhala", key: 'si'),
    CommonDropDownResponse(id: 3, description: "Tamil", key: 'ta'),
  ],
);
final List<CommonDropDownResponse> kReligionList = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "Buddhism", key: 'bu'),
    CommonDropDownResponse(id: 2, description: "Chistianity", key: 'ch'),
    CommonDropDownResponse(id: 3, description: "Islam", key: 'is'),
    CommonDropDownResponse(id: 4, description: "Jainism", key: "ja"),
    CommonDropDownResponse(id: 5, description: "Hinduism", key: 'hi'),
  ],
);
final List<CommonDropDownResponse> kNationalityList = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "Sri Lankan", key: 'sr'),
  ],
);
final List<CommonDropDownResponse> kSourceOfFundsList = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "Savings", key: 'savings'),
    CommonDropDownResponse(id: 2, description: "Checking", key: 'checking'),
    CommonDropDownResponse(id: 3, description: "Money Market", key: 'money'),
    CommonDropDownResponse(
        id: 4, description: "Certificate of Deposit", key: "certificate"),
    CommonDropDownResponse(id: 5, description: "Joint Account", key: 'joint'),
  ],
);

final List<CommonDropDownResponse> kQuestionsList1 = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "Your mother’s maiden name ?"),
    CommonDropDownResponse(
      id: 2,
      description: "Your first pet’s  name ?",
    ),
  ],
);
final List<CommonDropDownResponse> kQuestionsList2 = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "Your favourite food ?"),
    CommonDropDownResponse(
      id: 2,
      description: "Your favourite colour ?",
    ),
  ],
);
List<CommonDropDownResponse> kBankList = [];

List<CommonDropDownResponse> kTxnCategoryList = [];

List<CommonDropDownResponse> kBankBranchList = [];

List<CommonDropDownResponse> kBillerCategoryList = [];
List<CommonDropDownResponse> kBillerList = [];

List<CommonDropDownResponse> kActiveCurrentAccountList = [];
List<AccountEntity> kCurrentAccountList = [];

final List<CommonDropDownResponse> kAccountTypeList = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "Savings", key: "savings"),
    CommonDropDownResponse(
        id: 2, description: "Current Account", key: "current"),
  ],
);
final List<CommonDropDownResponse> kLanguageList2 = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "සිංහල", code: "si"),
    CommonDropDownResponse(id: 2, description: "English", code: "en"),
    CommonDropDownResponse(id: 3, description: "தமிழ்", code: "ta"),
  ],
);

class AppConstants {
  static const String appName = 'UnionBankMobile';
  static double totalAccountBalance = 0.0;
  static double totalLeaseBalance = 0.0;
  static double totalLoanBalance = 0.0;
  static double totalInvestmentBalance = 0.0;
  static double totalCardBalance = 0.0;

  static String kFontFamily = 'Proxima';

  static const String DEVICE_TYPE_ANDROID = "ANDROID";
  static const String DEVICE_TYPE_HUAWEI = "HUAWEI";

  static const String VENDOR_ANDROID = 'com.android.vending';
  static const String VENDOR_HUAWEI = 'com.huawei.appmarket';
  static const String VENDOR_IOS = 'com.apple.AppStore';
  static const String TESTFLIGHT_IOS = 'com.apple.TestFlight';
  static const int APP_SESSION_TIMEOUT = 5 * 60;
  // static const int APP_SESSION_TIMEOUT = 60 * 60;
  static const int UPLOAD_FILE_SIZE_IN_MB_IN_MAILBOX = 1;
  static const int UPLOAD_FILE_SIZE_IN_MB_IN_ONBOARDING = 2;
  static bool IS_USER_LOGGED = false;
  static bool IS_CURRENT_AVAILABLE = false;
  static double UI_PADDING = 20.0;
  static String USER_LOGGED_TIME = "";
  static bool IS_FIRST_TIME_BIOMETRIC_POPUP = true;

  static const String localeEN = 'en';
  static const String localeSI = 'si';
  static const String localeTA = 'ta';

  //Promotions types

  static const ubBankCode = 7302;
  static String? ubBankName;
  static String challangeID = "";
  static String unionBankTitle = "Union Bank";

  static const int otpTimeout = 60000;

  static late DateTime TOKEN_EXPIRE_TIME;
  static ProfileData profileData = ProfileData();
  static UserNamePolicy userNamePolicy = UserNamePolicy();
  static PasswordPolicy passwordPolicy = PasswordPolicy();
  static StreamController<int> unreadMailCount =
      StreamController<int>.broadcast();
  static String? BIOMETRIC_CODE;
  static String? RATES_URL;
  static String? FIRST_NAME;
  static String? SEAT_RESERVATION_URL;
  static String IMAGE_TYPE = "SELFIE";
  static List<CompanyDetail>? COMPANY_DETAILS;
   static String? CALL_CENTER_TEL_NO;

  static int HUAWEI_ANDROID_VERSION = 12;

  static RequestMoneyData requestMoneyData = RequestMoneyData();

  // static ImageApiResponseEntity imageData = ImageApiResponseEntity();

  ///OTP PRIVIOUS ROUTE TYPES

  //LOGIN SCREEN
  static const String LOGIN_INACTIVEUSER = "LOGIN_INACTIVEUSER";
  static const String LOGIN_NEWUSER = "LOGIN_NEWUSER";

  //MAILBOX SCREEN
  static const String MAILBOX_NEWMESSAGE = "MAILBOX_NEWMESSAGE";

  static List<AccountDetailsResponseDto> accountDetailsResponseDtos = [];
  static List<FdDetailsResponseDtoList> fdDetailsResponseDtoList = [];
  static List<LoanDetailsResponseDtoList> loanDetailsResponseDtoList = [];
  static List<CardTxnDetails> cardDetailsResponseDtoList = [];
  static List<LeaseDetailsResponseDtoList> leaseDetailsResponseDtoList = [];

  static String? lastLoggingTime;

  static List<CommonDropDownResponse> kQuestionsList1 = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "Your mother’s maiden name ?"),
      CommonDropDownResponse(
        id: 2,
        description: "Your first pet’s  name ?",
      ),
    ],
  );
  static List<CommonDropDownResponse> kQuestionsList2 = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "Your favourite food ?"),
      CommonDropDownResponse(
        id: 2,
        description: "Your favourite colour ?",
      ),
    ],
  );
  static List<CommonDropDownResponse> kAccountTypeList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "Saving Account"),
      CommonDropDownResponse(
        id: 2,
        description: "Saving Account 2",
      ),
    ],
  );
  static List<CommonDropDownResponse> kMonthList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "January", key: '1'),
      CommonDropDownResponse(id: 2, description: "February", key: '2'),
      CommonDropDownResponse(id: 3, description: "March", key: '3'),
      CommonDropDownResponse(id: 3, description: "April", key: '4'),
      CommonDropDownResponse(id: 4, description: "May", key: "5"),
      CommonDropDownResponse(id: 5, description: "June", key: '6'),
      CommonDropDownResponse(id: 6, description: "July", key: '7'),
      CommonDropDownResponse(id: 7, description: "August", key: '8'),
      CommonDropDownResponse(id: 8, description: "September", key: '9'),
      CommonDropDownResponse(id: 9, description: "October", key: '10'),
      CommonDropDownResponse(id: 10, description: "November", key: '11'),
      CommonDropDownResponse(id: 11, description: "December", key: '12'),
    ],
  );

  static List<CommonDropDownResponse> kYearList = [];

  static List<CommonDropDownResponse> kLeaseYearList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "1 Year", key: '12'),
      CommonDropDownResponse(id: 2, description: "2 Years", key: '24'),
      CommonDropDownResponse(id: 3, description: "3 Years", key: '36'),
      CommonDropDownResponse(id: 4, description: "4 Years", key: "48"),
      CommonDropDownResponse(id: 5, description: "5 Years", key: '60'),
    ],
  );

  static List<CommonDropDownResponse> kInterestTypeList = List.unmodifiable(
    [
      CommonDropDownResponse(
          id: 1, description: "Floating interest rate", key: 'fir'),
      CommonDropDownResponse(
          id: 2, description: "Floating interest rate2", key: 'fir2'),
    ],
  );
  static List<CommonDropDownResponse> kPeriodList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "3 Month(s)", key: 'm3'),
      CommonDropDownResponse(id: 2, description: "4 Month(s)", key: 'm4'),
      CommonDropDownResponse(id: 3, description: "5 Month(s)", key: 'm5'),
      CommonDropDownResponse(id: 4, description: "6 Month(s)", key: "m6"),
      CommonDropDownResponse(id: 5, description: "7 Month(s)", key: 'm7'),
    ],
  );

  static List<CommonDropDownResponse> kCurrencyList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "yei yei", key: 'lk'),
      CommonDropDownResponse(id: 2, description: "DOLLAR", key: 'do'),
    ],
  );

  static List<CommonDropDownResponse> kPurposeLoanList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "Education Loan", key: 'el'),
      CommonDropDownResponse(id: 2, description: "Health Loan", key: 'hl'),
    ],
  );

  static List<CommonDropDownResponse> kVehicleList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "Brand new", key: 'BRAND_NEW'),
      CommonDropDownResponse(
          id: 2, description: "Unregistered", key: 'UNREGISTERED'),
      CommonDropDownResponse(
          id: 3, description: "Registered", key: 'REGISTERED'),
    ],
  );

  static List<CommonDropDownResponse> kVehicleTypeList = List.unmodifiable(
    [
      CommonDropDownResponse(
          id: 1, description: "Dual Purpose Vehicles", key: 'DUAL_PURPOSE'),
      CommonDropDownResponse(
          id: 2, description: "Motor Bikes", key: 'MOTOR_BIKE'),
      CommonDropDownResponse(
          id: 3, description: "Three Wheel", key: 'THREE_WHEEL'),
      CommonDropDownResponse(id: 4, description: "Cars/SUV's", key: 'CAR_SUV'),
    ],
  );

  static List<CommonDropDownResponse> kFDTypeList = List.unmodifiable(
    [
      CommonDropDownResponse(
          id: 1, description: "Flexible Investment", key: 'flexi'),
    ],
  );

  static List<CommonDropDownResponse> kLeasePeriodList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "3 Month(s)", key: 'm3'),
      CommonDropDownResponse(id: 2, description: "4 Month(s)", key: 'm4'),
      CommonDropDownResponse(id: 3, description: "5 Month(s)", key: 'm5'),
      CommonDropDownResponse(id: 4, description: "6 Month(s)", key: "m6"),
      CommonDropDownResponse(id: 5, description: "7 Month(s)", key: 'm7'),
    ],
  );
  static List<CommonDropDownResponse> kMaritalStatusList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "Married", key: 'married'),
      CommonDropDownResponse(
          id: 2, description: "Un Married", key: 'unmarried'),
    ],
  );

  static List<CommonDropDownResponse> kLanguageList2 = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "සිංහල"),
      CommonDropDownResponse(
        id: 2,
        description: "English",
      ),
      CommonDropDownResponse(
        id: 3,
        description: "தமிழ்",
      ),
    ],
  );
  static List<CommonDropDownResponse> kAccountList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "Acc 1", key: 'ac1'),
      CommonDropDownResponse(id: 2, description: "Acc 2", key: 'ac2'),
      CommonDropDownResponse(id: 3, description: "Acc 3", key: 'ac2'),
    ],
  );
  static List<CommonDropDownResponse> kAmountRangeList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "10 000 - 50 000", key: 'ar1'),
      CommonDropDownResponse(id: 2, description: "50 000 - 70 000", key: 'ar2'),
      CommonDropDownResponse(id: 3, description: "70 000 - 90 000", key: 'ar3'),
    ],
  );
  static List<CommonDropDownResponse> kGetTransTypeList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "Fund Transfer", key: 'FT'),
      CommonDropDownResponse(id: 2, description: "Bill Payment", key: 'BILLPAY'),
      CommonDropDownResponse(id: 3, description: "Lanka QR Payment", key: 'LQR'),
      CommonDropDownResponse(id: 3, description: "Card Payment", key: 'CARD'),
    ],
  );
  static List<CommonDropDownResponse> kGetFTCatagoryList = List.unmodifiable(
    [
      // CommonDropDownResponse(id: 1, description: "Health", key: 'health'),
      // CommonDropDownResponse(id: 2, description: "Shopping", key: 'shopping'),
      // CommonDropDownResponse(
      //     id: 2, description: "Entertainment", key: 'entertainment'),
      // CommonDropDownResponse(id: 2, description: "Household", key: 'household'),
      // CommonDropDownResponse(id: 2, description: "Travel", key: 'travel'),
      // CommonDropDownResponse(id: 2, description: "Utility", key: 'utility'),
      // CommonDropDownResponse(id: 2, description: "Other", key: 'other'),
    ],
  );
  static List<CommonDropDownResponse> kGetFTFrequencyList = List.unmodifiable(
    [
      CommonDropDownResponse(id: 1, description: "daily", key: 'daily'),
      CommonDropDownResponse(id: 2, description: "weekly", key: 'weekly'),
      CommonDropDownResponse(id: 3, description: "monthly", key: 'monthly'),
      CommonDropDownResponse(id: 4, description: "annually", key: 'annually'),
    ],
  );

  static String? selectedVoucherId;

}

//Term Type
const kJustPayTerms = 'justPay';
const kAccountTerms = 'account';
const kCardTerms = 'card';
const kGeneralTerms = 'general';
const kTermType = 'general';
const kJustPayTermType = 'justpay';

//Languages
const String kLocaleEN = 'en';
const String kLocaleSI = 'si';
const String kLocaleTA = 'ta';


//Field Type
const fieldTypeTextField = 'TEXT FIELD';
const fieldTypeOneLineLabelField = 'ONE LINE LABEL FIELD';
const fieldTypeLableField = 'LABEL FIELD';
const fieldTypeDropDown = 'DROP DOWN';
//const kOtpMessageTypeBillPayment = 'BILLPAYMENTOTPREQ';

//OTP Types
const kOtpMessageTypeOnBoarding = 'digitalonboarding';
const kNewDeviceMessageType = 'newDevice';
const kInactiveDeviceMessageType = 'inactiveDevice';
const kProfileData = 'profiledata';
const kSecurityQuestion = 'changepassword';
const kNotificationSettings = 'notificationsetting';
const kOtpMessageTypeBillPayment = 'billpaymentotpreq';
const kForgotPassword = 'FORGOTPASSWORD';
const kPayeeOTPType = 'payeemanage';
const kChequeBookOtpType = 'chequeBookRequest';
const kStatementOtpType = 'statementRequest';
const kFundTransOTPType = 'ftr';
const kBillerMange = "billermanage";
const kBillPaymentOtp = "billPaymentOtpReq";
const kManageOtherBank = 'justpay';
const kOtherBank = 'JUSTPAY';
const kMessageTypeDigitalOnBoarding = 'digitalOnboarding';
const kloyaltypointsOtp = "loyaltypoints";

// OnBoarding Types
const kAccountOnBoarding = 'AC';
const kCreditCardOnBoarding = 'CC';
const kDebitCardOnBoarding = 'DC';
const kJustPayOnBoarding = 'JP';
const kDigitalOnBoarding = 'DO';

MobileLoginResponse? mobileData;

//AppMarkets
const List<String> appMarkets = [
  "com.android.vending",
  "com.amazon.venezia",
  "com.sec.android.app.samsungapps",
  "com.huawei.appmarket",
  "com.apple.AppStore",
  "com.apple.TestFlight",
  "com.apple.CoreSimulator"
];

List<BankIcon> bankIcons = [
  BankIcon(icon: AppAssets.amanaBank, bankCode: "7463",),
  BankIcon(icon: AppAssets.bocBank, bankCode: "7010",),
  BankIcon(icon: AppAssets.cargillsBank, bankCode: "7481",),
  BankIcon(icon: AppAssets.commercialBank, bankCode: "7056",),
  BankIcon(icon: AppAssets.dfccBank, bankCode:"7454",),
  BankIcon(icon: AppAssets.hnbBank, bankCode: "7083",),
  BankIcon(icon: AppAssets.hsbcBank, bankCode: "7092",),
  BankIcon(icon: AppAssets.ndbBank, bankCode: "7214",),
  BankIcon(icon: AppAssets.nsbBank, bankCode: "7719",),
  BankIcon(icon: AppAssets.ntbBank, bankCode: "7162",),
  BankIcon(icon: AppAssets.panasiaBank, bankCode: "7311",),
  BankIcon(icon: AppAssets.peopleBank, bankCode: "7135",),
  BankIcon(icon: AppAssets.sampathBank, bankCode: "7278",),
  BankIcon(icon: AppAssets.seylanBank, bankCode: "7287",),
  BankIcon(icon: AppAssets.standardChartedBank, bankCode: "7038",),
  BankIcon(icon: AppAssets.ubBank, bankCode: "7302",),
  BankIcon(icon: AppAssets.arpicoFinance, bankCode: "7889",),
  BankIcon(icon: AppAssets.asiaaFinace, bankCode: "7676",),
  BankIcon(icon: AppAssets.boChina, bankCode: "7700",),
  BankIcon(icon: AppAssets.cbcFinance, bankCode: "7667",),
  BankIcon(icon: AppAssets.cCredit, bankCode:"6870",),
  BankIcon(icon: AppAssets.centralFplc, bankCode: "7825",),
  BankIcon(icon: AppAssets.citiBank, bankCode: "7047",),
  BankIcon(icon: AppAssets.deutscheBank, bankCode: "7205",),
  BankIcon(icon: AppAssets.dialogFinance, bankCode: "7995",),
  BankIcon(icon: AppAssets.habibBank, bankCode: "7074",),
  BankIcon(icon: AppAssets.indianBank, bankCode: "7108",),
  BankIcon(icon: AppAssets.indianoBank, bankCode: "7117",),
  BankIcon(icon: AppAssets.lbFinance, bankCode: "7773",),
  BankIcon(icon: AppAssets.lolcFinance, bankCode: "7861",),
  BankIcon(icon: AppAssets.mcbBank, bankCode: "7269",),
  BankIcon(icon: AppAssets.merchantBankFinance, bankCode: "7898",),
  BankIcon(icon: AppAssets.mercantileInvenstment, bankCode: "7913",),
  BankIcon(icon: AppAssets.peopleLeasingFinance, bankCode: "7922",),
  BankIcon(icon: AppAssets.rdBank, bankCode: "7755",),
  BankIcon(icon: AppAssets.sanasaBank, bankCode: "7728",),
  BankIcon(icon: AppAssets.sarvodhaya, bankCode:"7931",),
  BankIcon(icon: AppAssets.sbi, bankCode: "7144",),
  BankIcon(icon: AppAssets.singerFinance, bankCode: "7630",),
  BankIcon(icon: AppAssets.softlogicFinance, bankCode: "7603",),
  BankIcon(icon: AppAssets.valibleFinance, bankCode: "7816",),
  BankIcon(icon: AppAssets.publicBank, bankCode: "7296",),
  BankIcon(icon: AppAssets.hdfcBank, bankCode: "7737",),
  ];




///bankDataList
// List<BankDataList>? bankDataList;

// GetHomeDetailsResponse? getDetails;
// RetrieveProfileImageResponse? getImageData;
