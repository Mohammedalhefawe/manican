import 'package:dartz/dartz.dart';
import 'package:manicann/features/employees/domain/entities/service.dart';
import 'package:manicann/features/employees/domain/repositories/employee_repository.dart';
import '../../../../core/error/failures.dart';

class GetAllServicesUseCase {
  final EmployeeRepository repository;

  GetAllServicesUseCase({required this.repository});

  Future<Either<Failure, List<ServiceEntity>>> call({required int branchId}) async {
    return await repository.getAllServices(branchId);
  }
}
