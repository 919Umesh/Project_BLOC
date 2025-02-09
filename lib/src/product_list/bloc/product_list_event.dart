import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable{
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ProductListRequested extends ProductListEvent{
  final String message;

  const ProductListRequested({required this.message});

  @override
  List<Object> get props => [message];
}