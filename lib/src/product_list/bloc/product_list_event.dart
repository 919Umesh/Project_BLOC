import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {

  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ProductListRequested extends ProductListEvent {

  const ProductListRequested();

  @override
  List<Object> get props => [];
}