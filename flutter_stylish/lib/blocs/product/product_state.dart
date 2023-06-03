import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stylish/model/product.dart';

@immutable
abstract class ProductState extends Equatable {}

class ProductLoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductState {
  ProductLoadedState(this.products, this.hots);
  final List<Product> products;
  final List<Product> hots;

  @override
  List<Object> get props => [products, hots];
}

class ProductErrorState extends ProductState {
  ProductErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}