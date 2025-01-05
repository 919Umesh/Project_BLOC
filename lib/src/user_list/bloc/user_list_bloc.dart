import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_bloc/src/user_list/model/user_list_model.dart';
import '../repository/user_list_repository.dart';
part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitial()) {
    on<UserListEvent>((event, emit) {});
    on<LoadUsersRequested>((event, emit) async {
      await getUsers(event, emit);
    });
  }

  Future<void> getUsers(LoadUsersRequested event, Emitter emit) async {
    try {
      emit(UserListLoading());
      final users = await UserListRepository.getUserList();
      emit(UserListLoadSuccess(users: users));
    } catch (e) {
      debugPrint("$e");
      emit(UserListLoadError(errorMessage: e.toString()));
    }
  }

}
