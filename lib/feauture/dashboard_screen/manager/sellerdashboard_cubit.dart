// ProductsellerCubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/dashboard_screen/data/repo/repo_dashboard.dart';
import 'package:graduation2/feauture/dashboard_screen/manager/sellerdashboard_state.dart';
import '../data/model/productsellerdashboardmodel.dart';

class ProductsellerCubit extends Cubit<ProductsellerdashboardState> {
  ProductsellerCubit(this.repoDashboard) : super(ProductsellerdInitial());

  final RepoDashboard repoDashboard;
  List<ProductsellerdashboardModel> products = [];

  Future<void> getProducts() async {
    emit(ProductsellerdLoading());
    final result = await repoDashboard.getspacificProducts();
    result.fold(
          (error) => emit(ProductsellerdError(error.message)),
          (List<ProductsellerdashboardModel> data) {
        products = data;
        emit(ProductsellerdSuccess(products));
      },
    );
  }

  // ✅ ضيفي ده
  void removeProduct(int id) {
    products.removeWhere((p) => p.id == id);
    emit(ProductsellerdSuccess(List.from(products)));
  }
}