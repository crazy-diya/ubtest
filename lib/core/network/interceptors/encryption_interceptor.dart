import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:union_bank_mobile/core/configurations/app_config.dart';
import 'package:union_bank_mobile/core/encryption/encryptor.dart';
import 'package:union_bank_mobile/core/network/interceptors/not_encrypted_apis.dart';
import 'package:union_bank_mobile/utils/app_sync_data.dart';


class EncryptInterceptor extends Interceptor {
  final AppSyncData? appSyncData;
  final Encrypt? encrypt;
  EncryptInterceptor({
    this.appSyncData,
    this.encrypt,
  });

  @override
  Future<void> onRequest(options, handler) async {
    log(options.path);
    if (AppConfig.isEncryptionAvailable) {
      if (NotEncryptedApi.notEncryptedApis.contains(options.path)) {
        options.contentType = 'application/json';
        options.headers['GHOSTID'] = appSyncData!.getGhostId();
        return handler.next(options);
      } else {
        options.contentType = 'text/plain';
        options.responseType = ResponseType.plain;
        options.headers['GHOSTID'] = appSyncData!.getGhostId();
        final jsonBody = json.encode(options.data);
        final encBody = encrypt!.encryptData(encryptData: jsonBody);
        options.data = encBody;
        log(encBody);
        return handler.next(options);
      }
    } else {
      options.contentType = 'application/json';
      return handler.next(options);
    }
  }

  @override
  void onResponse(response, handler) {
    if (AppConfig.isEncryptionAvailable) {
      if (NotEncryptedApi.notEncryptedApis.contains(response.requestOptions.path)) {
        return handler.next(response);
      } else {
        final decBody = encrypt!.decryptData(decryptingData: response.data ?? "");
        final jsonBody = jsonDecode(decBody);
        response.data = jsonBody;
        return handler.next(response);
      }
    } else {
      return handler.next(response);
    }
  }

  @override
  void onError(DioException dioError, handler) {
     if (AppConfig.isEncryptionAvailable) {
      if (NotEncryptedApi.notEncryptedApis.contains(dioError.requestOptions.path)) {
          return handler.next(dioError);
      }else{
        final decBody = encrypt!.decryptData(decryptingData: dioError.response?.data ?? "");
        final jsonBody = jsonDecode(decBody);
        dioError.response?.data = jsonBody;
        return handler.next(dioError);
      }
      }else{
         return handler.next(dioError);
      }
  }
}
