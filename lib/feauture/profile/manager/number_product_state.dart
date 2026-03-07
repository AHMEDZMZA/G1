abstract class ProductCountState {}

class ProductCountInitial extends ProductCountState {}

class ProductCountLoading extends ProductCountState {}

class ProductCountSuccess extends ProductCountState {
  final int count;
  ProductCountSuccess(this.count);
}

class ProductCountError extends ProductCountState {
  final String message;
  ProductCountError(this.message);
}
