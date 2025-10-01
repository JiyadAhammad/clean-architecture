import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/profile.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, Profile>> signUpUser({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failures, Profile>> signInUser({
    required String email,
    required String password,
  });

  Future<Either<Failures, Profile>> currentUser();
}
