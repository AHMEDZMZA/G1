/*import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../../core/const/api_endpoint.dart';
import '../../../core/services/api_error.dart';
import '../../../core/services/api_services.dart';
import '../../../core/utils/pref_helpers.dart';
import '../data/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiService apiService;

  static const String webClientId =
      '1052119802675-a4v4qpl2k3e51q2a6rckdg3ghvsbte1e.apps.googleusercontent.com';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: webClientId,
  );

  AuthCubit(this.apiService) : super(AuthInitialState());

  // ================= Helpers =================

  Map<String, dynamic>? _parseResponse(dynamic response) {
    if (response == null) return null;

    if (response is Map<String, dynamic>) {
      return response;
    } else if (response is String) {
      try {
        return jsonDecode(response) as Map<String, dynamic>;
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  String? _extractErrorMessage(Map<String, dynamic> jsonData) {
    if (jsonData['success'] == false) {
      if (jsonData['errors'] != null) {
        final errors = jsonData['errors'];
        if (errors is Map<String, dynamic>) {
          if (errors['errorMessage'] != null) {
            return errors['errorMessage'].toString();
          }
          if (errors['message'] != null) {
            return errors['message'].toString();
          }
        }
        if (errors is String) return errors;
      }

      if (jsonData['message'] != null &&
          jsonData['message'] != 'Internal Server Error') {
        return jsonData['message'].toString();
      }
      return 'An error occurred';
    }
    return null;
  }

  Map<String, dynamic>? _extractUserData(Map<String, dynamic> jsonData) {
    if (jsonData.containsKey('data') && jsonData['data'] != null) {
      final data = jsonData['data'];
      if (data is Map<String, dynamic>) return data;
    }
    return jsonData;
  }

  // ================= Register =================

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String gender,
    int? yearsOfExperience,
    List<String>? profileImage,
    List<String>? portfolio,
  }) async {
    emit(AuthLoadingState());

    try {
      final userData = UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        role: role,
        gender: gender,
        yearsOfExperience: yearsOfExperience,
        profileImage: profileImage,
        portfolio: portfolio,
      );

      final response =
      await apiService.post(ApiEndpoint.Register, userData.toJson());

      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      final jsonData = _parseResponse(response);
      final errorMessage =
      jsonData != null ? _extractErrorMessage(jsonData) : null;

      if (errorMessage != null) {
        emit(AuthFailureState(errorMessage));
        return;
      }

      final userMap =
      jsonData != null ? _extractUserData(jsonData) : null;

      emit(AuthSuccessState(
          userMap != null ? UserModel.fromJson(userMap) : userData));
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  Future<void> registerWithFiles({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String gender,
    required int yearsOfExperience,
    List<MultipartFile>? profileImages,
    List<MultipartFile>? portfolioFiles,
  }) async {
    emit(AuthLoadingState());

    try {
      final formData = FormData.fromMap({
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'Password': password,
        'ConfirmPassword': confirmPassword,
        'Role': role,
        'Gender': gender,
        'YearsOfExperience': yearsOfExperience,
        if (profileImages != null) 'ProfileImage': profileImages,
        if (portfolioFiles != null) 'Portfolio': portfolioFiles,
      });

      final response =
      await apiService.post(ApiEndpoint.Register, formData);

      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      final jsonData = _parseResponse(response);
      final errorMessage =
      jsonData != null ? _extractErrorMessage(jsonData) : null;

      if (errorMessage != null) {
        emit(AuthFailureState(errorMessage));
        return;
      }

      emit(AuthSuccessState(UserModel.fromJson(
          _extractUserData(jsonData!)!)));
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  // ================= Login =================

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());

    try {
      final response = await apiService.post(ApiEndpoint.login, {
        'Email': email,
        'Password': password,
      });
      final String? token = response.data['data']['token'];


      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      final jsonData = _parseResponse(response);
      final errorMessage =
      jsonData != null ? _extractErrorMessage(jsonData) : null;

      if (errorMessage != null) {
        emit(AuthFailureState(errorMessage));
        return;
      }

      emit(AuthSuccessState(
          UserModel.fromJson(_extractUserData(jsonData!)!)));
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  // ================= Google Login =================

  Future<void> signInWithGoogle({required String role}) async {
    emit(AuthLoadingState());

    try {
      await _googleSignIn.signOut();
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthInitialState());
        return;
      }


      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        emit(AuthFailureState('Failed to get Google ID Token'));
        return;
      }

      final response = await apiService.post(
        ApiEndpoint.googleLogin,
        {
          'idToken': idToken,
          'role': role,
        },
      );

      final jsonData = _parseResponse(response);
      final errorMessage =
      jsonData != null ? _extractErrorMessage(jsonData) : null;

      if (errorMessage != null) {
        emit(AuthFailureState(errorMessage));
        return;
      }

      emit(AuthSuccessState(
          UserModel.fromJson(_extractUserData(jsonData!)!)));
    } catch (e) {
      emit(AuthFailureState(e.toString()));
    }
  }

  // ================= OTP & Password =================

  Future<void> verifyEmail({required String email}) async {
    emit(AuthLoadingState());

    try {
      final response = await apiService.post(
        ApiEndpoint.verifyEmail,
        {'email': email},
      );

      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      emit(VerifyEmailSuccessState(email));
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  Future<void> checkEmailOtp({
    required String email,
    required String otp,
  }) async {
    emit(AuthLoadingState());

    try {
      final response = await apiService.post(
        ApiEndpoint.verifyotp,
        {'email': email, 'otpCode': otp},
      );

      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      emit(CheckOtpSuccessState());
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  Future<void> forgetPassword({required String email}) async {
    emit(AuthLoadingState());

    try {
      final response = await apiService.post(
        ApiEndpoint.forgetPassword,
        {'email': email},
      );

      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      emit(VerifyEmailSuccessState(email));
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    emit(AuthLoadingState());

    try {
      final response = await apiService.post(
        ApiEndpoint.resetPassword,
        {
          'email': email,
          'otpCode': otp,
          'newPassword': newPassword,
        },
      );

      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      emit(AuthInitialState());
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  // ================= Utils =================

  void logout() => emit(AuthInitialState());
  void resetState() => emit(AuthInitialState());
}
*/
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation2/core/utils/pref_helpers.dart';

