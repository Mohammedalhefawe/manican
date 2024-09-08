import 'package:dartz/dartz.dart';
import 'package:manicann/features/employees/domain/repositories/employee_repository.dart';
import '../../../../core/error/failures.dart';

class DeleteEmployeeUseCase {
  final EmployeeRepository repository;

  DeleteEmployeeUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteEmployee(id);
  }
}
