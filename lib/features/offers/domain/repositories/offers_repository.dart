import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:manican/features/offers/domain/entities/offer.dart';

import '../../../../core/error/failures.dart';

abstract class OffersRepository {
  Future<Either<Failure, List<Offer>>> getAllOffers();
  Future<Either<Failure, Unit>> addOffer(
      String title, String description, File? image);
}
