import 'dart:developer';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);
  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failures, Profile>> signInUser({
    required String email,
    required String password,
  }) async {
    return _getUser(
      fn: () async =>
          await _remoteDataSource.signInUser(email: email, password: password),
    );
  }

  @override
  Future<Either<Failures, Profile>> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      fn: () async => await _remoteDataSource.signUpUser(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failures, Profile>> currentUser() async {
    try {
      log('data repo impl');
      final user = await _remoteDataSource.getCurrentUserData();

      if (user == null) {
        return left(Failures(message: 'User not logged in'));
      }

      return right(user);
    } on SocketException catch (e) {
      return left(Failures(message: e.message));
    } on ServerException catch (e) {
      return left(Failures(message: e.message));
    }
  }

  Future<Either<Failures, Profile>> _getUser({
    required Future<Profile> Function() fn,
  }) async {
    try {
      final user = await fn();
      return right(user);
    } on SocketException catch (e) {
      return left(Failures(message: e.message));
    } on AuthException catch (e) {
      return left(Failures(message: e.message));
    } on ServerException catch (e) {
      return left(Failures(message: e.message));
    }
  }
}
