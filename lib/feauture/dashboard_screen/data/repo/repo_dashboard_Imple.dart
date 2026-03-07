
import 'package:dartz/dartz.dart';
import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/feauture/dashboard_screen/data/model/productsellerdashboardmodel.dart';
import 'package:graduation2/feauture/dashboard_screen/data/repo/repo_dashboard.dart';

import '../../manager/sellerdashboard_apiserves.dart';

class RepoDashboardImple implements RepoDashboard {
  final ProductsellerdashboardApiService productsellerdashboardApiService;

  RepoDashboardImple(this.productsellerdashboardApiService);

  @override
  Future<Either<ApiError, List<ProductsellerdashboardModel>>>
  getspacificProducts() async {
    try {
      final response =
          await productsellerdashboardApiService.getspacificProducts();
      return Right(response);
    } catch (e) {
      return Left(ApiError(message: e.toString()));
    }
  }
}
