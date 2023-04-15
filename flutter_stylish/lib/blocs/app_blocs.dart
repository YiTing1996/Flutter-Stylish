import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stylish/helper/common_export.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc(this._productRepository, endpoint, {id})
      : super(ProductLoadingState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final products = await _productRepository.getProducts(endpoint, id: id);
        // TODO: 還在想放哪裡好
        final hots = await _productRepository.getProducts(EndPoint.hots, id: id);
        emit(ProductLoadedState(products, hots));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });
  }
}
