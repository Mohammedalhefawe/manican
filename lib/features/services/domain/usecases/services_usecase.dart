import 'package:dartz/dartz.dart';
import 'package:manicann/features/services/data/repositories/services_repository_impl.dart';
import 'package:manicann/features/services/domain/entities/service.dart';
import 'package:manicann/features/services/domain/entities/service_discount_entity_data.dart';
import 'package:manicann/features/services/domain/entities/service_entity_data.dart';
import '../../../../core/error/failures.dart';

class ServicesUsecase {
  final ServicesRepositoryImpl repository;

  ServicesUsecase({required this.repository});

  Future<Either<Failure, List<ServiceEntity>>> getAllServices() async {
    return await repository.getAllServices();
  }

  Future<Either<Failure, Unit>> editService(
      ServiceEntityData serviceEntityData) async {
    return await repository.editService(serviceEntityData);
  }

  Future<Either<Failure, Unit>> addSpecialist() async {
    return await repository.addSpecialist();
  }

  Future<Either<Failure, Unit>> addService(
      ServiceEntityData serviceEntityData) async {
    return await repository.addService(serviceEntityData);
  }

  Future<Either<Failure, Unit>> addDiscount(
      ServiceDiscountEntity serviceDiscountEntity) async {
    return await repository.addDiscount(serviceDiscountEntity);
  }
}
