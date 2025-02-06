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