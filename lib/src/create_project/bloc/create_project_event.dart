// part of'create_project_bloc.dart';
//
// sealed class CreateProjectEvent extends Equatable {
//   const CreateProjectEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class ProjectCreateRequested extends CreateProjectEvent {
//   final String name;
//   final String duration;
//   final String location;
//   final String members;
//   final String amount;
//   final List<String> status;
//
//
//   const ProjectCreateRequested({
//     required this.name,
//     required this.duration,
//     required this.location,
//     required this.members,
//     required this.amount,
//     required this.status,
//   });
//   @override
//   List<Object> get props => [];
// }

// create_project_event.dart
part of 'create_project_bloc.dart';

abstract class CreateProjectEvent extends Equatable {
  const CreateProjectEvent();

  @override
  List<Object> get props => [];
}

class ProjectCreateRequested extends CreateProjectEvent {
  final String name;
  final String duration;
  final String location;
  final String members;
  final String amount;
  final List<String> status;

  const ProjectCreateRequested({
    required this.name,
    required this.duration,
    required this.location,
    required this.members,
    required this.amount,
    required this.status,
  });

  @override
  List<Object> get props => [name, duration, location, members, amount, status];
}