abstract class ServiceState {}

class ServiceInitial extends ServiceState {}

class SuccessServiceState extends ServiceState {}

class LoadingServiceState extends ServiceState {}

class ErrorServiceState extends ServiceState {
  final String message;

  ErrorServiceState({required this.message});

  
}
