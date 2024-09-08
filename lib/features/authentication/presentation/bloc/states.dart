abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class ChangeLoginPasswordVisibilityState extends LoginStates {}

class LoadingLoginState extends LoginStates {}

class SuccessLoginState extends LoginStates {}

class ErrorLoginState extends LoginStates {
  final String message;

  ErrorLoginState({required this.message});
}