import '../../../core/const/api_endpoint.dart';
import '../../../core/services/api_error.dart';
import '../../../core/services/api_services.dart';
import '../../../core/utils/pref_helpers.dart';
import '../data/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiService apiService;

  static const String webClientId =
      '1052119802675-a4v4qpl2k3e51q2a6rckdg3ghvsbte1e.apps.googleusercontent.com';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: webClientId,
  );

  AuthCubit(this.apiService) : super(AuthInitialState());

  // ================= Helpers =================

  Map<String, dynamic>? _parseResponse(dynamic response) {
    if (response == null) return null;

    if (response is Map<String, dynamic>) {
      return response;
    } else if (response is String) {
      try {
        return jsonDecode(response) as Map<String, dynamic>;
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  String? _extractErrorMessage(Map<String, dynamic> jsonData) {
    if (jsonData['success'] == false) {
      if (jsonData['errors'] != null) {
        final errors = jsonData['errors'];
        if (errors is Map<String, dynamic>) {
          if (errors['errorMessage'] != null) {
            return errors['errorMessage'].toString();
          }
          if (errors['message'] != null) {
            return errors['message'].toString();
          }
        }
        if (errors is String) return errors;
      }

      if (jsonData['message'] != null &&
          jsonData['message'] != 'Internal Server Error') {
        return jsonData['message'].toString();
      }
      return 'An error occurred';
    }
    return null;
  }

  Map<String, dynamic>? _extractUserData(Map<String, dynamic> jsonData) {
    if (jsonData.containsKey('data') && jsonData['data'] != null) {
      final data = jsonData['data'];
      if (data is Map<String, dynamic>) return data;
    }
    return jsonData;
  }

  // ================= Register =================

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String gender,
    int? yearsOfExperience,
    List<String>? profileImage,
    List<String>? portfolio,
  }) async {
    emit(AuthLoadingState());

    try {
      final userData = UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        role: role,
        gender: gender,
        yearsOfExperience: yearsOfExperience,
        profileImage: profileImage,
        portfolio: portfolio,
      );

      final response = await apiService.post(
        ApiEndpoint.Register,
        userData.toJson(),
      );

      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      final jsonData = _parseResponse(response);
      final errorMessage = jsonData != null
          ? _extractErrorMessage(jsonData)
          : null;

      if (errorMessage != null) {
        emit(AuthFailureState(errorMessage));
        return;
      }

      final userMap = jsonData != null ? _extractUserData(jsonData) : null;

      emit(
        AuthSuccessState(
          userMap != null ? UserModel.fromJson(userMap) : userData,
        ),
      );
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  Future<void> registerWithFiles({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String gender,
    int? yearsOfExperience,
    List<MultipartFile>? profileImages,
    List<MultipartFile>? portfolioFiles,
  }) async {
    emit(AuthLoadingState());

    try {
      final formData = FormData.fromMap({
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'Password': password,
        'ConfirmPassword': confirmPassword,
        'Role': role,
        'Gender': gender,
        'YearsOfExperience': yearsOfExperience,
        if (profileImages != null) 'ProfileImage': profileImages,
        if (portfolioFiles != null) 'Portfolio': portfolioFiles,
      });

      final response = await apiService.post(ApiEndpoint.Register, formData);

      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      final jsonData = _parseResponse(response);
      final errorMessage = jsonData != null
          ? _extractErrorMessage(jsonData)
          : null;

      if (errorMessage != null) {
        emit(AuthFailureState(errorMessage));
        return;
      }

      emit(AuthSuccessState(UserModel.fromJson(_extractUserData(jsonData!)!)));
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  // ================= Login (FIXED) =================

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());

    try {
      final response = await apiService.post(ApiEndpoint.login, {
        'Email': email,
        'Password': password,
      });

      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      final jsonData = _parseResponse(response);
      final errorMessage = jsonData != null
          ? _extractErrorMessage(jsonData)
          : null;

      if (errorMessage != null) {
        emit(AuthFailureState(errorMessage));
        return;
      }

      // --- الجزء المضاف لحفظ التوكن ---
      final userDataMap = _extractUserData(jsonData!);
      if (userDataMap != null && userDataMap['token'] != null) {
        final token = userDataMap['token'];
        await PrefHelpers.saveToken(token);

        // ✅ ضيفي ده
        final userId = PrefHelpers.extractUserIdFromToken(token);
        if (userId != null) {
          await PrefHelpers.saveUserId(userId);
        }
      }
      // ----------------------------

      emit(AuthSuccessState(UserModel.fromJson(userDataMap!)));
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  // // ================= Login =================

  // Future<void> login({
  //   required String email,
  //   required String password,
  // }) async {
  //   emit(AuthLoadingState());

  //   try {
  //     final response = await apiService.post(ApiEndpoint.login, {
  //       'Email': email,
  //       'Password': password,
  //     });

  //     if (response is ApiError) {
  //       emit(AuthFailureState(response.message));
  //       return;
  //     }

  //     final jsonData = _parseResponse(response);
  //     final errorMessage =
  //     jsonData != null ? _extractErrorMessage(jsonData) : null;

  //     if (errorMessage != null) {
  //       emit(AuthFailureState(errorMessage));
  //       return;
  //     }
  //     /////
  //     final token = response['data']['token'];
  // await PrefHelpers.saveToken(token);
  //     emit(AuthSuccessState(
  //         UserModel.fromJson(_extractUserData(jsonData!)!)));
  //   } catch (e) {
  //     emit(AuthFailureState('Unexpected error: $e'));
  //   }
  // }

  // ================= Google Login =================

  Future<void> signInWithGoogle({required String role}) async {
    emit(AuthLoadingState());

    try {
      await _googleSignIn.signOut();
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthInitialState());
        return;
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        emit(AuthFailureState('Failed to get Google ID Token'));
        return;
      }

      final response = await apiService.post(ApiEndpoint.googleLogin, {
        'idToken': idToken,
        'role': role,
      });

      final jsonData = _parseResponse(response);
      final errorMessage = jsonData != null
          ? _extractErrorMessage(jsonData)
          : null;

      if (errorMessage != null) {
        emit(AuthFailureState(errorMessage));
        return;
      }

      // --- الجزء المضاف لحفظ التوكن ---
      final userDataMap = _extractUserData(jsonData!);
      if (userDataMap != null && userDataMap['token'] != null) {
        await PrefHelpers.saveToken(userDataMap['token']);
      }
      // ----------------------------

      emit(AuthSuccessState(UserModel.fromJson(userDataMap!)));
    } catch (e) {
      emit(AuthFailureState(e.toString()));
    }
  }

  // ================= OTP & Password =================

  // Future<void> verifyEmail({required String email}) async {
  //   emit(AuthLoadingState());

  //   try {
  //     final response = await apiService.post(ApiEndpoint.verifyEmail, {
  //       'email': email,
  //     });

  //     // if (response is ApiError) {
  //     //   emit(AuthFailureState(response.message));
  //     //   return;
  //     // }

  //     emit(VerifyEmailSuccessState(email));
  //   } on ApiError catch (e) {
  //     emit(AuthFailureState(e.message)); // ✅ هياخد رسالة الباك إند الصح
  //   } catch (e) {
  //     emit(AuthFailureState('Unexpected error: $e'));
  //   }
  // }

Future<void> verifyEmail({required String email}) async {
  emit(AuthLoadingState());

  try {
    await apiService.post(
      ApiEndpoint.verifyEmail,
      {'email': email},
    );

    emit(VerifyEmailSuccessState(email));
  } on ApiError catch (e) {
    emit(AuthFailureState(e.message)); // ✅ هنا هتظهر رسالة الباك الصح
  } catch (e) {
    emit(AuthFailureState('Unexpected error: $e'));
  }
}

  Future<void> checkEmailOtp({
    required String email,
    required String otp,
  }) async {
    emit(AuthLoadingState());

    try {
      final response = await apiService.post(ApiEndpoint.checkEmailOtp, {
        'email': email.trim(),
        'otpCode': otp.trim(),
      });

      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      emit(CheckOtpSuccessState());
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  Future<void> forgetPassword({required String email}) async {
    emit(AuthLoadingState());

    try {
      final response = await apiService.post(ApiEndpoint.forgetPassword, {
        'email': email,
      });

      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      emit(VerifyEmailSuccessState(email));
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    emit(AuthLoadingState());

    try {
      final response = await apiService.post(ApiEndpoint.resetPassword, {
        'email': email,
        'otpCode': otp,
        'newPassword': newPassword,
      });

      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      emit(AuthInitialState());
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  // ================= Utils =================

  void logout() async {
    await PrefHelpers.clearToken(); // مسح التوكن عند الخروج
    emit(AuthInitialState());
  }

  void resetState() => emit(AuthInitialState());
}
