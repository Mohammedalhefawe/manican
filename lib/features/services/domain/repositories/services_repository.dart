import 'package:dartz/dartz.dart';
import 'package:manicann/features/services/domain/entities/service.dart';
import 'package:manicann/features/services/domain/entities/service_discount_entity_data.dart';
import 'package:manicann/features/services/domain/entities/service_entity_data.dart';

import '../../../../core/error/failures.dart';

abstract class ServicesRepository {
  Future<Either<Failure, List<ServiceEntity>>> getAllServices();
  Future<Either<Failure, Unit>> addService(ServiceEntityData serviceEntityData);
  Future<Either<Failure, Unit>> editService(
      ServiceEntityData serviceEntityData);
  Future<Either<Failure, Unit>> addDiscount(
      ServiceDiscountEntity serviceDiscountEntity);
  Future<Either<Failure, Unit>> addSpecialist();
}
