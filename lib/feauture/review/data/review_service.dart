import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:graduation2/feauture/review/data/add_review_model.dart';
import 'package:graduation2/feauture/review/data/product_review_model.dart';
import 'package:graduation2/feauture/review/data/product_state_model.dart';
import 'package:graduation2/feauture/review/data/review_response.dart';
import 'package:graduation2/feauture/review/data/user_state_model.dart';
import '../../../core/services/api_error.dart';
import '../../../core/services/api_exceptions.dart';
import '../../../core/services/dio_client.dart';

class ReviewApiService {
  final DioClient _dioClient = DioClient();

  Future<ReviewResponse?> addOrUpdateReview(AddReviewRequest request) async {
    try {
      log('📤 Adding / Updating Review');

      final response = await _dioClient.dio.post(
        '/api/Reviews/AddOrUpdateReview',
        data: request.toJson(),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'];
        return ReviewResponse.fromJson(data);
      }

      return null;
    } on DioException catch (e) {
      log('❌ Review Error: ${e.response?.data}');
      throw ApiExceptions.handleError(e);
    } catch (e) {
      log('❌ Unexpected Review Error: $e');
      rethrow;
    }
  }

  Future<List<ProductReviewModel>> getProductReviews(int productId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/Reviews/GetProductReviews',
        queryParameters: {'productId': productId},
      );

      if (response.statusCode == 200 && response.data != null) {
        final List list = response.data['data'];
        return list.map((e) => ProductReviewModel.fromJson(e)).toList();
      }

      return [];
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<ProductStatsModel?> getProductStats(int productId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/Reviews/GetProductStats',
        queryParameters: {'productId': productId},
      );

      if (response.statusCode == 200 && response.data != null) {
        return ProductStatsModel.fromJson(response.data['data']);
      }
      return null;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<UserStateModel?> getUserState(String productId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/Reviews/GetUserStats',
        queryParameters: {'targetUserId': productId},
      );

      if (response.statusCode == 200 && response.data != null) {
        return UserStateModel.fromJson(response.data['data']);
      }
      return null;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
}
