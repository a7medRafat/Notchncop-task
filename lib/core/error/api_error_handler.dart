import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return 'check_internet';
        case DioExceptionType.cancel:
          return 'cancel_request';
        case DioExceptionType.connectionTimeout:
          return 'connectionTimeout';
        case DioExceptionType.unknown:
          return 'check_internet';
        case DioExceptionType.receiveTimeout:
          return 'receiveTimeout';

        case DioExceptionType.sendTimeout:
          return 'sendTimeout';
        default:
          return 'server_error';
      }
    } else {
      return 'server_error';
    }
  }
}
