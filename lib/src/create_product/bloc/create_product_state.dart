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

// import 'package:equatable/equatable.dart';
// import '../../project_list/model/project_list_model.dart';
//
// abstract class CreateProductState extends Equatable {
//   const CreateProductState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class CreateProductStateInitial extends CreateProductState {}
//
// class CreateProductStateLoading extends CreateProductState {}
//
// class CreateProductSuccess extends CreateProductState {
//   final List<ProjectModel> projects;
//
//   const CreateProductSuccess({required this.projects});
//
//   @override
//   List<Object> get props => [projects];
// }
//
// class CreateProductFailure extends CreateProductState
// {
//   final String errorMessages;
//
//   const CreateProductFailure({required this.errorMessages});
//
//   @override
//   List<Object> get props => [errorMessages];
// }