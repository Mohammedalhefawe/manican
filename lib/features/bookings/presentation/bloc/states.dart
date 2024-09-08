abstract class BookingsStates {}

class BookingsInitialState extends BookingsStates {}

// Current

class CurrentBookingsTableChangingFilterState extends BookingsStates {}

class CurrentBookingsTableSearchState extends BookingsStates {}

class CurrentBookingsTableChangingPageState extends BookingsStates {}

class GetCurrentBookingsLoadingState extends BookingsStates {}

class GetCurrentBookingsSuccessState extends BookingsStates {}

class GetCurrentBookingsErrorState extends BookingsStates {
  final String error;

  GetCurrentBookingsErrorState({required this.error});
}

//Archived

class ArchivedBookingsTableChangingFilterState extends BookingsStates {}

class ArchivedBookingsTableSearchState extends BookingsStates {}

class ArchivedBookingsTableChangingPageState extends BookingsStates {}

class GetArchivedBookingsLoadingState extends BookingsStates {}

class GetArchivedBookingsSuccessState extends BookingsStates {}

class GetArchivedBookingsErrorState extends BookingsStates {
  final String error;

  GetArchivedBookingsErrorState({required this.error});
}

// Accept and Decline

class AcceptBookingLoadingState extends BookingsStates {}

class AcceptBookingSuccessState extends BookingsStates {}

class AcceptBookingErrorState extends BookingsStates {
  final String error;

  AcceptBookingErrorState({required this.error});
}

class DeclineBookingLoadingState extends BookingsStates {}

class DeclineBookingSuccessState extends BookingsStates {}

class DeclineBookingErrorState extends BookingsStates {
  final String error;

  DeclineBookingErrorState({required this.error});
}

class ReportBookingLoadingState extends BookingsStates {}

class ReportBookingSuccessState extends BookingsStates {}

class ReportBookingErrorState extends BookingsStates {
  final String error;

  ReportBookingErrorState({required this.error});
}
