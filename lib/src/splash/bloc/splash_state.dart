part of 'splash_bloc.dart';

sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashNavigateToIndex extends SplashState {}

final class SplashNavigateToLogin extends SplashState {}


