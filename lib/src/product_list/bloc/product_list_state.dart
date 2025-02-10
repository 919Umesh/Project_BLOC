import 'package:equatable/equatable.dart';
import '../model/product_list_model.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();
  @override
  List<Object> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListSuccess extends ProductListState {
  final List<ProductModel> products;
  final bool hasReachedEnd;

  const ProductListSuccess({required this.products,  this.hasReachedEnd = false,});

  @override
  List<Object> get props => [products,hasReachedEnd];
}

class ProductListFailure extends ProductListState {
  final String errorMessage;

  const ProductListFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}