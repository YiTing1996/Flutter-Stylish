import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class DetailInitialEvent extends DetailEvent {
  @override
  List<Object> get props => [];
}