import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/const/api_endpoint.dart';
import '../data/model/create_product_model.dart';

import '../data/model/prodect_model_explore.dart';


sealed class ProductState {}
final class ProductInitial extends ProductState {}
final class ProductLoading extends ProductState {}
final class ProductSuccess extends ProductState {
  final List<ProductsModel> products;
  ProductSuccess(this.products);
}
final class ProductFailure extends ProductState {
  final String errorMessage;
  ProductFailure(this.errorMessage);

}


/// CreateProducts State

abstract class CreateProductState {}

class CreateInitialState  extends CreateProductState {}

class CreateLoadingState  extends CreateProductState {}

class CreateSuccessState  extends CreateProductState {
  final CreateProductResponseModel product;

  CreateSuccessState({required this.product});
}

class CreateErrorState  extends CreateProductState {
  final String message;

  CreateErrorState({required this.message});

}

/// UpdateProduct State

abstract class UpdateProductState {}

class UpdateInitialState extends UpdateProductState {}

class UpdateLoadingState extends UpdateProductState {}

class UpdateSuccessState extends UpdateProductState {
  final CreateProductResponseModel product;

  UpdateSuccessState({required this.product});
}

class UpdateErrorState extends UpdateProductState {
  final String message;

  UpdateErrorState({required this.message});
}


// Delete Product State
abstract class DeleteProductState {}

class DeleteInitialState extends DeleteProductState {}

class DeleteLoadingState extends DeleteProductState {}

class DeleteSuccessState extends DeleteProductState {}

class DeleteErrorState extends DeleteProductState {
  final String message;
  DeleteErrorState({required this.message});
}
// abstract class ProductsState {}

// class ProductsInitial extends ProductsState {}

// class ProductsLoading extends ProductsState {}

// class ProductsSuccess extends ProductsState {
//   final List<ProductsModel> products;
//   ProductsSuccess(this.products);
// }

// class ProductsError extends ProductsState {
//   final String message;
//   ProductsError(this.message);
// }
