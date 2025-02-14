import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_bloc/app/temp/custom_log.dart';
import 'package:project_bloc/src/user_list/db/user_list_db.dart';
import 'package:project_bloc/src/user_list/model/user_list_model.dart';
import '../repository/user_list_repository.dart';
part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserListRepository _userListRepository;

  UserListBloc({required UserListRepository userListRepository})
      : _userListRepository = userListRepository,
        super(UserListInitial()) {
    on<LoadUsersRequested>(_onLoadUsers);
    on<UserNameRequested>(_onUserNameList);
  }

  Future<void> _onLoadUsers(LoadUsersRequested event, Emitter<UserListState> emit) async {
    try {
      emit(UserListLoading());
      final localUsers = await UserListDatabase.instance.getDataList();
      CustomLog.successLog(value: localUsers);
      if (localUsers.isNotEmpty) {
        emit(UserListLoadSuccess(users: localUsers));
        // Fluttertoast.showToast(msg: 'Db');
        return;
      }
      final users = await UserListRepository.getUserList();
      await _saveUsers(users);
      // Fluttertoast.showToast(msg: 'Remote');
      emit(UserListLoadSuccess(users: users));
    } catch (e) {
      debugPrint("Error loading users: $e");
      emit(UserListLoadError(errorMessage: e.toString()));
    }
  }

  Future<void> _saveUsers(List<UserModel> users) async {
    await UserListDatabase.instance.deleteData();
    for (var user in users) {
      await UserListDatabase.instance.insertData(user);
    }
  }

  Future<void> _onUserNameList(UserNameRequested event, Emitter<UserListState> emit) async {
    try {
      emit(UserNameLoading());
      final dataList = await _userListRepository.getUserNameList();
      emit(UserNameLoadSuccess(userList: dataList));
    } catch (e) {
      emit(UserNameLoadError(nameErrorMessage: e.toString()));
    }
  }
}