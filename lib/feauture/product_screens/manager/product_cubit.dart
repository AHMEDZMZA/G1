import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/api_services.dart';
import '../data/model/create_product_model.dart';
import '../data/model/update_product.dart';
import '../data/repo/repo_product.dart';
import 'product_state.dart';
import '../data/model/prodect_model_explore.dart';
import 'prodect_apiservice.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductApiService apiService;

  ProductCubit(this.apiService) : super(ProductInitial());

  // 🔹 All Products (Explore)
  Future<void> fetchAllProducts() async {
    emit(ProductLoading());
    try {
      final List<ProductsModel> products = await apiService.fetchAllProducts();

      products.isNotEmpty
          ? emit(ProductSuccess(products))
          : emit(ProductFailure("No products found"));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  // 🔹 Top Products (Best Sellers)
  Future<void> fetchTopProducts() async {
    emit(ProductLoading());
    try {
      final List<ProductsModel> products =
          await apiService.fetchTopProductsFromApi();

      products.isNotEmpty
          ? emit(ProductSuccess(products))
          : emit(ProductFailure("No top products found"));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}

class ProductsCubit extends Cubit<ProductState> {
  final ProductOwnerProfileRepo repo;

  ProductsCubit(this.repo) : super(ProductInitial());

  Future<void> getProducts(String userId) async {
    emit(ProductLoading());
    try {
      final products = await repo.getProductsOfUser(userId);
      emit(ProductSuccess(products));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}

/// CreateProducts Cubit
class CreateProductCubit extends Cubit<CreateProductState> {
  final RepoProduct repoProduct;

  CreateProductCubit({required this.repoProduct}) : super(CreateInitialState());

  Future<void> addToCart(CreateProductRequestModel model) async {
    emit(CreateInitialState());
    final result = await repoProduct.createProduct(model);
    result.fold(
      (failure) => emit(CreateErrorState(message: failure.message)),
      (value) => emit(CreateSuccessState(product: value)),
    );
  }
}

/// UpdateProduct Cubit
class UpdateProductCubit extends Cubit<UpdateProductState> {
  final RepoProduct repoProduct;

  UpdateProductCubit({required this.repoProduct}) : super(UpdateInitialState());

  Future<void> updateProduct(UpdateProductRequestModel model) async {
    emit(UpdateLoadingState());
    final result = await repoProduct.updateProduct(model);
    result.fold(
      (failure) => emit(UpdateErrorState(message: failure.message)),
      (value) => emit(UpdateSuccessState(product: value)),
    );
  }

}

// Delete Product Cubit
class DeleteProductCubit extends Cubit<DeleteProductState> {
  final RepoProduct repoProduct;

  DeleteProductCubit({required this.repoProduct}) : super(DeleteInitialState());

  Future<void> deleteProduct(int id) async {
    emit(DeleteLoadingState());
    final result = await repoProduct.deleteProduct(id);
    result.fold(
          (failure) => emit(DeleteErrorState(message: failure.message)),
          (_) => emit(DeleteSuccessState()),
    );
  }
}