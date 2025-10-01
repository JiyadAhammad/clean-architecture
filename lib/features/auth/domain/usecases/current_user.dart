import 'dart:developer';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/profile.dart';
import '../repository/auth_repository.dart';

class CurrentUser implements UseCase<Profile, NoParams> {
  final AuthRepository _authRepository;

  const CurrentUser(this._authRepository);
  @override
  Future<Either<Failures, Profile>> call(NoParams param) async {
    log('Current user domain usescase');
    final res = await _authRepository.currentUser();

    return res;
  }
}
