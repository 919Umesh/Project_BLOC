import 'package:bloc/bloc.dart';
import '../../project_list/project_list.dart';
import '../repository/search_project_repo.dart';
part 'search_project_event.dart';
part 'search_project_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchProjectRequested>(_onSearchProject);
    on<ClearSearchRequested>(_onClearSearch);
  }

  Future<void> _onSearchProject(
      SearchProjectRequested event,
      Emitter<SearchState> emit,
      ) async {
    if (event.query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    try {
      emit(SearchLoading());
      final results = await ProjectSearchRepository.searchProjects(query: event.query);
      emit(SearchSuccess(projects: results));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  //Clear the fields
  void _onClearSearch(ClearSearchRequested event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }
}