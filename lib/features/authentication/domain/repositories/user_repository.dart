import 'package:dartz/dartz.dart';
import 'package:manicann/core/error/failures.dart';

import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> userLogin(String phoneNumber, String password);
}
