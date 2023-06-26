import 'package:flutter_stylish/helper/export/bloc_export.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();
}

class CheckoutInitialEvent extends CheckoutEvent {
  @override
  List<Object> get props => [];
}

class UpdateCheckoutEvent extends CheckoutEvent {
  final String? fullName;
  final String? email;
  final String? address;
  final String? phone;
  final String? cardNumber;
  final String? dueYear;
  final String? dueMonth;
  final String? ccv;

  const UpdateCheckoutEvent({
    this.fullName,
    this.email,
    this.address,
    this.phone,
    this.cardNumber,
    this.dueYear,
    this.dueMonth,
    this.ccv,
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        address,
        phone,
        dueYear,
        dueMonth,
        ccv,
      ];
}

class ConfirmCheckoutEvent extends CheckoutEvent {
  final Checkout checkout;
  const ConfirmCheckoutEvent({required this.checkout});

  @override
  List<Object?> get props => [checkout];
}
