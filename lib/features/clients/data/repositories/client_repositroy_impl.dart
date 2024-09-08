import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manicann/core/error/exceptions.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/features/clients/domain/entities/booking.dart';
import 'package:manicann/features/clients/domain/entities/client_booking_percentage.dart';
import '../../domain/entities/client.dart';
import '../../domain/repositories/clients_repository.dart';
import '../datasources/client_remote_data_source.dart';
import '../models/client_model.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class ClientRepositoryImpl implements ClientRepository {
  final ClientRemoteDataSource remoteDataSource;

  ClientRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Client>>> getAllClients(
      {required int branchId}) async {
    try {
      final List<Client> clients =
          await remoteDataSource.getAllClients(branchId: branchId);
      return Right(clients);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Client>> getClientDetails(int id) async {
    try {
      final Client client =
          await remoteDataSource.getClientDetails(clientId: id);
      return Right(client);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addClient(
      {required Client client, required PlatformFile? image}) async {
    final ClientModel model = ClientModel(
      firstName: client.firstName,
      middleName: client.middleName,
      lastName: client.lastName,
      phoneNumber: client.phoneNumber,
      branchId: client.branchId,
      email: client.email,
    );
    return await _getMessage(() {
      return remoteDataSource.addClient(clientModel: model, image: image);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteClient({required int clientId}) async {
    return await _getMessage(() {
      return remoteDataSource.deleteClient(clientId: clientId);
    });
  }

  @override
  Future<Either<Failure, Unit>> editClient({
    required Client client,
    required PlatformFile? image,
  }) async {
    final ClientModel model = ClientModel(
      id: client.id,
      firstName: client.firstName,
      middleName: client.middleName,
      lastName: client.lastName,
      phoneNumber: client.phoneNumber,
      branchId: client.branchId,
      email: client.email,
    );
    return await _getMessage(() {
      return remoteDataSource.editClient(clientModel: model, image: image);
    });
  }

  @override
  Future<Either<Failure, List<Booking>>> getArchivedClientBookings(
      {required int clientId}) async {
    try {
      final List<Booking> archivedBookings =
          await remoteDataSource.getArchivedBookings(clientId: clientId);
      return Right(archivedBookings);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getCurrentClientBookings(
      {required int clientId}) async {
    try {
      final List<Booking> currentBookings =
          await remoteDataSource.getCurrentBookings(clientId: clientId);
      return Right(currentBookings);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> acceptBooking({required int bookingId}) async {
    return await _getMessage(() {
      return remoteDataSource.acceptBooking(bookingId: bookingId);
    });
  }

  @override
  Future<Either<Failure, Unit>> declineBooking({required int bookingId}) async {
    return await _getMessage(() {
      return remoteDataSource.declineBooking(bookingId: bookingId);
    });
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
  Future<Either<Failure, BookingPercentage>> getClientBookingPercentage(
      {required int clientId}) async {
    try {
      final BookingPercentage bookingPercentage =
          await remoteDataSource.getBookingPercentage(clientId: clientId);
      return Right(bookingPercentage);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
