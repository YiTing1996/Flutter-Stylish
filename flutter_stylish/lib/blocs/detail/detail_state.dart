import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stylish/model/product.dart';

@immutable
abstract class DetailState extends Equatable {}

class DetailLoadingState extends DetailState {
  @override
  List<Object> get props => [];
}

class DetailLoadedState extends DetailState {
  DetailLoadedState(this.product);
  final Product product;

  @override
  List<Object> get props => [product];
}

class DetailErrorState extends DetailState {
  DetailErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}