import 'package:dio/dio.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';

import '../../../features/data/models/responses/refresh_token_response.dart';

class TokenInterceptor extends Interceptor {
  final LocalDataSource? localDataSource;
  final Dio? dio;
  TokenInterceptor( { this.localDataSource,this.dio,});

  @override
  Future<void> onRequest(options, handler) async {
     if (AppConstants.IS_USER_LOGGED) {
          // CHECK IF REFRESH TOKEN IS EXPIRED
          if (DateTime.now().isAfter(AppConstants.TOKEN_EXPIRE_TIME) ||
              DateTime.now().isAtSameMomentAs(AppConstants.TOKEN_EXPIRE_TIME)) {
            // REMOVE TOKENS IN STORAGE
            localDataSource?.clearAccessToken();

            if (localDataSource?.getRefreshToken() != null) {
              final tokenResponse = await refreshToken();

              localDataSource?.setAccessToken(tokenResponse.accessToken);
              localDataSource?.setRefreshToken(tokenResponse.refreshToken);
              AppConstants.TOKEN_EXPIRE_TIME = DateTime.now()
                  .add(Duration(seconds: tokenResponse.tokenExpiresIn!));
            }

            final String? accessToken = await localDataSource?.getAccessToken();

            if (accessToken != null && accessToken.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
          } else {
            final String? accessToken = await localDataSource!.getAccessToken();
            if (accessToken != null && accessToken.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
          }
        } else {
       final String? accessToken = await localDataSource!.getAccessToken();
       if (accessToken != null && accessToken.isNotEmpty) {
         options.headers['Authorization'] = 'Bearer $accessToken';
       }
     }
    return handler.next(options);
  }

  @override
  void onResponse(response, handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException dioError, handler) {
    return handler.next(dioError);
  }


Future<RefreshTokenResponse> refreshToken() async {
   try {
      final response =
          await dio!.post('token/api/generateRefreshToken', data: {
        'refreshToken': await localDataSource!.getRefreshToken(),
      });
      return RefreshTokenResponse.fromJson(response.data);
    } on DioException {
      rethrow;
    }
  }

}
