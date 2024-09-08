abstract class BookingState {}

class BookingInitial extends BookingState {}

class SuccessBookingState extends BookingState {}

class LoadingBookingState extends BookingState {}

class ErrorBookingState extends BookingState {
  final String message;

  ErrorBookingState({required this.message});

  @override
  List<Object> get props => [message];
}
