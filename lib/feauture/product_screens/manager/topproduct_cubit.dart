import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product_screens/manager/prodect_apiservice.dart';
import 'package:graduation2/feauture/product_screens/manager/product_state.dart';

class TopProductCubit extends Cubit<ProductState> {
  final ProductApiService apiService;

  TopProductCubit(this.apiService) : super(ProductInitial());

  Future<void> fetchTopProducts() async {
    emit(ProductLoading());
    try {
      final products = await apiService.fetchTopProductsFromApi();
      emit(ProductSuccess(products));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }
}
