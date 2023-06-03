import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class ProductInitialEvent extends ProductEvent {
  @override
  List<Object> get props => [];
}