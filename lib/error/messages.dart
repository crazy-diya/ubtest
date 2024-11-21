import 'package:dio/dio.dart';

import 'failures.dart';

class ErrorHandler {
  ///error_title
  static const String TITLE_UBGO = "UBgo";
  static const String TITLE_ERROR = "error";
  static const String TITLE_OOPS = "Oops!";
  static const String TITLE_SUCCESS = "success";
  static const String TITLE_UPDATE = "update";
  static const String TITLE_QUESTION = "confirm";
  static const String TITLE_FAILED = "failed";
  static const String TITLE_SESSION_EXPIRED = "session_expired";
  static const String TITLE_AUTHORIZED_FAILURE = "authorized_failure";


  ///error_messages
  static const String errorSomethingWentWrong = "something_went_wrong";

  ///error_title
  static const String title = "Error";



  String? mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ConnectionFailure:
        return 'unable_to_connect_please_check';
      case ServerFailure:
        return (failure as ServerFailure).errorResponse.errorDescription;
      case AuthorizedFailure:
        return (failure as AuthorizedFailure).errorResponse.errorDescription;
      case SessionExpire:
        return (failure as SessionExpire).errorResponse.errorDescription;
      default:
        return 'something_went_wrong';
    }
  }

String handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return "connection_timed_out";
    case DioExceptionType.sendTimeout:
      return "request_timed_out";
    case DioExceptionType.receiveTimeout:
      return "response_timed_out";
    case DioExceptionType.badResponse:
      return "server_encountered_an_error"; 
    case DioExceptionType.cancel:
      return "request_canceled";
    case DioExceptionType.unknown:
      return "unable_connect_server_des";
    case DioExceptionType.badCertificate:
      return "certificate_is_invalid";
    case DioExceptionType.connectionError:
      return "unable_connect_server_des";
    default:
      return "something_went_wrong";
  }
}
}
