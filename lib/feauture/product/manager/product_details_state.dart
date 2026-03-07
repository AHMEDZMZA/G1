import 'package:graduation2/feauture/product/data/product_details_model.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {
  final ProductDetailsModel product;
  ProductDetailsSuccess(this.product);
}

class ProductDetailsFailure extends ProductDetailsState {
  final String message;
  ProductDetailsFailure(this.message);
}
