import 'package:flutter_stylish/helper/export/bloc_export.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartInitialEvent extends CartEvent {
    @override
  List<Object> get props => [];
}

class CartAddedEvent extends CartEvent {
  final CartItem cartItem;
  const CartAddedEvent(this.cartItem);
    @override
  List<Object> get props => [cartItem];
}

class CartRemoveEvent extends CartEvent {
  final CartItem cartItem;
  const CartRemoveEvent(this.cartItem);
    @override
  List<Object> get props => [cartItem];
}