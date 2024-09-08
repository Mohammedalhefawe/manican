import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manicann/features/employees/domain/repositories/employee_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/employee.dart';

class EditEmployeeUseCase {
  final EmployeeRepository repository;

  EditEmployeeUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(
      Employee employee,
      PlatformFile? image,
      List<int> addedServices,
      List<int> deletedServices,
      ) async {
    return await repository.editEmployee(employee, image, addedServices, deletedServices);
  }
}
