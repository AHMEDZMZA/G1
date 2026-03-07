

import '../data/model/productsellerdashboardmodel.dart';

abstract class ProductsellerdashboardState {}

class ProductsellerdInitial extends ProductsellerdashboardState {}

class ProductsellerdLoading extends ProductsellerdashboardState {}

class ProductsellerdSuccess extends ProductsellerdashboardState {

  final List<ProductsellerdashboardModel> products;

  ProductsellerdSuccess(this.products);
}

class ProductsellerdError extends ProductsellerdashboardState {

  final String message;

  ProductsellerdError(this.message);
}