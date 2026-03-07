import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/product/data/product_details_model.dart';

class ProductDetailsRepo {
  //   final ApiService _apiService = ApiService();

  //   Future<ProductDetailsModel> getProductDetails(int productId) async {
  //     final response = await _apiService.get(
  //       '/api/Product/GetProductDetailsById',
  //       {'id': productId},
  //     );
  //     if (response is Map<String, dynamic>) {
  //       return ProductDetailsModel.fromJson(response);
  //     }

  //     throw ApiError(message: 'Invalid product details response');
  //   }
  // Future<ProductDetailsModel> getProductDetails(int productId) async {
  //   final ApiService _apiService = ApiService();
  //   final response = await _apiService.get(
  //     '/api/Products/GetProductDetailsById',
  //     {'id': productId},
  //   );

  //   if (response is Map<String, dynamic>) {
  //     final data = response['data'];
  //     if (data != null) {
  //       return ProductDetailsModel.fromJson(data);
  //     }
  //   }

  //   throw ApiError(message: 'Product not found');
  // }
  Future<ProductDetailsModel> getProductDetails(int productId) async {
    final ApiService _apiService = ApiService();
    final response = await _apiService.get(
      '/api/Products/GetProductDetailsById',
      {'id': productId},
    );

    if (response is Map<String, dynamic>) {
      // الحالة 1: response مباشر
      if (response.containsKey('id')) {
        return ProductDetailsModel.fromJson(response);
      }

      // الحالة 2: response جوا data
      if (response.containsKey('data') && response['data'] != null) {
        return ProductDetailsModel.fromJson(response['data']);
      }
    }

    throw ApiError(message: 'Product not found');
  }
}
