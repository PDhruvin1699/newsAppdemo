// import 'package:blocnewsdemo/blocs/autstat.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   AuthBloc(super.initialState);
//
//   @override
//   AuthState get initialState => AuthInitial();
//
//   @override
//   Stream<AuthState> mapEventToState(AuthEvent event) async* {
//     if (event is SignupEvent) {
//       yield* _mapSignupEventToState(event);
//     } else if (event is LoginEvent) {
//       yield* _mapLoginEventToState(event);
//     }
//   }
//
//   Stream<AuthState> _mapSignupEventToState(SignupEvent event) async* {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: event.email,
//         password: event.password,
//       );
//       // You can add additional logic here if needed
//       yield SignupSuccess();
//     } catch (e) {
//       yield SignupFailure(error: e.toString());
//     }
//   }
//
//   Stream<AuthState> _mapLoginEventToState(LoginEvent event) async* {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: event.email,
//         password: event.password,
//       );
//       // You can add additional logic here if needed
//       yield LoginSuccess(user: userCredential.user);
//     } catch (e) {
//       yield LoginFailure(error: e.toString());
//     }
//   }
// }
// class AuthEvent {}
//
// class AuthState {}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'autstat.dart';
// auth_cubit.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'autstat.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitial());

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> checkAuthStatus() async {
    // Your authentication status check logic here
    // Example: bool isAuthenticated = await authService.checkAuthStatus();

    if (isAuthenticated) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    emit(AuthInitial());
  }

  bool get isAuthenticated => _auth.currentUser != null;
}

