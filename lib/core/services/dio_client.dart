// // // This class DioClient is a custom network client built using the dio package.
// // // It’s responsible for handling all HTTP requests (GET, POST, PUT, DELETE, etc.) in a clean and reusable way across the app.
// // //فئة DioClient هي عميل شبكة مخصص مُصمم باستخدام حزمة dio. وهي مسؤولة عن معالجة جميع طلبات HTTP (GET، POST، PUT، DELETE، إلخ) بطريقة سلسة وقابلة لإعادة الاستخدام عبر التطبيق.   //
// //

// import 'dart:developer';
// import 'package:dio/dio.dart';

// import '../utils/pref_helpers.dart';

// class DioClient {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: 'https://craftoriagp.runasp.net',

//       // ممكن الـ API يحتاج followRedirects: false
//       followRedirects: false,
//       validateStatus: (status) {
//         // اقبل أي status code عشان نشوف إيه اللي راجع
//         return status != null && status < 500;
//       },
//     ),
//   );

//   DioClient() {
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           final token = await PrefHelpers.getToken();

//           log('🔹 REQUEST: ${options.method} ${options.path}');
//           log('🔹 Headers: ${options.headers}');
//           log('🔹 Body: ${options.data}');
//           log('🔹 Token: ${token != null ? "✅ Present" : "❌ Missing"}');

//           if (token != null && token.isNotEmpty) {
//             options.headers['Authorization'] = 'Bearer $token';
//           }

//           return handler.next(options);
//         },
//         onResponse: (response, handler) {
//           log('✅ RESPONSE: ${response.statusCode}');
//           log('✅ Data: ${response.data}');
//           log('✅ Headers: ${response.headers}');
//           return handler.next(response);
//         },
//         onError: (error, handler) {
//           log('❌ ERROR: ${error.type}');
//           log('❌ Status Code: ${error.response?.statusCode}');
//           log('❌ Response Data: ${error.response?.data}');
//           log('❌ Message: ${error.message}');
//           return handler.next(error);
//         },
//       ),
//     );
//   }

//   Dio get dio => _dio;
// }



import 'dart:developer';
import 'package:dio/dio.dart';

import '../utils/pref_helpers.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://craftoriagp.runasp.net',
      followRedirects: false,
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get token FIRST, before logging
          final token = await PrefHelpers.getToken();
          
          // Add Authorization header if token exists
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // Now log AFTER adding the header
          log('🔹 REQUEST: ${options.method} ${options.path}');
          log('🔹 Headers: ${options.headers}');
          log('🔹 Body: ${options.data}');
          log('🔹 Token: ${token != null ? "✅ Present" : "❌ Missing"}');

          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('✅ RESPONSE: ${response.statusCode}');
          log('✅ Data: ${response.data}');
          log('✅ Headers: ${response.headers}');
          return handler.next(response);
        },
        onError: (error, handler) {
          log('❌ ERROR: ${error.type}');
          log('❌ Status Code: ${error.response?.statusCode}');
          log('❌ Response Data: ${error.response?.data}');
          log('❌ Message: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}