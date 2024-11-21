import 'package:uuid/uuid.dart';

import '../features/data/datasources/local_data_source.dart';

class AppSyncData {

  final LocalDataSource? localDataSource;

  AppSyncData({this.localDataSource});

  String _epicTransId = "";
  String _appTransId = "";

  /// EPIC USER ID
  // Get Epic User ID
  String? getEpicUserId() {
    return localDataSource!.getEpicUserIdForDeepLink() ?? localDataSource!.getEpicUserId();
  }

  // Set Epic User ID
  void setEpicUserId(String epicUserId) {
    localDataSource!.setEpicUserId(epicUserId);
  }

  /// APP TRANS ID
  // Set App Trans ID
  set appTransId(String id) => _appTransId = id;

  // Get App Trans Id
  String get appTransId {
    if (_appTransId == "") {
      final String uuid = const Uuid().v4();
      appTransId = uuid;
      return uuid;
    } else {
      return _appTransId;
    }
  }

  /// EPIC TRANS ID
  // Set Epic Trans Id
  set epicTransId(String id) => _epicTransId = id;

  // Get Epic Trans Id
  String get epicTransId {
    // if (_epicTransId == "") {
      final String uuid = const Uuid().v4();
      epicTransId = uuid;
      return uuid;
    // } else {
    //   return _epicTransId;
    // }
  }

  /// APP ID
  // Set App ID
  void setAppId() {
    localDataSource!.setAppID();
  }

  // Get App ID
  String getAppId() {
    final String? appId = localDataSource!.getAppID();
    if (appId == null || appId == "") {
      return localDataSource!.setAppID();
    } else {
      return appId;
    }
  }

  /// GHOST ID
  // Set Ghost Id
  void setGhostId() {
    localDataSource!.setGhostId();
  }

  // Get Ghost Id
  String getGhostId() {
    final String? ghostId = localDataSource!.getGhostId();
    if (ghostId == null || ghostId == "") {
      return localDataSource!.setGhostId();
    } else {
      return ghostId;
    }
  }

   // Get Migrate Flag
  String? getIsMigrated() {
    return localDataSource?.getMigratedFlag()??"";
  }
}
