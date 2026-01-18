import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/api_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';

const int timeOutDuration = 20;

class ServiceCall {
  // static final ServiceCall _instance = ServiceCall._internal();
  // late Dio _dio;
  // late Dio _dioNoAuth;

  // factory ServiceCall() {
  //   return _instance;
  // }

  // ServiceCall._internal() {
  //   _dio = Dio(
  //     BaseOptions(
  //       connectTimeout: const Duration(seconds: timeOutDuration),
  //       receiveTimeout: const Duration(seconds: timeOutDuration),
  //     ),
  //   );

  //   // Add interceptors
  //   _dio.interceptors.add(
  //     InterceptorsWrapper(
  //       onRequest: (options, handler) {
  //         // Add access token to every request
  //         final token = GetStorage().read(accessToken);
  //         if (token != null) {
  //           options.headers['Authorization'] = token;
  //         }
  //         return handler.next(options);
  //       },
  //       onError: (DioException error, handler) async {
  //         // Handle 401 errors (Unauthorized)
  //         if (error.response?.statusCode == 401) {
  //           // Try to refresh token
  //           final newToken = await _refreshAccessToken();

  //           if (newToken != null) {
  //             // Retry the original request with new token
  //             error.requestOptions.headers['Authorization'] = newToken;

  //             try {
  //               final response = await _dio.fetch(error.requestOptions);
  //               return handler.resolve(response);
  //             } catch (e) {
  //               return handler.reject(error);
  //             }
  //           } else {
  //             // Refresh failed, logout user
  //             _handleTokenExpiration();
  //             return handler.reject(error);
  //           }
  //         }
  //         return handler.next(error);
  //       },
  //     ),
  //   );
  // }
  static final ServiceCall _instance = ServiceCall._internal();
  late Dio _dio;
  late Dio _dioNoAuth; // New: Dio instance without auth interceptor

  factory ServiceCall() {
    return _instance;
  }

