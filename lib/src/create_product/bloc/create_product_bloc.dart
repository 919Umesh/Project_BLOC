import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bloc/src/create_product/bloc/create_product_event.dart';
import 'package:project_bloc/src/create_product/bloc/create_product_state.dart';
import '../repository/create_product_repo.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  final CreateProductRepository _createProductRepository;

  CreateProductBloc({required CreateProductRepository createProductRepository})
      : _createProductRepository = createProductRepository,
        super(CreateProductInitial()) {
    on<CreateProductRequested>(_onProductCreateRequested);
  }

  Future<void> _onProductCreateRequested(CreateProductRequested event, Emitter emit) async {
    emit(CreateProductLoading());
    try {
      final response = await _createProductRepository.createProduct(form: event.formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(CreateProductSuccess(message: response.statusCode!.toString()));
      } else {
        Fluttertoast.showToast(msg: 'Failure');
        emit(CreateProductError(message: response.statusCode!.toString()));
      }
    } catch (e) {
      emit(CreateProductError(message: e.toString()));
    }
  }
}
