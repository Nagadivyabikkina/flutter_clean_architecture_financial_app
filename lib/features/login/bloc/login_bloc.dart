import 'package:clean_framework/clean_framework.dart';
import 'package:flutter_clean_architecture_financial_app/features/login/api/login_service.dart';
import 'package:flutter_clean_architecture_financial_app/features/login/bloc/login_usecase.dart';
import 'package:flutter_clean_architecture_financial_app/features/login/model/login_view_model.dart';

class LoginBloc extends Bloc {
  late LoginUseCase _loginUseCase;

  final loginViewModelPipe = Pipe<LoginViewModel>();
  final userNamePipe = Pipe<String>();
  final passwordPipe = Pipe<String>();
  final submitPipe = EventPipe();

  LoginBloc({LoginService? loginService}) {
    _loginUseCase = LoginUseCase(
        (viewModel) => loginViewModelPipe.send(viewModel as LoginViewModel));
    loginViewModelPipe.whenListenedDo(() {
      _loginUseCase.create();
    });
    userNamePipe.receive.listen(userNameInputHandler);
    passwordPipe.receive.listen(passwordInputHandler);
    submitPipe.listen(submitHandler);
  }

  void userNameInputHandler(String username) {
    _loginUseCase.updateUsername(username);
  }

  void passwordInputHandler(String password) {
    _loginUseCase.updatePassword(password);
  }

  void submitHandler() {
    _loginUseCase.submit();
  }

  @override
  void dispose() {
    loginViewModelPipe.dispose();
    userNamePipe.dispose();
    passwordPipe.dispose();
    submitPipe.dispose();
  }
}
