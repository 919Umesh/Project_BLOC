import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../core/injection/injection_helper.dart';
import '../../../core/services/sharepref/flutter_secure_storage.dart';
import '../model/login_model.dart';
import '../repository/login_repository.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc({required LoginRepository loginRepository})
      : _loginRepository = loginRepository, super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
    try {
      final response = LoginModel(
        email: event.email,
        password: event.password,
      );
      locator<SecureStorageHelper>().setIsLogin(true);
      locator<SecureStorageHelper>().setUserCode(response.email);
      await _loginRepository.loginUser(user: response);
      debugPrint(response.password);
      emit(LoginSuccess(message: 'Login Successfully',token:response.email));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
