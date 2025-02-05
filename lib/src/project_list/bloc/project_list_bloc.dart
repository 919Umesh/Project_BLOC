import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../model/project_list_model.dart';
import '../repository/project_list_repo.dart';
part 'project_list_state.dart';
part 'project_list_event.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  ProjectListBloc() : super(ProjectListInitial()) {
    on<ProjectListEvent>((event, emit) {});
    on<LoadProjectRequested>((event, emit) async {
      await getProject(event, emit);
    });
  }

  Future<void> getProject(LoadProjectRequested event, Emitter emit) async {
    try {
      emit(ProjectListLoading());

      final projects = await ProjectListRepository.getProjectList(status: event.status);
      emit(ProjectListLoadSuccess(projects: projects));
    } catch (e) {
      debugPrint("$e");
      emit(ProjectListLoadError(errorMessage: e.toString()));
    }
  }

}
