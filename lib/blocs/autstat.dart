// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'authbloc.dart';
//
// class AuthInitial extends AuthState {}
//
// class SignupEvent extends AuthEvent {
//   final String email;
//   final String password;
//   final  String confirmPassword;
//
//   SignupEvent(this.email, this.password, this.confirmPassword);
// }
//
// class SignupSuccess extends AuthState {}
//
// class SignupFailure extends AuthState {
//   final String error;
//
//   SignupFailure({required this.error});
// }
//
// class LoginEvent extends AuthEvent {
//   final String email;
//   final String password;
//
//   LoginEvent(this.email, this.password);
// }
//
// class LoginSuccess extends AuthState {
//   final User? user;
//
//   LoginSuccess({required this.user});
// }
//
// class LoginFailure extends AuthState {
//   final String error;
//
//   LoginFailure({required this.error});
// }

//
// abstract class AuthState {}
//
// class AuthInitial extends AuthState {}
//
// class AuthSuccess extends AuthState {}
//
// class AuthError extends AuthState {
//   final String errorMessage;
//
//   AuthError(this.errorMessage);
// }
// autstat.dart

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}
