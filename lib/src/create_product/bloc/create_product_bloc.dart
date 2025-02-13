import 'package:bloc/bloc.dart';
import '../create_product.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  CreateProductBloc() :super(CreateProductInitial()) {
    on<CreateProductRequested>(_onProductCreateRequested);
  }

  Future<void> _onProductCreateRequested(CreateProductRequested event, Emitter emit) async {
    emit(CreateProductLoading());
    try {
      final response = await createProductRepository.createProduct(form: event.formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(CreateProductSuccess(message: response.statusMessage!));
      } else {
        emit(CreateProductError(message: response.statusMessage!));
      }
    } catch (e) {
      emit(CreateProductError(message: e.toString()));
    }
  }
}



