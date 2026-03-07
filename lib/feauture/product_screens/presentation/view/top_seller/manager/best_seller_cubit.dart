import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/services/api_services.dart';
import '../../../../manager/prodect_apiservice.dart';
import 'best)seller_state.dart';

class BestSellerCubit extends Cubit<BestSellerState> {
  final ProductApiService apiService;

  BestSellerCubit(this.apiService) : super(BestSellerInitial());

  Future<void> fetchBestSellers() async {
    emit(BestSellerLoading());

    try {
      final sellers = await apiService.getTopSellers();

      emit(BestSellerSuccess(sellers));
    } catch (e) {
      emit(BestSellerFailure(e.toString()));
    }
  }
}
