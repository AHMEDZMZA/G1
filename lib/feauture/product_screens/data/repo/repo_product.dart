import 'package:dartz/dartz.dart';
import 'package:graduation2/core/services/api_error.dart';

import '../model/create_product_model.dart';
import '../model/update_product.dart';

abstract class RepoProduct {
  Future<Either<ApiError, CreateProductResponseModel>> createProduct(
    CreateProductRequestModel requestModel,
  );

  Future<Either<ApiError, CreateProductResponseModel>> updateProduct(
    UpdateProductRequestModel requestModel,
  );

  Future<Either<ApiError, void>> deleteProduct(int id);
}
