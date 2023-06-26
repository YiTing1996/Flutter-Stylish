import 'package:flutter_stylish/helper/export/bloc_export.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
}

class CheckoutLoadingState extends CheckoutState {
  @override
  List<Object?> get props => [];
}

class CheckoutLoadedState extends CheckoutState {
  final String? fullName;
  final String? email;
  final String? address;
  final String? phone;
  final String? cardNumber;
  final String? dueYear;
  final String? dueMonth;
  final String? ccv;
  final Checkout checkout;

  CheckoutLoadedState({
    this.fullName,
    this.email,
    this.address,
    this.phone,
    this.cardNumber,
    this.dueYear,
    this.dueMonth,
    this.ccv,
  }) : checkout = Checkout(
          fullName: fullName,
          email: email,
          address: address,
          phone: phone,
          cardNumber: cardNumber,
          dueYear: dueYear,
          dueMonth: dueMonth,
          ccv: ccv,
        );

  @override
  List<Object?> get props => [
        fullName,
        email,
        address,
        phone,
        cardNumber,
        dueYear,
        dueMonth,
        ccv,
      ];
}
