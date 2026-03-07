import '../data/user_model.dart';

sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final UserModel user;
  

  AuthSuccessState(this.user);
}

final class AuthFailureState extends AuthState {
  final String errorMessage;
  AuthFailureState(this.errorMessage);
}

// OTP
class VerifyEmailSuccessState extends AuthState {
  final String email;
  VerifyEmailSuccessState(this.email);
}

class CheckOtpSuccessState extends AuthState {}

