abstract class BeforeAfterState {}

class BeforeAfterInitial extends BeforeAfterState {}

class SuccessBeforeAfterState extends BeforeAfterState {}

class LoadingBeforeAfterState extends BeforeAfterState {}

class ErrorBeforeAfterState extends BeforeAfterState {
  final String message;

  ErrorBeforeAfterState({required this.message});

  @override
  List<Object> get props => [message];
}
