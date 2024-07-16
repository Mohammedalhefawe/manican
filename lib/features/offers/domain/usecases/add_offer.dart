import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:manican/core/error/failures.dart';
import 'package:manican/features/offers/domain/repositories/offers_repository.dart';

class AddOfferUsecase {
  final OffersRepository repository;

  AddOfferUsecase(this.repository);

  Future<Either<Failure, Unit>> call(
      {required String title,
      required String description,
      required File? image}) async {
    return await repository.addOffer(title, description, image);
  }
}
