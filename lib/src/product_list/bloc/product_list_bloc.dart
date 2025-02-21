import 'package:flutter_bloc/flutter_bloc.dart';
import '../product_list.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final List<ProductModel> _allProducts = [];
  int _currentPage = 1;
  static const int _itemsPerPage = 5;

  ProductListBloc() : super(ProductListInitial()) {
    on<ProductListRequested>(_onProductListRequested);
    on<ProductListLoadMoreRequested>(_onProductListLoadMoreRequested);
  }

  Future<void> _onProductListRequested(
    ProductListRequested event,
    Emitter<ProductListState> emit,
  ) async {
    try {
      emit(ProductListLoading());
      _currentPage = 1;
      _allProducts.clear();

      final newProducts = await ProductListRepository.getProductList(
        page: _currentPage,
        limit: _itemsPerPage,
      );

      _allProducts.addAll(newProducts);

      emit(ProductListSuccess(
        products: List.from(_allProducts),
        hasReachedEnd: newProducts.length < _itemsPerPage,
      ));
    } catch (e) {
      emit(ProductListFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _onProductListLoadMoreRequested(
    ProductListLoadMoreRequested event,
    Emitter<ProductListState> emit,
  ) async {
    try {
      final state = this.state;
      if (state is ProductListSuccess && !state.hasReachedEnd) {
        _currentPage++;
        final newProducts = await ProductListRepository.getProductList(
          page: _currentPage,
          limit: _itemsPerPage,
        );
        _allProducts.addAll(newProducts);
        emit(ProductListSuccess(
          products: List.from(_allProducts),
          hasReachedEnd: newProducts.length < _itemsPerPage,
        ));
      }
    } catch (e) {
      emit(ProductListFailure(errorMessage: e.toString()));
    }
  }
}
