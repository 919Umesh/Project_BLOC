part of 'project_list_bloc.dart';

abstract class ProjectListState {}

class ProjectListInitial extends ProjectListState {}

class ProjectListLoading extends ProjectListState {}

class ProjectListLoadSuccess extends ProjectListState {
  final List<ProjectModel> projects;

  ProjectListLoadSuccess({required this.projects});

  List<Object?> get props => [projects];
}

class ProjectListLoadError extends ProjectListState {
  final String errorMessage;

  ProjectListLoadError({required this.errorMessage});

  List<Object?> get props => [errorMessage];
}
