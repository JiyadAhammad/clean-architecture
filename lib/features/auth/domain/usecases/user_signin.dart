import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/profile.dart';
import '../repository/auth_repository.dart';

class UserSignin implements UseCase<Profile, UserSigninParams> {
  final AuthRepository _authRepository;

  const UserSignin(this._authRepository);
  @override
  Future<Either<Failures, Profile>> call(UserSigninParams param) async {
    final res = await _authRepository.signInUser(
      email: param.email,
      password: param.password,
    );

    return res;
  }
}

class UserSigninParams {
  final String email;
  final String password;

  UserSigninParams({required this.email, required this.password});
}
