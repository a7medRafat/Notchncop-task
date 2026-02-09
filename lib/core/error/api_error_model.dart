import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/core/functions/print_functions.dart';

part 'api_error_model.g.dart';

abstract class BaseErrorModel implements Exception {
  final dynamic message;
  final int? code;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final StackTrace trace;

  BaseErrorModel({this.message, this.code, StackTrace? trace})
    : trace = trace ?? StackTrace.current {
    printError(toString(), trace: this.trace);
  }

  @override
  String toString() => 'Error: $message (code: $code)';
}

@JsonSerializable()
class ApiErrorModel extends BaseErrorModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final DioException? dioException;

  ApiErrorModel({super.message, super.code, super.trace, this.dioException});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  @override
  String toString() {
    try {
      if (dioException != null) {
        return formatError(dioException);
      }

      return 'ApiErrorModel(message: $message, code: $code)';
    } catch (e) {
      return 'ApiErrorModel(message: ${message.toString()}, code: $code)';
    }
  }

  /// ✅ Unified error message (prefer parsed Dio message)
  @override
  dynamic get message => _parsedMessage ?? super.message;

  @override
  int? get code => super.code ?? dioException?.response?.statusCode;

  String? get endpoint => dioException?.requestOptions.path;

  dynamic get body => dioException?.requestOptions.data;

  Map<String, dynamic>? get query =>
      dioException?.requestOptions.queryParameters;

  dynamic get response => dioException?.response?.data;

  /// Optional: structured list of errors (for form validation display)
  Map<String, List<String>>? get errorMap {
    final data = dioException?.response?.data;
    final errors = data is Map<String, dynamic> ? data['errors'] : null;
    if (errors is Map<String, dynamic>) {
      return errors.map((k, v) => MapEntry(k, List<String>.from(v ?? [])));
    }
    return null;
  }

  String? get _parsedMessage {
    final data = dioException?.response?.data;

    if (data is Map<String, dynamic>) {
      final msg =
          data['data']?['message'] ??
          data['message'] ??
          data['error'] ??
          data['msg'];
      if (msg is String && msg.isNotEmpty) return msg;

      final errors = data['errors'];
      if (errors is Map<String, dynamic> && errors.isNotEmpty) {
        for (final value in errors.values) {
          if (value is List && value.isNotEmpty) {
            final first = value.first.toString().trim();
            if (first.isNotEmpty) return first;
          } else if (value is String && value.isNotEmpty) {
            return value.trim();
          }
        }
      }
    }

    final rawMessage = dioException?.message ?? super.message?.toString();
    if (rawMessage != null &&
        rawMessage.contains('(and') &&
        rawMessage.contains('error)')) {
      return rawMessage.replaceAll(RegExp(r'\(and.+error\)'), '').trim();
    }

    return rawMessage;
  }
}

@JsonSerializable()
class GenericErrorModel extends BaseErrorModel {
  GenericErrorModel({super.message, super.code, super.trace});
}
