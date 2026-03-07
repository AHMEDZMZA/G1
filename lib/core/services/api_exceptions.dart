import 'package:dio/dio.dart';
import 'api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    if (data is Map<String, dynamic> && data['message'] != null) {
      return ApiError(message: data['message'], statusCode: statusCode);
    }
    // if (statusCode == 302) {
    //   return ApiError(
    //     message: "The email Already exists in the system.",
    //   );
    // }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: "Connection timeout. Please check your internet connection.",
        );

      case DioExceptionType.sendTimeout:
        return ApiError(
          message: "Request timed out while sending data to the server.",
        );

      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Server took too long to respond.");

      case DioExceptionType.badCertificate:
        return ApiError(
          message: "Bad SSL certificate. Please contact support.",
        );

      case DioExceptionType.cancel:
        return ApiError(
          message: "Request was cancelled before completion, please try again",
        );

      case DioExceptionType.connectionError:
        return ApiError(
          message: "Network connection error. Please check your internet.",
        );

      case DioExceptionType.unknown:
        return ApiError(
          message: "An unknown error occurred. Please try again.",
        );
      default:
        return ApiError(
          message: "An unknown error occurred. Please try again.",
        );
    }
  }
}
