
import '../features/data/models/responses/error_response_model.dart';

class ServerException implements Exception {
  final ErrorResponseModel errorResponseModel;

  ServerException(this.errorResponseModel);
}

class APIFailException implements Exception {
  final ErrorResponseModel errorResponseModel;

  APIFailException(this.errorResponseModel);
}

class CacheException implements Exception {}

class UnAuthorizedException implements Exception {
  final ErrorResponseModel errorResponseModel;

  UnAuthorizedException(this.errorResponseModel);
}

class SessionExpireException implements Exception {
  final ErrorResponseModel errorResponseModel;

  SessionExpireException(this.errorResponseModel);
}

class DioException implements Exception {
  final ErrorResponseModel errorResponseModel;

  DioException({required this.errorResponseModel});
}
