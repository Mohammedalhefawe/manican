import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:manicann/features/offers/data/datasources/offer_remote_data_source.dart';
import 'package:manicann/features/offers/data/models/offer_model.dart';
import 'package:manicann/features/offers/domain/entities/offer_entity_data.dart';
import 'package:manicann/features/offers/domain/repositories/offers_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class OffersRepositoryImpl implements OffersRepository {
  final OfferRemoteDataSource remoteDataSource;

  OffersRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Unit>> addOffer(
      OfferEntityData offerEntityData) async {
    if (true) {
      try {
        await remoteDataSource.addOffer(offerEntityData);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> editOffer(
      OfferEntityData offerEntityData, String id) async {
    if (true) {
      try {
        await remoteDataSource.editOffer(offerEntityData, id);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteOffer(String id) async {
    if (true) {
      try {
        await remoteDataSource.deleteOffer(id);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<OfferModel>>> getAllOffers() async {
    if (true) {
      try {
        final remoteOffers = await remoteDataSource.getAllOffers();
        return Right(remoteOffers);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
