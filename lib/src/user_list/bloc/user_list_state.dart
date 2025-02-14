part of 'user_list_bloc.dart';

abstract class UserListState {}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserNameLoading extends UserListState {}

class UserListLoadSuccess extends UserListState {
  final List<UserModel> users;

  UserListLoadSuccess({required this.users});
}

class UserNameLoadSuccess extends UserListState {
  final List<UserModel> userList;

  UserNameLoadSuccess({required this.userList});

  List<Object> get props => [userList];
}

class UserListLoadError extends UserListState {
  final String errorMessage;

  UserListLoadError({required this.errorMessage});
}


class UserNameLoadError extends UserListState {
  final String nameErrorMessage;

  UserNameLoadError({required this.nameErrorMessage});
}

