import '../../utils/enums.dart';

class AppConfig {
  static DeviceOS deviceOS = DeviceOS.ANDROID;

  ///Android Security Config
  static bool isADBCheckAvailable = false;
  static bool isRootCheckAvailable = false;
  static bool isEmulatorCheckAvailable = false;
  static bool isTamperDetection = false;

  ///IOS Security Config
  static bool isCheckJailBroken = false;
  static bool isSimulatorCheckAvailable = false;

  ///Common Security Config
  static bool isSourceVerificationAvailable = false;
  static bool isSSLAvailable = true;
  static bool isScreenShotDisable = false;

  ///Encryption
  static bool isEncryptionAvailable = true;


  ///Analytics
  static bool isAnalyticsEnable = false;
  static bool isCrashlyticsEnable = false;

  ///UNSECURE CONNECTION WITHOUT SSL
  static bool isHttpOverride = false;
}
