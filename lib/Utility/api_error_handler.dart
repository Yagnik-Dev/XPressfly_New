import 'package:dio/dio.dart';
import 'package:xpressfly_git/Utility/app_exceptions.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';

void handleError(error) async {
  bool internetConnectionAvailable = await isInternetConnectivityEnabled();
  String message;

  if (error is DioException) {
    message = DioExceptions.fromDioError(error).toString();

    if (internetConnectionAvailable) {
      internetConnectionAvailable
          ? 'Cannot establish connection. Please check your internet connection and try again.'
          : 'Cannot establish connection. No internet connection available.';
    } else {
      message =
          internetConnectionAvailable
              ? 'An error occurred : $message'
              : 'Connection Lost. No internet connection available.';
    }
  } else {
    message =
        'A response with a status code that is not within the range of inclusive 100 to exclusive 600 is a non-standard response, possibly due to the server\'s software';
  }
}
