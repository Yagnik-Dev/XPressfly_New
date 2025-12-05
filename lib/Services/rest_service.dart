import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const int timeOutDuration = 20;

class ServiceCall {
  // GET
  Future<dynamic> get(
    String baseUrl,
    String api, [
    dynamic requestheader,
  ]) async {
    var response = await Dio()
        .get(
          baseUrl + api,
          options: Options(
            headers: requestheader,
            responseType: ResponseType.plain,
          ),
        )
        .timeout(const Duration(seconds: timeOutDuration));
    return response.data;
  }

  // Get with query params
  Future<dynamic> getWithQueryParameters(
    String baseUrl,
    String api,
    Map<String, dynamic> queryParameters, [
    dynamic requestheader,
  ]) async {
    var response = await Dio()
        .get(
          baseUrl + api,
          queryParameters: queryParameters,
          options: Options(
            headers: requestheader,
            responseType: ResponseType.plain,
          ),
        )
        .timeout(const Duration(seconds: timeOutDuration));
    return response.data;
  }

  // POST
  Future<dynamic> post(
    String baseUrl,
    String api,
    dynamic params, [
    dynamic requestheader,
  ]) async {
    // var res = jsonEncode(params);
    var response = await Dio()
        .post(
          baseUrl + api,
          data: params,
          options: Options(
            headers: requestheader,
            responseType: ResponseType.plain,
          ),
        )
        .timeout(const Duration(seconds: timeOutDuration));
    // debugPrint("request body $res");
    debugPrint(response.data);
    return response.data;
  }

  Future<dynamic> postMultipart(
    String baseUrl,
    String api,
    dynamic params, [
    dynamic requestheader,
  ]) async {
    var response = await Dio()
        .post(
          baseUrl + api,
          data: params,
          options: Options(
            headers: requestheader,
            responseType: ResponseType.plain,
          ),
        )
        .timeout(const Duration(seconds: timeOutDuration));
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
    var response = await Dio()
        .put(
          baseUrl + api,
          data: params,
          options: Options(
            headers: requestHeader,
            responseType: ResponseType.plain,
          ),
        )
        .timeout(const Duration(seconds: timeOutDuration));
    if ((response.statusCode == 204 && response.data != null) ||
        (response.statusCode == 200 && response.data != null)) {
      return response.toString();
    }
  }

  // DELETE
  Future<dynamic> delete(
    String baseUrl,
    String api, [
    dynamic requestHeader,
  ]) async {
    var response = await Dio()
        .delete(
          baseUrl + api,
          // data: params,
          options: Options(
            headers: requestHeader,
            responseType: ResponseType.plain,
          ),
        )
        .timeout(const Duration(seconds: timeOutDuration));
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
      var response = await Dio().put(
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
}
