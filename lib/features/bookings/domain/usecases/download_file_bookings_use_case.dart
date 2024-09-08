import 'package:dartz/dartz.dart';
import 'package:manicann/features/employees/data/models/file_employee_model.dart';
import 'package:manicann/features/employees/domain/entities/file_attendance.dart';
import 'package:manicann/features/employees/domain/repositories/employee_repository.dart';
import '../../../../core/error/failures.dart';

class FileBookingsUseCase {
  final EmployeeRepository repository;

  FileBookingsUseCase({required this.repository});

  Future<Either<Failure, FileResponseModel>> downloadFileBooking(
      DownloadFileEntity fileAttendanceEntity) async {
    return await repository.downloadFileAttendance(fileAttendanceEntity);
  }
}
