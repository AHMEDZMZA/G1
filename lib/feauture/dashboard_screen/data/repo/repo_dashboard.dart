import 'package:dartz/dartz.dart';

import '../../../../core/services/api_error.dart';
import '../model/productsellerdashboardmodel.dart';

abstract class RepoDashboard {
  Future<Either<ApiError, List<ProductsellerdashboardModel>>>
  getspacificProducts();
}
