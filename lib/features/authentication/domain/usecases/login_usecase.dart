import 'package:dartz/dartz.dart';
import 'package:manicann/features/authentication/domain/repositories/user_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

class LoginUseCase {
  final UserRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    return await repository.userLogin(email, password);
  }
}
