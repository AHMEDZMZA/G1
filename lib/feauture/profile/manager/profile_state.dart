import 'package:graduation2/feauture/profile/data/user_profile_model.dart';

abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}
class UserProfileLoading extends UserProfileState {}
class UserProfileSuccess extends UserProfileState {
  final UserProfileModel profile;
  UserProfileSuccess(this.profile);
}
class UserProfileFailure extends UserProfileState {
  final String message;
  UserProfileFailure(this.message);
}

