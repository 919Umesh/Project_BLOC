import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../datetime_picker/bloc/datetime_bloc.dart';
import '../model/project_list_model.dart';
import '../repository/project_list_repo.dart';
part 'project_list_state.dart';
part 'project_list_event.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  final DatePickerBloc datePickerBloc;
  ProjectListBloc({required this.datePickerBloc}) : super(ProjectListInitial()) {
    on<ProjectListEvent>((event, emit) {});
    on<LoadProjectRequested>((event, emit) async {
      await getProject(event, emit);
    });
    on<FilterDateRequested>((event, emit) async {
      await getFilterDate(event, emit);
    });
  }

  Future<void> getProject(LoadProjectRequested event, Emitter emit) async {
    try {
      emit(ProjectListLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      final projects = await ProjectListRepository.getProjectList(status: event.status);
      emit(ProjectListLoadSuccess(projects: projects));
    } catch (e) {
      emit(ProjectListLoadError(errorMessage: e.toString()));
    }
  }

  Future<void> getFilterDate(FilterDateRequested event, Emitter emit) async {
    try {
      emit(FilterDateLoading());
      final dateState = datePickerBloc.state;
      final projects = await ProjectListRepository.getProjectList(status: dateState.toDate);
      emit(FilterDateSuccess(dateList:projects));
    } catch (e) {
      emit(FilterDateError(filterError: e.toString()));
    }
  }
}
