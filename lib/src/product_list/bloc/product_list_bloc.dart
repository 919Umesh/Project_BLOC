import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bloc/src/product_list/bloc/product_list_event.dart';
import 'package:project_bloc/src/product_list/bloc/product_list_state.dart';

import '../repository/product_list_repo.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {

    on<ProductListRequested>(_fetchProductList);
  }

  Future<void> _fetchProductList(ProductListRequested event, Emitter emit) async {
    emit(ProductListLoading());
    try {
      final products = await ProductListRepository.getProductList();
      emit(ProductListSuccess(products: products));
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to load products. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
      );
      emit(ProductListFailure(errorMessage: e.toString()));
    }
  }
}
