import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_financial_app/features/login/bloc/login_bloc.dart';
import 'package:flutter_clean_architecture_financial_app/features/login/ui/login_presenter.dart';

class LoginFeatureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: LoginPresenter(),
    );
  }
}
