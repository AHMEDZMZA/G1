/// This class ApiError is a custom model created to represent errors that occur when calling an API.
class ApiError {
  final String message;
  final int? statusCode;

  ApiError({required this.message, this.statusCode});

  @override
  String toString() {
    return message;
  }
}
