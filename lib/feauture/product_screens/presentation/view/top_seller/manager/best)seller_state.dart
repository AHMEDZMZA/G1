import '../../../../data/model/top_seller_model.dart';

sealed class BestSellerState {}

final class BestSellerInitial extends BestSellerState {}

final class BestSellerLoading extends BestSellerState {}

final class BestSellerSuccess extends BestSellerState {
  final List<TopSellerModel> sellers;
  BestSellerSuccess(this.sellers);
}

final class BestSellerFailure extends BestSellerState {
  final String errorMessage;
  BestSellerFailure(this.errorMessage);
}
