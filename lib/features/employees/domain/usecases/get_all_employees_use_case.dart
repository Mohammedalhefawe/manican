import 'package:dartz/dartz.dart';
import 'package:manicann/features/employees/domain/repositories/employee_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/employee.dart';

class GetAllEmployeesUseCase {
  final EmployeeRepository repository;

  GetAllEmployeesUseCase({required this.repository});

  Future<Either<Failure, List<Employee>>> call({required int branchId}) async {
    return await repository.getAllEmployees(branchId);
  }
}
