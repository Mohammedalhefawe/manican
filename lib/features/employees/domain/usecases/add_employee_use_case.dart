import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manicann/features/employees/domain/repositories/employee_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/employee.dart';

class AddEmployeeUseCase {
  final EmployeeRepository repository;

  AddEmployeeUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(Employee employee, PlatformFile? image) async {
    return await repository.addEmployee(employee, image);
  }
}
