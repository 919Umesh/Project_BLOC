import 'package:bloc/bloc.dart';
import 'package:project_bloc/src/product_list/bloc/product_list_event.dart';
import 'package:project_bloc/src/product_list/bloc/product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {
    on<ProductListRequested>(_fetchProductList);
  }

  Future<void> _fetchProductList(
      ProductListRequested event, Emitter emit) async {
    emit(ProductListLoading());

    try {} catch (e) {}
  }
}
