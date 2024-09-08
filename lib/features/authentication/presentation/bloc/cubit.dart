import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/constance/constance.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/di/appInitializer.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import 'states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit({required this.loginUseCase}) : super(LoginInitState());

  final LoginUseCase loginUseCase;

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isLoginPasswordHidden = true;
  void changeLoginPasswordState() {
    isLoginPasswordHidden = !isLoginPasswordHidden;
    emit(ChangeLoginPasswordVisibilityState());
  }

  User? currentUser;
  String? message;
  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(LoadingLoginState());
    print(state.toString());
    final failureOrUser = await loginUseCase(
      email: email,
      password: password,
    );
    failureOrUser.fold(
      (failure) {
        emit(ErrorLoginState(message: _mapFailureToString(failure)));
      },
      (user) {
        currentUser = user;
        AppInitializer.isHaveAuth = true;
        AppLink.token = user.token;
        AppLink.role = user.role;
        AppLink.branchId =
            user.branchId != null ? user.branchId.toString() : '0';
        emit(SuccessLoginState());
      },
    );
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
