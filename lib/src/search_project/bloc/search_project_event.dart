part of 'search_project_bloc.dart';

abstract class SearchEvent {}

class SearchProjectRequested extends SearchEvent {
  final String query;
  SearchProjectRequested({required this.query});
}
class ClearSearchRequested extends SearchEvent {}