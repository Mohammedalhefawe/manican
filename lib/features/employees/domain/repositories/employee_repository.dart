import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/features/employees/data/models/file_employee_model.dart';
import 'package:manicann/features/employees/domain/entities/attendance.dart';
import 'package:manicann/features/employees/domain/entities/employee.dart';
import 'package:manicann/features/employees/domain/entities/file_attendance.dart';
import 'package:manicann/features/employees/domain/entities/service.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<Employee>>> getAllEmployees(int branchId);
  Future<Either<Failure, Employee>> getEmployeeDetails(int id);
  Future<Either<Failure, Unit>> addEmployee(
    Employee employee,
    PlatformFile? image,
  );
  Future<Either<Failure, Unit>> editEmployee(
    Employee employee,
    PlatformFile? image,
    List<int> addedServices,
    List<int> deletedServices,
  );
  Future<Either<Failure, Unit>> deleteEmployee(int id);
  Future<Either<Failure, Unit>> uploadFileAttendance(
      FileAttendanceEntity fileAttendanceEntity);
  Future<Either<Failure, FileResponseModel>> downloadFileAttendance(
      DownloadFileEntity downloadFileEntity);

  Future<Either<Failure, List<ServiceEntity>>> getAllServices(int id);
  Future<Either<Failure, List<Attendance>>> getEmployeeAttendance(int id);
}
