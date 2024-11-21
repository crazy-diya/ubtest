import '../../flavors/flavor_config.dart';

const kConnectionTimeout = 60 * 2;
const kReceiveTimeout = 60 * 2;

class IPAddress {
  static const String DEV = '192.168.20.76:8080/';

  ///MAIN SIT ENV
  // static const String SIT = '122.255.17.157:8081/';

  ///MAIN SIT ENV
  static const String SIT = 'ubgoqa.unionb.com/';

  ///COMPLIANCE SIT ENV
  // static const String SIT = 'ubgoqa.unionb.com:8082/';

  ///MAIN UAT ENV
  // static const String UAT = 'ubgouat.unionb.com/';

  ///COMPLIANCE UAT ENV
  static const String UAT = 'ubgouat.unionb.com/UAT/';

  static const String QA = 'epictechdev.com:50228/';
  static const String LIVE = 'www.ubdirect.com:8081/';
}

class ServerProtocol {
  // static const String DEV = 'https://';
  static const String DEV = 'http://';
  static const String SIT = 'https://';
  static const String QA = 'http://';

  // static const String QA = 'https://';
  static const String UAT = 'https://';
  static const String LIVE = 'https://';
}

class ContextRoot {
  static const String DEV = '';
  static const String SIT = '';
  static const String QA = '';
  static const String UAT = '';
  static const String LIVE = '';
}

class NetworkConfig {
  static String getNetworkUrl() {
    String url = _getProtocol() + _getIP() + _getContextRoot();
    return url;
  }

  static String _getContextRoot() {
    if (FlavorConfig.isDevelopment()) {
      return ContextRoot.DEV;
    } else if (FlavorConfig.isQA()) {
      return ContextRoot.QA;
    } else if (FlavorConfig.isUAT()) {
      return ContextRoot.UAT;
    } else if (FlavorConfig.isSIT()) {
      return ContextRoot.SIT;
    } else {
      return ContextRoot.LIVE;
    }
  }

  static String _getProtocol() {
    if (FlavorConfig.isDevelopment()) {
      return ServerProtocol.DEV;
    } else if (FlavorConfig.isQA()) {
      return ServerProtocol.QA;
    } else if (FlavorConfig.isUAT()) {
      return ServerProtocol.UAT;
    } else if (FlavorConfig.isSIT()) {
      return ServerProtocol.SIT;
    } else {
      return ServerProtocol.LIVE;
    }
  }

  static String _getIP() {
    if (FlavorConfig.isDevelopment()) {
      return IPAddress.DEV;
    } else if (FlavorConfig.isQA()) {
      return IPAddress.QA;
    } else if (FlavorConfig.isUAT()) {
      return IPAddress.UAT;
    } else if (FlavorConfig.isSIT()) {
      return IPAddress.SIT;
    } else {
      return IPAddress.LIVE;
    }
  }

  static String getToken() {
    if (FlavorConfig.isDevelopment()) {
      return "yX8e4IujIwuWXGYvposamglY0p5H3pq95iq6zyId";
    } else if (FlavorConfig.isQA()) {
      return "yX8e4IujIwuWXGYvposamglY0p5H3pq95iq6zyId";
    } else if (FlavorConfig.isUAT()) {
      return "yX8e4IujIwuWXGYvposamglY0p5H3pq95iq6zyId";
    } else if (FlavorConfig.isSIT()) {
      return "yX8e4IujIwuWXGYvposamglY0p5H3pq95iq6zyId";
    } else {
      return "yX8e4IujIwuWXGYvposamglY0p5H3pq95iq6zyId";
    }
  }
}

class APIResponse {
  static const String RESPONSE_LOGIN_SUCCESS = "dbp-367";
  static const String RESPONSE_BIOMETRIC_LOGIN_SUCCESS = "dbp-359";

  static const String RESPONSE_CHANGE_PASSWORD_SUCCESS = "dbp-350";

  static const String RESPONSE_M_LOGIN_SUCCESS_PASSWORD_RESET = "dbp-353";
  static const String RESPONSE_M_LOGIN_SUCCESS_PASSWORD_EXPIRED = "dbp-354";
  static const String RESPONSE_M_LOGIN_SUCCESS_NEW_DEVICE = "dbp-352";
  static const String RESPONSE_M_LOGIN_SUCCESS_INACTIVE_DEVICE = "dbp-351";


  static const String RESPONSE_B_LOGIN_SUCCESS_PASSWORD_EXPIRED = "dbp-363";
  static const String RESPONSE_B_LOGIN_SUCCESS_NEW_DEVICE = "dbp-361";
  static const String RESPONSE_B_LOGIN_SUCCESS_INACTIVE_DEVICE = "dbp-360";
  static const String RESPONSE_FORGOT_PWD_INVALID_USERNAME = "507";
  static const String RESPONSE_FORGOT_PWD_INVALID_NIC = "502";
  static const String RESPONSE_FORGOT_PWD_INVALID_SEQ_ANS = "826";

  static const String WRONG_CURRENT_PASSWORD_ERROR_MESSAGE = "813";

  static const String INVALID_CREDENTIALS = "820";
  static const String SERVER_ERROR = "804";
  static const String JDBC_ERROR = "804";


  static const String RESPONSE_B_LOGIN_SUCCESS_PASSWORD_RESET = "dbp-362";
  static const String USER_STATUS_INACTIVE_OR_BLOCKED = "dbp-456";
  static const String LOGIN_SUCCESS_SECURITY_QUESTION = "dbp-457";
  static const String LOGIN_SUCCESS_TANDC = "dbp-458";
  static const String LOGIN_SUCCESS_MIGRATE_USER_PASSWORD_RESET  = "dbp-459";

  //---------------------------------

  static const String SUCCESS = "00";
}
