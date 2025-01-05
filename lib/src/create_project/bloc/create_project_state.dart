// part of 'create_project_bloc.dart';
//
//
// abstract class CreateProjectState extends Equatable {
//   const CreateProjectState();
//
//   @override
//   List<Object> get props => [];
// }
//
// final class RegisterInitial extends CreateProjectState {}
//
// final class RegisterLoading extends CreateProjectState {}
//
// final class RegisterSuccess extends CreateProjectState {
//   final String message;
//   const RegisterSuccess({required this.message});
//
//   @override
//   List<Object> get props => [message];
// }
//
// final class RegisterError extends CreateProjectState {
//   final String message;
//   const RegisterError({required this.message});
//
//   @override
//   List<Object> get props => [message];
// }

// create_project_state.dart
part of 'create_project_bloc.dart';

abstract class CreateProjectState extends Equatable {
  const CreateProjectState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends CreateProjectState {}

class RegisterLoading extends CreateProjectState {}

class RegisterSuccess extends CreateProjectState {
  final String message;

  const RegisterSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterError extends CreateProjectState {
  final String message;

  const RegisterError({required this.message});

  @override
  List<Object> get props => [message];
}