import 'package:dartz/dartz.dart';
import 'package:manicann/features/services/data/datasources/services_remote_data_source.dart';
import 'package:manicann/features/services/data/models/services_model.dart';
import 'package:manicann/features/services/domain/entities/service_discount_entity_data.dart';
import 'package:manicann/features/services/domain/entities/service_entity_data.dart';
import 'package:manicann/features/services/domain/repositories/services_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  final ServiceRemoteDataSource remoteDataSource;

  ServicesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ServiceModel>>> getAllServices() async {
    if (true) {
      try {
        final remoteServices = await remoteDataSource.getAllServices();
        return Right(remoteServices);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addService(
      ServiceEntityData serviceEntityData) async {
    if (true) {
      try {
        await remoteDataSource.addService(serviceEntityData);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> editService(
      ServiceEntityData serviceEntityData) async {
    if (true) {
      try {
        await remoteDataSource.editService(serviceEntityData);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addSpecialist() {
    // TODO: implement addSpecialist
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addDiscount(
      ServiceDiscountEntity serviceDiscountEntity) async {
    if (true) {
      try {
        await remoteDataSource.addDiscount(serviceDiscountEntity);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
