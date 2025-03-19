part of 'project_list_bloc.dart';

abstract class ProjectListState {}

class ProjectListInitial extends ProjectListState {}

class ProjectListLoading extends ProjectListState {}

class ProjectListLoadSuccess extends ProjectListState {
  final List<ProjectModel> projects;

  ProjectListLoadSuccess({required this.projects});

  @override
  List<Object?> get props => [projects];
}

class ProjectListLoadError extends ProjectListState {
  final String errorMessage;

  ProjectListLoadError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class FilterDateInitial extends ProjectListState{}

class FilterDateLoading extends ProjectListState{}

class FilterDateSuccess extends ProjectListState{
  final List<ProjectModel> dateList;
  FilterDateSuccess({required this.dateList});

  @override
  List<Object?> get props => [dateList];
}

class FilterDateError extends ProjectListState {
  final String filterError;

  FilterDateError({required this.filterError});

  @override
  List<Object> get props => [filterError];
}