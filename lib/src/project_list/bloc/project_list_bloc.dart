import 'package:bloc/bloc.dart';
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
  }

  Future<void> getProject(LoadProjectRequested event, Emitter emit) async {
    try {
      emit(ProjectListLoading());
      final projects = await ProjectListRepository.getProjectList(status: event.status);
      emit(ProjectListLoadSuccess(projects: projects));
    } catch (e) {
      emit(ProjectListLoadError(errorMessage: e.toString()));
    }
  }

  Future<void> getFilterDate(LoadProjectRequested event, Emitter emit) async {
    try {
      emit(ProjectListLoading());
      final dateState = datePickerBloc.state;
      final projects = await ProjectListRepository.getProjectList(status: dateState.fromDate);
      emit(ProjectListLoadSuccess(projects: projects));
    } catch (e) {
      emit(ProjectListLoadError(errorMessage: e.toString()));
    }
  }

}
