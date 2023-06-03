import 'package:flutter_stylish/helper/export/bloc_export.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Repository _repository = Repository();

  ProductBloc()
      : super(ProductLoadingState()) {
    on<ProductInitialEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final products = await _repository.getProducts(EndPoint.all);
        final hots = await _repository.getProducts(EndPoint.hots);
        emit(ProductLoadedState(products, hots));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });
  }
}
