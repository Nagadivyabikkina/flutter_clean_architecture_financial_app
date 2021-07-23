import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_bloc.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_enums.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_view_model.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_form_entry/new_online_registration_actions.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/new_online_registration_form_entry/new_online_registration_screen.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/ui/widgets/custom_circular_progress_bar_widget.dart';

class NewOnlineRegistrationRequestPresenter extends Presenter<
    NewOnlineRegistrationBloc,
    NewOnlineRegistrationViewModel,
    NewOnlineRegistrationScreen> {
  @override
  Stream<NewOnlineRegistrationViewModel> getViewModelStream(
      NewOnlineRegistrationBloc bloc) {
    return bloc.newOnlineRegistrationViewModelPipe.receive;
  }

  @override
  Widget buildLoadingScreen(BuildContext context) {
    return CustomCircularProgressBar();
  }

  @override
  NewOnlineRegistrationScreen buildScreen(
      BuildContext context,
      NewOnlineRegistrationBloc bloc,
      NewOnlineRegistrationViewModel viewModel) {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      if (viewModel.serviceResponseStatus ==
          NewOnlineRegistrationServiceResponseStatus.succeed) {
        return;
      } else if (viewModel.serviceResponseStatus ==
          NewOnlineRegistrationServiceResponseStatus.failed) {
        NewOnlineRegistrationRequestActions(bloc)
            .showDialogWithContent(context, "Errors!", 'Submission failed');
      }
    });

    return NewOnlineRegistrationScreen(
      viewModel: viewModel,
      actions: NewOnlineRegistrationRequestActions(bloc),
    );
  }
}