  ServiceCall._internal() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: timeOutDuration),
        receiveTimeout: const Duration(seconds: timeOutDuration),
      ),
    );

    // Add interceptors to authenticated Dio
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = GetStorage().read(accessToken);
          if (token != null) {
            options.headers['Authorization'] = token;
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            final newToken = await _refreshAccessToken();

            if (newToken != null) {
              error.requestOptions.headers['Authorization'] = newToken;

              try {
                final response = await _dio.fetch(error.requestOptions);
                return handler.resolve(response);
              } catch (e) {
                return handler.reject(error);
              }
            } else {
              _handleTokenExpiration();
              return handler.reject(error);
            }
          }
          return handler.next(error);
        },
      ),
    );

    // New: Create Dio instance without auth interceptor for public APIs
    _dioNoAuth = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: timeOutDuration),
        receiveTimeout: const Duration(seconds: timeOutDuration),
      ),
    );
  }
  // Refresh access token
  Future<String?> _refreshAccessToken() async {
    try {
      final storedRefreshToken = GetStorage().read(refreshTokenVal);

      if (storedRefreshToken == null) {
        debugPrint('No refresh token found');
        return null;
      }

      debugPrint('Attempting to refresh token...');

      // Create a new Dio instance without interceptors to avoid infinite loop
      final refreshDio = Dio();

      final response = await refreshDio.post(
        ApiConstant.baseUrl + ApiConstant.refreshToken,
        data: {'refresh_token': storedRefreshToken},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;

        final newAccessToken = 'Bearer ${data['access_token']}';
        final newRefreshToken = data['refresh_token'];

        // Store new tokens
        GetStorage().write(accessToken, newAccessToken);
        if (newRefreshToken != null) {
          GetStorage().write(refreshTokenVal, newRefreshToken);
        }

        debugPrint('Token refreshed successfully');
        return newAccessToken;
      }

      return null;
    } catch (e) {
      debugPrint('Error refreshing token: $e');
      return null;
    }
  }

  // Handle token expiration - logout user
  void _handleTokenExpiration() {
    debugPrint('Token expired, logging out user');

    // Clear all storage
    GetStorage().erase();

    // Navigate to login screen
    // Note: You might need to use Get.find or pass context
    // Get.offAllNamed('/login_screen');
  }

  // GET
  Future<dynamic> get(
    String baseUrl,
    String api, [
    dynamic requestheader,
  ]) async {
    var response = await _dio.get(
      baseUrl + api,
      options: Options(
        headers: requestheader,
        responseType: ResponseType.plain,
      ),
    );
    return response.data;
  }

  // Get with query params
  Future<dynamic> getWithQueryParameters(
    String baseUrl,
    String api,
    Map<String, dynamic> queryParameters, [
    dynamic requestheader,
  ]) async {
    var response = await _dio.get(
      baseUrl + api,
      queryParameters: queryParameters,
      options: Options(
        headers: requestheader,
        responseType: ResponseType.plain,
      ),
    );
    return response.data;
  }

  // POST
  Future<dynamic> post(
    String baseUrl,
    String api,
    dynamic params, [
    dynamic requestheader,
  ]) async {
    var response = await _dio.post(
      baseUrl + api,
      data: params,
      options: Options(
        headers: requestheader,
        responseType: ResponseType.plain,
      ),
    );
    debugPrint(response.data);
    return response.data;
  }

  Future<dynamic> postMultipartNoAuth(
    String baseUrl,
    String api,
    dynamic params, [
    dynamic requestheader,
  ]) async {
    try {
      var response = await _dioNoAuth.post(
        baseUrl + api,
        data: params,
        options: Options(
          headers: requestheader,
          responseType: ResponseType.plain,
        ),
      );
      debugPrint('Response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      debugPrint('DioException: ${e.response?.data}');
      rethrow;
    }
  }

  Future<dynamic> postMultipart(
    String baseUrl,
    String api,
    dynamic params, [
    dynamic requestheader,
  ]) async {
    var response = await _dio.post(
      baseUrl + api,
      data: params,
      options: Options(
        headers: requestheader,
        responseType: ResponseType.plain,
      ),
    );
    debugPrint(response.data);
    return response.data;
  }

  // PUT
  Future<dynamic> put(
    String baseUrl,
    String api,
    dynamic params, [
    dynamic requestHeader,
  ]) async {
    var response = await _dio.put(
      baseUrl + api,
      data: params,
      options: Options(
        headers: requestHeader,
        responseType: ResponseType.plain,
      ),
    );
    if ((response.statusCode == 204 && response.data != null) ||
        (response.statusCode == 200 && response.data != null)) {
      return response.toString();
    }
  }

  // ...existing code...

  // PATCH
  Future<dynamic> patch(
    String baseUrl,
    String api,
    dynamic params, [
    dynamic requestHeader,
  ]) async {
    var response = await _dio.patch(
      baseUrl + api,
      data: params,
      options: Options(
        headers: requestHeader,
        responseType: ResponseType.plain,
      ),
    );
    debugPrint(response.data);
    return response.data;
  }

  // DELETE
  Future<dynamic> delete(
    String baseUrl,
    String api, [
    dynamic requestHeader,
  ]) async {
    var response = await _dio.delete(
      baseUrl + api,
      options: Options(
        headers: requestHeader,
        responseType: ResponseType.plain,
      ),
    );
    if ((response.statusCode == 204 && response.data != null) ||
        (response.statusCode == 200 && response.data != null)) {
      return response.toString();
    }
  }

  Future<String?> putMultipart(
    String baseUrl,
    String endPoint,
    FormData formData,
    Map<String, dynamic> headers,
  ) async {
    try {
      var response = await _dio.put(
        '$baseUrl$endPoint',
        data: formData,
        options: Options(headers: headers),
      );
      return response.data.toString();
    } on DioException catch (e) {
      debugPrint('Dio Error: $e');
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<String?> patchMultipart(
    String baseUrl,
    String endPoint,
    FormData formData,
    Map<String, dynamic> headers,
  ) async {
    try {
      var response = await _dio.patch(
        '$baseUrl$endPoint',
        data: formData,
        options: Options(headers: headers),
      );
      return response.data.toString();
    } on DioException catch (e) {
      debugPrint('Dio Error: $e');
      return null;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  // Manual refresh token call (if needed)
  Future<bool> refreshToken() async {
    final newToken = await _refreshAccessToken();
    return newToken != null;
  }
}
