import '../data/model/categories_model_forhome.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoriesModel> categories;
  CategorySuccess(this.categories);
}

class CategoryFailure extends CategoryState {
  final String error;
  CategoryFailure(this.error);
}
