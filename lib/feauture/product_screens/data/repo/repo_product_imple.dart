import 'package:dartz/dartz.dart';
import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/feauture/product_screens/data/model/create_product_model.dart';
import 'package:graduation2/feauture/product_screens/data/repo/repo_product.dart';

import '../../manager/prodect_apiservice.dart';
import '../model/update_product.dart';

class RepoProductImple implements RepoProduct {
  final ProductApiService productApiService;

  RepoProductImple({required this.productApiService});

  @override
  Future<Either<ApiError, CreateProductResponseModel>> createProduct(
    CreateProductRequestModel requestModel,
  ) async {
    try {
      final response = await productApiService.createProduct(requestModel);
      return Right(response);
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, CreateProductResponseModel>> updateProduct(
    UpdateProductRequestModel requestModel,
  ) async {
    try {
      final response = await productApiService.updateProduct(requestModel);
      return Right(response);
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, void>> deleteProduct(int id) async {
    try {
      await productApiService.deleteProduct(id);
      return const Right(null);
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
