import 'package:clean_framework/clean_framework.dart';
import 'package:flutter_clean_architecture_financial_app/dependency/card_scanner_plugin.dart';
import 'package:flutter_clean_architecture_financial_app/dependency/permission_handler_plugin.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_form_entry/new_online_registration_event.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_form_entry/new_online_registration_usecase.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_success/new_online_registration_success_event.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_success/new_online_registration_success_usecase.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_form_entry/new_online_registration_view_model.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/model/new_online_registration_success/new_online_registration_success_view_model.dart';

class NewOnlineRegistrationBloc extends Bloc {
  final newOnlineRegistrationEventsPipe =
      Pipe<NewOnlineRegistrationEvent>(canSendDuplicateData: true);

  final newOnlineRegistrationConfirmEventEventPipe =
      Pipe<NewOnlineRegistrationConfirmEvent>(canSendDuplicateData: true);

  NewOnlineRegistrationRequestUseCase? _newOnlineRegistrationRequestUseCase;
  final newOnlineRegistrationViewModelPipe =
      Pipe<NewOnlineRegistrationViewModel>();

  NewOnlineRegistrationRequestSuccessUseCase?
      _newOnlineRegistrationRequestSuccessUseCase;
  final newOnlineRegistrationSuccessViewModelPipe =
      Pipe<NewOnlineRegistrationRequestSuccessViewModel>();

  NewOnlineRegistrationBloc({
    NewOnlineRegistrationRequestUseCase? newOnlineRegistrationRequestUseCase,
    NewOnlineRegistrationRequestSuccessUseCase?
        newOnlineRegistrationRequestSuccessUseCase,
  }) {
    newOnlineRegistrationEventsPipe.receive.listen((event) {
      newOnlineRegistrationEventsPipeHandler(event);
    });
    _newOnlineRegistrationRequestUseCase =
        newOnlineRegistrationRequestUseCase ??
            NewOnlineRegistrationRequestUseCase(
                (viewModel) => newOnlineRegistrationViewModelPipe
                    .send(viewModel as NewOnlineRegistrationViewModel),
                PermissionHandlerPlugin(),
                CardScannerPlugin());
    newOnlineRegistrationViewModelPipe
        .whenListenedDo(_newOnlineRegistrationRequestUseCase!.create);

//success pipe and usecase
    _newOnlineRegistrationRequestSuccessUseCase =
        newOnlineRegistrationRequestSuccessUseCase ??
            NewOnlineRegistrationRequestSuccessUseCase((viewModel) =>
                newOnlineRegistrationSuccessViewModelPipe.send(
                    viewModel as NewOnlineRegistrationRequestSuccessViewModel));
    newOnlineRegistrationSuccessViewModelPipe
        .whenListenedDo(_newOnlineRegistrationRequestSuccessUseCase!.create);
    newOnlineRegistrationConfirmEventEventPipe.receive.listen((event) {
      newOnlineRegistrationConfirmEventPipeHandler(event);
    });
  }

  @override
  void dispose() {
    newOnlineRegistrationEventsPipe.dispose();
    newOnlineRegistrationViewModelPipe.dispose();
    newOnlineRegistrationSuccessViewModelPipe.dispose();
    newOnlineRegistrationConfirmEventEventPipe.dispose();
  }

  newOnlineRegistrationEventsPipeHandler(NewOnlineRegistrationEvent event) {
    if (event is CardScannerEvent) {
      _newOnlineRegistrationRequestUseCase!.getCardInformation();
    }
    if (event is UpdateCardHolderNameRequestEvent) {
      _newOnlineRegistrationRequestUseCase!.updateUserName(event.username);
      return;
    } else if (event is UpdateCardHolderNumberRequestEvent) {
      _newOnlineRegistrationRequestUseCase!.updateCardNumber(event.cardNumber);
      return;
    } else if (event is UpdateCardExpiryRequestEvent) {
      _newOnlineRegistrationRequestUseCase!
          .updateCardExpireDate(event.expiryDate);
      return;
    } else if (event is UpdateUserPasswordRequestEvent) {
      _newOnlineRegistrationRequestUseCase!.updatePassword(event.password);
      return;
    } else if (event is UpdateEmailAddressRequestEvent) {
      _newOnlineRegistrationRequestUseCase!.updateEmailAddress(event.email);
      return;
    }
  }

  void newOnlineRegistrationConfirmEventPipeHandler(
      NewOnlineRegistrationConfirmEvent event) {
    if (event is ResetNewOnlineRegistrationViewModelEvent) {
      _newOnlineRegistrationRequestSuccessUseCase!.resetViewModel();
    }
  }

  String validateUserName(String userName) {
    return _newOnlineRegistrationRequestUseCase!.validateUserName(userName);
  }

  String validateCardHolderNumber(String cardNumber) {
    return _newOnlineRegistrationRequestUseCase!.validateCardNumber(cardNumber);
  }

  String? validateCardExpiryDate(String expiryDate) {
    return _newOnlineRegistrationRequestUseCase!.validateDate(expiryDate);
  }

  String validateUserPassword(String password) {
    return _newOnlineRegistrationRequestUseCase!.validateUserPassword(password);
  }

  String validateEmailAddress(String email) {
    return _newOnlineRegistrationRequestUseCase!.validateEmailAddress(email);
  }
}
