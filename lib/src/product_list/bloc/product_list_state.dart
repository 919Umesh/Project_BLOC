import 'package:equatable/equatable.dart';

abstract class ProductListState extends Equatable{
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListInitial extends ProductListState{}

class ProductListLoading extends ProductListState{}

class ProductListSuccess extends ProductListState{}