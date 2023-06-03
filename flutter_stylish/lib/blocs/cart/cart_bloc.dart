import 'package:flutter_stylish/helper/export/bloc_export.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoadingState()) {
    on<CartInitialEvent>(_onLoadCart);
    on<CartAddedEvent>(_onAddedCart);
    on<CartRemoveEvent>(_onRemovedCart);
  }

  void _onLoadCart(CartInitialEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const CartLoadedState());
    } catch (_) {
      emit(CartErrorState());
    }
  }

  void _onAddedCart(CartAddedEvent event, Emitter<CartState> emit) async {

    if (state is CartLoadedState) {
      try {
        emit(CartLoadedState(
            cart: Cart(
                cartItems: List.from((state as CartLoadedState).cart.cartItems)
                  ..add(event.cartItem))));
      } on Exception {
        emit(CartErrorState());
      }
    }
  }

  void _onRemovedCart(CartRemoveEvent event, Emitter<CartState> emit) async {
    if (state is CartLoadedState) {
      try {
        emit(CartLoadedState(
            cart: Cart(
                cartItems: List.from((state as CartLoadedState).cart.cartItems)
                  ..remove(event.cartItem))));
      } on Exception {
        emit(CartErrorState());
      }
    }
  }
}