import 'dart:async';
import 'dart:developer';

import 'package:clean_architucture/core/usecase/usecase.dart';
import 'package:clean_architucture/features/auth/domain/usecases/current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/profile.dart';
import '../../domain/usecases/user_signin.dart';
import '../../domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // @override
  // void onChange(Change<AuthState> change) {
  //   log('Auth Bloc state changes => $change ');
  //   super.onChange(change);
  // }

  final UserSignUp _userSignUp;
  final UserSignin _userSignin;
  final CurrentUser _currentUser;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignin userSignin,
    required CurrentUser currentUser,
  }) : _userSignUp = userSignUp,
       _userSignin = userSignin,
       _currentUser = currentUser,
       super(AuthInitial()) {
    on<AuthSignup>(_authSignup);
    on<AuthSignin>(_authSignin);
    on<AuthIsUserLoggedIn>(_authIsUserLoggedIn);
  }

  Future<void> _authSignup(AuthSignup event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );

    res.fold(
      (Failures failure) => emit(AuthFailure(failure.message)),
      (Profile user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _authSignin(AuthSignin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignin(
      UserSigninParams(email: event.email, password: event.password),
    );

    res.fold(
      (Failures failure) => emit(AuthFailure(failure.message)),
      (Profile user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _authIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    log('Function called');
    final res = await _currentUser(NoParams());
    res.fold((Failures failure) => emit(AuthFailure(failure.message)), (
      Profile user,
    ) {
      log('$user. user ');
      emit(AuthSuccess(user));
    });
  }
}
