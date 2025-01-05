// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:project_bloc/src/create_project/repository/create_project_repo.dart';
// part 'create_project_state.dart';
// part 'create_project_event.dart';
//
// class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
//   CreateProjectBloc() : super(RegisterInitial()) {
//     on<CreateProjectEvent>((event, emit) {});
//     on<ProjectCreateRequested>((event, emit) async {
//       await _mapOnUserRegisterEventToState(event, emit);
//     });
//   }
//
//   Future<void> _mapOnUserRegisterEventToState(
//     ProjectCreateRequested event,
//     Emitter emit,
//   ) async {
//     emit(RegisterLoading());
//     try {
//       final bool result = await CreateProjectRepository.login(
//           name: event.name,
//           duration: event.duration,
//           location: event.location,
//           members: event.members,
//           amount: event.amount,
//           status: []);
//       if (result) {
//         emit(const RegisterSuccess(message: "User Register Successfully"));
//       } else {
//         emit(const RegisterError(message: "User Register Error"));
//       }
//     } catch (e) {
//       emit(RegisterError(message: e.toString()));
//     }
//   }
// }
//

// create_project_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_bloc/src/create_project/repository/create_project_repo.dart';

part 'create_project_state.dart';
part 'create_project_event.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  final CreateProjectRepository repository;

  CreateProjectBloc({required this.repository}) : super(RegisterInitial()) {
    on<ProjectCreateRequested>(_handleProjectCreateRequested);
  }

  Future<void> _handleProjectCreateRequested(
      ProjectCreateRequested event,
      Emitter<CreateProjectState> emit,
      ) async {
    emit(RegisterLoading());
    try {
      final bool result = await repository.createProject(
        name: event.name,
        duration: event.duration,
        location: event.location,
        members: event.members,
        amount: event.amount,
        status: event.status,
      );

      if (result) {
        emit(const RegisterSuccess(message: "Project Created Successfully"));
      } else {
        emit(const RegisterError(message: "Project Creation Failed"));
      }
    } catch (e) {
      emit(RegisterError(message: e.toString()));
    }
  }
}