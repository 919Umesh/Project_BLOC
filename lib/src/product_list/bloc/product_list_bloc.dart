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
