import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manicann/core/error/exceptions.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/features/employees/data/models/employee_model.dart';
import 'package:manicann/features/employees/data/models/file_employee_model.dart';
import 'package:manicann/features/employees/domain/entities/employee.dart';
import 'package:manicann/features/employees/domain/entities/file_attendance.dart';
import 'package:manicann/features/employees/domain/entities/service.dart';
import 'package:manicann/features/employees/domain/repositories/employee_repository.dart';
import '../../domain/entities/attendance.dart';
import '../datasources/employee_remote_data_source.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource remoteDataSource;

  EmployeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Employee>>> getAllEmployees(int branchId) async {
    try {
      final List<Employee> employeesList =
          await remoteDataSource.getAllEmployees(branchId);
      return Right(employeesList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Employee>> getEmployeeDetails(int id) async {
    try {
      final Employee employee = await remoteDataSource.getEmployeeDetails(id);
      return Right(employee);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addEmployee(
      Employee employee, PlatformFile? image) async {
    final EmployeeModel model = EmployeeModel(
      firstName: employee.firstName,
      middleName: employee.middleName,
      lastName: employee.lastName,
      phoneNumber: employee.phoneNumber,
      branchId: employee.branchId,
      role: employee.role,
      salary: employee.salary,
      isFixed: employee.isFixed,
      position: employee.position,
      startDate: employee.startDate,
      nationalId: employee.nationalId,
      pin: employee.pin,
      email: employee.email,
      password: employee.password,
      services: employee.services,
      ratio: employee.ratio,
    );
    return await _getMessage(() {
      return remoteDataSource.addEmployee(model, image);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteEmployee(int id) async {
    return await _getMessage(() {
      return remoteDataSource.deleteEmployee(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> editEmployee(
    Employee employee,
    PlatformFile? image,
    List<int> addedServices,
    List<int> deletedServices,
  ) async {
    final EmployeeModel model = EmployeeModel(
      id: employee.id,
      firstName: employee.firstName,
      middleName: employee.middleName,
      lastName: employee.lastName,
      phoneNumber: employee.phoneNumber,
      branchId: employee.branchId,
      role: employee.role,
      salary: employee.salary,
      isFixed: employee.isFixed,
      position: employee.position,
      startDate: employee.startDate,
      nationalId: employee.nationalId,
      pin: employee.pin,
      email: employee.email,
      password: employee.password,
      ratio: employee.ratio,
    );
    return await _getMessage(() {
      return remoteDataSource.editEmployee(
          model, image, addedServices, deletedServices);
    });
  }

  @override
  Future<Either<Failure, List<ServiceEntity>>> getAllServices(int id) async {
    try {
      final List<ServiceEntity> servicesList =
          await remoteDataSource.getAllServices(id);
      return Right(servicesList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Attendance>>> getEmployeeAttendance(
      int id) async {
    try {
      final List<Attendance> attendanceList =
          await remoteDataSource.getEmployeeAttendance(id);
      return Right(attendanceList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    try {
      await deleteOrUpdateOrAddPost();
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> uploadFileAttendance(
      FileAttendanceEntity fileAttendanceEntity) async {
    if (true) {
      try {
        await remoteDataSource.uploadFileAttendance(fileAttendanceEntity);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, FileResponseModel>> downloadFileAttendance(
      DownloadFileEntity downloadFileEntity) async {
    if (true) {
      try {
        final FileResponseModel fileResponseModel =
            await remoteDataSource.downloadFileAttendance(downloadFileEntity);
        return Right(fileResponseModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
