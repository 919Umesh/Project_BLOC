import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project_bloc/src/user_list/db/user_list_db.dart';
import 'package:project_bloc/src/user_list/model/user_list_model.dart';
import '../repository/user_list_repository.dart';
part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserListRepository _userListRepository;
  List<UserModel> _cachedUsers = [];

  UserListBloc({required UserListRepository userListRepository})
      : _userListRepository = userListRepository,
        super(UserListInitial()) {
    on<LoadUsersRequested>(_onLoadUsers);
    on<UserNameRequested>(_onUserNameList);
  }

  Future<void> _onLoadUsers(LoadUsersRequested event, Emitter<UserListState> emit) async {
    try {
      emit(UserListLoading());

      if (_cachedUsers.isNotEmpty) {
        emit(UserListLoadSuccess(users: _cachedUsers));
        return;
      }

      final localUsers = await UserListDatabase.instance.getDataList();
      if (localUsers.isNotEmpty) {
        _cachedUsers = localUsers;
        emit(UserListLoadSuccess(users: localUsers));
        return;
      }

      final users = await UserListRepository.getUserList();
      await _saveUsers(users);
      _cachedUsers = users;
      emit(UserListLoadSuccess(users: users));
    } catch (e) {
      debugPrint("Error loading users: $e");
      emit(UserListLoadError(errorMessage: e.toString()));
    }
  }

  //Save on the local db
  Future<void> _saveUsers(List<UserModel> users) async {
    await UserListDatabase.instance.deleteData();
    for (var user in users) {
      await UserListDatabase.instance.insertData(user);
    }
  }

  //Fetch user name from the local database
  Future<void> _onUserNameList(UserNameRequested event, Emitter<UserListState> emit) async {
    try {
      emit(UserListLoading());
      final dataList = await _userListRepository.getUserNameList();
      emit(UserNameLoadSuccess(userList: dataList));
    } catch (e) {
      emit(UserListLoadError(errorMessage: e.toString()));
    }
  }
}