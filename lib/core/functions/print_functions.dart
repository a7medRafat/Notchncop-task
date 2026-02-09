import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// ANSI color codes
const _reset = '\x1B[0m';
const _green = '\x1B[32m';
const _yellow = '\x1B[33m';
const _red = '\x1B[31m';

/// Truncate long log messages
String _truncateMessage(String message, {int maxLength = 2000}) {
  if (message.length > maxLength) {
    return '${message.substring(0, maxLength - 3)}...';
  }
  return message;
}

/// Generic print with color (debug/profile only)
void _printColored(String message, String color, {StackTrace? trace}) {
  if (kDebugMode) {
    final truncated = _truncateMessage(message);
    final traceMsg = trace != null ? "\nStackTrace: $trace" : "";
    print("$color$truncated$traceMsg$_reset");
  }
}

/// Public APIs

void debugPrintLog(dynamic message, {StackTrace? trace}) =>
    _printColored(message.toString(), _green, trace: trace);

void printWarning(dynamic message, {StackTrace? trace}) =>
    _printColored(message.toString(), _yellow, trace: trace);

String printError(dynamic message, {StackTrace? trace}) {
  final formatted = formatError(message, trace: trace);
  _printColored(formatted, _red);
  return message.toString();
}

/// Error formatter (special handling for Dio)
String formatError(dynamic message, {StackTrace? trace}) {
  final errorDetails = StringBuffer();

  if (message is DioException) {
    final requestOptions = message.requestOptions;

    final body = requestOptions.data is FormData
        ? (requestOptions.data as FormData)
        : requestOptions.data;

    errorDetails
      ..writeln("Endpoint: ${requestOptions.path}")
      ..writeln("Body:\n${const JsonEncoder.withIndent('  ').convert(body)}")
      ..writeln(
          "Query Parameters:\n${const JsonEncoder.withIndent('  ').convert(requestOptions.queryParameters)}")
      ..writeln("Error: ${message.response?.statusCode} (${message.type})")
      ..writeln("Response:\n${message.response?.data}");
  } else {
    errorDetails.writeln("Error: $message");
  }

  if (trace != null) {
    errorDetails.writeln("\nStackTrace:\n$trace");
  }

  return errorDetails.toString();
}
