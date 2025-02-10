// import 'package:bloc/bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:project_bloc/src/product_list/bloc/product_list_event.dart';
// import 'package:project_bloc/src/product_list/bloc/product_list_state.dart';
//
// import '../repository/product_list_repo.dart';
//
// class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
//   ProductListBloc() : super(ProductListInitial()) {
//
//     on<ProductListRequested>(_fetchProductList);
//   }
//
//   Future<void> _fetchProductList(ProductListRequested event, Emitter emit) async {
//     emit(ProductListLoading());
//     try {
//       final products = await ProductListRepository.getProductList();
//       emit(ProductListSuccess(products: products));
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Failed to load products. Please try again.",
//         toastLength: Toast.LENGTH_SHORT,
//       );
//       emit(ProductListFailure(errorMessage: e.toString()));
//     }
//   }
// }

// import 'package:bloc/bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:project_bloc/src/product_list/bloc/product_list_event.dart';
// import 'package:project_bloc/src/product_list/bloc/product_list_state.dart';
// import '../repository/product_list_repo.dart';
//
// class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
//   ProductListBloc() : super(ProductListInitial()) {
//     on<ProductListRequested>(_fetchProductList);
//   }
//
//   Future<void> _fetchProductList(ProductListRequested event, Emitter emit) async {
//     emit(ProductListLoading());
//     try {
//       final products = await ProductListRepository.getProductList(
//         page: event.page,
//         limit: event.limit,
//       );
//       emit(ProductListSuccess(products: products));
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Failed to load products. Please try again.",
//         toastLength: Toast.LENGTH_SHORT,
//       );
//       emit(ProductListFailure(errorMessage: e.toString()));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import '../product_list.dart';


class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {

  final List<ProductModel> _allProducts = [];

  ProductListBloc() : super(ProductListInitial()) {
    on<ProductListRequested>(_onProductListRequested);
  }

  Future<void> _onProductListRequested(
      ProductListRequested event,
      Emitter<ProductListState> emit,
      ) async {
    try {
      if (event.page == 1) {
        emit(ProductListLoading());
        _allProducts.clear();
      }

      final newProducts = await ProductListRepository.getProductList(
        page: event.page,
        limit: event.limit,
      );

      _allProducts.addAll(newProducts);

      emit(ProductListSuccess(
        products: List.from(_allProducts),
        hasReachedEnd: newProducts.length < event.limit,
      ));
    } catch (e) {
      emit(ProductListFailure(errorMessage: e.toString()));
    }
  }
}
