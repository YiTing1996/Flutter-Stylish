import 'package:equatable/equatable.dart';

class Checkout extends Equatable {
  final String? fullName;
  final String? email;
  final String? address;
  final String? phone;
  final String? cardNumber;
  final String? dueYear;
  final String? dueMonth;
  final String? ccv;

  const Checkout({
    required this.fullName,
    required this.email,
    required this.address,
    required this.phone,
    required this.cardNumber,
    required this.dueMonth,
    required this.dueYear,
    required this.ccv,
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        address,
        phone,
        cardNumber,
        dueMonth,
        dueYear,
        ccv,
      ];
}