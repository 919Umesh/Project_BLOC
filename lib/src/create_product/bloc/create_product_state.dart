import 'package:equatable/equatable.dart';

abstract class CreateProductState extends Equatable {
  const CreateProductState();

  @override
  List<Object> get props => [];
}

class CreateProductInitial extends CreateProductState {}

class CreateProductLoading extends CreateProductState {}

class CreateProductSuccess extends CreateProductState {
  final String message;

  const CreateProductSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateProductError extends CreateProductState {
  final String message;

  const CreateProductError({required this.message});

  @override
  List<Object> get props => [message];
}
