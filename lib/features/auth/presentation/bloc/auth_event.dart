part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

final class AuthSignin extends AuthEvent {
  final String email;
  final String password;

  AuthSignin({required this.email, required this.password});
}

final class AuthSignup extends AuthEvent {
  final String email;
  final String name;
  final String password;

  AuthSignup({required this.email, required this.name, required this.password});
}

final class AuthIsUserLoggedIn extends AuthEvent {}
