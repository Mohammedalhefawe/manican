import 'package:dartz/dartz.dart';
import 'package:manicann/features/offers/data/models/offer_model.dart';
import 'package:manicann/features/offers/domain/entities/offer_entity_data.dart';
import '../../../../core/error/failures.dart';

abstract class OffersRepository {
  Future<Either<Failure, List<OfferModel>>> getAllOffers();
  Future<Either<Failure, Unit>> addOffer(OfferEntityData offerEntityData);
  Future<Either<Failure, Unit>> editOffer(
      OfferEntityData offerEntityData, String id);
  Future<Either<Failure, Unit>> deleteOffer(String id);
}
