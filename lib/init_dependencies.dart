import 'package:clean_architucture/features/auth/domain/usecases/current_user.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secrets.dart';
import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/user_signin.dart';
import 'features/auth/domain/usecases/user_signup.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureInjection() async {
  _initAuth();

  /// Initialize Supabase SDK
  final supabaseInstance = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  getIt.registerLazySingleton(() => supabaseInstance.client);
}

void _initAuth() {
  getIt
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt()),
    )
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(getIt()))
    ..registerFactory(() => UserSignUp(getIt()))
    ..registerFactory(() => UserSignin(getIt()))
    ..registerFactory(() => CurrentUser(getIt()))
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        userSignUp: getIt(),
        userSignin: getIt(),
        currentUser: getIt(),
      ),
    );
}
