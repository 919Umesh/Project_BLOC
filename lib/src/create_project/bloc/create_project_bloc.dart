import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_bloc/src/create_project/model/create_project_model.dart';
import 'package:project_bloc/src/create_project/repository/create_project_repo.dart';
part 'create_project_state.dart';
part 'create_project_event.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  final CreateProjectRepository _createProjectRepository;

  CreateProjectBloc({required CreateProjectRepository createProjectRepository})
      : _createProjectRepository = createProjectRepository,
        super(RegisterInitial()) {
    on<ProjectCreateRequested>(_onProjectCreateRequested);
  }

  Future<void> _onProjectCreateRequested(
    ProjectCreateRequested event,
    Emitter emit,
  ) async {
    emit(RegisterLoading());
    try {
      final project = Project(
          name: event.name,
          duration: event.duration,
          location: event.location,
          members: event.members,
          amount: event.amount,
          status: event.status);
      await _createProjectRepository.createProject(product: project);
    } catch (e) {
      emit(RegisterError(message: e.toString()));
      debugPrint(e.toString());
    }
  }
}
