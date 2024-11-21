// ignore_for_file: constant_identifier_names

enum AlertType {
  SUCCESS,
  FAIL,
  WARNING,
  INFO,
  DOCUMENT1,
  DOCUMENT2,
  DOCUMENT3,
  CONNECTION,
  PASSWORD,
  FINGERPRINT,
  FACEID,
  USER1,
  USER2,
  USER3,
  MAIL,
  MOBILE,
  DELETE,
  LANGUAGE,
  MONEY1,
  MONEY2,
  QR,
  TRANSFER,
  SERVER,
  STATEMENT,
  CHECKBOOK,
  SECURITY

}

enum ToastStatus { SUCCESS, FAIL , INFO,WARNING,ERROR}

enum ButtonType { PRIMARYENABLED, PRIMARYDISABLED ,OUTLINEENABLED, OUTLINEDISABLED}
enum DeviceOS { ANDROID, HUAWEI }

enum AppPlatform { MOBILE, WEB }

enum Status { EDIT, ADD, DELETE}

enum SecurityFailureType {  
  ADB,
  ROOT,
  JAILBROKEN,
  EMU,
  SECURE,
  SOURCE,
  HOOK,
  DEBUGGER,
  OBFUSCATION,
  BINDING
  }

enum Flavor { DEV, UAT, QA, LIVE,SIT }

enum QuestionComponentType { DATA, EMPTY, BUTTON }

enum IDType { SELFIE, ID_FRONT, ID_BACK }

enum AppButtonStyle { GREYBG, EMPTY }

enum ColorTheme { DARK, LIGHT }

enum CalculatorType { PERSONAL, HOUSING, FIXED, LEASING }

enum LoginMethods { NONE, FINGERPRINT, FACEID }

enum ObType { CAO, NUO, OBO, justPay, JUSTPAY , DO }

enum MigrateUser {PASS,TNC,SECQUE }

enum KYCStep {
  PERSONALINFO,
  CONTACTINFO,
  EMPDETAILS,
  OTHERINFO,
  DOCUMENTVERIFY,
  SCHEDULEVERIFY,
  REVIEW,
  TNC,
  INTERSTEDPROD,
  SECURITYQ,
  CREATEUSER,
  BIOMETRIC
}

enum StepperState { COMPLETED, PENDING, INACTIVE }

enum DocumentImageType {
  SELFIE,
  NICFRONT,
  NICBACK,
  LICENCEFRONT,
  LICENCEBACK,
  PASSPORTFRONT,
  PASSPORTBACK,
  BILLINGPROOF
}

enum AccountType {
  INVESTMENT,
  FIXED_DEPO,
  LOAN,
  CARDS,
  ACCOUNTS,
  SAVING_ACCOUNT,
  LEASE
}

enum FTType { SAVED, UNSAVED, SCHEDULED }

enum ServiceRequestStatus { PENDING, REJECTED, COMPLETED }

enum RequestTypes { ACTIVE, ALL ,complete}

enum ButtonStatus { ENABLE, DISABLE }

enum HttpMethods { POST, PUT, DELETE }

enum Download { PDF, EX, NON }

enum RouteTypes { BILLERMANAGEMENT , SAVEDBILLER}

enum NotificationType {FOREGROUND, BACKGROUND }

enum FtRouteType {
  OWNNOW,
  OWNLATER,
  OWNRECUURING,
  SAVEDNOW,
  SAVEDRECURRING,
  SAVEDLATER,
  NEWNOW,
  NEWLATER,
  NEWRECURRING
}

enum BPRouteType {
  NOW,
  LATER,
  RECUURING,
}

enum JustPayState{
  INIT,
  DRAFT,
  FINISH,
}
enum ServiceReqType{
  CHEQUE,
  STATEMENT,
}

enum OnboardingType {
  DEBIT,
  BANK,
}

enum RequestCallBack {
  COMPLETED,
  CANCELED,
  REJECTED,
  INPROGRESS,
  NOTSTARTED,
  ONHOLD
}

enum CreditCardPaymentType{
  OWN,
  THIRDPARTY
}
