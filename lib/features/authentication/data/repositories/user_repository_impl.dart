import 'package:dartz/dartz.dart';
import 'package:manicann/core/error/exceptions.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/features/authentication/domain/entities/user.dart';
import 'package:manicann/features/authentication/domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  //final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    /*required this.networkInfo*/
  });

  @override
  Future<Either<Failure, User>> userLogin(
      String phoneNumber, String password) async {
    if (true) {
      //edited
      try {
        final user = await remoteDataSource.login(phoneNumber, password);
        localDataSource.cacheUserInfo(user);
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
