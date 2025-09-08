import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/profile.dart';
import '../repository/auth_repository.dart';

class UserSignUp implements UseCase<Profile, UserSignUpParams> {
  const UserSignUp(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<Failures, Profile>> call(UserSignUpParams param) async {
    final result = await _authRepository.signUpUser(
      name: param.name,
      email: param.email,
      password: param.password,
    );

    return result;
  }
}

class UserSignUpParams {
  final String email;
  final String name;
  final String password;

  UserSignUpParams({
    required this.email,
    required this.name,
    required this.password,
  });
}
