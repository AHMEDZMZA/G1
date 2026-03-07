import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product_screens/manager/prodect_apiservice.dart';
import 'package:graduation2/feauture/profile/manager/number_product_state.dart';

class ProductCountCubit extends Cubit<ProductCountState> {
  final ProductApiService repo;

  ProductCountCubit(this.repo) : super(ProductCountInitial());

  Future<void> fetchMyProductsCount() async {
    emit(ProductCountLoading());

    try {
      final count = await repo.getMyProductsCount();
      emit(ProductCountSuccess(count));
    } catch (e) {
      emit(ProductCountError('Failed to load product count'));
    }
  }
}
