import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/login_model.dart';
import '../repository/login_repository.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc({required LoginRepository loginRepository})
      : _loginRepository = loginRepository,
        super(LoginInitial()) {
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
      await _loginRepository.loginUser(user: response);
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
