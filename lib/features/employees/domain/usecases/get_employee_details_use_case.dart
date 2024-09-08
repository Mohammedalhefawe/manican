import 'package:dartz/dartz.dart';
import 'package:manicann/features/employees/domain/repositories/employee_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/employee.dart';

class GetEmployeeDetailsUseCase {
  final EmployeeRepository repository;

  GetEmployeeDetailsUseCase(this.repository);

  Future<Either<Failure, Employee>> call(int id) async {
    return await repository.getEmployeeDetails(id);
  }
}
