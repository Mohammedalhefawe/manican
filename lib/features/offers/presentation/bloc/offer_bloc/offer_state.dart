abstract class OfferState {}

class OfferInitial extends OfferState {}

class SuccessOfferState extends OfferState {}

class LoadingOfferState extends OfferState {}

class SuccessDeleteOfferState extends OfferState {}

class ErrorDeleteOfferState extends OfferState {
  final String message;

  ErrorDeleteOfferState({required this.message});
}

class SuccessEditOfferState extends OfferState {}

class ErrorEditOfferState extends OfferState {
  final String message;

  ErrorEditOfferState({required this.message});
}

class SuccessAddOfferState extends OfferState {}

class ErrorAddOfferState extends OfferState {
  final String message;

  ErrorAddOfferState({required this.message});
}

class ErrorOfferState extends OfferState {
  final String message;

  ErrorOfferState({required this.message});
}
