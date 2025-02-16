import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class CreateProductEvent extends Equatable {
  const CreateProductEvent();

  @override
  List<Object> get props => [];
}

class CreateProductRequested extends CreateProductEvent {
  final FormData formData;

  const CreateProductRequested({required this.formData});

  @override
  List<Object> get props => [formData];
}

class UpdateProductRequested extends CreateProductEvent {
  final FormData formData;
  final String id;

  const UpdateProductRequested({required this.formData,required this.id});

  @override
  List<Object> get props => [formData,id];
}

