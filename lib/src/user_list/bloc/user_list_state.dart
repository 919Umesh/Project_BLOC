part of 'user_list_bloc.dart';

abstract class UserListState {}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoadSuccess extends UserListState {
  final List<UserModel> users;

  UserListLoadSuccess({required this.users});
}

class UserListLoadError extends UserListState {
  final String errorMessage;

  UserListLoadError({required this.errorMessage});
}
