import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../config/env.dart';

class DioFactory {
  DioFactory._();

  static Dio? _tmdbDio;

  static Dio getTmdbDio() {
    return _tmdbDio ??= _createTmdbDio();
  }

  static Dio getDio() => getTmdbDio();

  static Dio _createTmdbDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 30),
        headers: _tmdbHeaders(),
        followRedirects: false,
        validateStatus: (status) =>
            status != null && status >= 200 && status < 300,
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }

  static Map<String, dynamic> _tmdbHeaders() => <String, dynamic>{
    'Authorization': Env.authorizationHeaderValue,
    'accept': 'application/json',
    'Accept-Language': 'en-US',
  };
}
