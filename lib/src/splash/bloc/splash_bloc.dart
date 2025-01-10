import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../core/injection/injection_helper.dart';
import '../../../core/services/sharepref/flutter_secure_storage.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});
    on<SplashScreenStarted>(_navigateToLogin);
  }

  Future<void> _navigateToLogin(
    SplashScreenStarted event,
    Emitter emit,
  ) async {
    final isLogin = await locator<SecureStorageHelper>().getIsLogin();
    await Future.delayed(const Duration(seconds: 3));
    if (isLogin) {
      emit(SplashNavigateToHome());
    } else {
      emit(SplashNavigateToLogin());
    }
  }
}
