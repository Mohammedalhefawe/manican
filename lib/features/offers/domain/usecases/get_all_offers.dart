import 'package:manican/features/offers/domain/entities/offer.dart';
import 'package:manican/features/offers/domain/repositories/offers_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class GetAllOfferUsecase {
  final OffersRepository repository;

  GetAllOfferUsecase(this.repository);

  Future<Either<Failure, List<Offer>>> call() async {
    return await repository.getAllOffers();
  }
}
