
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:manican/features/offers/data/datasources/post_remote_data_source.dart';
import 'package:manican/features/offers/domain/entities/offer.dart';
import 'package:manican/features/offers/domain/repositories/offers_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';

class OffersRepositoryImpl implements OffersRepository {
  final OfferRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  OffersRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> addOffer(
      String title, String description, File? image) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addOffer(title, description, image);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Offer>>> getAllOffers() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteOffers = await remoteDataSource.getAllOffers();
        return Right(remoteOffers);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      print('No Internet');
      return Left(OfflineFailure());
    }
  }
}
