part of 'search_project_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProjectModel> projects;
  SearchSuccess({required this.projects});
}

class SearchError extends SearchState {
  final String message;
  SearchError({required this.message});
}