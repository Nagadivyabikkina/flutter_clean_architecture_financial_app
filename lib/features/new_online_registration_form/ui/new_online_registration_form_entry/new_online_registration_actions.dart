import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_bloc.dart';
import 'package:flutter_clean_architecture_financial_app/features/new_online_registration_form/bloc/new_online_registration_form_entry/new_online_registration_event.dart';
import 'package:flutter_clean_architecture_financial_app/routes.dart';

class NewOnlineRegistrationRequestActions {
  NewOnlineRegistrationRequestActions(this.bloc);
  final NewOnlineRegistrationBloc bloc;

  void pressCreateButton(
    BuildContext context,
    String userName,
    String cardNumber,
    String expiryDate,
    String email,
    String password,
  ) {
    String userNameValidated = bloc.validateUserName(userName);
    String userCardNumberValidated = bloc.validateCardHolderNumber(cardNumber);
    String? userCardExpiryDate = bloc.validateCardExpiryDate(expiryDate);
    String userPasswordValidated = bloc.validateUserPassword(password);

    String userEmail = bloc.validateEmailAddress(email);

    if (userNameValidated.isNotEmpty ||
        userCardNumberValidated.isNotEmpty ||
        userCardExpiryDate!.isNotEmpty ||
        userEmail.isNotEmpty ||
        userPasswordValidated.isNotEmpty) {
      showDialogWithContent(context, "Invalid Information!",
          "Please fill in all fields properly");
      return;
    } else {
      CFRouterScope.of(context)
          .replaceWith(FinancialAppRouter.NewSuccessScreen);
    }
  }

  void onUpdateNameParam(String userName) {
    var event = UpdateCardHolderNameRequestEvent(userName);
    bloc.newOnlineRegistrationEventsPipe.send(event);
  }

  void onUpdateNumberParam(String cardNumber) {
    var event = UpdateCardHolderNumberRequestEvent(cardNumber);
    bloc.newOnlineRegistrationEventsPipe.send(event);
  }

  void onUpdateCardExpiryDate(String expiryDate) {
    var event = UpdateCardExpiryRequestEvent(expiryDate);
    bloc.newOnlineRegistrationEventsPipe.send(event);
  }

  void onUpdateEmailAddress(String email) {
    var event = UpdateEmailAddressRequestEvent(email);
    bloc.newOnlineRegistrationEventsPipe.send(event);
  }

  void onUpdatePassword(String password) {
    var event = UpdateUserPasswordRequestEvent(password);
    bloc.newOnlineRegistrationEventsPipe.send(event);
  }

  void onCardScanned() {
    var event = CardScannerEvent();
    bloc.newOnlineRegistrationEventsPipe.send(event);
  }

  void showDialogWithContent(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }
}
