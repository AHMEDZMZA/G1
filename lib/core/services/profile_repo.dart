// import 'package:graduation2/core/const/api_endpoint.dart';
// import 'package:graduation2/core/services/api_error.dart';
// import 'package:graduation2/core/services/api_services.dart';
// import 'package:graduation2/feauture/expert_profile/data/user_profile_model.dart';

// class ProfileRepo {
//   final ApiService _apiService = ApiService();

//   Future<dynamic> getUserProfile() async {
//     final result = await _apiService.get(
//       ApiEndpoint.userProfile,
//       null,
//     );

//     if (result is ApiError) return result;
//     return UserProfileModel.fromJson(result);
//   }
// }
