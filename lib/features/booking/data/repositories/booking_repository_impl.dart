import 'package:dartz/dartz.dart';
import 'package:manicann/features/Booking/data/datasources/Booking_remote_data_source.dart';
import 'package:manicann/features/booking/data/models/Services_employee_Model.dart';
import 'package:manicann/features/booking/data/models/available_time_model.dart';
import 'package:manicann/features/booking/data/models/users_model.dart';
import 'package:manicann/features/booking/domain/repositories/booking_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ServiceEmployeeModel>>
      getAllServicesAndEmployee() async {
    if (true) {
      try {
        final remoteBooking =
            await remoteDataSource.getAllServicesAndEmployee();
        return Right(remoteBooking);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addBooking(bookingEntityData) async {
    if (true) {
      try {
        await remoteDataSource.addBooking(bookingEntityData);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<AvailableTimeModel>>> getAvailableTime(
      String idService, String date) async {
    if (true) {
      try {
        final remoteBooking =
            await remoteDataSource.getAvaliableTime(idService, date);
        return Right(remoteBooking);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    if (true) {
      try {
        final remoteBooking = await remoteDataSource.getAllUsers();
        return Right(remoteBooking);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  // @override
  // Future<Either<Failure, Unit>> editBooking(
  //     BookingEntityData BookingEntityData) async {
  //   if (true) {
  //     try {
  //       await remoteDataSource.editBooking(BookingEntityData);
  //       return const Right(unit);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   }
  // }

  // @override
  // Future<Either<Failure, Unit>> addSpecialist() {
  //   // TODO: implement addSpecialist
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, Unit>> addDiscount(
  //     BookingDiscountEntity BookingDiscountEntity) async {
  //   if (true) {
  //     try {
  //       await remoteDataSource.addDiscount(BookingDiscountEntity);
  //       return const Right(unit);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   }
  // }
}
