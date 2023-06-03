import 'package:flutter_stylish/helper/export/bloc_export.dart';

@immutable
abstract class CartState extends Equatable {
  const CartState();
}

class CartLoadingState extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadedState extends CartState {
  final Cart cart;
  const CartLoadedState({this.cart = const Cart()});
  @override
  List<Object> get props => [cart];
}

class CartErrorState extends CartState {
  @override
  List<Object> get props => [];
}