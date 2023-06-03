import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final List<CartItem> cartItems;
  const Cart({this.cartItems = const <CartItem>[]});

  double get subtotal =>
      cartItems.fold(0, (total, current) => total + current.price);

  double get deliveryFee => 30.0;

  double total(subtotal, deliveryFee) {
    return subtotal + deliveryFee;
  }

  String get subtotalString => subtotal.toStringAsFixed(2);
  String get totalString => total(subtotal, deliveryFee).toStringAsFixed(2);
  String get deliveryFeeString => deliveryFee.toStringAsFixed(2);

  @override
  List<Object?> get props => [cartItems];
}

class CartItem {

  @override
  String toString() {
    return 'CartItem: {id: $id, price: $price, title: $title, mainImage: $mainImage}';
  }

  int id;
  String title;
  int price;
  CColor color;
  String size;
  String mainImage;
  int stock;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.color,
    required this.size,
    required this.mainImage,
    required this.stock,
  });
}

class CColor {
  CColor({
    required this.code,
    required this.name,
  });

  String code;
  String name;
}