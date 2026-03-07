import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../core/const/api_endpoint.dart';
import '../../../core/services/api_error.dart';
import '../../../core/services/api_exceptions.dart';
import '../../../core/services/dio_client.dart';
import '../../../core/utils/pref_helpers.dart';


import '../../home/data/model/categories_model_forhome.dart';
import '../data/model/prodect_model_explore.dart';
import '../data/model/create_product_model.dart';
import '../data/model/top_seller_model.dart';
import '../data/model/update_product.dart';

class ProductApiService {
  final DioClient _dioClient = DioClient();

  // 1️⃣ Create Product
  Future<CreateProductResponseModel> createProduct(CreateProductRequestModel model) async {
    final formData = FormData.fromMap({
      'NameEn': model.nameEn,
      'NameAr': model.nameAr,
      'Price': model.price,
      'Quantity': model.quantity,
      'Description': model.description,
      'CategoryId': model.categoryId,
      'ImageFile': await MultipartFile.fromFile(
        model.imageFile,
        filename: model.imageFile.split('/').last,
      ),
      'Tgs': model.tags,
    });

    Response response = await _dioClient.dio.post(
      ApiEndpoint.createProduct,
      data: formData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return CreateProductResponseModel.fromJson(response.data);
    } else {
      throw ApiExceptions.handleError(response.data);
    }
  }
  ///---------------------
  // // 2️⃣ Update Product
  Future<CreateProductResponseModel> updateProduct(UpdateProductRequestModel model) async {
    try {
      final token = await PrefHelpers.getToken();
      String sellerName = model.sellerName ?? '';

      if (sellerName.isEmpty && token != null) {
        final parts = token.split('.');
        final payload = json.decode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
        );
        sellerName = payload['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'] ?? '';
      }

      final map = <String, dynamic>{
        'NameEn': model.nameEn,
        'NameAr': model.nameAr,
        'Price': model.price,
        'Quantity': model.quantity,
        'Description': model.description,
        'CategoryId': model.categoryId,
        'Tgs': model.tags,
        'SellerName': sellerName,
      };
      print('🔍 map keys: ${map.keys.toList()}');
      if (model.imageFile != null) {
        map['ImageFile'] = await MultipartFile.fromFile(
          model.imageFile!,
          filename: model.imageFile!.split('/').last,
        );
      }

      Response response = await _dioClient.dio.put(
        ApiEndpoint.updateProduct,
        queryParameters: {'id': model.id},
        data: FormData.fromMap(map),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreateProductResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      rethrow;
    }
  }
  // 3️⃣ Decode Token
  String _getUserIdFromToken(String token) {
    try {
      final parts = token.split('.');
      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );
      return payload[
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']
          .toString();
    } catch (_) {
      return '';
    }
  }

  // 4️⃣ Get Categories
  Future<List<CategoriesModel>> fetchCategories() async {
    final response = await _dioClient.dio.get(ApiEndpoint.GetAllProdecCategories);

    if (response.data is Map) {
      // ✅ جرب الاتنين capital و small
      final list = response.data['Data'] ?? response.data['data'];
      if (list != null) {
        return (list as List)
            .map((e) => CategoriesModel.fromJson(e))
            .toList();
      }
    }

    if (response.data is List) {
      return (response.data as List)
          .map((e) => CategoriesModel.fromJson(e))
          .toList();
    }

    return [];
  }

  // 5️⃣ Get All Products (Explore)
  Future<List<ProductsModel>> fetchAllProducts() async {
    final response =
    await _dioClient.dio.get(ApiEndpoint.GetAllProdets);

    if (response.data is Map && response.data['data'] != null) {
      return (response.data['data'] as List)
          .map((e) => ProductsModel.fromJson(e))
          .toList();
    }

    if (response.data is List) {
      return (response.data as List)
          .map((e) => ProductsModel.fromJson(e))
          .toList();
    }

    return [];
  }

  // 6️⃣ Get Top Products
  Future<List<ProductsModel>> fetchTopProductsFromApi() async {
    final response =
    await _dioClient.dio.get(ApiEndpoint.get_top_prodects);

    if (response.data is Map && response.data['data'] != null) {
      return (response.data['data'] as List)
          .map((e) => ProductsModel.fromJson(e))
          .toList();
    }

    if (response.data is List) {
      return (response.data as List)
          .map((e) => ProductsModel.fromJson(e))
          .toList();
    }

    return [];
  }
  Future<List<TopSellerModel>> getTopSellers() async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoint.get_top_sellers,
      );

      if (response.data is List) {
        return (response.data as List)
            .map((e) => TopSellerModel.fromJson(e))
            .toList();
      }

      return [];
    } catch (e) {
      log('❌ Top Sellers Error: $e');
      return [];
    }
  }

  /// Get number of products for the current user
  Future<int> getMyProductsCount() async {
    final token = await PrefHelpers.getToken();
    if (token == null || token.isEmpty) {
      throw ApiError(message: 'User not authenticated');
    }

    final response = await _dioClient.dio.get(
      '/api/Products/my-products-count',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
      return response.data['totalProducts'] ?? 0;
    }

    throw ApiError(message: 'Failed to load product count');
  }

  Future<void> deleteProduct(int id) async {
    final response = await _dioClient.dio.delete(
      ApiEndpoint.delete,
      queryParameters: {'id': id},
    );

    if (response.statusCode == 200) {
      final success = response.data['success'];
      if (success == true) {
        return;
      } else {
        throw Exception(response.data['message'] ?? 'Delete failed');
      }
    } else {
      throw Exception('Delete failed');
    }
  }

}


