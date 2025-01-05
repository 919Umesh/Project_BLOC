part of 'create_project_bloc.dart';

abstract class CreateProjectState extends Equatable {
  const CreateProjectState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends CreateProjectState {}

final class RegisterLoading extends CreateProjectState {}

final class RegisterSuccess extends CreateProjectState {
  final String message;
  const RegisterSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class RegisterError extends CreateProjectState {
  final String message;
  const RegisterError({required this.message});

  @override
  List<Object> get props => [message];
}
