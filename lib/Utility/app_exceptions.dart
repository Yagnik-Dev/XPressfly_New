import 'dart:convert';

import 'package:dio/dio.dart';

// This is use for DIO HTTP API REQUEST

class DioExceptions implements Exception {
  String? strMessage;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        strMessage = 'Request was cancelled';
        break;
      case DioExceptionType.connectionTimeout:
        strMessage = 'Connection timeout';
        break;
      case DioExceptionType.unknown:
        strMessage = 'An error occurred';
        break;
      case DioExceptionType.receiveTimeout:
        strMessage = 'Receive timeout in connection';
        break;
      case DioExceptionType.badResponse:
        strMessage = _handleError(
          dioError.response!.statusCode ?? 0,
          dioError.response!.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        strMessage = 'Send timeout in connection';
        break;
      default:
        strMessage = 'An unexpected error occurred';
        break;
    }
  }

  String _handleError(int statusCode, dynamic error) {
    Map<String, dynamic> valueMap = json.decode(error);
    var localError = LocalError.fromJson(valueMap);

    switch (statusCode) {
      case 400:
        return localError.description.toString();
      case 401:
        {
          return 'Unauthorized - The request was a legal request, but the server is refusing to respond to it.';
        }
      case 403:
        return 'The request was a legal request, but the server is refusing to respond to it';
      case 404:
        return 'The requested page could not be found but may be available again in the future';
      case 405:
        return 'A request was made of a page using a request method not supported by that page';
      case 415:
        return 'The server will not accept the request, because the media type is not supported';
      case 500:
        return 'Server error - the server failed to fulfil an apparently valid request';
      default:
        return 'A response with a status code that is not within the range of inclusive 100 to exclusive 600 is a non-standard response, possibly due to the server\'s software';
    }
  }

  @override
  String toString() => strMessage ?? "";
}

class LocalError {
  final String description;

  LocalError({required this.description});

  factory LocalError.fromJson(Map<String, dynamic> json) {
    return LocalError(description: json['description'] ?? 'Description');
  }
}
