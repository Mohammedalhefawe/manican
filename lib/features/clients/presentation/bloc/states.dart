abstract class ClientsStates {}

class ClientsInitialState extends ClientsStates {}

class ClientsTableChangingFilterState extends ClientsStates {}

class ClientsTableSearchState extends ClientsStates {}

class ClientsTableChangingPageState extends ClientsStates {}

class ClientsAddProfilePictureSuccessState extends ClientsStates {}

class ClientsAddProfilePictureErrorState extends ClientsStates {}

class GetClientsLoadingState extends ClientsStates {}

class GetClientsSuccessState extends ClientsStates {}

class GetClientsErrorState extends ClientsStates {
  final String error;

  GetClientsErrorState({required this.error});
}

class DeleteClientLoadingState extends ClientsStates {}

class DeleteClientSuccessState extends ClientsStates {}

class DeleteClientErrorState extends ClientsStates {
  final String error;

  DeleteClientErrorState({required this.error});
}

class AddClientLoadingState extends ClientsStates {}

class AddClientSuccessState extends ClientsStates {}

class AddClientErrorState extends ClientsStates {
  final String error;

  AddClientErrorState({required this.error});
}

class AddClientClienttyFieldsWarningState extends ClientsStates {
  final String error;

  AddClientClienttyFieldsWarningState({required this.error});
}

class ClientToEditSelectionState extends ClientsStates {}

class ClientsEditProfilePictureSuccessState extends ClientsStates {}

class ClientsEditProfilePictureErrorState extends ClientsStates {}

class EditClientNothingChangedState extends ClientsStates {}

class EditClientLoadingState extends ClientsStates {}

class EditClientSuccessState extends ClientsStates {}

class EditClientErrorState extends ClientsStates {
  final String error;

  EditClientErrorState({required this.error});
}

class ClientToShowDetailsSelectionState extends ClientsStates {}

class GetClientCurrentBookingsLoadingState extends ClientsStates {}

class GetClientCurrentBookingsSuccessState extends ClientsStates {}

class GetClientCurrentBookingsErrorState extends ClientsStates {
  final String error;

  GetClientCurrentBookingsErrorState({required this.error});
}

class AcceptBookingLoadingState extends ClientsStates {}

class AcceptBookingSuccessState extends ClientsStates {}

class AcceptBookingErrorState extends ClientsStates {
  final String error;

  AcceptBookingErrorState({required this.error});
}

class DeclineBookingLoadingState extends ClientsStates {}

class DeclineBookingSuccessState extends ClientsStates {}

class DeclineBookingErrorState extends ClientsStates {
  final String error;

  DeclineBookingErrorState({required this.error});
}

class GetClientArchivedBookingsLoadingState extends ClientsStates {}

class GetClientArchivedBookingsSuccessState extends ClientsStates {}

class GetClientArchivedBookingsErrorState extends ClientsStates {
  final String error;

  GetClientArchivedBookingsErrorState({required this.error});
}

class GetBookingPercentageLoadingState extends ClientsStates {}

class GetBookingPercentageSuccessState extends ClientsStates {}

class GetBookingPercentageErrorState extends ClientsStates {
  final String error;

  GetBookingPercentageErrorState({required this.error});
}


