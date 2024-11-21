import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter_udid/flutter_udid.dart';
// import 'package:open_document/my_files/init.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:union_bank_mobile/core/configurations/app_config.dart';
import 'package:union_bank_mobile/core/encryption/encryptor.dart';
import 'package:union_bank_mobile/core/network/certificates.dart';
import 'package:union_bank_mobile/core/network/interceptors/encryption_interceptor.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/utils/extension.dart';

import '../../error/exceptions.dart' as exe;
import '../../error/messages.dart';
import '../../features/data/models/common/base_request.dart';
import '../../features/data/models/responses/error_response_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_sync_data.dart';
import '../../utils/device_data.dart';
import '../../utils/enums.dart';
import 'interceptors/token_interceptor.dart';
import 'network_config.dart';
// import 'package:sentry_dio/sentry_dio.dart';

class APIHelper {
  final Dio? dio;
  final AppSyncData? appSyncData;
  final LocalDataSource? localDataSource;
  String? deviceId;
  String? request;
  final DeviceData? deviceData;
  final Encrypt encrypt;

  APIHelper( 
      {required this.dio,
      required this.deviceData,
      required this.appSyncData,
      required this.localDataSource,required this.encrypt,}) {
    _initApiClient();
  }

  Future<void> _initApiClient() async {
    final logInterceptor = LogInterceptor()
      ..responseHeader = true
      ..requestHeader = true;

    final BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: kConnectionTimeout),
      receiveTimeout: const Duration(seconds: kReceiveTimeout),
      persistentConnection: true,
      baseUrl: NetworkConfig.getNetworkUrl(),
      headers: {
        'x-api-key': NetworkConfig.getToken(),
      },
    );

    dio
      ?..options = options
      ..interceptors.add(TokenInterceptor(localDataSource: localDataSource,dio: dio))
       ..interceptors.add(EncryptInterceptor(appSyncData: appSyncData,encrypt: encrypt))
      ..interceptors.add(logInterceptor);
      if(!AppConfig.isHttpOverride){
        dio
      ?..options = options
      ..httpClientAdapter =
          Http2Adapter(ConnectionManager(idleTimeout: Duration(seconds: 15),),
              fallbackAdapter: IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.badCertificateCallback = (X509Certificate cert, String host, int port) {
            log( cert.endValidity.isAfter(DateTime.now()).toString());
            if (AppConfig.isSSLAvailable) {
              return isTrustedCertificate(cert,host);
            } else {
              return true;
            }
          };
          return client;
          
        },validateCertificate: (cert, host, port) {
          if (AppConfig.isSSLAvailable) {
            return isTrustedCertificate(cert,host);
            } else {
              return true;
            }
        },
      ));
      }
  }


  Future<dynamic> get(String url) async {
    try {
      final response = await dio!.get(NetworkConfig.getNetworkUrl() + url);
      _printDecodedData(response.data);
      return response.data;
    } on DioException catch (e) {
      log('[API Helper - GET] Connection Exception => ${e.message}');

      if (e.response != null) {
        final int statusCode = e.response!.statusCode!;

        if (statusCode < 200 || statusCode > 400) {
          switch (statusCode) {
            case 401:
              throw exe.UnAuthorizedException(
                  ErrorResponseModel.fromJson(e.response?.data));
            case 403:
              throw exe.UnAuthorizedException(
                  ErrorResponseModel.fromJson(e.response?.data));
            case 404:
              throw exe.ServerException(ErrorResponseModel(
                  errorDescription: ErrorHandler.errorSomethingWentWrong));
            case 500:
            default:
              throw exe.DioException(
                  errorResponseModel: ErrorResponseModel(
                      errorCode: e.response?.statusCode.toString(),
                      errorDescription: e.response?.statusMessage));
          }
        }
      } else {
        throw exe.ServerException(ErrorResponseModel(
            errorDescription: ErrorHandler().handleDioError(e)));
      }
    }
  }

  Future<dynamic> delete(String url,
      {Map? headers,
      required body,
      encoding,
      isKeyExchangeRequest = false,
      HttpMethods httpMethod = HttpMethods.DELETE}) async {
    assert(body != null);

    try {
      final Map<String, dynamic> bodyData =
          await _generateBaseRequestData(body);

      log('[API Helper - DELETE] Request Body => ${bodyData.toString()}');

      final response = await dio!.delete(url,
          data: bodyData,
          options: Options(headers: headers as Map<String, dynamic>?));
      if (response.headers["token"] != null) {}

      if (response.data == "") {
        throw exe.ServerException(ErrorResponseModel(
            errorDescription: ErrorHandler.errorSomethingWentWrong));
      } else {
        _printDecodedData(response.data);
        return response.data;
      }
    } on DioException catch (e) {
      log('[API Helper - DELETE] Connection Exception => ${e.message}');

      if (e.response != null) {
        final int statusCode = e.response!.statusCode!;

        if (statusCode < 200 || statusCode >= 400) {
          if (statusCode >= 400 && statusCode <= 499) {
            if (e.response!.data != null) {
              log(
                  '[API Helper - DELETE] Connection Exception => ${e.response?.data}');
              throw exe.ServerException(ErrorResponseModel(
                  errorCode: e.response?.data["errorCode"],
                  errorDescription: e.response?.data["errorDescription"]));
            } else {
              throw exe.ServerException(ErrorResponseModel(
                  errorDescription: ErrorHandler.errorSomethingWentWrong));
            }
          } else {
            if (e.response!.data != null) {
              throw exe.DioException(
                  errorResponseModel: ErrorResponseModel(
                      errorCode: e.response?.statusCode.toString(),
                      errorDescription: e.response?.statusMessage));
            } else {
              throw exe.ServerException(ErrorResponseModel(
                  errorDescription: ErrorHandler.errorSomethingWentWrong));
            }
          }
        } else {
          if (e.response?.statusCode == 307 || e.response?.statusCode == 308) {
            return e.response?.data;
          }
        }
      } else {
        throw exe.ServerException(ErrorResponseModel(
            errorDescription: ErrorHandler().handleDioError(e)));
      }
    }
  }

  Future<dynamic> post(
    String url, {
    Map? headers,
    required body,
    encoding,
    isKeyExchangeRequest = false,
  }) async {
    assert(body != null);

    try {
      final Map<String, dynamic> bodyData =
          await _generateBaseRequestData(body);

      final requestBody =
          Response(data: bodyData, requestOptions: RequestOptions());

      log('[API Helper - POST] Request Body => ${requestBody.toString()}');

      final response = await dio?.post(url,
          data: bodyData,
          options: Options(headers: headers as Map<String, dynamic>?));

      

      if (response?.data == "" || response?.data == null) {

        throw exe.ServerException(ErrorResponseModel(
            errorDescription: ErrorHandler.errorSomethingWentWrong));
      } else {
        log('[API Helper - POST] Response Body => ${response.toString()}');
        return response?.data;
      }
    } on DioException catch (e) {

      log('[API Helper - POST] Connection Exception => ${e.message}');

      if (e.response != null) {
        final int statusCode = e.response!.statusCode!;

        if (statusCode < 200 || statusCode >= 400) {
          if (statusCode >= 400 && statusCode <= 499) {
            if (e.response!.data != null) {
              log('[API Helper - POST] Connection Exception => ${e.response?.data}');
              if (statusCode == 401) {
                throw exe.UnAuthorizedException(
                    ErrorResponseModel.fromJson(e.response?.data));
              } else if(statusCode == 403){
                throw exe.SessionExpireException(
                      ErrorResponseModel.fromJson(e.response?.data));
              } else if (statusCode == 404) {
                throw exe.ServerException(ErrorResponseModel(
                    errorDescription: ErrorHandler.errorSomethingWentWrong));
              } else {
                throw exe.ServerException(ErrorResponseModel(
                    errorCode: e.response?.data["errorCode"],
                    errorDescription: e.response?.data["errorDescription"]));
              }
            } else {
              throw exe.ServerException(ErrorResponseModel(
                  errorDescription: ErrorHandler.errorSomethingWentWrong));
            }
          } else {
            if (e.response!.data != null) {
              if (statusCode == 503) {
                log('[API Helper - POST] Connection Exception => ${e.response?.data}');
                throw exe.ServerException(ErrorResponseModel(
                    errorDescription: ErrorHandler.errorSomethingWentWrong));
              } else {
                log('[API Helper - POST] Connection Exception => ${e.response?.data}');
                throw exe.ServerException(ErrorResponseModel(
                    errorCode: e.response!.statusCode.toString(),
                    errorDescription: e.response!.data["errorDescription"]));
              }
            } else {
              log('[API Helper - POST] Connection Exception => ${e.response?.data}');
              throw exe.ServerException(ErrorResponseModel(
                  errorDescription: ErrorHandler.errorSomethingWentWrong));
            }
          }
        } else if (e.response?.statusCode == 307 ||
            e.response?.statusCode == 308) {
          log('[API Helper - POST] Response Body => ${e.response.toString()}');
          return e.response?.data;
        } else {
          log('[API Helper - POST] Response Body => ${e.response.toString()}');
          throw exe.ServerException(ErrorResponseModel(
              errorDescription: ErrorHandler.errorSomethingWentWrong));
        }
      } else {
        log('[API Helper - POST] Response Body => ${e.response.toString()}');
         throw exe.ServerException(ErrorResponseModel(
            errorDescription: ErrorHandler().handleDioError(e)));
      }
    } finally {
    }
  }

  Future<dynamic> put(String url,
      {Map? headers,
      required body,
      encoding,
      isKeyExchangeRequest = false,
      HttpMethods httpMethod = HttpMethods.PUT}) async {
    assert(body != null);


    try {
      final Map<String, dynamic> bodyData =
          await _generateBaseRequestData(body);

      final requestBody =
          Response(data: bodyData, requestOptions: RequestOptions());

      log('[API Helper - PUT] Request Body => ${requestBody.toString()}');

      final response = await dio?.put(url,
          data: bodyData,
          options: Options(headers: headers as Map<String, dynamic>?));

      

      if (response?.data == "" || response?.data == null) {
        throw exe.ServerException(ErrorResponseModel(
            errorDescription: ErrorHandler.errorSomethingWentWrong));
      } else {
        log('[API Helper - PUT] Response Body => ${response.toString()}');
        return response?.data;
      }
    } on DioException catch (e) {

      log('[API Helper - PUT] Connection Exception => ${e.message}');

      if (e.response != null) {
        final int statusCode = e.response!.statusCode!;

        if (statusCode < 200 || statusCode >= 400) {
          if (statusCode >= 400 && statusCode <= 499) {
            if (e.response!.data != null) {
              log('[API Helper - PUT] Connection Exception => ${e.response?.data}');
              if (statusCode == 401) {
                throw exe.UnAuthorizedException(
                    ErrorResponseModel.fromJson(e.response?.data));
              } else if(statusCode == 403){
                throw exe.SessionExpireException(
                      ErrorResponseModel.fromJson(e.response?.data));
              } else if (statusCode == 404) {
                throw exe.ServerException(ErrorResponseModel(
                    errorDescription: ErrorHandler.errorSomethingWentWrong));
              } else {
                throw exe.ServerException(ErrorResponseModel(
                    errorCode: e.response?.data["errorCode"],
                    errorDescription: e.response?.data["errorDescription"]));
              }
            } else {
              throw exe.ServerException(ErrorResponseModel(
                  errorDescription: ErrorHandler.errorSomethingWentWrong));
            }
          } else {
            if (e.response?.data != null) {
              if (statusCode == 503) {
                throw exe.ServerException(ErrorResponseModel(
                    errorDescription: ErrorHandler.errorSomethingWentWrong));
              } else {
                throw exe.ServerException(ErrorResponseModel(
                    errorCode: e.response?.statusCode.toString(),
                    errorDescription: e.response?.data["errorDescription"]));
              }
            } else {
              throw exe.ServerException(ErrorResponseModel(
                  errorDescription: ErrorHandler.errorSomethingWentWrong));
            }
          }
        } else if (e.response?.statusCode == 307 || e.response?.statusCode == 308) {
          return e.response?.data;
        }  else {
          throw exe.ServerException(ErrorResponseModel(
              errorDescription: ErrorHandler.errorSomethingWentWrong));
        }
      } else {
         throw exe.ServerException(ErrorResponseModel(
            errorDescription: ErrorHandler().handleDioError(e)));
      }
    } finally {
    }
  }

  void _printDecodedData(Map<String, dynamic>? map) {
    try {
      log("[API Helper] ${json.encode(map)}\n\n");
    } catch (e) {
      log("[API Helper] ${e.toString()}\n\n");
    }
  }

  Future<Map<String, dynamic>> _generateBaseRequestData(
      Map<String, dynamic> body) async {
    final deviceInfo = await deviceData!.getDeviceData();

    final deviceInfoString = jsonEncode(deviceInfo);

    final BaseRequest baseRequest = BaseRequest();
    // App Sync Data
    baseRequest.appId = appSyncData!.getAppId();
    baseRequest.appTransId = appSyncData!.appTransId;
    baseRequest.epicTransId = appSyncData!.epicTransId;
    baseRequest.ghostId = appSyncData!.getGhostId();
    baseRequest.epicUserId = appSyncData!.getEpicUserId();
    baseRequest.deviceId = await FlutterUdid.consistentUdid;

    // App Constant Data
    baseRequest.appMaxTimeout = kAppMaxTimeout;
    baseRequest.appReferenceNumber = kReferenceNumber;

    baseRequest.deviceChannel = kDeviceChannel;
    baseRequest.messageVersion = kMessageVersion;

    //App Device Info
    baseRequest.deviceInfo = deviceInfoString.toBase64();

    //Timestamp
    baseRequest.timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    baseRequest.isMigrated = appSyncData?.getIsMigrated();

    
    // 2024-03-22 10:20:24.120000"

    body.addAll(baseRequest.toJson());

    return body;
  }
}
