import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_bloc.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_success/new_online_registration_success_event.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_success/new_online_registration_success_view_model.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_success_screen/new_online_registration_success_screen.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/widgets/custom_circular_progress_bar_widget.dart';
import 'package:flutter_clean_architecture_financial_app/routes.dart';

class NewOnlineRegistrationSuccessPresenter extends Presenter<
    NewOnlineRegistrationBloc,
    NewOnlineRegistrationRequestSuccessViewModel,
    NewOnlineRegistrationSuccessScreen> {
  @override
  Stream<NewOnlineRegistrationRequestSuccessViewModel> getViewModelStream(
      NewOnlineRegistrationBloc bloc) {
    return bloc.newOnlineRegistrationSuccessViewModelPipe.receive;
  }

  @override
  NewOnlineRegistrationSuccessScreen buildScreen(
      BuildContext context,
      NewOnlineRegistrationBloc bloc,
      NewOnlineRegistrationRequestSuccessViewModel viewModel) {
    return NewOnlineRegistrationSuccessScreen(
      viewModel: viewModel,
      presenterAction: NewOnlineRegistrationConfirmPresenterActions(bloc),
    );
  }

  @override
  Widget buildLoadingScreen(BuildContext context) {
    return CustomCircularProgressBar();
  }
}

class NewOnlineRegistrationConfirmPresenterActions {
  NewOnlineRegistrationBloc bloc;
  NewOnlineRegistrationConfirmPresenterActions(this.bloc);

  popNavigationListener(BuildContext context) {
    bloc.newOnlineRegistrationConfirmEventEventPipe
        .send(ResetNewOnlineRegistrationViewModelEvent());
    CFRouterScope.of(context).popUntil(FinancialAppRouter.initialRoute);
  }
}
