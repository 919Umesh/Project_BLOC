part of 'project_list_bloc.dart';
abstract class ProjectListEvent {}

class LoadProjectRequested extends ProjectListEvent {
  final String status;
  LoadProjectRequested({this.status = ''});


  List<Object?> get props => [status];
}
