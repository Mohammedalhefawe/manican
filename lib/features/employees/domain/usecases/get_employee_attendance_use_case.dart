import 'package:dartz/dartz.dart';
import 'package:manicann/features/employees/domain/entities/attendance.dart';
import 'package:manicann/features/employees/domain/repositories/employee_repository.dart';
import '../../../../core/error/failures.dart';

class GetEmployeeAttendanceUseCase {
  final EmployeeRepository repository;

  GetEmployeeAttendanceUseCase({required this.repository});

  Future<Either<Failure, List<Attendance>>> call({required int employeeId}) async {
    return await repository.getEmployeeAttendance(employeeId);
  }
}
