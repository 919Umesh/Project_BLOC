// import 'package:equatable/equatable.dart';
//
// abstract class ProductListEvent extends Equatable {
//
//   const ProductListEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class ProductListRequested extends ProductListEvent {
//   final String page;
//   final String limit;
//   const ProductListRequested({required this.page,required this.limit});
//
//   @override
//   List<Object> get props => [page,limit];
// }
import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();
  @override
  List<Object> get props => [];
}

class ProductListRequested extends ProductListEvent {
  final int page;
  final int limit;

  const ProductListRequested({required this.page, required this.limit});

  @override
  List<Object> get props => [page, limit];
}