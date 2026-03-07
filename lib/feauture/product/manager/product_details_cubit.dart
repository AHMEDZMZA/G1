import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product/data/product_details_repo.dart';
import 'package:graduation2/feauture/product/manager/product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepo repo;

  ProductDetailsCubit(this.repo) : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(int productId) async {
    emit(ProductDetailsLoading());
    try {
      final product = await repo.getProductDetails(productId);
      emit(ProductDetailsSuccess(product));
    } catch (e) {
      emit(ProductDetailsFailure(e.toString()));
    }
  }
}
