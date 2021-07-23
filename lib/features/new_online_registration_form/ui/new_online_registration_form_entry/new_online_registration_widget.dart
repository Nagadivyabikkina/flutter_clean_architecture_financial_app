import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_bloc.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_form_entry/new_online_registration_presenter.dart';

class NewOnlineRegistrationRequestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewOnlineRegistrationBloc(),
      child: NewOnlineRegistrationRequestPresenter(),
    );
  }
}
