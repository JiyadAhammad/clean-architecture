import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel> signUpUser({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signInUser({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._supabaseClient);
  final SupabaseClient _supabaseClient;

  @override
  Session? get currentUserSession => _supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return UserModel.formJson(response.user!.toJson());
      }
      throw const ServerException('User is null');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      if (response.user != null) {
        return UserModel.formJson(response.user!.toJson());
      }
      throw const ServerException('User is null');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      // log('${_supabaseClient.}');
      log('$currentUserSession. get current is null');
      if (currentUserSession == null) {
        return null;
      }
      final userData = await _supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentUserSession!.user.id);

      log('$userData. current user object in remote data source');

      return UserModel.formJson(
        userData.first,
      ).copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
